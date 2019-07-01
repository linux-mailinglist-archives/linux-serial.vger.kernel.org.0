Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E43CD26380
	for <lists+linux-serial@lfdr.de>; Wed, 22 May 2019 14:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbfEVMLk (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 22 May 2019 08:11:40 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:32428 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727975AbfEVMLk (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 22 May 2019 08:11:40 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id EAA3DA26B7;
        Wed, 22 May 2019 14:11:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id SthgKyBj_0Xd; Wed, 22 May 2019 14:11:19 +0200 (CEST)
From:   Stefan Roese <sr@denx.de>
To:     linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yegor Yefremov <yegorslists@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH 1/2] serial: mctrl_gpio: Check if GPIO property exisits before requesting it
Date:   Wed, 22 May 2019 14:11:16 +0200
Message-Id: <20190522121117.14347-1-sr@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This patch adds a check for the GPIOs property existence, before the
GPIO is requested. This fixes an issue seen when the 8250 mctrl_gpio
support is added (2nd patch in this patch series) on x86 platforms using
ACPI. Please find a details problem description here:

https://lkml.org/lkml/2016/8/9/357

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Yegor Yefremov <yegorslists@googlemail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 drivers/tty/serial/serial_mctrl_gpio.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial/serial_mctrl_gpio.c
index 39ed56214cd3..cac50b20a119 100644
--- a/drivers/tty/serial/serial_mctrl_gpio.c
+++ b/drivers/tty/serial/serial_mctrl_gpio.c
@@ -116,6 +116,13 @@ struct mctrl_gpios *mctrl_gpio_init_noauto(struct device *dev, unsigned int idx)
 
 	for (i = 0; i < UART_GPIO_MAX; i++) {
 		enum gpiod_flags flags;
+		char *gpio_str;
+
+		/* Check if GPIO property exists and continue if not */
+		gpio_str = kasprintf(GFP_KERNEL, "%s-gpios",
+				     mctrl_gpios_desc[i].name);
+		if (!device_property_present(dev, gpio_str))
+			continue;
 
 		if (mctrl_gpios_desc[i].dir_out)
 			flags = GPIOD_OUT_LOW;
-- 
2.21.0

