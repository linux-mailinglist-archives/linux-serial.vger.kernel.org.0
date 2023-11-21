Return-Path: <linux-serial+bounces-31-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C8C7F28B2
	for <lists+linux-serial@lfdr.de>; Tue, 21 Nov 2023 10:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9274C282563
	for <lists+linux-serial@lfdr.de>; Tue, 21 Nov 2023 09:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41EA38F8D;
	Tue, 21 Nov 2023 09:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IH+7wSj9"
X-Original-To: linux-serial@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87351FA7
	for <linux-serial@vger.kernel.org>; Tue, 21 Nov 2023 09:23:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E493C433C7;
	Tue, 21 Nov 2023 09:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700558596;
	bh=Y5i+1euxXI4UCUqQ8X+2VuZ/t15K0hpOycDIDgEeERI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IH+7wSj9QouOREWdasm6QA3mhk9WhQXzBt0Q8x2nYkUJMCp92n6GV3It3p5TDM9RP
	 YRzbU4o3CIcfbsVm6Z65o4m6XtIPzBbIKIWDZfMDyE7zAqnEAkPdvp8iF9ic5Cbhqf
	 aZKZGqZjt9j/W6KMV+S9+Q1++LngSBSOz9VZiysDM6KhCYJ2OgAUJGRsVWO/1EP4ch
	 pwwPnTBJoiu2M+AnPBSuBUTGhM468rDQ/eqjns03GJAfokrz73XaYrYvX/gz2jl6/L
	 QTNTA6kFDUwHUiabdwYcDj2t4MS4vU7sjigNDMUwlS+o2ugv4bTnbOG5UZQJmOb/b0
	 VbaBgCbr3yrtg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 08/17] tty: goldfish: drop unneeded temporary variables
Date: Tue, 21 Nov 2023 10:22:49 +0100
Message-ID: <20231121092258.9334-9-jirislaby@kernel.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231121092258.9334-1-jirislaby@kernel.org>
References: <20231121092258.9334-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We can pass 'buf' directly to goldfish_tty_rw() using simple (unsigned
long) cast. There is no need to obfuscate the code by another variable
with double casts.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/goldfish.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/goldfish.c b/drivers/tty/goldfish.c
index 4591f940b7a1..dccf6c6c69c6 100644
--- a/drivers/tty/goldfish.c
+++ b/drivers/tty/goldfish.c
@@ -128,16 +128,14 @@ static void goldfish_tty_rw(struct goldfish_tty *qtty,
 static void goldfish_tty_do_write(int line, const u8 *buf, unsigned int count)
 {
 	struct goldfish_tty *qtty = &goldfish_ttys[line];
-	unsigned long address = (unsigned long)(void *)buf;
 
-	goldfish_tty_rw(qtty, address, count, 1);
+	goldfish_tty_rw(qtty, (unsigned long)buf, count, 1);
 }
 
 static irqreturn_t goldfish_tty_interrupt(int irq, void *dev_id)
 {
 	struct goldfish_tty *qtty = dev_id;
 	void __iomem *base = qtty->base;
-	unsigned long address;
 	unsigned char *buf;
 	u32 count;
 
@@ -147,8 +145,7 @@ static irqreturn_t goldfish_tty_interrupt(int irq, void *dev_id)
 
 	count = tty_prepare_flip_string(&qtty->port, &buf, count);
 
-	address = (unsigned long)(void *)buf;
-	goldfish_tty_rw(qtty, address, count, 0);
+	goldfish_tty_rw(qtty, (unsigned long)buf, count, 0);
 
 	tty_flip_buffer_push(&qtty->port);
 	return IRQ_HANDLED;
-- 
2.42.1


