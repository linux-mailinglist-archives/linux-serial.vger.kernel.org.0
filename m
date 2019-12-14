Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF7111EF67
	for <lists+linux-serial@lfdr.de>; Sat, 14 Dec 2019 01:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfLNAtS (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 13 Dec 2019 19:49:18 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:63397 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfLNAtS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 13 Dec 2019 19:49:18 -0500
Received: from fsav405.sakura.ne.jp (fsav405.sakura.ne.jp [133.242.250.104])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id xBE0mX3g067624;
        Sat, 14 Dec 2019 09:48:33 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav405.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav405.sakura.ne.jp);
 Sat, 14 Dec 2019 09:48:33 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav405.sakura.ne.jp)
Received: from [192.168.1.9] (softbank126040062084.bbtec.net [126.40.62.84])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id xBE0mWtv067616
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sat, 14 Dec 2019 09:48:33 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in
 mem_serial_out
To:     Greg KH <gregkh@linuxfoundation.org>
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
References: <00000000000053539a0599173973@google.com>
 <20191212105701.GB1476206@kroah.com>
 <CACT4Y+ZeR=z-3CSXFazmngUhs9DqfxgZLKBNhzvfg49Nrw=EzA@mail.gmail.com>
 <20191213093357.GB2135612@kroah.com>
 <CACT4Y+beoeY9XwbQX7nDY_5EPMQwK+j3JZ9E-k6vhiZudEA1LA@mail.gmail.com>
 <74859736-478a-6ad7-f0be-cfe87ec40ff5@i-love.sakura.ne.jp>
 <20191213160700.GA2632926@kroah.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <4f514a5a-af11-e688-8f8d-72bbadadc889@i-love.sakura.ne.jp>
Date:   Sat, 14 Dec 2019 09:48:29 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191213160700.GA2632926@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2019/12/14 1:07, Greg KH wrote:
> On Fri, Dec 13, 2019 at 11:31:08PM +0900, Tetsuo Handa wrote:
>> On 2019/12/13 19:00, Dmitry Vyukov wrote:
>>> Easier said than done. "normal user of the serial port" is not really
>>> a thing in Linux, right? You either have CAP_SYS_ADMIN or not, that's
>>> not per-device...
>>> As far as I remember +Tetsuo proposed a config along the lines of
>>> "restrict only things that legitimately cause damage under a fuzzer
>>> workload", e.g. freezing filesystems, disabling console output, etc.
>>> This may be another candidate. But I can't find where that proposal is
>>> now.
>>
>> That suggestion got no response for two months.
>>
>>   https://lkml.kernel.org/r/3e4e2b6b-7828-54ab-cf28-db1a396d7e20@i-love.sakura.ne.jp
>>
>> Unless we add such kernel config option to upstream kernels, it will become
>> a whack-a-mole game.
> 
> It will be a whack-a-mole game no matter what.
> 
> Yes, /dev/mem/ makes no sense to fuzz.  Neither does other things (like
> serial port memory addresses.)

/dev/mem makes sense to fuzz. Ditto for other things.

> 
> You just will have a list of things that you "do not fuzz as these are
> dangerous".  Nothing new here, any os will have that.

The list of kernel config options will become too complicated to maintain.
If we can have one kernel config option, we can avoid maintaining
the list of kernel config options (which keeps changing over time).
