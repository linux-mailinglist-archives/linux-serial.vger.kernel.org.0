Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B046AB6A69
	for <lists+linux-serial@lfdr.de>; Wed, 18 Sep 2019 20:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388135AbfIRSUo (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 18 Sep 2019 14:20:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:42978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388024AbfIRSUZ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 Sep 2019 14:20:25 -0400
Subject: Re: [GIT PULL] TTY/Serial patches for 5.4-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568830824;
        bh=gaJVN6i0tLY/DInqds7HLK5NoSXLnc0NyGG+sv33Xeg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xm0sY9q722HY5gsLSPMgD+f/rmLh74ZguJeKgOn9OAfUIo12dOWjlNpI2NEMnpJXB
         L1dMzgUU3b3aIDzQBx7jy5rsqLD1hRVRINHFKG/4XAJK9PS6DqHSFwG3vj52+6uPK5
         1W2HxTrqC+dkO97f3LMR90Z7B+K4MG/MpeikuRPc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190918114726.GA1899411@kroah.com>
References: <20190918114726.GA1899411@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190918114726.GA1899411@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.4-rc1
X-PR-Tracked-Commit-Id: 1dce2df3ee06e4f10fd9b8919a0f2e90e0ac3188
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e444d51b14c4795074f485c79debd234931f0e49
Message-Id: <156883082464.23903.7758080359677649894.pr-tracker-bot@kernel.org>
Date:   Wed, 18 Sep 2019 18:20:24 +0000
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

The pull request you sent on Wed, 18 Sep 2019 13:47:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e444d51b14c4795074f485c79debd234931f0e49

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
