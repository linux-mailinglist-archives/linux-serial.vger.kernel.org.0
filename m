Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2122E394D2C
	for <lists+linux-serial@lfdr.de>; Sat, 29 May 2021 18:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbhE2Quk (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sat, 29 May 2021 12:50:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:44328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229716AbhE2Quj (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 29 May 2021 12:50:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A0AD0610CC;
        Sat, 29 May 2021 16:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622306942;
        bh=w6aelTtD9hoNXtjEieLpm0Lezw9O9VOpyI44rlBpTvg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RXwndY8GXajVLiMXL3fu0kQrue0Ya0+8nshlwD99BldZxvJH2LzvDhzpvQ2IKDc/z
         LuvTgWcz+pLUeOXYwHxj2GZU2PxlysgKP2+KA4UPQQ/tl2TeihwgHh5DmqvhvZQ0c5
         MJF1nmq3NGPHT/BvJM6w9/iw7xkBR8OIE+itoJBY+HkTVP+sOWoXkNUmR/fWiUmK/l
         HnITump7XfC6P2HTQ2Rzyfy/aq1qpOMDG8bDW6beKxOf3SQ0NRy6I24d0EdJbMJeeY
         0n70UYUGgSLD/Z7jsaYdi+foGoRq8KexvJF9YoJnw7ImqE/m4gkb+ds+Zadfj+h0J0
         zBUL47iiXyAig==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9A57360987;
        Sat, 29 May 2021 16:49:02 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 5.13-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YLJPKme41JEplEPQ@kroah.com>
References: <YLJPKme41JEplEPQ@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <YLJPKme41JEplEPQ@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.13-rc4
X-PR-Tracked-Commit-Id: 56dde68f85be0a20935bb4ed996db7a7f68b3202
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3837f9a08bdab2c9fabe6e52dcfb6cfbfa8be7d6
Message-Id: <162230694262.3322.17750446640994561353.pr-tracker-bot@kernel.org>
Date:   Sat, 29 May 2021 16:49:02 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The pull request you sent on Sat, 29 May 2021 16:26:50 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.13-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3837f9a08bdab2c9fabe6e52dcfb6cfbfa8be7d6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
