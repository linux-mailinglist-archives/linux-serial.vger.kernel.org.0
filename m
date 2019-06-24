Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2590951E90
	for <lists+linux-serial@lfdr.de>; Tue, 25 Jun 2019 00:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfFXWwj (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 24 Jun 2019 18:52:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40136 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfFXWwj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 24 Jun 2019 18:52:39 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hfXp9-00085C-Ho; Tue, 25 Jun 2019 00:52:31 +0200
Date:   Tue, 25 Jun 2019 00:52:30 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Hodaszi, Robert" <Robert.Hodaszi@digi.com>
cc:     Michael Shych <michaelsh@mellanox.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: "No irq handler for vector" problem
In-Reply-To: <c49e9454-d6d2-408c-8232-ee4c17d6975d@digi.com>
Message-ID: <alpine.DEB.2.21.1906242335250.32342@nanos.tec.linutronix.de>
References: <dcc1febb-2afc-da9b-696e-3c9bf63f4b76@digi.com> <alpine.DEB.2.21.1906211858340.5503@nanos.tec.linutronix.de> <37433D8393E7AF43B0D856B93884DA9E4FD67B64@MTK-SMS-XCH02.digi.com> <AM6PR05MB61689A1EE1E6B31682A476FAD9E10@AM6PR05MB6168.eurprd05.prod.outlook.com>
 <alpine.DEB.2.21.1906231955420.32342@nanos.tec.linutronix.de> <AM6PR05MB6168265CCF44FBCAEBBD4EA8D9E00@AM6PR05MB6168.eurprd05.prod.outlook.com> <d40acbee-df87-1f4b-48c1-66fe31c841fd@digi.com> <alpine.DEB.2.21.1906241609080.32342@nanos.tec.linutronix.de>
 <c49e9454-d6d2-408c-8232-ee4c17d6975d@digi.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, 24 Jun 2019, Hodaszi, Robert wrote:
> On Mon, 24 Jun 2019, Gleixner, Thomas wrote:
> >
> > The best way to figure out how the timing is of all those moving parts is
> > to enable trace points and selective function tracing. That should give us
> > a good picture.
> >
> Here are 2 logs, using ftrace with filter for do_IRQ(), 
> synchronize_irq(), some IRQ deactivation functions, and 
> irq_handler_entry event. The IRQ is assigned to the core#1, and the test 
> script (opening and closing the serial port) is running on core#0.

Thanks for providing the data.

> It seems, either the core#1 is busy with something else (other, higher 
> priority IRQ),

It's actually deep idle, which makes it slow to come out and service the
interrupt.

> and the UART interrupt is pending in the local APIC. Or

Kinda.

> the masking in the IO-APIC is not working (is that possible?).

It works, but AFAICT from the data the timing is as follows:

   CPU 0      	     	  CPU 1	       	      IO_APIC
       			  deep idle() 

					      interrupt is raised
					      sent to CPU1
   mask()
   ...
   free()
			  do_IRQ()
			    -> vector is clear

We can actually figure out whether the interrupt is sent and not
acknowledged yet. Sigh....

Can you please try the patch below on top of the delayed deactivate? You
should see the printk in the ioapic sync function 

Thanks,

	tglx

8<-------------
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1893,6 +1893,41 @@ static int ioapic_set_affinity(struct ir
 	return ret;
 }
 
