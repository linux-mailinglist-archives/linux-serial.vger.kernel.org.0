Return-Path: <linux-serial+bounces-1828-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2A2836097
	for <lists+linux-serial@lfdr.de>; Mon, 22 Jan 2024 12:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 205EC1F21D13
	for <lists+linux-serial@lfdr.de>; Mon, 22 Jan 2024 11:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A670C3DB81;
	Mon, 22 Jan 2024 11:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O35PWqRv"
X-Original-To: linux-serial@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D323D99C;
	Mon, 22 Jan 2024 11:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921474; cv=none; b=l7mbP8br/t1VmcpX32eR+20Y9I/kRSvDxx800uMI5JHUavoBWy1JBCOVbh0pkp2rWytDHIQ0AuHppWtzXW9S4RCJYXv+GsPmhv02CjCNa3QTNy++gb5O1mDJ/wW3xFvRrtdlRe6pZ4nagzDvoh9ZTNlaDXeuVBrZ+z96x1bGAyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921474; c=relaxed/simple;
	bh=0kGQUJQwhbenv97iXL8zYZfALi/hSUtPbfP/KVaAw/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UZxbHOXlBF4EFxExzGOZ5ERXXmFnpx0AUsO0zkVjdvz67LlW0ez0c4jbmu/lU6cOG0Ki8k9pHbQHMKwtjkiwyH2rxFvRWZbm30jL4dfqM8J4gzijiSqhFfzNEYmfO07vmBpQe+98aEne5giKWcu1jpfVWkpzHglndnNO3tmqvK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O35PWqRv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FFF0C43390;
	Mon, 22 Jan 2024 11:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705921473;
	bh=0kGQUJQwhbenv97iXL8zYZfALi/hSUtPbfP/KVaAw/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O35PWqRvPaBQIozwDDSlhMc9YQOYNHxXTv1qYj1lXqRAi5ztp/epuGqCkyxz31y9u
	 x+80JLhP79cJQkVcCjfq8IUW/KC55wxSBCjknwdn8EYmUccOxwuWluoXwc1B5CDQmc
	 rc3+DEapeBj6j5AyC073fbOy56z30M3CGOsOUKf3GvHL2bG3gGlasbYasRNbBHdZa4
	 W4OjVdp7qYzcBKkvjQHKc4hvG6d/blw71fhIfE108zp/0E2IgTwRXW2uBiPMjXbMmk
	 IXQhPX0yUuLGmDKCX0oZbVmdY/dJ+LvswcFV5B3x/Abqpiv4Y81Q1wG8ircX6TJxAe
	 hWbZJH1CgEKPw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 15/47] tty: vt: define an enum for CSI+K codes
Date: Mon, 22 Jan 2024 12:03:29 +0100
Message-ID: <20240122110401.7289-16-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122110401.7289-1-jirislaby@kernel.org>
References: <20240122110401.7289-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Decrypt the constant values by proper enum names. This time in csi_K().

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 16ba3a3666ab..2f3f5e4817f6 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1542,6 +1542,12 @@ static void csi_J(struct vc_data *vc, enum CSI_J vpar)
 	vc->vc_need_wrap = 0;
 }
 
+enum {
+	CSI_K_CURSOR_TO_LINEEND		= 0,
+	CSI_K_LINESTART_TO_CURSOR	= 1,
+	CSI_K_LINE			= 2,
+};
+
 static void csi_K(struct vc_data *vc)
 {
 	unsigned int count;
@@ -1549,15 +1555,15 @@ static void csi_K(struct vc_data *vc)
 	int offset;
 
 	switch (vc->vc_par[0]) {
-		case 0:	/* erase from cursor to end of line */
+		case CSI_K_CURSOR_TO_LINEEND:
 			offset = 0;
 			count = vc->vc_cols - vc->state.x;
 			break;
-		case 1:	/* erase from start of line to cursor */
+		case CSI_K_LINESTART_TO_CURSOR:
 			offset = -vc->state.x;
 			count = vc->state.x + 1;
 			break;
-		case 2: /* erase whole line */
+		case CSI_K_LINE:
 			offset = -vc->state.x;
 			count = vc->vc_cols;
 			break;
-- 
2.43.0


