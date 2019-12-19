Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 731C8125D92
	for <lists+linux-serial@lfdr.de>; Thu, 19 Dec 2019 10:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfLSJZH (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 19 Dec 2019 04:25:07 -0500
Received: from ns.iliad.fr ([212.27.33.1]:38030 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726599AbfLSJZH (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 19 Dec 2019 04:25:07 -0500
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id ABD7D20404;
        Thu, 19 Dec 2019 10:25:05 +0100 (CET)
Received: from [192.168.108.51] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 966352040A;
        Thu, 19 Dec 2019 10:25:05 +0100 (CET)
Subject: Re: [PATCH 08/10] tty: serial: samsung_tty: use 'unsigned int' not
 'unsigned'
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Jiri Slaby <jslaby@suse.com>
References: <20191210143706.3928480-1-gregkh@linuxfoundation.org>
 <20191210143706.3928480-8-gregkh@linuxfoundation.org>
 <eb3cf8f9-3606-c2d6-ad90-4388a52c320b@free.fr>
 <20191212110834.GB1490894@kroah.com> <20191212160949.GA10815@infradead.org>
 <20191212161234.GA1673430@kroah.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <9339baa1-4a4b-ad12-e7e5-ba7b80d18031@free.fr>
Date:   Thu, 19 Dec 2019 10:25:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191212161234.GA1673430@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Thu Dec 19 10:25:05 2019 +0100 (CET)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 12/12/2019 17:12, Greg Kroah-Hartman wrote:

> On Thu, Dec 12, 2019 at 08:09:49AM -0800, Christoph Hellwig wrote:
>
>> On Thu, Dec 12, 2019 at 12:08:34PM +0100, Greg Kroah-Hartman wrote:
>>
>>> Yes.  It's a long-time checkpatch warning, it's good to be explicit for
>>> this type of thing.
>>
>> There is literally no practical benefit going either way.  It is
>> just checkpatch forcing one personal opinion on people.
> 
> Fair enough, but, I was trying to align up the variables to be the same
> type that was then used in a function call.  That's the only reason I
> made this change.

Do you type 'long long unsigned int' for an ULL?

Regards.
