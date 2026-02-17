Return-Path: <linux-serial+bounces-12734-lists+linux-serial=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-serial@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFgiBY+slGncGQIAu9opvQ
	(envelope-from <linux-serial+bounces-12734-lists+linux-serial=lfdr.de@vger.kernel.org>)
	for <lists+linux-serial@lfdr.de>; Tue, 17 Feb 2026 18:59:43 +0100
X-Original-To: lists+linux-serial@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEE214ED42
	for <lists+linux-serial@lfdr.de>; Tue, 17 Feb 2026 18:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F8D4307EA88
	for <lists+linux-serial@lfdr.de>; Tue, 17 Feb 2026 17:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D838937417B;
	Tue, 17 Feb 2026 17:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOc0XdaP"
X-Original-To: linux-serial@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5653374177;
	Tue, 17 Feb 2026 17:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771350913; cv=none; b=XVPLqcn+cB5oELMFU7fc4GjgdmWiiaKzn3GWL0MqvSXvN+SBkNvS9QyZkpjewXCbiHjCvLZNh8Pw2y8tdI8x4o2PJzZbM3A2Y5SLw9qyoWaMP0x9cBVjJB/BTPIdt6sgjMRtbMspDjJuzC6rhF1uJ5TmFZdns8j/hrxhTQJ3ZK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771350913; c=relaxed/simple;
	bh=ne/rggZugHlkrQd1McLir38d0z+83WRrGV4YfxWIgd4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=A1WOqC+h5mKs+fR+WRNq7JALPwW1jiy8l/tTJ4CX62HlLa1lavltZn1SBqWqmqIO7YqVgAnlupiS6TqstCQtHz59VVL8Qt/LFjz+G1vTheonT3/OVScQHcbRAlg7I6uBxGk8pZSfeLAv9MtEUPg3WeIaQK52TafvPtR0BUZL+88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOc0XdaP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98C25C4CEF7;
	Tue, 17 Feb 2026 17:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771350913;
	bh=ne/rggZugHlkrQd1McLir38d0z+83WRrGV4YfxWIgd4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BOc0XdaP63fvne96C68aoj+M6XB3Avh3KOL0pAOyxUkS5DngKLXFVFi78ahDtpSaI
	 u+EtCXHRJve8h6JtkZpcKJemMeIburgmGc/d2wN/dEmXJsEJPDmdqhpVW+j4ZjlTLX
	 YDHROMFOprC/e+gUsHnggUbeK/8JCbE/RY0swtj2OQ3SUjp7spKbzQ6FzCNz4RNPzO
	 VRP4ySIEG25rr/Py7jWjlz/aWdqKMTd44kdSKk8dAWo/pf5Ismikr+tx2GYUhqgSYV
	 zU19/FtLZkEzsKrLDZO4UkvTq0mHl/6+rhzy2Fn3sAOm2IqzkEEpVscIuEvH65SMNw
	 d3r7AIqlMy6rA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C20A6380AAF2;
	Tue, 17 Feb 2026 17:55:06 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver updates for 7.0-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aZR7VPj-GDiNMcX9@kroah.com>
References: <aZR7VPj-GDiNMcX9@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aZR7VPj-GDiNMcX9@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-7.0-rc1
X-PR-Tracked-Commit-Id: 0a15f43b92ddaa2fdb476891a12ac2e207c7fcd2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3ad7945754000d868ed86315d33085a914c422c1
Message-Id: <177135090540.577366.13414902900628074149.pr-tracker-bot@kernel.org>
Date: Tue, 17 Feb 2026 17:55:05 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12734-lists,linux-serial=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-serial@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-serial];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7FEE214ED42
X-Rspamd-Action: no action

The pull request you sent on Tue, 17 Feb 2026 15:29:40 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-7.0-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3ad7945754000d868ed86315d33085a914c422c1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

