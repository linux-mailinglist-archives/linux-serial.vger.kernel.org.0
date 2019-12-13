Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F046C11ED3D
	for <lists+linux-serial@lfdr.de>; Fri, 13 Dec 2019 22:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfLMVsu (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 13 Dec 2019 16:48:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:52568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbfLMVst (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 13 Dec 2019 16:48:49 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B9212253D;
        Fri, 13 Dec 2019 21:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576273729;
        bh=sPWhOOOWVc7e+qdedT6apM7CUC44x6CZqrxWfXP/3wQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ax2wcx33lygU+VgX2SvejstqfOgJ3u752qTJuWdGb9PRpZJ8N4Of7zfSPql1iBtXE
         lz32npd0//v5l6YV5Bw81HGnwbdQvOsmOBm1UOFObAfVDryH0ehwEykXVvrGW6ONFm
         wrljTJyTK9qwOMpxO0d74dj4SrusBBm/m41rEFjY=
Date:   Fri, 13 Dec 2019 17:07:00 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        syzbot <syzbot+f4f1e871965064ae689e@syzkaller.appspotmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        asierra@xes-inc.com, ext-kimmo.rautkoski@vaisala.com,
        Jiri Slaby <jslaby@suse.com>,
        kai heng feng <kai.heng.feng@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        mika.westerberg@linux.intel.com, o.barta89@gmail.com,
        paulburton@kernel.org, sr@denx.de,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        yegorslists@googlemail.com
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in
 mem_serial_out
Message-ID: <20191213160700.GA2632926@kroah.com>
References: <00000000000053539a0599173973@google.com>
 <20191212105701.GB1476206@kroah.com>
 <CACT4Y+ZeR=z-3CSXFazmngUhs9DqfxgZLKBNhzvfg49Nrw=EzA@mail.gmail.com>
 <20191213093357.GB2135612@kroah.com>
 <CACT4Y+beoeY9XwbQX7nDY_5EPMQwK+j3JZ9E-k6vhiZudEA1LA@mail.gmail.com>
 <74859736-478a-6ad7-f0be-cfe87ec40ff5@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74859736-478a-6ad7-f0be-cfe87ec40ff5@i-love.sakura.ne.jp>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Dec 13, 2019 at 11:31:08PM +0900, Tetsuo Handa wrote:
> On 2019/12/13 19:00, Dmitry Vyukov wrote:
> > Easier said than done. "normal user of the serial port" is not really
> > a thing in Linux, right? You either have CAP_SYS_ADMIN or not, that's
> > not per-device...
> > As far as I remember +Tetsuo proposed a config along the lines of
> > "restrict only things that legitimately cause damage under a fuzzer
> > workload", e.g. freezing filesystems, disabling console output, etc.
> > This may be another candidate. But I can't find where that proposal is
> > now.
> 
> That suggestion got no response for two months.
> 
>   https://lkml.kernel.org/r/3e4e2b6b-7828-54ab-cf28-db1a396d7e20@i-love.sakura.ne.jp
> 
> Unless we add such kernel config option to upstream kernels, it will become
> a whack-a-mole game.

It will be a whack-a-mole game no matter what.

Yes, /dev/mem/ makes no sense to fuzz.  Neither does other things (like
serial port memory addresses.)

You just will have a list of things that you "do not fuzz as these are
dangerous".  Nothing new here, any os will have that.

thanks,

greg k-h
