Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E545F7DE69
	for <lists+linux-serial@lfdr.de>; Thu,  1 Aug 2019 17:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbfHAPEb (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 1 Aug 2019 11:04:31 -0400
Received: from bonobo.elm.relay.mailchannels.net ([23.83.212.22]:34887 "EHLO
        bonobo.elm.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731420AbfHAPEa (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 1 Aug 2019 11:04:30 -0400
X-Sender-Id: dreamhost|x-authsender|robert.middleton@rm5248.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 915D834343A;
        Thu,  1 Aug 2019 14:58:42 +0000 (UTC)
Received: from pdx1-sub0-mail-a90.g.dreamhost.com (100-96-29-186.trex.outbound.svc.cluster.local [100.96.29.186])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id D862B343471;
        Thu,  1 Aug 2019 14:58:41 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|robert.middleton@rm5248.com
Received: from pdx1-sub0-mail-a90.g.dreamhost.com ([TEMPUNAVAIL].
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.17.5);
        Thu, 01 Aug 2019 14:58:42 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|robert.middleton@rm5248.com
X-MailChannels-Auth-Id: dreamhost
X-Army-Well-Made: 4c04438d3ac039e1_1564671522383_653288784
X-MC-Loop-Signature: 1564671522382:1890551398
X-MC-Ingress-Time: 1564671522382
Received: from pdx1-sub0-mail-a90.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a90.g.dreamhost.com (Postfix) with ESMTP id 24E63802A9;
        Thu,  1 Aug 2019 07:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=rm5248.com; h=from:to:cc
        :subject:date:message-id; s=rm5248.com; bh=zWC1TB9NAbjqK1Hlh6A/F
        GtfCm8=; b=Qpedbs1HDE4OTMOPi/g5S2MrBaftw5DaOJs4tfAEoOnIn1ikQJbrW
        QO+1S3iSGmVQx26cbm94GzpiHcLUUjEi/FoA/TVDgMs54ANkMypKXqkER33P7+fu
        FX93+gCoMSfJQe38CyITSjriwKgkXSBmkmLWxdUAfhEeFjrmlJ+g7U=
Received: from localhost.localdomain (50-195-76-73-static.hfc.comcastbusiness.net [50.195.76.73])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: robert.middleton@rm5248.com)
        by pdx1-sub0-mail-a90.g.dreamhost.com (Postfix) with ESMTPSA id 825CD8028C;
        Thu,  1 Aug 2019 07:58:35 -0700 (PDT)
X-DH-BACKEND: pdx1-sub0-mail-a90
From:   Robert Middleton <robert.middleton@rm5248.com>
To:     linux-serial@vger.kernel.org
Cc:     Robert Middleton <robert.middleton@rm5248.com>
Subject: [PATCH v3] serial: 8250_exar: Clear buffer before shutdown
Date:   Thu,  1 Aug 2019 10:56:40 -0400
Message-Id: <20190801145640.26080-1-robert.middleton@rm5248.com>
X-Mailer: git-send-email 2.11.0
X-VR-OUT-STATUS: OK
X-VR-OUT-SCORE: 0
X-VR-OUT-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrleejgdektdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucggtfgfnhhsuhgsshgtrhhisggvpdfftffgtefojffquffvnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffosedttdertdertddtnecuhfhrohhmpeftohgsvghrthcuofhiuggulhgvthhonhcuoehrohgsvghrthdrmhhiuggulhgvthhonhesrhhmhedvgeekrdgtohhmqeenucffohhmrghinhepphhorhhtrdguvghvnecukfhppeehtddrudelhedrjeeirdejfeenucfrrghrrghmpehmohguvgepshhmthhppdhhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeehtddrudelhedrjeeirdejfedprhgvthhurhhnqdhprghthheptfhosggvrhhtucfoihguughlvghtohhnuceorhhosggvrhhtrdhmihguughlvghtohhnsehrmhehvdegkedrtghomheqpdhmrghilhhfrhhomheprhhosggvrhhtrdhmihguughlvghtohhnsehrmhehvdegkedrtghomhdpnhhrtghpthhtoheprhhosggvrhhtrdhmihguughlvghtohhnsehrmhehvdegkedrtghomhenucevlhhushhtvghrufhiiigvpedt
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

When closing and shutting down the exar serial port, if the chip
has not finished sending all of the data in its buffer, the
remaining bytes will be lost.  Hold off on the shutdown until the
bytes have all been sent.

Signed-off-by: Robert Middleton <robert.middleton@rm5248.com>
---
Changes in v3:
- Added a counter(up to 1000) to terminate the loop if the hardware
  goes away/has a problem, as per Greg K-H

 drivers/tty/serial/8250/8250_exar.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index edd6dfe055bf..f0eb49113b6a 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -19,6 +19,7 @@
 #include <linux/string.h>
 #include <linux/tty.h>
 #include <linux/8250_pci.h>
+#include <linux/delay.h>
 
 #include <asm/byteorder.h>
 
@@ -457,6 +458,27 @@ static irqreturn_t exar_misc_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static void
+exar_shutdown(struct uart_port *port)
+{
+	unsigned char lsr;
+	bool tx_complete = 0;
+	struct uart_8250_port *up = up_to_u8250p(port);
+	struct circ_buf *xmit = &port->state->xmit;
+	int i = 0;
+
+	do {
+		lsr = serial_in(up, UART_LSR);
+		if (lsr & (UART_LSR_TEMT | UART_LSR_THRE))
+			tx_complete = 1;
+		else
+			tx_complete = 0;
+		msleep(1);
+	} while (!uart_circ_empty(xmit) && !tx_complete && i++ < 1000);
+
+	serial8250_do_shutdown(port);
+}
+
 static int
 exar_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *ent)
 {
@@ -500,6 +522,7 @@ exar_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *ent)
 			  | UPF_EXAR_EFR;
 	uart.port.irq = pci_irq_vector(pcidev, 0);
 	uart.port.dev = &pcidev->dev;
+	uart.port.shutdown = exar_shutdown;
 
 	rc = devm_request_irq(&pcidev->dev, uart.port.irq, exar_misc_handler,
 			 IRQF_SHARED, "exar_uart", priv);
-- 
2.11.0

