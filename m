Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2F33301E76
	for <lists+linux-serial@lfdr.de>; Sun, 24 Jan 2021 20:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbhAXTei (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sun, 24 Jan 2021 14:34:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:41618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbhAXTea (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 24 Jan 2021 14:34:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 928F522CF6;
        Sun, 24 Jan 2021 19:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611516829;
        bh=wr/Uj5CLiy/BVQDda3Y7RLMIWK2TZi5VzMcrpucAc8Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=G9QanLynN7zMnacDf7lAq4h76+MpGsUWh6lNuKQauO3FRtgxkaPlNLoi4H7G+Tlt3
         vtyW5d36Gg0UxKkI3qTgtzeY+/Njvo/L0u0r4bQFoRWD2pH0o72BoJ2sVlT3NwRne2
         g/U0h3tp0A9Fx/aaEtJkO8U5rrpT0AurU9uEF4qWhm127TTjET0fuKqY2M6mzaerzc
         9Q/WFGPDoZfdl5bXyY3TbHy6mDR2165lLdZXRbL98pnd0DtNmn8x2rOjkf5CoHPPUg
         z9Nat+99Sytu4rSuMNj7zuEuqAXoI9ZxmTLP9kuT9cYrXJw/p61++d7zyDNw63EaSq
         ihejEnmQSCvFA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 78FF1652E1;
        Sun, 24 Jan 2021 19:33:49 +0000 (UTC)
Subject: Re: [GIT PULL] TTY / Serial fixes for 5.11-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YA1uxr1Gy9UiHd1/@kroah.com>
References: <YA1uxr1Gy9UiHd1/@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <YA1uxr1Gy9UiHd1/@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.11-rc5
X-PR-Tracked-Commit-Id: 17749851eb9ca2298e7c3b81aae4228961b36f28
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4da81fa2108aa46249768bfb04cea7c534fafdda
Message-Id: <161151682941.23923.8946666872762685830.pr-tracker-bot@kernel.org>
Date:   Sun, 24 Jan 2021 19:33:49 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The pull request you sent on Sun, 24 Jan 2021 13:57:42 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.11-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4da81fa2108aa46249768bfb04cea7c534fafdda

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
