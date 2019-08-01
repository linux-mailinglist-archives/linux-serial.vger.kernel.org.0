Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E16117E280
	for <lists+linux-serial@lfdr.de>; Thu,  1 Aug 2019 20:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfHASpZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-serial@lfdr.de>); Thu, 1 Aug 2019 14:45:25 -0400
Received: from skedge04.snt-world.com ([91.208.41.69]:44556 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfHASpY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 1 Aug 2019 14:45:24 -0400
Received: from sntmail14r.snt-is.com (unknown [10.203.32.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge04.snt-world.com (Postfix) with ESMTPS id ED90367A7B0;
        Thu,  1 Aug 2019 20:45:21 +0200 (CEST)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail14r.snt-is.com
 (10.203.32.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 1 Aug 2019
 20:45:21 +0200
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Thu, 1 Aug 2019 20:45:21 +0200
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/3] serial: mctrl_gpio: Avoid probe failures in case of
 missing gpiolib
Thread-Topic: [PATCH v2 1/3] serial: mctrl_gpio: Avoid probe failures in case
 of missing gpiolib
Thread-Index: AQHVSJlF+cJCIhOOZEmFG6rcowK4DA==
Date:   Thu, 1 Aug 2019 18:45:21 +0000
Message-ID: <20190801184505.17239-1-frieder.schrempf@kontron.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: ED90367A7B0.AF516
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: festevam@gmail.com, geert+renesas@glider.be,
        gregkh@linuxfoundation.org, jslaby@suse.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org,
        u.kleine-koenig@pengutronix.de
X-Spam-Status: No
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

If CONFIG_GPIOLIB is not enabled, mctrl_gpio_init() and
mctrl_gpio_init_noauto() will currently return an error pointer with
-ENOSYS. As the mctrl GPIOs are usually optional, drivers need to
check for this condition to allow continue probing.

To avoid the need for this check in each driver, we return NULL
instead, as all the mctrl_gpio_*() functions are skipped anyway.
We also adapt mctrl_gpio_to_gpiod() to be in line with this change.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---
Changes in v2
=============
* Move the sh_sci changes to a separate patch
* Add a patch for the 8250 driver
* Add Fabio's R-b tag
---
 drivers/tty/serial/serial_mctrl_gpio.c | 3 +++
 drivers/tty/serial/serial_mctrl_gpio.h | 6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial/serial_mctrl_gpio.c
index 2b400189be91..54c43e02e375 100644
--- a/drivers/tty/serial/serial_mctrl_gpio.c
+++ b/drivers/tty/serial/serial_mctrl_gpio.c
@@ -61,6 +61,9 @@ EXPORT_SYMBOL_GPL(mctrl_gpio_set);
 struct gpio_desc *mctrl_gpio_to_gpiod(struct mctrl_gpios *gpios,
 				      enum mctrl_gpio_idx gidx)
 {
+	if (gpios == NULL)
+		return NULL;
+
 	return gpios->gpio[gidx];
 }
 EXPORT_SYMBOL_GPL(mctrl_gpio_to_gpiod);
diff --git a/drivers/tty/serial/serial_mctrl_gpio.h b/drivers/tty/serial/serial_mctrl_gpio.h
index b7d3cca48ede..1b2ff503b2c2 100644
--- a/drivers/tty/serial/serial_mctrl_gpio.h
+++ b/drivers/tty/serial/serial_mctrl_gpio.h
@@ -114,19 +114,19 @@ static inline
 struct gpio_desc *mctrl_gpio_to_gpiod(struct mctrl_gpios *gpios,
 				      enum mctrl_gpio_idx gidx)
 {
-	return ERR_PTR(-ENOSYS);
+	return NULL;
 }
 
 static inline
 struct mctrl_gpios *mctrl_gpio_init(struct uart_port *port, unsigned int idx)
 {
-	return ERR_PTR(-ENOSYS);
+	return NULL;
 }
 
 static inline
 struct mctrl_gpios *mctrl_gpio_init_noauto(struct device *dev, unsigned int idx)
 {
-	return ERR_PTR(-ENOSYS);
+	return NULL;
 }
 
 static inline
-- 
2.17.1
