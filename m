Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 445291D9F26
	for <lists+linux-serial@lfdr.de>; Tue, 19 May 2020 20:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgESSWB (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 19 May 2020 14:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729244AbgESSWA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 19 May 2020 14:22:00 -0400
Received: from mail.bugwerft.de (mail.bugwerft.de [IPv6:2a03:6000:1011::59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 77369C08C5C1;
        Tue, 19 May 2020 11:22:00 -0700 (PDT)
Received: from zenbar.fritz.box (pd95ef292.dip0.t-ipconnect.de [217.94.242.146])
        by mail.bugwerft.de (Postfix) with ESMTPSA id 8631340AEC3;
        Tue, 19 May 2020 18:19:03 +0000 (UTC)
From:   Daniel Mack <daniel@zonque.org>
To:     devicetree@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org, jslaby@suse.com,
        jringle@gridpoint.com, m.brock@vanmierlo.com,
        pascal.huerst@gmail.com, Daniel Mack <daniel@zonque.org>
Subject: [PATCH v2 5/6] sc16is7xx: Allow sharing the IRQ line
Date:   Tue, 19 May 2020 20:21:46 +0200
Message-Id: <20200519182147.218713-6-daniel@zonque.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200519182147.218713-1-daniel@zonque.org>
References: <20200519182147.218713-1-daniel@zonque.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

When the interrupt line is shared with other devices, the IRQ must be
level-triggered, as only one device can trigger a falling edge. To support
this, try to acquire the IRQ with IRQF_TRIGGER_LOW|IRQF_SHARED first.

Interrupt controllers that lack support for level-triggers will return an
error, in which case the driver will now retry the acqusition with
IRQF_TRIGGER_FALLING, which was also the default before.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 drivers/tty/serial/sc16is7xx.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index cebc0cf9c30e..7e2360f8e393 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1313,7 +1313,19 @@ static int sc16is7xx_probe(struct device *dev,
 				s->p[u].irda_mode = true;
 	}
 
-	/* Setup interrupt */
+	/*
+	 * Setup interrupt. We first try to acquire the IRQ line as level IRQ.
+	 * If that succeeds, we can allow sharing the interrupt as well.
+	 * In case the interrupt controller doesn't support that, we fall
+	 * back to a non-shared falling-edge trigger.
+	 */
+	ret = devm_request_threaded_irq(dev, irq, NULL, sc16is7xx_irq,
+					IRQF_TRIGGER_LOW | IRQF_SHARED |
+					IRQF_ONESHOT,
+					dev_name(dev), s);
+	if (!ret)
+		return 0;
+
 	ret = devm_request_threaded_irq(dev, irq, NULL, sc16is7xx_irq,
 					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 					dev_name(dev), s);
-- 
2.26.2

