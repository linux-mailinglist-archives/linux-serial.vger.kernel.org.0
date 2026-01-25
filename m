Return-Path: <linux-serial+bounces-12522-lists+linux-serial=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-serial@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCn/H4Y1dmmTNgEAu9opvQ
	(envelope-from <linux-serial+bounces-12522-lists+linux-serial=lfdr.de@vger.kernel.org>)
	for <lists+linux-serial@lfdr.de>; Sun, 25 Jan 2026 16:23:50 +0100
X-Original-To: lists+linux-serial@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1FC812A0
	for <lists+linux-serial@lfdr.de>; Sun, 25 Jan 2026 16:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F37E43003EF3
	for <lists+linux-serial@lfdr.de>; Sun, 25 Jan 2026 15:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9E031A041;
	Sun, 25 Jan 2026 15:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TzIGLrzV"
X-Original-To: linux-serial@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698B627B353;
	Sun, 25 Jan 2026 15:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769354627; cv=none; b=Rw2RsjhbGzETFcqLIgh2l1kp207iXWBQwybtBMOfwbA4vCxLEenbCq1XeW2o/gSmtBA9ZjutCc6fY+0GXkFl+7cga9Bf7jMXG4ndVPMgYwd8Z09i5B17NN1CewwEWGdqEy2aZQF7GGLKZYYH0bTFfJy3BvaTHXxysWckQdqFUuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769354627; c=relaxed/simple;
	bh=/TpwMBLlRoFFUo9Vr8pkL7Ua5YuLlU1iKbnE/OiSoaY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KbrEmiPrqKr0HSuNkinlQmEtGJ1awXOeQojY8FqBt5xy30xWPkCtZIdo1YJXF52fzKru7B6ylV3dzRhWllnEUAozvUq97fF8GqlwnUYWaRZ2Iv23KgFOuKUwfKcKMAyQ7MUUK2GCStq2caHmPcr4AR7KWSMM0m0ktrGnCUM4gYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TzIGLrzV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31BAFC4CEF1;
	Sun, 25 Jan 2026 15:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769354626;
	bh=/TpwMBLlRoFFUo9Vr8pkL7Ua5YuLlU1iKbnE/OiSoaY=;
	h=Date:From:To:Cc:Subject:From;
	b=TzIGLrzV3hRcM00CnKqua4R82RLuUoi1KHr3tffc2JiY5X0gjnIgC/7+wqY8n1Gl2
	 XkbblWjlIq4xydB6cP4I3THQ2NHKqPcro4tTIM+74DmAAlT95nOAtU9lFmDoe/EZbq
	 RhV4XIo3BKB6oijfT6ckdcO4USPFCvMlbomqRSLQ=
Date: Sun, 25 Jan 2026 16:23:43 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] Serial driver fixes for 6.19-rc7
Message-ID: <aXY1f0U7rHgwl4bO@kroah.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12522-lists,linux-serial=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-serial@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-serial];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: BC1FC812A0
X-Rspamd-Action: no action

The following changes since commit f8f9c1f4d0c7a64600e2ca312dec824a0bc2f1da:

  Linux 6.19-rc3 (2025-12-28 13:24:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.19-rc7

for you to fetch changes up to 32f37e57583f869140cff445feedeea8a5fea986:

  serial: Fix not set tty->port race condition (2026-01-23 17:23:09 +0100)

----------------------------------------------------------------
Serial driver fixes for 6.19-rc7

Here are 3 small serial driver fixes for 6.19-rc7 that resolve some
reported issues.  They include:
  - tty->port race condition fix for a reported problem
  - qcom_geni serial driver fix
  - 8250_pci serial driver fix

All of these have been in linux-next with no reported issues

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      serial: Fix not set tty->port race condition

Marnix Rijnart (1):
      serial: 8250_pci: Fix broken RS485 for F81504/508/512

Praveen Talari (1):
      serial: qcom_geni: Fix BT failure regression on RB2 platform

 drivers/tty/serial/8250/8250_pci.c    |  2 +-
 drivers/tty/serial/qcom_geni_serial.c | 13 ++++++-------
 drivers/tty/serial/serial_core.c      |  6 ++++++
 3 files changed, 13 insertions(+), 8 deletions(-)

