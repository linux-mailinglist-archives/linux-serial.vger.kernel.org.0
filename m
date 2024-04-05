Return-Path: <linux-serial+bounces-3204-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EEFC8994F4
	for <lists+linux-serial@lfdr.de>; Fri,  5 Apr 2024 08:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFEF41C2211B
	for <lists+linux-serial@lfdr.de>; Fri,  5 Apr 2024 06:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9ED2C1BA;
	Fri,  5 Apr 2024 06:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GzfuGQBz"
X-Original-To: linux-serial@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C992C1B6;
	Fri,  5 Apr 2024 06:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712297326; cv=none; b=qZlUg2hN9P/aS6qB0T0MFQW324r2+Y/9XCMtwfLmqkxQ3OjFJe3pm6o3SmyfUHnV7YoTTopmmIQm1cWmH/Ce/pOsu9P3Y2WnrgO2C3w9YTZcmnJNIjy4p4eljOfQWkzFWvj2QwpHkBzsQzYCNN0mfr2eleD1Zo55Lj05tvp+0qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712297326; c=relaxed/simple;
	bh=eLFz8uhtcnkr+mmr2mJCW7abChfFurz5pgm0LRWZQB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f+b2QoyVJVUvQPZ7O4LIjQQc8T3RaIXxr/KOd+1+iWIvL0CSzBWX4vfBtABg/0SUkmTEoCiEvgbC6e1kKVuQE0Tgo07fxFLvcT1oWBfAZmNhfuWrnHLPDmUtaFGNW4Xf35luISBHG4RWaS57l34914TFdA9gHSa746E4Co2p21k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GzfuGQBz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D70EC43390;
	Fri,  5 Apr 2024 06:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712297326;
	bh=eLFz8uhtcnkr+mmr2mJCW7abChfFurz5pgm0LRWZQB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GzfuGQBzmLL+POZxHTP2DAorvhpY4UPzoC2rpot1rpECWEcHLV5ob+fllk1vGfne3
	 DOVFqB9dJSoW016vy7pgo6c+mrMsM0SbXCA+vAlV9fmCyd+5jVbHd/APjW2u4nSIR2
	 Q6T/o4dIVKglkUmY/h+rpTk57A1m+r5JaxENwkMxAH+bMlutDjDRFxB9r3xr80n1mh
	 07alDoPIMRu7FvhEfE/1a5yhnb5sz/FGl80YqL47Amp0jB2PRXEkm4z1+zCRra7TEx
	 mbtO8sgSeHNzIMmWNVm9vpRDMiLQ/fn/p/wxSF8h2ddYTr1ltjslLlxc5ip69Kn9ks
	 RqWHtrV2X0Pag==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Stefani Seibold <stefani@seibold.net>
Subject: [PATCH 04/15] kfifo: remove support for physically non-contiguous memory
Date: Fri,  5 Apr 2024 08:08:15 +0200
Message-ID: <20240405060826.2521-5-jirislaby@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240405060826.2521-1-jirislaby@kernel.org>
References: <20240405060826.2521-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

First, there is no such user. The only user of this interface is
caam_rng_fill_async() and that uses kfifo_alloc() -> kmalloc().

Second, the implementation does not allow anything else than direct
mapping and kmalloc() (due to virt_to_phys()), anyway.

Therefore, there is no point in having this dead (and complex) code in
the kernel.

Note the setup_sgl_buf() function now boils down to simple sg_set_buf().
That is called twice from setup_sgl() to take care of kfifo buffer
wrap-around.

setup_sgl_buf() will be extended shortly, so keeping it in place.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Stefani Seibold <stefani@seibold.net>
---
 lib/kfifo.c | 38 +++++---------------------------------
 1 file changed, 5 insertions(+), 33 deletions(-)

diff --git a/lib/kfifo.c b/lib/kfifo.c
index a36bfdbdb17d..d5830960ab87 100644
--- a/lib/kfifo.c
+++ b/lib/kfifo.c
@@ -305,43 +305,15 @@ int __kfifo_to_user(struct __kfifo *fifo, void __user *to,
 }
 EXPORT_SYMBOL(__kfifo_to_user);
 
-static int setup_sgl_buf(struct scatterlist *sgl, void *buf,
-		int nents, unsigned int len)
+static unsigned int setup_sgl_buf(struct scatterlist *sgl, void *buf,
+				  int nents, unsigned int len)
 {
-	int n;
-	unsigned int l;
-	unsigned int off;
-	struct page *page;
-
-	if (!nents)
+	if (!nents || !len)
 		return 0;
 
-	if (!len)
-		return 0;
+	sg_set_buf(sgl, buf, len);
 
-	n = 0;
-	page = virt_to_page(buf);
-	off = offset_in_page(buf);
-	l = 0;
-
-	while (len >= l + PAGE_SIZE - off) {
-		struct page *npage;
-
-		l += PAGE_SIZE;
-		buf += PAGE_SIZE;
-		npage = virt_to_page(buf);
-		if (page_to_phys(page) != page_to_phys(npage) - l) {
-			sg_set_page(sgl, page, l - off, off);
-			sgl = sg_next(sgl);
-			if (++n == nents || sgl == NULL)
-				return n;
-			page = npage;
-			len -= l - off;
-			l = off = 0;
-		}
-	}
-	sg_set_page(sgl, page, len, off);
-	return n + 1;
+	return 1;
 }
 
 static unsigned int setup_sgl(struct __kfifo *fifo, struct scatterlist *sgl,
-- 
2.44.0


