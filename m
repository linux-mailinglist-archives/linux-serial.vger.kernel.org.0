Return-Path: <linux-serial+bounces-10904-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7AAB9ABBB
	for <lists+linux-serial@lfdr.de>; Wed, 24 Sep 2025 17:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAC4618877F7
	for <lists+linux-serial@lfdr.de>; Wed, 24 Sep 2025 15:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEC8314A75;
	Wed, 24 Sep 2025 15:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="yOJGmxMN"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F513312812;
	Wed, 24 Sep 2025 15:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758728283; cv=none; b=JzeDKfAf+VWglTJPUTQh7+Tg8byFMya6IhfrSYW279rJwOqBYYTj+3/JV4VYn/NHWh3S1MauuRNQ/ihx7s42ohE79igaS9JkJw8XZg5giaINSdl3ed4uKU9Ml4fYzzPNaWW+cN3/nxzfTuWtGKjNL17gcvkyQDDLh0fV19Larzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758728283; c=relaxed/simple;
	bh=EiHkljC9QU3UQx5Q0Xp7xpqJC6W8tI5E/JbkJFZsgFc=;
	h=From:To:Cc:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Subject; b=q624XIB1nsbehDwAo8ieqpTL+yZLwO4twa/qLBnHMF8IUOE+TKLIO8hhoHiSlF6C/qbiTuU4vigp2789oE2cy8J7DMax4ZTxEAjzQBK3JI8iUah9SH0pPRBYrBd+TGxi4Wy1jJwQhBAQJzd9V0iYkYwueWdeBEMasvuDGdgdQX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=yOJGmxMN; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=wfqEx0e56u3qVbZT8ZufXWs8gMjtToIcof8Yh3RTjFg=; b=yOJGmxMNGEtMGm1jxhyvUySnta
	w8D6dcoXaQ5CvheqJuwC0UwCAeRl9PH0cDQLYicrEuWXFW9ljIw6AvrV9Qg+lUGyiBcFS5M4x3fdV
	tBzmqG2o2pHml4AUbkjGE4CDcedspSxvVUtirBtOWMf1Ej1ILIA99waaRe1OhnIZKdaA=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:51978 helo=localhost.localdomain)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1v1RZ8-0000RT-OK; Wed, 24 Sep 2025 11:37:58 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	fvallee@eukrea.fr
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Wed, 24 Sep 2025 11:37:37 -0400
Message-Id: <20250924153740.806444-13-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250924153740.806444-1-hugo@hugovil.com>
References: <20250924153740.806444-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
Subject: [PATCH 12/15] serial: sc16is7xx: add missing space between macro args (checkpatch)
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Fix the following checkpatch error:

    ERROR: space required after that ',' (ctx:VxV)
    +#define to_sc16is7xx_one(p,e)...

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index a05be92f7e776..9d04d665ec9ab 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -365,7 +365,7 @@ static struct uart_driver sc16is7xx_uart = {
 	.nr		= SC16IS7XX_MAX_DEVS,
 };
 
-#define to_sc16is7xx_one(p,e)	((container_of((p), struct sc16is7xx_one, e)))
+#define to_sc16is7xx_one(p, e)	((container_of((p), struct sc16is7xx_one, e)))
 
 static u8 sc16is7xx_port_read(struct uart_port *port, u8 reg)
 {
-- 
2.39.5


