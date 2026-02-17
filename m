Return-Path: <linux-serial+bounces-12727-lists+linux-serial=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-serial@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id DsPVDq3gk2kR9gEAu9opvQ
	(envelope-from <linux-serial+bounces-12727-lists+linux-serial=lfdr.de@vger.kernel.org>)
	for <lists+linux-serial@lfdr.de>; Tue, 17 Feb 2026 04:29:49 +0100
X-Original-To: lists+linux-serial@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B19431489F8
	for <lists+linux-serial@lfdr.de>; Tue, 17 Feb 2026 04:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D36D23006142
	for <lists+linux-serial@lfdr.de>; Tue, 17 Feb 2026 03:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3663260580;
	Tue, 17 Feb 2026 03:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pythcoiner.dev header.i=@pythcoiner.dev header.b="lXscuYGe"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail.pythcoiner.dev (unknown [159.198.47.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B157222584;
	Tue, 17 Feb 2026 03:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.198.47.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771298984; cv=none; b=ruBRK63niavnMxhSrLgj1grTrAM2qY9d1eQfajE/7K8+9JU7ndGEZbxwbQ6ZmUwA+rmxwMLrviUeTt0US8hFqfDl9Op26igsWNhQ1eTF6IWbEix3hTUYcD57PrXvM5wbFdroNFvq39aP3Ielu5zYdufdwhtpyacHlFqdA3eDWMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771298984; c=relaxed/simple;
	bh=Q9HJR8ZlJDXNqq/opcn86eWl8m6JBWvpYDOZ0obgEOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sji0dctnvJSgqeWhnUz/lS2BjBYRU4F87pGvCMGYrC9jQ3Nja8vaQfiXyqICWNDxCQ0bKdjIHgRJjB/uunX2nu/sxHZKZSHYsO97Fw2ANODGHVXHQFYiNef7gY4m2IK6d4ut1ix/uUoVHijhgpLJmez+5YDfcdP48CLd7G8CCJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pythcoiner.dev; spf=pass smtp.mailfrom=pythcoiner.dev; dkim=pass (2048-bit key) header.d=pythcoiner.dev header.i=@pythcoiner.dev header.b=lXscuYGe; arc=none smtp.client-ip=159.198.47.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pythcoiner.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pythcoiner.dev
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E3BF5AAF89;
	Tue, 17 Feb 2026 03:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pythcoiner.dev;
	s=dkim; t=1771298427; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=uRtLPqQMGhjNsCO4iwfqS8zEqGhEiD3jTSg5XEJ6qCw=;
	b=lXscuYGeVbqyE34cxF4ySCCYbeQvg58h/+gtJmZOs1ySxwebJUHr3sKUfkv5PSJAQMmK8i
	nn49mG4HYHVcawSIAN5yW+JiiWZMzgOxlAZbIuWARM11XzqLMkmN8RVmoI741J+DAOtVLR
	U1v1yi0fhc2j+JBb8FQ/z93VAvtJ1BYwAo6Y+C71jeeiv/+ByuVZ+JVk4dyNRDzs+mGjWa
	mRTx8twF1b931JW8zaAZU8/vK1rZukMuLK6rIj8FcEK5lBoUDBD8V44UGNOb6VwbbWBI/f
	QFR6RKvAcwEVYBdkYyVF/OYuM1gqo7PT0d83WHeKevsUwvYBOfQnKslFc+gOUg==
From: Pete Connor <pete.connor@pythcoiner.dev>
To: Chaitanya Vadrevu <chaitanya.vadrevu@emerson.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pete Connor <pete.connor@pythcoiner.dev>
Subject: [PATCH] serial: 8250_ni: use kzalloc_obj() for allocation
Date: Mon, 16 Feb 2026 22:19:13 -0500
Message-ID: <20260217031913.1166949-1-pete.connor@pythcoiner.dev>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[pythcoiner.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[pythcoiner.dev:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12727-lists,linux-serial=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[pete.connor@pythcoiner.dev,linux-serial@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[pythcoiner.dev:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-serial];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B19431489F8
X-Rspamd-Action: no action

  Replace kzalloc() with the preferred kzalloc_obj() helper
  to address a checkpatch warning.

  Signed-off-by: Pete Connor <pete.connor@pythcoiner.dev>
---
 drivers/tty/serial/8250/8250_ni.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_ni.c b/drivers/tty/serial/8250/8250_ni.c
index cb5b42b3609c..3f3dac694e20 100644
--- a/drivers/tty/serial/8250/8250_ni.c
+++ b/drivers/tty/serial/8250/8250_ni.c
@@ -285,7 +285,7 @@ static int ni16550_probe(struct platform_device *pdev)
 	bool rs232_property;
 	int ret;
 
-	uart = kzalloc(sizeof(*uart), GFP_KERNEL);
+	uart = kzalloc_obj(*uart, GFP_KERNEL);
 	if (!uart)
 		return -ENOMEM;
 
-- 
2.47.3


