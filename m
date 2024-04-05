Return-Path: <linux-serial+bounces-3205-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C548994F6
	for <lists+linux-serial@lfdr.de>; Fri,  5 Apr 2024 08:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00B10B22C04
	for <lists+linux-serial@lfdr.de>; Fri,  5 Apr 2024 06:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0475A28DD6;
	Fri,  5 Apr 2024 06:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9CDEEBc"
X-Original-To: linux-serial@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9202D022;
	Fri,  5 Apr 2024 06:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712297328; cv=none; b=UOBLZcw93kQXGH/oPK1WJedrYEzHHKuj0vf1MOl36yQ8Fg4+1zk9vmr/GdXoSOOAgZfLqoCZQicGgW/2CAUOQmFLiaG/OYhw62OTPEKc6/ATR9lIK6eVG62iC5d9mhx/7TC07N8lwV+L+4dO/5JZgL+xbeX5Mxcjh7wbX75VAUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712297328; c=relaxed/simple;
	bh=tJF+08Wovvyo19kq87yZF22HcvtylXgBS1IrMhly7rU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=keZDI95fbBfZ5CpqpWh9ddnCLHuDJMhdJhfFeA3/jgMisX4NvF89fjQ6BbGkICyCws49OQSO7EXXm+3SQsl9bg5fNM6rEDvuw1C66d4CFOO32QgsCnhQF7m7d/J1NdaTtFnZCiT4VtWY6qHDiNvLA2Cyv3gtIoebTcdxXSJ5Zqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9CDEEBc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D8FFC43390;
	Fri,  5 Apr 2024 06:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712297328;
	bh=tJF+08Wovvyo19kq87yZF22HcvtylXgBS1IrMhly7rU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E9CDEEBcfyw2ffCm6aUYqXJA5qSm0YJrQ+aFa7UxK9hVuad9NnszikFvcmQIkjBPC
	 xKpisKEvsutUwGrESLI8A2eJsbceUvcIFhChkZBe/SxGy75b9fAsNiq3DVxD2Ywf/z
	 tq+xQ7gkUeOscD1kh9dY+daJpA7nSC+y/YB4t5xNNkLl4VKmwetPVs3+RMW1SjzKic
	 OYz8zkGQLidRQEHBXpCSqHq2pZaenXzr/+qClBq6hcBQDcyB5L4nW2aEa8KCmdVX+s
	 luj6J47bKbGHM48IdcuD4uwj1SGtFs0nukSQigbH4JxCf940+wcSagFIcKh7cW86XR
	 tW5OB4EZe/tQA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Stefani Seibold <stefani@seibold.net>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 05/15] kfifo: rename l to len_to_end in setup_sgl()
Date: Fri,  5 Apr 2024 08:08:16 +0200
Message-ID: <20240405060826.2521-6-jirislaby@kernel.org>
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

So that one can make any sense of the name.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Stefani Seibold <stefani@seibold.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 lib/kfifo.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/kfifo.c b/lib/kfifo.c
index d5830960ab87..61e35550aea5 100644
--- a/lib/kfifo.c
+++ b/lib/kfifo.c
@@ -321,7 +321,7 @@ static unsigned int setup_sgl(struct __kfifo *fifo, struct scatterlist *sgl,
 {
 	unsigned int size = fifo->mask + 1;
 	unsigned int esize = fifo->esize;
-	unsigned int l;
+	unsigned int len_to_end;
 	unsigned int n;
 
 	off &= fifo->mask;
@@ -330,10 +330,10 @@ static unsigned int setup_sgl(struct __kfifo *fifo, struct scatterlist *sgl,
 		size *= esize;
 		len *= esize;
 	}
-	l = min(len, size - off);
+	len_to_end = min(len, size - off);
 
-	n = setup_sgl_buf(sgl, fifo->data + off, nents, l);
-	n += setup_sgl_buf(sgl + n, fifo->data, nents - n, len - l);
+	n = setup_sgl_buf(sgl, fifo->data + off, nents, len_to_end);
+	n += setup_sgl_buf(sgl + n, fifo->data, nents - n, len - len_to_end);
 
 	return n;
 }
-- 
2.44.0


