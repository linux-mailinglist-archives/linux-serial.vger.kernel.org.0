Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFDAA7B580
	for <lists+linux-serial@lfdr.de>; Wed, 31 Jul 2019 00:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbfG3WNg (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 30 Jul 2019 18:13:36 -0400
Received: from aye.elm.relay.mailchannels.net ([23.83.212.6]:10031 "EHLO
        aye.elm.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726253AbfG3WNf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 30 Jul 2019 18:13:35 -0400
X-Sender-Id: dreamhost|x-authsender|robert.middleton@rm5248.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 6CDE9141A8F;
        Tue, 30 Jul 2019 22:13:33 +0000 (UTC)
Received: from pdx1-sub0-mail-a39.g.dreamhost.com (100-96-88-209.trex.outbound.svc.cluster.local [100.96.88.209])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id C4899141191;
        Tue, 30 Jul 2019 22:13:32 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|robert.middleton@rm5248.com
Received: from pdx1-sub0-mail-a39.g.dreamhost.com ([TEMPUNAVAIL].
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.17.5);
        Tue, 30 Jul 2019 22:13:33 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|robert.middleton@rm5248.com
X-MailChannels-Auth-Id: dreamhost
X-Macabre-Well-Made: 3e7b8f7f35d4d77f_1564524813264_2293073126
X-MC-Loop-Signature: 1564524813264:4152673415
X-MC-Ingress-Time: 1564524813264
Received: from pdx1-sub0-mail-a39.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a39.g.dreamhost.com (Postfix) with ESMTP id 3496F82F55;
        Tue, 30 Jul 2019 15:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=rm5248.com; h=from:to:cc
        :subject:date:message-id; s=rm5248.com; bh=++2BeHmIz8mhIX1wJzYDl
        byprCs=; b=RyLFJm01XNHbvI4Zs0Df6wZSTN0Mo37gLtW+oS3L/sRcWPpHdOoPI
        mRSNvIoh8ikqZI5fVXmPc79gTbFnMfwoLOjkEmNAUg26e8iD4iF3CC0ROa7kmGqh
        PsncYpLfc1eKIsNe8QMvzWxyr9IYDmiO//NiEWNsdd8p7JMSGevzgk=
Received: from localhost.localdomain (50-195-76-73-static.hfc.comcastbusiness.net [50.195.76.73])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: robert.middleton@rm5248.com)
        by pdx1-sub0-mail-a39.g.dreamhost.com (Postfix) with ESMTPSA id 79AEE82F54;
        Tue, 30 Jul 2019 15:13:28 -0700 (PDT)
X-DH-BACKEND: pdx1-sub0-mail-a39
From:   Robert Middleton <robert.middleton@rm5248.com>
To:     linux-serial@vger.kernel.org
Cc:     Robert Middleton <robert.middleton@rm5248.com>
Subject: [PATCH v2] serial: 8250_exar: Clear buffer before shutdown
Date:   Tue, 30 Jul 2019 18:13:08 -0400
Message-Id: <20190730221308.6929-1-robert.middleton@rm5248.com>
X-Mailer: git-send-email 2.11.0
X-VR-OUT-STATUS: OK
X-VR-OUT-SCORE: 0
X-VR-OUT-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrleeggddtkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucggtfgfnhhsuhgsshgtrhhisggvpdfftffgtefojffquffvnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffosedttdertdertddtnecuhfhrohhmpeftohgsvghrthcuofhiuggulhgvthhonhcuoehrohgsvghrthdrmhhiuggulhgvthhonhesrhhmhedvgeekrdgtohhmqeenucffohhmrghinhepphhorhhtrdguvghvnecukfhppeehtddrudelhedrjeeirdejfeenucfrrghrrghmpehmohguvgepshhmthhppdhhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeehtddrudelhedrjeeirdejfedprhgvthhurhhnqdhprghthheptfhosggvrhhtucfoihguughlvghtohhnuceorhhosggvrhhtrdhmihguughlvghtohhnsehrmhehvdegkedrtghomheqpdhmrghilhhfrhhomheprhhosggvrhhtrdhmihguughlvghtohhnsehrmhehvdegkedrtghomhdpnhhrtghpthhtoheprhhosggvrhhtrdhmihguughlvghtohhnsehrmhehvdegkedrtghomhenucevlhhushhtvghrufhiiigvpedt
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

