Return-Path: <linux-serial+bounces-735-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B84680BC6E
	for <lists+linux-serial@lfdr.de>; Sun, 10 Dec 2023 18:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF5721F20F49
	for <lists+linux-serial@lfdr.de>; Sun, 10 Dec 2023 17:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B7315E95;
	Sun, 10 Dec 2023 17:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="orOFv/Gc"
X-Original-To: linux-serial@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E163AFC
	for <linux-serial@vger.kernel.org>; Sun, 10 Dec 2023 09:46:02 -0800 (PST)
Received: from pop-os.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id CNsNrgtex45wtCNsNrxdc4; Sun, 10 Dec 2023 18:46:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1702230361;
	bh=wfIMRxTsCNGiqACgN++FPbWBDIxFPSfkoS5LG06bXxY=;
	h=From:To:Cc:Subject:Date;
	b=orOFv/GcKajVFIiAedek7oFZUFxrfMzYkdHRpGANl/6cYSoq82uxliXUF+KkdwKcL
	 c7ibMFNTT3YGvJyjS9LuRq0eHSHVa4oz3cKh1V9rZJtZIY1slfpClUn3RnkQHIjGI3
	 hpGXwnlZgSelEBaQ3xLjA/TIhZxVtLJUP2P2T/WEAOYSfH8txI30kwN8pMzBb6mH3W
	 JzFXhQKgzxwceTTZUxE/CGBlSeFap1008C8mcp7e1vdVCIJyV8W/xFbumrwASvUJY/
	 10+bWMsmafB0lkvhpLYgIgC3zx51MsH/KSpDDjNIg0ujbntauByC/JzpnlhdjGioXL
	 M3TulHQKTat5Q==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 10 Dec 2023 18:46:01 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-serial@vger.kernel.org
Subject: [PATCH] serdev: Remove usage of the deprecated ida_simple_xx() API
Date: Sun, 10 Dec 2023 18:45:58 +0100
Message-Id: <d20d3ac106bac6b7cabe39f22ad00ac86910e0a5.1702230342.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ida_alloc() and ida_free() should be preferred to the deprecated
ida_simple_get() and ida_simple_remove().

This is less verbose.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/tty/serdev/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 3090e3454c44..a3c645ff4a7e 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -77,7 +77,7 @@ static bool is_serdev_device(const struct device *dev)
 static void serdev_ctrl_release(struct device *dev)
 {
 	struct serdev_controller *ctrl = to_serdev_controller(dev);
-	ida_simple_remove(&ctrl_ida, ctrl->nr);
+	ida_free(&ctrl_ida, ctrl->nr);
 	kfree(ctrl);
 }
 
@@ -491,7 +491,7 @@ struct serdev_controller *serdev_controller_alloc(struct device *host,
 	if (!ctrl)
 		return NULL;
 
-	id = ida_simple_get(&ctrl_ida, 0, 0, GFP_KERNEL);
+	id = ida_alloc(&ctrl_ida, GFP_KERNEL);
 	if (id < 0) {
 		dev_err(parent,
 			"unable to allocate serdev controller identifier.\n");
-- 
2.34.1