+/*
+ * Interrupt shutdown masks the ioapic pin, but the interrupt might already
+ * be on flight, but not yet serviced by the target CPU. That means
+ * synchronize_irq() has returned and claimed that everything is calmed
+ * down. So free_irq() would proceed and clear the vector. Once the target
+ * CPU comes around to service it it will find a cleared vector and
+ * complain. Verify that the corresponding Remote-IRR bit is clear. If not,
+ * wait. This function is called with interrupts disabled and the irq core
+ * code is serialized so nothing can reconfigure that interrupt.
+ */
+static void ioapic_sync_irq(struct irq_data *irqd)
+{
+	struct mp_chip_data *mpd = irqd->chip_data;
+	struct irq_pin_list *entry;
+	bool irr;
+
+	do {
+		irr = false;
+		raw_spin_lock_irq(&ioapic_lock);
+		for_each_irq_pin(entry, mpd->irq_2_pin) {
+			struct IO_APIC_route_entry re;
+
+			re = __ioapic_read_entry(entry->apic, entry->pin);
+			if (re.irr)
+				irr = true;
+		}
+		raw_spin_unlock_irq(&ioapic_lock);
+		/* Give it a few microseconds to be serviced */
+		if (irr) {
+			pr_info("IOAPIC: Remote-IRR set on sync\n");
+			udelay(5);
+		}
+	} while (irr);
+}
+
 static struct irq_chip ioapic_chip __read_mostly = {
 	.name			= "IO-APIC",
 	.irq_startup		= startup_ioapic_irq,
@@ -1902,6 +1937,7 @@ static struct irq_chip ioapic_chip __rea
 	.irq_eoi		= ioapic_ack_level,
 	.irq_set_affinity	= ioapic_set_affinity,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_sync		= ioapic_sync_irq,
 	.flags			= IRQCHIP_SKIP_SET_WAKE,
 };
 
@@ -1914,6 +1950,7 @@ static struct irq_chip ioapic_ir_chip __
 	.irq_eoi		= ioapic_ir_ack_level,
 	.irq_set_affinity	= ioapic_set_affinity,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_sync		= ioapic_sync_irq,
 	.flags			= IRQCHIP_SKIP_SET_WAKE,
 };
 
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -418,6 +418,7 @@ static inline irq_hw_number_t irqd_to_hw
  *			required. This is used for CPU hotplug where the
  *			target CPU is not yet set in the cpu_online_mask.
  * @irq_retrigger:	resend an IRQ to the CPU
+ * @irq_sync:		sync an IRQ on shutdown (optional)
  * @irq_set_type:	set the flow type (IRQ_TYPE_LEVEL/etc.) of an IRQ
  * @irq_set_wake:	enable/disable power-management wake-on of an IRQ
  * @irq_bus_lock:	function to lock access to slow bus (i2c) chips
@@ -462,6 +463,7 @@ struct irq_chip {
 
 	int		(*irq_set_affinity)(struct irq_data *data, const struct cpumask *dest, bool force);
 	int		(*irq_retrigger)(struct irq_data *data);
+	void		(*irq_sync)(struct irq_data *data);
 	int		(*irq_set_type)(struct irq_data *data, unsigned int flow_type);
 	int		(*irq_set_wake)(struct irq_data *data, unsigned int on);
 
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1655,6 +1655,17 @@ int setup_irq(unsigned int irq, struct i
 }
 EXPORT_SYMBOL_GPL(setup_irq);
 
+static void sync_on_free(struct irq_desc *desc)
+{
+	unsigned long flags;
+
+	chip_bus_lock(desc);
+	raw_spin_lock_irqsave(&desc->lock, flags);
+	irq_desc_get_chip(desc)->irq_sync(irq_desc_get_irq_data(desc));
+	raw_spin_unlock_irqrestore(&desc->lock, flags);
+	chip_bus_sync_unlock(desc);
+}
+
 /*
  * Internal function to unregister an irqaction - used to free
  * regular and special interrupts that are part of the architecture.
@@ -1664,6 +1675,7 @@ static struct irqaction *__free_irq(stru
 	unsigned irq = desc->irq_data.irq;
 	struct irqaction *action, **action_ptr;
 	unsigned long flags;
+	bool sync = false;
 
 	WARN(in_interrupt(), "Trying to free IRQ %d from IRQ context!\n", irq);
 
@@ -1702,6 +1714,8 @@ static struct irqaction *__free_irq(stru
 		irq_settings_clr_disable_unlazy(desc);
 		/* Only shutdown. Deactivate after synchronize_irq() */
 		irq_shutdown(desc);
+		if (irq_desc_get_chip(desc)->irq_sync)
+			sync = true;
 	}
 
 #ifdef CONFIG_SMP
@@ -1729,6 +1743,9 @@ static struct irqaction *__free_irq(stru
 
 	unregister_handler_proc(irq, action);
 
+	if (sync)
+		sync_on_free(desc);
+
 	/* Make sure it's not being used on another CPU: */
 	synchronize_hardirq(irq);
 
