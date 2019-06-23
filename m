Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 379AB4FDC2
	for <lists+linux-serial@lfdr.de>; Sun, 23 Jun 2019 21:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfFWTBg (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sun, 23 Jun 2019 15:01:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34110 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfFWTBg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 23 Jun 2019 15:01:36 -0400
X-Greylist: delayed 2491 seconds by postgrey-1.27 at vger.kernel.org; Sun, 23 Jun 2019 15:01:34 EDT
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hf75q-000576-Hn; Sun, 23 Jun 2019 20:19:58 +0200
Date:   Sun, 23 Jun 2019 20:19:56 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Michael Shych <michaelsh@mellanox.com>
cc:     "Hodaszi, Robert" <Robert.Hodaszi@digi.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: RE: "No irq handler for vector" problem
In-Reply-To: <AM6PR05MB61689A1EE1E6B31682A476FAD9E10@AM6PR05MB6168.eurprd05.prod.outlook.com>
Message-ID: <alpine.DEB.2.21.1906231955420.32342@nanos.tec.linutronix.de>
References: <dcc1febb-2afc-da9b-696e-3c9bf63f4b76@digi.com> <alpine.DEB.2.21.1906211858340.5503@nanos.tec.linutronix.de> <37433D8393E7AF43B0D856B93884DA9E4FD67B64@MTK-SMS-XCH02.digi.com>
 <AM6PR05MB61689A1EE1E6B31682A476FAD9E10@AM6PR05MB6168.eurprd05.prod.outlook.com>
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

Michael,

On Sun, 23 Jun 2019, Michael Shych wrote:
> 
> > -----Original Message-----
> > From: Hodaszi, Robert <Robert.Hodaszi@digi.com>
> > Sent: Friday, June 21, 2019 8:47 PM
> > To: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Michael Shych <michaelsh@mellanox.com>; x86@kernel.org; Vadim
> > Pasternak <vadimp@mellanox.com>; Ido Schimmel
> > <idosch@mellanox.com>; Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org>; linux-serial@vger.kernel.org
> > Subject: RE: "No irq handler for vector" problem

can you please teach your mail client not to copy the full header into the
reply. That's really not useful on a mailing list.

> > On June 21, 2019 19:00:25 Thomas Gleixner <tglx@linutronix.de> wrote:
> > >
> > > Not freeing the vector would just paper over the problem. Can you try the
> > > patch below?
> > >
> 
> Tried patch on our system. The problem still exist:
>  [   49.802818] do_IRQ: 0.37 No irq handler for vector

Stared some more into the interrupt code. I think Robert was on the right
track, but I did not see the tree in the forest.

The scenario he described can actually happen and yes, we should deactivate
the interrupt after the synchronize_hardirq() and not before. Tentative fix
below.

Thanks,

	tglx

8<-------------
--- a/kernel/irq/autoprobe.c
+++ b/kernel/irq/autoprobe.c
@@ -90,7 +90,7 @@ unsigned long probe_irq_on(void)
 			/* It triggered already - consider it spurious. */
 			if (!(desc->istate & IRQS_WAITING)) {
 				desc->istate &= ~IRQS_AUTODETECT;
-				irq_shutdown(desc);
+				irq_shutdown_and_deactivate(desc);
 			} else
 				if (i < 32)
 					mask |= 1 << i;
@@ -127,7 +127,7 @@ unsigned int probe_irq_mask(unsigned lon
 				mask |= 1 << i;
 
 			desc->istate &= ~IRQS_AUTODETECT;
-			irq_shutdown(desc);
+			irq_shutdown_and_deactivate(desc);
 		}
 		raw_spin_unlock_irq(&desc->lock);
 	}
@@ -169,7 +169,7 @@ int probe_irq_off(unsigned long val)
 				nr_of_irqs++;
 			}
 			desc->istate &= ~IRQS_AUTODETECT;
-			irq_shutdown(desc);
+			irq_shutdown_and_deactivate(desc);
 		}
 		raw_spin_unlock_irq(&desc->lock);
 	}
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -314,6 +314,12 @@ void irq_shutdown(struct irq_desc *desc)
 		}
 		irq_state_clr_started(desc);
 	}
+}
+
+
+void irq_shutdown_and_deactivate(struct irq_desc *desc)
+{
+	irq_shutdown(desc);
 	/*
 	 * This must be called even if the interrupt was never started up,
 	 * because the activation can happen before the interrupt is
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -116,7 +116,7 @@ static bool migrate_one_irq(struct irq_d
 		 */
 		if (irqd_affinity_is_managed(d)) {
 			irqd_set_managed_shutdown(d);
-			irq_shutdown(desc);
+			irq_shutdown_and_deactivate(desc);
 			return false;
 		}
 		affinity = cpu_online_mask;
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -82,6 +82,7 @@ extern int irq_activate_and_startup(stru
 extern int irq_startup(struct irq_desc *desc, bool resend, bool force);
 
 extern void irq_shutdown(struct irq_desc *desc);
+extern void irq_shutdown_and_deactivate(struct irq_desc *desc);
 extern void irq_enable(struct irq_desc *desc);
 extern void irq_disable(struct irq_desc *desc);
 extern void irq_percpu_enable(struct irq_desc *desc, unsigned int cpu);
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/random.h>
 #include <linux/interrupt.h>
+#include <linux/irqdomain.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
 #include <linux/sched/rt.h>
@@ -1699,6 +1700,7 @@ static struct irqaction *__free_irq(stru
 	/* If this was the last handler, shut down the IRQ line: */
 	if (!desc->action) {
 		irq_settings_clr_disable_unlazy(desc);
+		/* Only shutdown. Deactivate after synchronize_irq() */
 		irq_shutdown(desc);
 	}
 
@@ -1768,6 +1770,14 @@ static struct irqaction *__free_irq(stru
 		 * require it to deallocate resources over the slow bus.
 		 */
 		chip_bus_lock(desc);
+		/*
+		 * There is no interrupt on the fly anymore. Deactivate it
+		 * completely.
+		 */
+		raw_spin_lock_irqsave(&desc->lock, flags);
+		irq_domain_deactivate_irq(&desc->irq_data);
+		raw_spin_unlock_irqrestore(&desc->lock, flags);
+
 		irq_release_resources(desc);
 		chip_bus_sync_unlock(desc);
 		irq_remove_timings(desc);
@@ -1855,7 +1865,7 @@ static const void *__cleanup_nmi(unsigne
 	}
 
 	irq_settings_clr_disable_unlazy(desc);
-	irq_shutdown(desc);
+	irq_shutdown_and_deactivate(desc);
 
 	irq_release_resources(desc);
 




