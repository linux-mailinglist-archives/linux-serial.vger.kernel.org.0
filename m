Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487C91CB477
	for <lists+linux-serial@lfdr.de>; Fri,  8 May 2020 18:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgEHQPY (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 8 May 2020 12:15:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:39004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727030AbgEHQPF (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 8 May 2020 12:15:05 -0400
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 5.7-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588954505;
        bh=U4uf/LTSUu7dB+Di6WR4IkthF41sHSKz6pcDL2QLpoc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=WPOEyeLexYDw9cZHzp/NPtH5BELeEX7JNzhYOTBno0979eYutop7brZLsaAb3lco6
         E5sWQWwERvL6ojeBmu9e2IpX9y3D9AUKqM6WFbWAYt7Yoqds3EU650n+MDWZga0m3+
         dL9zlaZpQRSGbj9uTbxH3T6qdfnNDD81W+gPAF6k=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200508141737.GA350607@kroah.com>
References: <20200508141737.GA350607@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200508141737.GA350607@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.7-rc5
X-PR-Tracked-Commit-Id: 2ae11c46d5fdc46cb396e35911c713d271056d35
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cbd0e4821373ab10833c38edc3b858e3fa1a2976
Message-Id: <158895450527.20886.7050127718088470296.pr-tracker-bot@kernel.org>
Date:   Fri, 08 May 2020 16:15:05 +0000
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

The pull request you sent on Fri, 8 May 2020 16:17:37 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.7-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cbd0e4821373ab10833c38edc3b858e3fa1a2976

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
