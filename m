Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 639EBA0C5B
	for <lists+linux-serial@lfdr.de>; Wed, 28 Aug 2019 23:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfH1V2C (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 28 Aug 2019 17:28:02 -0400
Received: from office2.cesnet.cz ([195.113.144.244]:40750 "EHLO
        office2.cesnet.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbfH1V2C (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 28 Aug 2019 17:28:02 -0400
Received: from localhost (unknown [IPv6:2001:718:1:2c:a5b5:770:4491:af45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by office2.cesnet.cz (Postfix) with ESMTPSA id 3FE10400093;
        Wed, 28 Aug 2019 23:21:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
        s=office2; t=1567027315;
        bh=nYlT2H1UO2l0oo6Lh4ihSsFyuxCxXdiwIzdAqxvSaF4=;
        h=Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:From:Date:Subject:To:Cc;
        b=k9Qegsg1PK8yGqQ513ozYN6FQFdzt7nQxQ3avTHuHsoCG0B0VvcPRNKPjNJSWyeIH
         JRxbY9nXbTODTGC17wfaeyx68JPdwupVRaADRV5Uv+ZZeWGx0P0altzTCVv9EZ3qxm
         soOorvYD03qxJL+4m4OKUqzxMPfZXNz5adD0jDhg=
Message-Id: <7b65026af26581722b37347b4557057ba86504a8.1567027079.git.jan.kundrat@cesnet.cz>
In-Reply-To: <13ea227620aaad8a7231d42ed03a8508297d4eb3.1567027079.git.jan.kundrat@cesnet.cz>
References: <13ea227620aaad8a7231d42ed03a8508297d4eb3.1567027079.git.jan.kundrat@cesnet.cz>
From:   =?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>
Date:   Wed, 28 Aug 2019 22:29:30 +0200
Subject: [PATCH 2/2] tty: max310x: Fail probe when external clock crystal is
 not stable
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     linux-serial@vger.kernel.org
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Joe Burmeister <joe.burmeister@devtank.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On (some) of my boards, it appears that it takes up to three *checks* of
this register's value for the external crystal to settle so that it is
reported as "ready" by the chip. For example, on one of these boards it
always succeeds upon a third try no matter if the individual waits are
for 1ms or for 10ms. The original timeout of 10ms is therefore not ideal
as it was generating false warnings on working HW for me. Let's solve
this by retrying up to 20 times (i.e., 200ms).

With this retrying in place, it is now also possible to fail device
initialization altogether. A stable clock is really required in order to
use this UART, so log an error message and bail out if the chip keeps
saying "nope".

Tested on several MAX14830 PCBs.

Signed-off-by: Jan Kundrát <jan.kundrat@cesnet.cz>
---
 drivers/tty/serial/max310x.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 0e0c2740ec7e..e8cd09d3e86f 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -610,11 +610,14 @@ static int max310x_set_ref_clk(struct device *dev, struct max310x_port *s,
 
 	/* Wait for crystal */
 	if (xtal) {
-		unsigned int val;
-		msleep(10);
-		regmap_read(s->regmap, MAX310X_STS_IRQSTS_REG, &val);
+		unsigned int val, i;
+		for (i = 0; i < 20 && !(val & MAX310X_STS_CLKREADY_BIT); ++i) {
+			msleep(10);
+			regmap_read(s->regmap, MAX310X_STS_IRQSTS_REG, &val);
+		}
 		if (!(val & MAX310X_STS_CLKREADY_BIT)) {
-			dev_warn(dev, "clock is not stable yet\n");
+			dev_err(dev, "clock is not stable\n");
+			return -EAGAIN;
 		}
 	}
 
@@ -1301,6 +1304,10 @@ static int max310x_probe(struct device *dev, struct max310x_devtype *devtype,
 	}
 
 	uartclk = max310x_set_ref_clk(dev, s, freq, xtal);
+	if (uartclk < 0) {
+		ret = uartclk;
+		goto out_uart;
+	}
 	dev_dbg(dev, "Reference clock set to %i Hz\n", uartclk);
 
 	for (i = 0; i < devtype->nr; i++) {
-- 
2.21.0


