Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D833D4ED86
	for <lists+linux-serial@lfdr.de>; Fri, 21 Jun 2019 19:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbfFURAZ (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 21 Jun 2019 13:00:25 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55430 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfFURAZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 21 Jun 2019 13:00:25 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1heMtf-0001xI-3z; Fri, 21 Jun 2019 19:00:19 +0200
Date:   Fri, 21 Jun 2019 19:00:18 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Hodaszi, Robert" <Robert.Hodaszi@digi.com>
cc:     Michael Shych <michaelsh@mellanox.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: RE: "No irq handler for vector" problem
In-Reply-To: <dcc1febb-2afc-da9b-696e-3c9bf63f4b76@digi.com>
Message-ID: <alpine.DEB.2.21.1906211858340.5503@nanos.tec.linutronix.de>
References: <dcc1febb-2afc-da9b-696e-3c9bf63f4b76@digi.com>
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

On Fri, 21 Jun 2019, Hodaszi, Robert wrote:
> 
> Also, it seems, if I'm running the serial port opening-closing process 
> on the same core as the interrupt is assigned to, I'm not getting the 
> error message. If I'm running it on a different core, most of the time, 
> I'm getting the error message.

...

> Unfortunately, I'm stuck at this point a bit. Don't really know, what 
> would be the proper solution (how could I avoid free'ing up a pending 
> IRQ's vector), also I'm not knowing the x86 part of the kernel very well 
> yet.

Not freeing the vector would just paper over the problem. Can you try the
patch below?

Thanks,

	tglx

8<------------------
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 53aa234a6803..189db40b0524 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -3003,8 +3003,8 @@ void mp_irqdomain_deactivate(struct irq_domain *domain,
 			     struct irq_data *irq_data)
 {
 	/* It won't be called for IRQ with multiple IOAPIC pins associated */
-	ioapic_mask_entry(mp_irqdomain_ioapic_idx(domain),
-			  (int)irq_data->hwirq);
+	clear_IO_APIC_pin(mp_irqdomain_ioapic_idx(domain),
+			  (unsigned int)irq_data->hwirq);
 }
 
 int mp_irqdomain_ioapic_idx(struct irq_domain *domain)
