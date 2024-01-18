Return-Path: <linux-serial+bounces-1681-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA4F8313F0
	for <lists+linux-serial@lfdr.de>; Thu, 18 Jan 2024 09:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D36B11F2266C
	for <lists+linux-serial@lfdr.de>; Thu, 18 Jan 2024 08:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50AF1CFA4;
	Thu, 18 Jan 2024 07:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2R25vDo"
X-Original-To: linux-serial@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5612D614;
	Thu, 18 Jan 2024 07:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705564738; cv=none; b=MrKToH4r4px3ki9MzQAnvYY0d4bGnNdwl4Qn3wGw2tjxUTKKP337GPfYQIoLNcDh1FmXXl1gnzlUGatBO3a6BWvwwfjMQVecPCDgOiM40sedpaxdnt17ysU/E1tiLglb3KbTJHfpHjddKaRe1+ijz9DM1DaQz9rT7n0h63Wkd4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705564738; c=relaxed/simple;
	bh=6xvbnww7JlLBYTWi11QyGdS/O6ZiCkP8ssfXGVVStMk=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=S259w2J91BbYaL+nPw2RyOlO5XKGARSn1ld2+rWX6Px5FRvPbaqmDp1RmA67u2Ok53lw4I0o6+xXPsmn/yftFuAWquCDcqfoYr79dxrCRzlUleYGODASskz1zGbcAJi4a5ToDMAssgD/DrUuApyrbS3mR9rbvCtOw8kW13+Sz1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2R25vDo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36171C433B1;
	Thu, 18 Jan 2024 07:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705564738;
	bh=6xvbnww7JlLBYTWi11QyGdS/O6ZiCkP8ssfXGVVStMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a2R25vDoJz4BOPRUHRYWkdxEDZ2+Es96N38Dy7n38C4ar8g33k/Mi0D5yL7iM5q8w
	 iriWoeFhnXrml8yUHpNoGoGn6rCs9XKHcH3UlWgrOQoMF1NnoU3wOA+1UWuP4ST17j
	 ptUm3pJ6Lk7oHfQMKfRaSx2y4ALD4Vsp4QGyfQ42ZfkIFecZGIV5H851L0gYv93C2C
	 iIdiPt+2zvEoKXNLocvSUY2N164LaEbfdykz1UrZxOyzqZ0f4lKPyyv1n/djv1EAcQ
	 M8QtpBUrLbZKmYX3vJWYUVExgEifFqz2nPP0NcRQbHXG70/hNZSPza0tk1f0F6fG2c
	 Yy3izNATVYncw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 27/45] fbdev/core: simplify cursor_state setting in fbcon_ops::cursor()
Date: Thu, 18 Jan 2024 08:57:38 +0100
Message-ID: <20240118075756.10541-28-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118075756.10541-1-jirislaby@kernel.org>
References: <20240118075756.10541-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a switch decicing if cursor should be drawn or not. The whole
switch can be simplified to one line. Do this cleanup as a preparatory
work for the next patch. There, all the CM_* constants are removed.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
---
 drivers/video/fbdev/core/bitblit.c   | 11 +----------
 drivers/video/fbdev/core/fbcon_ccw.c | 11 +----------
 drivers/video/fbdev/core/fbcon_cw.c  | 11 +----------
 drivers/video/fbdev/core/fbcon_ud.c  | 11 +----------
 4 files changed, 4 insertions(+), 40 deletions(-)

diff --git a/drivers/video/fbdev/core/bitblit.c b/drivers/video/fbdev/core/bitblit.c
index 8587c9da0670..daff152f4c22 100644
--- a/drivers/video/fbdev/core/bitblit.c
+++ b/drivers/video/fbdev/core/bitblit.c
@@ -348,16 +348,7 @@ static void bit_cursor(struct vc_data *vc, struct fb_info *info, int mode,
 			mask[i++] = msk;
 	}
 
-	switch (mode) {
-	case CM_ERASE:
-		ops->cursor_state.enable = 0;
-		break;
-	case CM_DRAW:
-	case CM_MOVE:
-	default:
-		ops->cursor_state.enable = (use_sw) ? 0 : 1;
-		break;
-	}
+	ops->cursor_state.enable = (mode != CM_ERASE) && !use_sw;
 
 	cursor.image.data = src;
 	cursor.image.fg_color = ops->cursor_state.image.fg_color;
diff --git a/drivers/video/fbdev/core/fbcon_ccw.c b/drivers/video/fbdev/core/fbcon_ccw.c
index 2789ace79634..889423d580bc 100644
--- a/drivers/video/fbdev/core/fbcon_ccw.c
+++ b/drivers/video/fbdev/core/fbcon_ccw.c
@@ -349,16 +349,7 @@ static void ccw_cursor(struct vc_data *vc, struct fb_info *info, int mode,
 		kfree(tmp);
 	}
 
-	switch (mode) {
-	case CM_ERASE:
-		ops->cursor_state.enable = 0;
-		break;
-	case CM_DRAW:
-	case CM_MOVE:
-	default:
-		ops->cursor_state.enable = (use_sw) ? 0 : 1;
-		break;
-	}
+	ops->cursor_state.enable = (mode != CM_ERASE) && !use_sw;
 
 	cursor.image.data = src;
 	cursor.image.fg_color = ops->cursor_state.image.fg_color;
diff --git a/drivers/video/fbdev/core/fbcon_cw.c b/drivers/video/fbdev/core/fbcon_cw.c
index 86a254c1b2b7..a306ca5802e8 100644
--- a/drivers/video/fbdev/core/fbcon_cw.c
+++ b/drivers/video/fbdev/core/fbcon_cw.c
@@ -332,16 +332,7 @@ static void cw_cursor(struct vc_data *vc, struct fb_info *info, int mode,
 		kfree(tmp);
 	}
 
-	switch (mode) {
-	case CM_ERASE:
-		ops->cursor_state.enable = 0;
-		break;
-	case CM_DRAW:
-	case CM_MOVE:
-	default:
-		ops->cursor_state.enable = (use_sw) ? 0 : 1;
-		break;
-	}
+	ops->cursor_state.enable = (mode != CM_ERASE) && !use_sw;
 
 	cursor.image.data = src;
 	cursor.image.fg_color = ops->cursor_state.image.fg_color;
diff --git a/drivers/video/fbdev/core/fbcon_ud.c b/drivers/video/fbdev/core/fbcon_ud.c
index 23bc045769d0..f6fc458b46c7 100644
--- a/drivers/video/fbdev/core/fbcon_ud.c
+++ b/drivers/video/fbdev/core/fbcon_ud.c
@@ -372,16 +372,7 @@ static void ud_cursor(struct vc_data *vc, struct fb_info *info, int mode,
 			mask[i++] = ~msk;
 	}
 
-	switch (mode) {
-	case CM_ERASE:
-		ops->cursor_state.enable = 0;
-		break;
-	case CM_DRAW:
-	case CM_MOVE:
-	default:
-		ops->cursor_state.enable = (use_sw) ? 0 : 1;
-		break;
-	}
+	ops->cursor_state.enable = (mode != CM_ERASE) && !use_sw;
 
 	cursor.image.data = src;
 	cursor.image.fg_color = ops->cursor_state.image.fg_color;
-- 
2.43.0


