Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6582311DC
	for <lists+linux-serial@lfdr.de>; Fri, 31 May 2019 18:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfEaQBr (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 31 May 2019 12:01:47 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:33936 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfEaQBr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 31 May 2019 12:01:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=afcLOKgX4OCVxF4a1lMtB51TBMhd9WaUTbt0JZE8sdA=; b=K7SQjXfvbYmDcBK7oUohd1cdWc
        5/e7pclxjeKmXtoe19jFn4nLNW5Hrauywrc7WCafOoC3i5W9ceXGYAoufDEZntmLz/it13WfJtr/y
        sx3ADo1j4i9lD/gLplWPHbovhAE2+S/GTdEoDrOVgPRm0EtQfT/xONai5IgqYIIsD4qAfH1DJWkGb
        dLyYg/tTY3ccOW3NAlc2lwQC1UWSH4LiZaaCdb07QMGrm0ZO73JKfpMmqw6EVSek0mvppNLDIH3Pd
        XTxj0eEFdik4lu/JiBcCy7/u66ipDrf+TEXbZ1UZ5wWBkcDmafH2SDt3LoWLvUohl7Zhcz2UvgxaD
        ouMuTEDA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([2001:4d48:ad52:3201:222:68ff:fe15:37dd]:50406 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1hWjyQ-0001iJ-Pm; Fri, 31 May 2019 17:01:42 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1hWjyQ-0008Ni-8V; Fri, 31 May 2019 17:01:42 +0100
In-Reply-To: <20190531155700.crrawgf3iot2sm2t@shell.armlinux.org.uk>
References: <20190531155700.crrawgf3iot2sm2t@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH v2] serial: sa1100: add note about modem control signals
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1hWjyQ-0008Ni-8V@rmk-PC.armlinux.org.uk>
Date:   Fri, 31 May 2019 17:01:42 +0100
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

As suggested by Uwe, add a note indicating that the modem control
signals do not support interrupts, which precludes the driver from
using mctrl_gpio_init().

Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/tty/serial/sa1100.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/sa1100.c b/drivers/tty/serial/sa1100.c
index 97bdfeccbea9..8e618129e65c 100644
--- a/drivers/tty/serial/sa1100.c
+++ b/drivers/tty/serial/sa1100.c
@@ -860,6 +860,10 @@ static int sa1100_serial_resume(struct platform_device *dev)
 static int sa1100_serial_add_one_port(struct sa1100_port *sport, struct platform_device *dev)
 {
 	sport->port.dev = &dev->dev;
+
+	// mctrl_gpio_init() requires that the GPIO driver supports interrupts,
+	// but we need to support GPIO drivers for hardware that has no such
+	// interrupts.  Use mctrl_gpio_init_noauto() instead.
 	sport->gpios = mctrl_gpio_init_noauto(sport->port.dev, 0);
 	if (IS_ERR(sport->gpios)) {
 		int err = PTR_ERR(sport->gpios);
-- 
2.7.4

