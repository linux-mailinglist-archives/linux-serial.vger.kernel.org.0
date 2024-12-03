Return-Path: <linux-serial+bounces-6979-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 325869E1D40
	for <lists+linux-serial@lfdr.de>; Tue,  3 Dec 2024 14:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06005164C35
	for <lists+linux-serial@lfdr.de>; Tue,  3 Dec 2024 13:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002C41EC013;
	Tue,  3 Dec 2024 13:14:40 +0000 (UTC)
X-Original-To: linux-serial@vger.kernel.org
Received: from sym2.noone.org (sym.noone.org [178.63.92.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8031B0F39
	for <linux-serial@vger.kernel.org>; Tue,  3 Dec 2024 13:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.92.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733231679; cv=none; b=agIJkMssxuYRgyGvINlU1SAZ7AZozd9ioiT8WgaYd6EPo7a807xLiLecX2IzAkr2aApCoupVRljqirr/2+CCM3JLgYLZ3GipjMZf5vPHmay8W6mI7Pk2+Cf7qaxmV5LlSRDPpUE1QLgJrPgTUX2wAMVe+huFfIgFR7guEwK1fd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733231679; c=relaxed/simple;
	bh=5l1v7oWMoVTYuhMIDxBZcQhR5K8VC8lFLJO4dutQwrQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=guvbnYKmC7uou9PXXVW0jqZW5RasdqaDfJ4wXjXjqfg4UfDB5A57Ob4tSuUkCTcXnsoBeRj2WKApQC9BzMjkKm4AkZow0/SVhvV+mcS5CcCiKoUkdVmGUG/ZGw0BovwgGxmmgFRv9oFu4FaqozofT2XIbzxKqG7qSVN2MxPiIU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=distanz.ch; spf=none smtp.mailfrom=sym.noone.org; arc=none smtp.client-ip=178.63.92.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=distanz.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sym.noone.org
Received: by sym2.noone.org (Postfix, from userid 1002)
	id 4Y2h2H18zzz3j1bj; Tue,  3 Dec 2024 14:14:30 +0100 (CET)
From: Tobias Klauser <tklauser@distanz.ch>
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH] serial: altera_jtaguart: Use KBUILD_MODNAME
Date: Tue,  3 Dec 2024 14:14:30 +0100
Message-Id: <20241203131430.7094-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

There is no need to redefine the driver name. Use KBUILD_MODNAME and get
rid of DRV_NAME altogether.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/linux-serial/2024120337-unending-renewed-8e7e@gregkh/
Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 drivers/tty/serial/altera_jtaguart.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
index b9c3c3bed0c1..38721e8c73ef 100644
--- a/drivers/tty/serial/altera_jtaguart.c
+++ b/drivers/tty/serial/altera_jtaguart.c
@@ -365,7 +365,7 @@ OF_EARLYCON_DECLARE(juart, "altr,juart-1.0", altera_jtaguart_earlycon_setup);
 
 static struct uart_driver altera_jtaguart_driver = {
 	.owner		= THIS_MODULE,
-	.driver_name	= "altera_jtaguart",
+	.driver_name	= KBUILD_MODNAME,
 	.dev_name	= "ttyJ",
 	.major		= ALTERA_JTAGUART_MAJOR,
 	.minor		= ALTERA_JTAGUART_MINOR,
@@ -451,7 +451,7 @@ static struct platform_driver altera_jtaguart_platform_driver = {
 	.probe	= altera_jtaguart_probe,
 	.remove = altera_jtaguart_remove,
 	.driver	= {
-		.name		= DRV_NAME,
+		.name		= KBUILD_MODNAME,
 		.of_match_table	= of_match_ptr(altera_jtaguart_match),
 	},
 };
@@ -481,4 +481,4 @@ module_exit(altera_jtaguart_exit);
 MODULE_DESCRIPTION("Altera JTAG UART driver");
 MODULE_AUTHOR("Thomas Chou <thomas@wytron.com.tw>");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:" DRV_NAME);
+MODULE_ALIAS("platform:" KBUILD_MODNAME);
-- 
2.47.1


