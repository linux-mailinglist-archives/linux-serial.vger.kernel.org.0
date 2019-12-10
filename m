Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17B90118B1E
	for <lists+linux-serial@lfdr.de>; Tue, 10 Dec 2019 15:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfLJOhm (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 10 Dec 2019 09:37:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:52712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727681AbfLJOhk (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 Dec 2019 09:37:40 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20FCB2077B;
        Tue, 10 Dec 2019 14:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575988659;
        bh=ZZu6g4CiDeZIBwN4xUg7j+IL9wGtec4FD9ThMJUWWyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pyVsl2AwF+Rb+dIKagy9ZSrdqWe8rtMZlGi5PL+0o/xJIQXw9ft9eVi4Fu5yj6DvG
         P47DJ8vavR+vbU3NaJwJRJK+9tkEodLUTSv9iSUzchyepYgHc3XEkKE/oAwh9evvHA
         +CtUSn845z8GZ/5mJ8qti1oD1GYcDa9C061zVE+M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Hyunki Koo <kkoos00@naver.com>,
        HYUN-KI KOO <hyunki00.koo@samsung.com>,
        Shinbeom Choi <sbeom.choi@samsung.com>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] tty: serial: samsung_tty: fix blank line checkpatch warning
Date:   Tue, 10 Dec 2019 15:37:06 +0100
Message-Id: <20191210143706.3928480-10-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191210143706.3928480-1-gregkh@linuxfoundation.org>
References: <20191210143706.3928480-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

checkpatch is giving a bunch of:
	WARNING: Missing a blank line after declarations
messages on this file, so fix up all instances of that issue.

Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Hyunki Koo <kkoos00@naver.com>
Cc: HYUN-KI KOO <hyunki00.koo@samsung.com>
Cc: Shinbeom Choi <sbeom.choi@samsung.com>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/samsung_tty.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 4aebed241068..d5c75d288498 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -1543,6 +1543,7 @@ static void s3c24xx_serial_release_port(struct uart_port *port)
 static int s3c24xx_serial_request_port(struct uart_port *port)
 {
 	const char *name = s3c24xx_serial_portname(port);
+
 	return request_mem_region(port->mapbase, MAP_SIZE, name) ? 0 : -EBUSY;
 }
 
@@ -1963,6 +1964,7 @@ static inline struct s3c24xx_serial_drv_data *s3c24xx_get_driver_data(
 #ifdef CONFIG_OF
 	if (pdev->dev.of_node) {
 		const struct of_device_id *match;
+
 		match = of_match_node(s3c24xx_uart_dt_match, pdev->dev.of_node);
 		return (struct s3c24xx_serial_drv_data *)match->data;
 	}
@@ -2109,6 +2111,7 @@ static int s3c24xx_serial_resume_noirq(struct device *dev)
 		/* restore IRQ mask */
 		if (s3c24xx_serial_has_interrupt_mask(port)) {
 			unsigned int uintm = 0xf;
+
 			if (tx_enabled(port))
 				uintm &= ~S3C64XX_UINTM_TXD_MSK;
 			if (rx_enabled(port))
-- 
2.24.0

