Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8BD22E1D8
	for <lists+linux-serial@lfdr.de>; Sun, 26 Jul 2020 20:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgGZSFG (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sun, 26 Jul 2020 14:05:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:50062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbgGZSFF (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 26 Jul 2020 14:05:05 -0400
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 5.8-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595786705;
        bh=24O0k0F26enNF4/Objjk3xGe2zoDHtqpnZtGDTXilu0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zt7bzb+rM5eNic7eDKRVF6M+G3dwehakMRDU+BQ31qq8oUqyoN2un+flyM2Ao+kTk
         LQvbmCJ975nd5HbRrUUNFnslxmuAUzFCiPZmjwhzB624Ia6vM//cf63pSfCZudHyLx
         /R1dghL+rofcsAGH8mgZn7ixpfGxxiKsrdUXZ0YU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200726111217.GA1283587@kroah.com>
References: <20200726111217.GA1283587@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200726111217.GA1283587@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.8-rc7
X-PR-Tracked-Commit-Id: 5fdbe136ae19ab751daaa4d08d9a42f3e30d17f9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7d22af6c5bdb001c5ed0a20185138304ad2af91b
Message-Id: <159578670541.6689.8287585016801874925.pr-tracker-bot@kernel.org>
Date:   Sun, 26 Jul 2020 18:05:05 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The pull request you sent on Sun, 26 Jul 2020 13:12:17 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.8-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7d22af6c5bdb001c5ed0a20185138304ad2af91b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
