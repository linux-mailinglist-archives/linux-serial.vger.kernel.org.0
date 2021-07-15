Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 382303C98B7
	for <lists+linux-serial@lfdr.de>; Thu, 15 Jul 2021 08:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbhGOGTC (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 15 Jul 2021 02:19:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:53000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231149AbhGOGTC (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 15 Jul 2021 02:19:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9117F61358;
        Thu, 15 Jul 2021 06:16:07 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V3] serial: 8250_pnp: Support configurable clock frequency
Date:   Thu, 15 Jul 2021 14:16:37 +0800
Message-Id: <20210715061637.134436-1-chenhuacai@loongson.cn>
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
V2: Remove unnecessary braces for single statement blocks
V3: Remove unnecessary conditional statement
 drivers/tty/serial/8250/8250_pnp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pnp.c b/drivers/tty/serial/8250/8250_pnp.c
index de90d681b64c..98e5ee4d0d08 100644
--- a/drivers/tty/serial/8250/8250_pnp.c
+++ b/drivers/tty/serial/8250/8250_pnp.c
@@ -13,6 +13,7 @@
 #include <linux/pnp.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
+#include <linux/property.h>
 #include <linux/serial_core.h>
 #include <linux/bitops.h>
 
@@ -475,6 +476,7 @@ serial_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 	if (pnp_irq_flags(dev, 0) & IORESOURCE_IRQ_SHAREABLE)
 		uart.port.flags |= UPF_SHARE_IRQ;
 	uart.port.uartclk = 1843200;
+	device_property_read_u32(&dev->dev, "clock-frequency", &uart.port.uartclk);
 	uart.port.dev = &dev->dev;
 
 	line = serial8250_register_8250_port(&uart);
-- 
2.27.0

