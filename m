Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 757B611CA5D
	for <lists+linux-serial@lfdr.de>; Thu, 12 Dec 2019 11:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbfLLKQ7 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 12 Dec 2019 05:16:59 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58685 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728435AbfLLKQ7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Dec 2019 05:16:59 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ifLWi-0007bi-8o; Thu, 12 Dec 2019 11:16:56 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1ifLWg-00082u-UW; Thu, 12 Dec 2019 11:16:54 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 2/2] serdev: make use of printk extension %pe for better error messages
Date:   Thu, 12 Dec 2019 11:16:49 +0100
Message-Id: <20191212101649.18126-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191212101649.18126-1-u.kleine-koenig@pengutronix.de>
References: <20191212101649.18126-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

With %pe the symbolic name is printed, so you get

	failure adding device. status -EIO

which is more expressive than the current state

	failure adding device. status -5

.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serdev/core.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 226adeec2aed..e50665425902 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -115,8 +115,8 @@ int serdev_device_add(struct serdev_device *serdev)
 
 	err = device_add(&serdev->dev);
 	if (err < 0) {
-		dev_err(&serdev->dev, "Can't add %s, status %d\n",
-			dev_name(&serdev->dev), err);
+		dev_err(&serdev->dev, "Can't add %s, status %pe\n",
+			dev_name(&serdev->dev), ERR_PTR(err));
 		goto err_clear_serdev;
 	}
 
@@ -540,7 +540,8 @@ static int of_serdev_register_devices(struct serdev_controller *ctrl)
 		err = serdev_device_add(serdev);
 		if (err) {
 			dev_err(&serdev->dev,
-				"failure adding device. status %d\n", err);
+				"failure adding device. status %pe\n",
+				ERR_PTR(err));
 			serdev_device_put(serdev);
 		} else
 			found = true;
@@ -656,7 +657,8 @@ static acpi_status acpi_serdev_register_device(struct serdev_controller *ctrl,
 	err = serdev_device_add(serdev);
 	if (err) {
 		dev_err(&serdev->dev,
-			"failure adding ACPI serdev device. status %d\n", err);
+			"failure adding ACPI serdev device. status %pe\n",
+			ERR_PTR(err));
 		serdev_device_put(serdev);
 	}
 
@@ -731,8 +733,8 @@ int serdev_controller_add(struct serdev_controller *ctrl)
 	ret_of = of_serdev_register_devices(ctrl);
 	ret_acpi = acpi_serdev_register_devices(ctrl);
 	if (ret_of && ret_acpi) {
-		dev_dbg(&ctrl->dev, "no devices registered: of:%d acpi:%d\n",
-			ret_of, ret_acpi);
+		dev_dbg(&ctrl->dev, "no devices registered: of:%pe acpi:%pe\n",
+			ERR_PTR(ret_of), ERR_PTR(ret_acpi));
 		ret = -ENODEV;
 		goto err_rpm_disable;
 	}
-- 
2.24.0

