Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC2C32BE05
	for <lists+linux-serial@lfdr.de>; Tue, 28 May 2019 05:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbfE1D75 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 27 May 2019 23:59:57 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38868 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbfE1D75 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 May 2019 23:59:57 -0400
Received: by mail-pg1-f194.google.com with SMTP id v11so10111281pgl.5
        for <linux-serial@vger.kernel.org>; Mon, 27 May 2019 20:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=accesio-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YfZsnrOT7U9a4u/BVJ2F7JOFa3gpzkk6By6MVzwR6P8=;
        b=m/OsNvDk0biyRqbHhkhyqdUooCSPk7kdlyYWL8cqAnv9Bedl5SljUlsn7PpzvfdmD7
         iLHHPoYg92W0jMvW1Ss5vlS/d9LYLaZAWTerXvc6v+BAd4lBEZ0CW+2YHwSZLKLzDBG4
         5fkqYepGnUsuWzq9p2DqTQ++8JkE8OP/er66JkO++5jCyyWp7Xc9OwtR63WDrQht6e22
         8qcYT63lbWLOqUfMtKup22M5tJQmrRZo03InpAbB1w1YgUhDXi1m43cc5Psb3Yl2NdKh
         CHnBelJanY/52X6hPjkhPBDJUHpoAP5SGCos1a80CfKzrYduSnYgK91vPnLpNwGwkEf4
         Cocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YfZsnrOT7U9a4u/BVJ2F7JOFa3gpzkk6By6MVzwR6P8=;
        b=jMAz03MF6x8vjIO/r3YOJer6D0x8FNiEFS8qQEVukUlMJA0lTwdgOu3B830Q97oHJ+
         oROQUll8eWres4/Ire+tJAWaBxlzhGsjLRhYf2qUP0EdI7Hz9p9ox6gXMxXlfT+Ys6AJ
         wTZf7rUtiIAsX0xet1+sE1e69XKaVy0sXxT8yu0qdbzLe7nSEXSK+flEOU4m9NG+zTnv
         B81WVlAbZy2YvZeR1rCFhPkDnpW7Xylgn9sp4cuyA0udMg8zP/A8YXBhOIPq+RePct4y
         1lTVbznlNr2MM9Ex41YDjnOkceCLihSC+wQ6VnnqwHVISTnXebFCdFwlxfdqVs/YoP+8
         ecsA==
X-Gm-Message-State: APjAAAXZJRbMJBlytg60PdnQjMKBnqFB29cigySXqfn+dqwbZ1xj0x00
        UTfhCDe8TdM8mGGAt0bWNIiJfNCqFmYzXBimRKF1QxSUmiybZtuDtEbTZ6awU+Tmb+ncPgT/Ruy
        t/H/NnutubneXt6ffYTZmRqA7kvUdDb284koQtHNEUOx5v480GKbT28U8/JUv6irJPQdGmu3sjj
        q3
X-Google-Smtp-Source: APXvYqzVpV8Uqvyrq9S1fpCvRu5GUr9bBjTrf/feHLyw/l96uU3b0c7a8LfLZ21btUGT+CDWMsaf3Q==
X-Received: by 2002:a17:90a:cb89:: with SMTP id a9mr2884692pju.67.1559015996154;
        Mon, 27 May 2019 20:59:56 -0700 (PDT)
Received: from acces-pc.dolannet.net (cpe-70-95-148-49.san.res.rr.com. [70.95.148.49])
        by smtp.gmail.com with ESMTPSA id j64sm23438052pfb.126.2019.05.27.20.59.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 20:59:55 -0700 (PDT)
From:   jay.dolan@accesio.com
To:     linux-serial@vger.kernel.org
Cc:     Jay Dolan <jay.dolan@accesio.com>
Subject: [PATCH v3 1/1] serial: 8250: Add support for higher baud rates to Pericom chips
Date:   Mon, 27 May 2019 20:59:43 -0700
Message-Id: <20190528035943.6274-2-jay.dolan@accesio.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190528035943.6274-1-jay.dolan@accesio.com>
References: <20190528035943.6274-1-jay.dolan@accesio.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Jay Dolan <jay.dolan@accesio.com>

The Pericom chips can achieve additional baud rates by programming the
sample clock register. The baud rates can be described as
921600 * 16 / (16 - scr) for scr values 5 to 15. The divisor is set to 1
for these baud rates.

Adds new quirk for Pericom chips other than the four port chips to use
the

Signed-off-by: Jay Dolan <jay.dolan@accesio.com>
---
 drivers/tty/serial/8250/8250_pci.c | 97 ++++++++++++++++++++++++------
 1 file changed, 79 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index df41397de478..9a895ae449c5 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1326,13 +1326,66 @@ static int pci_default_setup(struct serial_private *priv,
 
 	return setup_port(priv, port, bar, offset, board->reg_shift);
 }
