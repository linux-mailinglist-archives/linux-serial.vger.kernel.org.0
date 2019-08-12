Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF0C289CE1
	for <lists+linux-serial@lfdr.de>; Mon, 12 Aug 2019 13:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbfHLL2g (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 12 Aug 2019 07:28:36 -0400
Received: from mtaout.hs-regensburg.de ([194.95.104.10]:57194 "EHLO
        mtaout.hs-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728002AbfHLL2g (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 12 Aug 2019 07:28:36 -0400
X-Greylist: delayed 395 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Aug 2019 07:28:34 EDT
Received: from pluto.lfdr (im-mob-039.hs-regensburg.de [172.20.37.154])
        by mtaout.hs-regensburg.de (Postfix) with ESMTP id 466YMn249Qzy5p;
        Mon, 12 Aug 2019 13:21:57 +0200 (CEST)
From:   Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        jailhouse-dev@googlegroups.com
Cc:     Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Jay Dolan <jay.dolan@accesio.com>
Subject: [PATCH] serial: 8250_pci: Implement MSI(-X) support
Date:   Mon, 12 Aug 2019 13:21:52 +0200
Message-Id: <20190812112152.693622-1-ralf.ramsauer@oth-regensburg.de>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PMX-Version: 6.3.3.2656215, Antispam-Engine: 2.7.2.2107409, Antispam-Data: 2019.8.12.110917, AntiVirus-Engine: 5.63.0, AntiVirus-Data: 2019.8.12.5630000
X-PMX-Spam: Gauge=IIIIIIIII, Probability=9%, Report='
 MULTIPLE_RCPTS 0.1, HTML_00_01 0.05, HTML_00_10 0.05, LINES_OF_YELLING_3 0.05, BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_2000_2999 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_7000_LESS 0, LEGITIMATE_SIGNS 0, MULTIPLE_REAL_RCPTS 0, NO_URI_HTTPS 0, __ANY_URI 0, __BODY_NO_MAILTO 0, __CC_NAME 0, __CC_NAME_DIFF_FROM_ACC 0, __CC_REAL_NAMES 0, __CTE 0, __HAS_CC_HDR 0, __HAS_FROM 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __LINES_OF_YELLING 0, __MIME_TEXT_ONLY 0, __MIME_TEXT_P 0, __MIME_TEXT_P1 0, __MIME_VERSION 0, __MULTIPLE_RCPTS_CC_X2 0, __NO_HTML_TAG_RAW 0, __PHISH_SPEAR_SUBJ_TEAM 0, __SANE_MSGID 0, __SUBJ_ALPHA_END 0, __TO_MALFORMED_2 0, __TO_NAME 0, __TO_NAME_DIFF_FROM_ACC 0, __TO_REAL_NAMES 0, __URI_NO_WWW 0, __URI_NS '
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

There may be setups, where legacy interrupts are not available. This is
the caese, e.g., when Linux runs as guest (aka. non-root cell) of the
partitioning hypervisor Jailhouse. There, only MSI(-X) interrupts are
available for guests.

But the 8250_pci driver currently only supports legacy ints. So let's
enable MSI(-X) interrupts.

Nevertheless, this needs to handled with care: while many 8250 devices
actually claim to support MSI(-X) interrupts it should not be enabled be
default. I had at least one device in my hands with broken MSI
implementation.

So better introduce a whitelist with devices that are known to support
MSI(-X) interrupts. I tested all devices mentioned in the patch.

Signed-off-by: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
---
 drivers/tty/serial/8250/8250_pci.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index bbe5cba21522..97992884c0ee 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -53,6 +53,16 @@ struct serial_private {
 	int			line[0];
 };
 
+static const struct pci_device_id pci_use_msi[] = {
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9900,
+			 0xA000, 0x1000) },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9912,
+			 0xA000, 0x1000) },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9922,
+			 0xA000, 0x1000) },
+	{ }
+};
+
 static int pci_default_setup(struct serial_private*,
 	  const struct pciserial_board*, struct uart_8250_port *, int);
 
@@ -3643,7 +3653,22 @@ pciserial_init_ports(struct pci_dev *dev, const struct pciserial_board *board)
 	memset(&uart, 0, sizeof(uart));
 	uart.port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ;
 	uart.port.uartclk = board->base_baud * 16;
-	uart.port.irq = get_pci_irq(dev, board);
+
+	if (pci_match_id(pci_use_msi, dev)) {
+		dev_dbg(&dev->dev, "Using MSI(-X) interrupts\n");
+		pci_set_master(dev);
+		rc = pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_ALL_TYPES);
+	} else {
+		dev_dbg(&dev->dev, "Using legacy interrupts\n");
+		rc = pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_LEGACY);
+	}
+	if (rc < 0) {
+		kfree(priv);
+		priv = ERR_PTR(rc);
+		goto err_deinit;
+	}
+
+	uart.port.irq = pci_irq_vector(dev, 0);
 	uart.port.dev = &dev->dev;
 
 	for (i = 0; i < nr_ports; i++) {
-- 
2.22.0

