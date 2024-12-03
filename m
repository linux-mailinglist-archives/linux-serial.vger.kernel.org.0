Return-Path: <linux-serial+bounces-6976-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D34749E1D04
	for <lists+linux-serial@lfdr.de>; Tue,  3 Dec 2024 14:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4DA0B2413F
	for <lists+linux-serial@lfdr.de>; Tue,  3 Dec 2024 12:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032961EBFE8;
	Tue,  3 Dec 2024 12:57:01 +0000 (UTC)
X-Original-To: linux-serial@vger.kernel.org
Received: from sym2.noone.org (sym.noone.org [178.63.92.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EAA1EBFFB
	for <linux-serial@vger.kernel.org>; Tue,  3 Dec 2024 12:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.92.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733230620; cv=none; b=ssuLg0o2XOdGUgNMCfDw7B88rV2A3Y9fPOmh1TCcVTZyVGeoBMpBePzdTSybQDnK4I+9mf3Y1FRPh+UGrHY5Gpi5FCQuAtbETQamE0VAhiC4/C8Sqbs07Fp62kIVmNfaO5JB6UeKQ3lZYPxWOJi8rrJfdzt7q7kVOU0jfIZ3DGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733230620; c=relaxed/simple;
	bh=LJN0lc52yFIRVEqCuqG8eBqB0nyBm0PMkPN91YkKkSA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=FmqLezsMPA3hUv+8N8QKtBG0KM6XFsCffCFLmn27gSOmEGw1Pp/lwUxgWHqHUF4t2jTZet5P+JvSfa5DQNocwBK7yxS00TVKiwM/1pyKC7CgWb5YZuTNau4qk08O9K6GhyS0iBq7+V8Vs/WEJ2/zip11TKBhjihdZpAzFQE89C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=distanz.ch; spf=none smtp.mailfrom=sym.noone.org; arc=none smtp.client-ip=178.63.92.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=distanz.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sym.noone.org
Received: by sym2.noone.org (Postfix, from userid 1002)
	id 4Y2gdz1xZCz3j1br; Tue,  3 Dec 2024 13:56:54 +0100 (CET)
From: Tobias Klauser <tklauser@distanz.ch>
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH] serial: altera_jtaguart: Use DRV_NAME to initialize uart_driver.driver_name
Date: Tue,  3 Dec 2024 13:56:54 +0100
Message-Id: <20241203125654.29657-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Use the DRV_NAME constant instead of the verbatim string.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 drivers/tty/serial/altera_jtaguart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
index b9c3c3bed0c1..9657c3bb8e66 100644
--- a/drivers/tty/serial/altera_jtaguart.c
+++ b/drivers/tty/serial/altera_jtaguart.c
@@ -365,7 +365,7 @@ OF_EARLYCON_DECLARE(juart, "altr,juart-1.0", altera_jtaguart_earlycon_setup);
 
 static struct uart_driver altera_jtaguart_driver = {
 	.owner		= THIS_MODULE,
-	.driver_name	= "altera_jtaguart",
+	.driver_name	= DRV_NAME,
 	.dev_name	= "ttyJ",
 	.major		= ALTERA_JTAGUART_MAJOR,
 	.minor		= ALTERA_JTAGUART_MINOR,
-- 
2.47.0


