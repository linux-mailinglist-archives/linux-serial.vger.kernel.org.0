Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 395578D59A
	for <lists+linux-serial@lfdr.de>; Wed, 14 Aug 2019 16:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfHNOID (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 14 Aug 2019 10:08:03 -0400
Received: from mga11.intel.com ([192.55.52.93]:23815 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbfHNOID (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Aug 2019 10:08:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2019 07:08:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,385,1559545200"; 
   d="scan'208";a="178169319"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 14 Aug 2019 07:08:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B4D5518B; Wed, 14 Aug 2019 17:08:00 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Stefan Roese <sr@denx.de>, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] serial: mctrl_gpio: Use gpiod flags directly
Date:   Wed, 14 Aug 2019 17:07:59 +0300
Message-Id: <20190814140759.17486-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Description of the modem line control GPIOs contain a boolean type to set
direction of the line. Since GPIO library provides an enumerator type of flags,
we may utilize it and allow a bit more flexibility on the choice of the type of
the line parameters. It also removes an additional layer of value conversion.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/serial_mctrl_gpio.c | 36 +++++++++++++-------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial/serial_mctrl_gpio.c
index 2b400189be91..d9074303c88e 100644
--- a/drivers/tty/serial/serial_mctrl_gpio.c
+++ b/drivers/tty/serial/serial_mctrl_gpio.c
@@ -27,16 +27,21 @@ struct mctrl_gpios {
 static const struct {
 	const char *name;
 	unsigned int mctrl;
-	bool dir_out;
+	enum gpiod_flags flags;
 } mctrl_gpios_desc[UART_GPIO_MAX] = {
-	{ "cts", TIOCM_CTS, false, },
-	{ "dsr", TIOCM_DSR, false, },
-	{ "dcd", TIOCM_CD, false, },
-	{ "rng", TIOCM_RNG, false, },
-	{ "rts", TIOCM_RTS, true, },
-	{ "dtr", TIOCM_DTR, true, },
+	{ "cts", TIOCM_CTS, GPIOD_IN, },
+	{ "dsr", TIOCM_DSR, GPIOD_IN, },
+	{ "dcd", TIOCM_CD,  GPIOD_IN, },
+	{ "rng", TIOCM_RNG, GPIOD_IN, },
+	{ "rts", TIOCM_RTS, GPIOD_OUT_LOW, },
+	{ "dtr", TIOCM_DTR, GPIOD_OUT_LOW, },
 };
 
+static bool mctrl_gpio_flags_is_dir_out(unsigned int idx)
+{
+	return mctrl_gpios_desc[idx].flags & GPIOD_FLAGS_BIT_DIR_OUT;
+}
+
 void mctrl_gpio_set(struct mctrl_gpios *gpios, unsigned int mctrl)
 {
 	enum mctrl_gpio_idx i;
@@ -48,7 +53,7 @@ void mctrl_gpio_set(struct mctrl_gpios *gpios, unsigned int mctrl)
 		return;
 
 	for (i = 0; i < UART_GPIO_MAX; i++)
-		if (gpios->gpio[i] && mctrl_gpios_desc[i].dir_out) {
+		if (gpios->gpio[i] && mctrl_gpio_flags_is_dir_out(i)) {
 			desc_array[count] = gpios->gpio[i];
 			__assign_bit(count, values,
 				     mctrl & mctrl_gpios_desc[i].mctrl);
@@ -73,7 +78,7 @@ unsigned int mctrl_gpio_get(struct mctrl_gpios *gpios, unsigned int *mctrl)
 		return *mctrl;
 
 	for (i = 0; i < UART_GPIO_MAX; i++) {
-		if (gpios->gpio[i] && !mctrl_gpios_desc[i].dir_out) {
+		if (gpios->gpio[i] && !mctrl_gpio_flags_is_dir_out(i)) {
 			if (gpiod_get_value(gpios->gpio[i]))
 				*mctrl |= mctrl_gpios_desc[i].mctrl;
 			else
@@ -94,7 +99,7 @@ mctrl_gpio_get_outputs(struct mctrl_gpios *gpios, unsigned int *mctrl)
 		return *mctrl;
 
 	for (i = 0; i < UART_GPIO_MAX; i++) {
-		if (gpios->gpio[i] && mctrl_gpios_desc[i].dir_out) {
+		if (gpios->gpio[i] && mctrl_gpio_flags_is_dir_out(i)) {
 			if (gpiod_get_value(gpios->gpio[i]))
 				*mctrl |= mctrl_gpios_desc[i].mctrl;
 			else
@@ -116,7 +121,6 @@ struct mctrl_gpios *mctrl_gpio_init_noauto(struct device *dev, unsigned int idx)
 		return ERR_PTR(-ENOMEM);
 
 	for (i = 0; i < UART_GPIO_MAX; i++) {
-		enum gpiod_flags flags;
 		char *gpio_str;
 		bool present;
 
@@ -131,15 +135,11 @@ struct mctrl_gpios *mctrl_gpio_init_noauto(struct device *dev, unsigned int idx)
 		if (!present)
 			continue;
 
-		if (mctrl_gpios_desc[i].dir_out)
-			flags = GPIOD_OUT_LOW;
-		else
-			flags = GPIOD_IN;
-
 		gpios->gpio[i] =
 			devm_gpiod_get_index_optional(dev,
 						      mctrl_gpios_desc[i].name,
-						      idx, flags);
+						      idx,
+						      mctrl_gpios_desc[i].flags);
 
 		if (IS_ERR(gpios->gpio[i]))
 			return ERR_CAST(gpios->gpio[i]);
@@ -200,7 +200,7 @@ struct mctrl_gpios *mctrl_gpio_init(struct uart_port *port, unsigned int idx)
 	for (i = 0; i < UART_GPIO_MAX; ++i) {
 		int ret;
 
-		if (!gpios->gpio[i] || mctrl_gpios_desc[i].dir_out)
+		if (!gpios->gpio[i] || mctrl_gpio_flags_is_dir_out(i))
 			continue;
 
 		ret = gpiod_to_irq(gpios->gpio[i]);
-- 
2.20.1

