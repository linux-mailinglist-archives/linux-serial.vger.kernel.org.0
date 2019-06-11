Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAED33CA55
	for <lists+linux-serial@lfdr.de>; Tue, 11 Jun 2019 13:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389953AbfFKLrd (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 11 Jun 2019 07:47:33 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42836 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389881AbfFKLrd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 11 Jun 2019 07:47:33 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so7271777pff.9
        for <linux-serial@vger.kernel.org>; Tue, 11 Jun 2019 04:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=accesio-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jzdTnYTIOXokO0oHOpiG94LWr0tBZSe7Na/PAAIVWWU=;
        b=swMAmGfKlkdF+16Pdu9mHxKLf5emnnvCi9ZBC6nOq/em71n16zGcYtY2cj9omGVmUq
         /nDZqyYtmTIHOcmW4vOm3BbkCWidAhQewq+XKkc/FeDcjJBcy4EFU7DcKUBLj0uaeFuf
         rs/e4o6Aajn4mluMN5ZVsavIBBNdbRhMaw9j2mpi7KnsmfwVLIm2TG8FMWjSb6Fg4vkS
         k4pbjhRm5DtpQYAtYfNk8MzWIOo+cT0bH6CrpmGi655atMRxCcHD3WYaM3d40jZZAfW0
         AnfXcWUgjP6BrS4OC6ACml8Y0yGoQI/CmxaEJaxpBUDf7JvHF2nZU3MjO0J2BJus2mGu
         3knA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jzdTnYTIOXokO0oHOpiG94LWr0tBZSe7Na/PAAIVWWU=;
        b=TEZjKWV1EOJ/VObeHuhVFZnFsYaPmq18xdo8SBaAprjvM35S4bJZt2ZIj7jYpUu1CC
         uDZXBOTjqulZjKGJdMDCZHZUx/O0qoZBqZOGl2o3MFZkC/61iYHlGb6HjqPGN3weq710
         XJkFb9oD//DDCOI5Svqk5/fImRIhCwHFvn2f0OrtgL4TN5IXfPiqmCCiEnLhNd/N2/nv
         YY5ybfbyApIMja+G01bCS8JjVGstpcPgLp+PipWvq32qjYPl6swo9AQsXZg0Sd60ZfQw
         dGwxR7sRyH3iAbxhsT5oDbL4ki6KYQWJKCEDkxTZ6rroUWzgQTexhFVMYLNnZ3bO0NOV
         rTuA==
X-Gm-Message-State: APjAAAWchRSaSibOSR7FqkEFyZYNhY5OGc4Utwv7anX8+OB8GLobmr6j
        6XU9xwyGlhrpINyPWOPwWIoCh1Rqw3OhaYynLvNDBuA+s/UVMx8ycpDwnuT8W/BV0eb94jBH1b0
        fYFlc5lfZd7CiymhxjStqVWxD28j8CNUZ1oq+tUVktzGPEP4FOkYBp/EotG+k1aTLCGSmH7WasE
        jF
X-Google-Smtp-Source: APXvYqztgFlBXy5d13yLQQXW/pLqfG9wKIwpAPsgovlN9xEMB7g0cWFGvMw+wCrlzTLskGzIuCP/NQ==
X-Received: by 2002:a63:4001:: with SMTP id n1mr18945148pga.382.1560253652080;
        Tue, 11 Jun 2019 04:47:32 -0700 (PDT)
Received: from acces-pc.dolannet.net (cpe-70-95-148-49.san.res.rr.com. [70.95.148.49])
        by smtp.gmail.com with ESMTPSA id 25sm14174078pfp.76.2019.06.11.04.47.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 04:47:31 -0700 (PDT)
From:   jay.dolan@accesio.com
To:     linux-serial@vger.kernel.org
Cc:     Jay Dolan <jay.dolan@accesio.com>
Subject: [PATCH v4 1/1] serial: 8250: Add support for higher baud rates to Pericom chips
Date:   Tue, 11 Jun 2019 04:47:15 -0700
Message-Id: <20190611114715.31372-2-jay.dolan@accesio.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190611114715.31372-1-jay.dolan@accesio.com>
References: <20190611114715.31372-1-jay.dolan@accesio.com>
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
index df41397de478..7ba1c3b2381d 100644
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
+			serial_port_out(port, 2, 16 - scr);
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