-
+void
+pericom_do_set_divisor(struct uart_port *port, unsigned int baud,
+			       unsigned int quot, unsigned int quot_frac)
+{
+	int scr;
+	int lcr;
+	int actual_baud;
+	int tolerance;
+
+	for (scr = 5 ; scr <= 15 ; scr++) {
+		actual_baud = 921600 * 16 / scr;
+		tolerance = actual_baud / 50;
+
+		if ((baud < actual_baud + tolerance) &&
+			(baud > actual_baud - tolerance)) {
+
+			lcr = serial_port_in(port, UART_LCR);
+			serial_port_out(port, UART_LCR, lcr | 0x80);
+
+			serial_port_out(port, UART_DLL, 1);
+			serial_port_out(port, UART_DLM, 0);
+			serial_port_out(port, UART_PCM_SCR, 16 - scr);
+			serial_port_out(port, UART_LCR, lcr);
+			return;
+		} else if (baud > actual_baud) {
+			break;
+		}
+	}
+	serial8250_do_set_divisor(port, baud, quot, quot_frac);
+}
 static int pci_pericom_setup(struct serial_private *priv,
 		  const struct pciserial_board *board,
 		  struct uart_8250_port *port, int idx)
 {
 	unsigned int bar, offset = board->first_offset, maxnr;
 
+	bar = FL_GET_BASE(board->flags);
+	if (board->flags & FL_BASE_BARS)
+		bar += idx;
+	else
+		offset += idx * board->uart_offset;
+
+
+	maxnr = (pci_resource_len(priv->dev, bar) - board->first_offset) >>
+		(board->reg_shift + 3);
+
+	if (board->flags & FL_REGION_SZ_CAP && idx >= maxnr)
+		return 1;
+
+	port->port.set_divisor = pericom_do_set_divisor;
+
+	return setup_port(priv, port, bar, offset, board->reg_shift);
+}
+
+static int pci_pericom_setup_four_at_eight(struct serial_private *priv,
+		  const struct pciserial_board *board,
+		  struct uart_8250_port *port, int idx)
+{
+	unsigned int bar, offset = board->first_offset, maxnr;
+
 	bar = FL_GET_BASE(board->flags);
 	if (board->flags & FL_BASE_BARS)
 		bar += idx;
@@ -1348,6 +1401,8 @@ static int pci_pericom_setup(struct serial_private *priv,
 	if (board->flags & FL_REGION_SZ_CAP && idx >= maxnr)
 		return 1;
 
+	port->port.set_divisor = pericom_do_set_divisor;
+
 	return setup_port(priv, port, bar, offset, board->reg_shift);
 }
 
@@ -1995,7 +2050,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.device		= PCI_DEVICE_ID_PERICOM_PI7C9X7954,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
-		.setup		= pci_pericom_setup,
+		.setup		= pci_pericom_setup_four_at_eight,
 	},
 	/*
 	 * PLX
@@ -2032,107 +2087,113 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.device     = PCI_DEVICE_ID_ACCESIO_PCIE_COM_4SDB,
 		.subvendor  = PCI_ANY_ID,
 		.subdevice  = PCI_ANY_ID,
-		.setup      = pci_pericom_setup,
+		.setup      = pci_pericom_setup_four_at_eight,
 	},
 	{
 		.vendor     = PCI_VENDOR_ID_ACCESIO,
 		.device     = PCI_DEVICE_ID_ACCESIO_MPCIE_COM_4S,
 		.subvendor  = PCI_ANY_ID,
 		.subdevice  = PCI_ANY_ID,
-		.setup      = pci_pericom_setup,
+		.setup      = pci_pericom_setup_four_at_eight,
 	},
 	{
 		.vendor     = PCI_VENDOR_ID_ACCESIO,
 		.device     = PCI_DEVICE_ID_ACCESIO_PCIE_COM232_4DB,
 		.subvendor  = PCI_ANY_ID,
 		.subdevice  = PCI_ANY_ID,
-		.setup      = pci_pericom_setup,
+		.setup      = pci_pericom_setup_four_at_eight,
 	},
 	{
 		.vendor     = PCI_VENDOR_ID_ACCESIO,
 		.device     = PCI_DEVICE_ID_ACCESIO_MPCIE_COM232_4,
 		.subvendor  = PCI_ANY_ID,
 		.subdevice  = PCI_ANY_ID,
-		.setup      = pci_pericom_setup,
+		.setup      = pci_pericom_setup_four_at_eight,
 	},
 	{
 		.vendor     = PCI_VENDOR_ID_ACCESIO,
 		.device     = PCI_DEVICE_ID_ACCESIO_PCIE_COM_4SMDB,
 		.subvendor  = PCI_ANY_ID,
 		.subdevice  = PCI_ANY_ID,
-		.setup      = pci_pericom_setup,
+		.setup      = pci_pericom_setup_four_at_eight,
 	},
 	{
 		.vendor     = PCI_VENDOR_ID_ACCESIO,
 		.device     = PCI_DEVICE_ID_ACCESIO_MPCIE_COM_4SM,
 		.subvendor  = PCI_ANY_ID,
 		.subdevice  = PCI_ANY_ID,
-		.setup      = pci_pericom_setup,
+		.setup      = pci_pericom_setup_four_at_eight,
 	},
 	{
 		.vendor     = PCI_VENDOR_ID_ACCESIO,
 		.device     = PCI_DEVICE_ID_ACCESIO_MPCIE_ICM422_4,
 		.subvendor  = PCI_ANY_ID,
 		.subdevice  = PCI_ANY_ID,
-		.setup      = pci_pericom_setup,
+		.setup      = pci_pericom_setup_four_at_eight,
 	},
 	{
 		.vendor     = PCI_VENDOR_ID_ACCESIO,
 		.device     = PCI_DEVICE_ID_ACCESIO_MPCIE_ICM485_4,
 		.subvendor  = PCI_ANY_ID,
 		.subdevice  = PCI_ANY_ID,
-		.setup      = pci_pericom_setup,
+		.setup      = pci_pericom_setup_four_at_eight,
 	},
 	{
 		.vendor     = PCI_DEVICE_ID_ACCESIO_PCIE_ICM_4S,
 		.device     = PCI_DEVICE_ID_ACCESIO_PCIE_ICM232_4,
 		.subvendor  = PCI_ANY_ID,
 		.subdevice  = PCI_ANY_ID,
-		.setup      = pci_pericom_setup,
+		.setup      = pci_pericom_setup_four_at_eight,
 	},
 	{
 		.vendor     = PCI_VENDOR_ID_ACCESIO,
 		.device     = PCI_DEVICE_ID_ACCESIO_MPCIE_ICM232_4,
 		.subvendor  = PCI_ANY_ID,
 		.subdevice  = PCI_ANY_ID,
-		.setup      = pci_pericom_setup,
+		.setup      = pci_pericom_setup_four_at_eight,
 	},
 	{
 		.vendor     = PCI_VENDOR_ID_ACCESIO,
 		.device     = PCI_DEVICE_ID_ACCESIO_PCIE_COM422_4,
 		.subvendor  = PCI_ANY_ID,
 		.subdevice  = PCI_ANY_ID,
-		.setup      = pci_pericom_setup,
+		.setup      = pci_pericom_setup_four_at_eight,
 	},
 	{
 		.vendor     = PCI_VENDOR_ID_ACCESIO,
 		.device     = PCI_DEVICE_ID_ACCESIO_PCIE_COM485_4,
 		.subvendor  = PCI_ANY_ID,
 		.subdevice  = PCI_ANY_ID,
-		.setup      = pci_pericom_setup,
+		.setup      = pci_pericom_setup_four_at_eight,
 	},
 	{
 		.vendor     = PCI_VENDOR_ID_ACCESIO,
 		.device     = PCI_DEVICE_ID_ACCESIO_PCIE_COM232_4,
 		.subvendor  = PCI_ANY_ID,
 		.subdevice  = PCI_ANY_ID,
-		.setup      = pci_pericom_setup,
+		.setup      = pci_pericom_setup_four_at_eight,
 	},
 	{
 		.vendor     = PCI_VENDOR_ID_ACCESIO,
 		.device     = PCI_DEVICE_ID_ACCESIO_PCIE_COM_4SM,
 		.subvendor  = PCI_ANY_ID,
 		.subdevice  = PCI_ANY_ID,
-		.setup      = pci_pericom_setup,
+		.setup      = pci_pericom_setup_four_at_eight,
 	},
 	{
 		.vendor     = PCI_VENDOR_ID_ACCESIO,
 		.device     = PCI_DEVICE_ID_ACCESIO_PCIE_ICM_4SM,
 		.subvendor  = PCI_ANY_ID,
 		.subdevice  = PCI_ANY_ID,
-		.setup      = pci_pericom_setup,
+		.setup      = pci_pericom_setup_four_at_eight,
 	},
-	/*
+	{
+		.vendor     = PCI_VENDOR_ID_ACCESIO,
+		.device     = PCI_ANY_ID,
+		.subvendor  = PCI_ANY_ID,
+		.subdevice  = PCI_ANY_ID,
+		.setup      = pci_pericom_setup,
+	},	/*
 	 * SBS Technologies, Inc., PMC-OCTALPRO 232
 	 */
 	{
-- 
2.17.1

