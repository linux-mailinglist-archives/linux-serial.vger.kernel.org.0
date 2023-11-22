Return-Path: <linux-serial+bounces-143-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E94D47F4ED5
	for <lists+linux-serial@lfdr.de>; Wed, 22 Nov 2023 18:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 261291C209ED
	for <lists+linux-serial@lfdr.de>; Wed, 22 Nov 2023 17:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075F94F1F7;
	Wed, 22 Nov 2023 17:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="Yo9pnX9J"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0612112;
	Wed, 22 Nov 2023 09:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=BuF5Rm4s6M217X/U1K5BQhU00lWtXZ8dQ8SUtzZjsGM=; b=Yo9pnX9J+bpTdoFD2661sN1cvD
	39exH1gyt8h+s+uewECF2UNAZBRv+HZCQg8kNjv0X3qkmaPRQIgAWvkKk9MeOI2bmg8ojy+Y5Efo1
	it3yuqno9VggZjjJuZEoWSfAgXAbc1ViklqAG7ymlPYdUlU9bpGGTiee6KL8/sD+LdxM=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:55790 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1r5rV8-00014i-2e; Wed, 22 Nov 2023 12:59:03 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Date: Wed, 22 Nov 2023 12:58:59 -0500
Message-Id: <20231122175859.3874753-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
Subject: [PATCH] serial: sc16is7xx: change confusing comment about Tx FIFO
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

The comment wording can be confusing, as txlen will return the number of
bytes available in the FIFO, which can be less than the maximum theoretical
Tx FIFO size.

Change the comment so that it is unambiguous.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index db2bb1c0d36c..43776aabea41 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -675,7 +675,7 @@ static void sc16is7xx_handle_tx(struct uart_port *port)
 	/* Get length of data pending in circular buffer */
 	to_send = uart_circ_chars_pending(xmit);
 	if (likely(to_send)) {
-		/* Limit to size of TX FIFO */
+		/* Limit to space available in TX FIFO */
 		txlen = sc16is7xx_port_read(port, SC16IS7XX_TXLVL_REG);
 		if (txlen > SC16IS7XX_FIFO_SIZE) {
 			dev_err_ratelimited(port->dev,

base-commit: 98b1cc82c4affc16f5598d4fa14b1858671b2263
-- 
2.39.2


