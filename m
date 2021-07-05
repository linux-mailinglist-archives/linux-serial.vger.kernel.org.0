Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41E43BBCB7
	for <lists+linux-serial@lfdr.de>; Mon,  5 Jul 2021 14:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhGEMOe (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 5 Jul 2021 08:14:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:45014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231183AbhGEMOe (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 5 Jul 2021 08:14:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C757611AE;
        Mon,  5 Jul 2021 12:11:55 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] serial: 8250_pnp: Support configurable clock frequency
Date:   Mon,  5 Jul 2021 20:12:38 +0800
Message-Id: <20210705121238.1223921-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Jianmin Lv <lvjianmin@loongson.cn>

ACPI-based Loongson boards need configurable rather than fixed clock
frequency for serial ports.

Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/tty/serial/8250/8250_pnp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_pnp.c b/drivers/tty/serial/8250/8250_pnp.c
index de90d681b64c..5f8fc724ba46 100644
--- a/drivers/tty/serial/8250/8250_pnp.c
+++ b/drivers/tty/serial/8250/8250_pnp.c
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/serial_core.h>
 #include <linux/bitops.h>
+#include <linux/property.h>
 
 #include <asm/byteorder.h>
 
@@ -474,7 +475,9 @@ serial_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 	uart.port.flags |= UPF_SKIP_TEST | UPF_BOOT_AUTOCONF;
 	if (pnp_irq_flags(dev, 0) & IORESOURCE_IRQ_SHAREABLE)
 		uart.port.flags |= UPF_SHARE_IRQ;
-	uart.port.uartclk = 1843200;
+	if (device_property_read_u32(&dev->dev, "clock-frequency", &uart.port.uartclk)) {
+		uart.port.uartclk = 1843200;
+	}
 	uart.port.dev = &dev->dev;
 
 	line = serial8250_register_8250_port(&uart);
-- 
2.27.0

