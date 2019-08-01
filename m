Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2C997DB8C
	for <lists+linux-serial@lfdr.de>; Thu,  1 Aug 2019 14:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbfHAMdK (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 1 Aug 2019 08:33:10 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45028 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729674AbfHAMdH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 1 Aug 2019 08:33:07 -0400
Received: by mail-io1-f67.google.com with SMTP id s7so143748485iob.11
        for <linux-serial@vger.kernel.org>; Thu, 01 Aug 2019 05:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nSjf7Vc65CILCy7mU48VP6jwKV8+a2ONS+dOixTDAV8=;
        b=edmqvP5V+EVTYlKP6vnI67S2BlmrDVQ0NeBnAp+i3ZXzUfRZ58pq7I8IoLyo1RMw2A
         1EC7uvN3D45SSIAJCZpvaJL+SDjUfsgKOquh6gYu2tbkn9EQtEYIw80NZbMzP+E3iX3e
         blxjUhtoL7t/0vcGRVfMoaSeCHsugSb216djtjYFj9uV7rODMALyKOM35VzrWRgZSLbL
         8XF9s4txpGfkv5dCDjYJueIp4ukBePYvwYY8vPnjj+BYNjueBpcmQVbC51nAWBBOfvuA
         chFIs/3wTCRifrEnZEabGMXD5oQa3krd5vPrQxGVrOswyxYbKsebayBsw5HjOcAySoGr
         zIJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nSjf7Vc65CILCy7mU48VP6jwKV8+a2ONS+dOixTDAV8=;
        b=lY2eNK4u4tX5db/LEWGJdrlLkdk0Q/Eaq11OHpZH7MOUa8P8LcJNYc8AcPkiE1QLmE
         nQt7neyEjYz5ODafIHz7mUa0DFkcyGZVpldawD6Qhv56l8k2A+xfQEepOLcodGBx8Y6R
         qgkptVGIv52zGpAKeEZKk1W5cl6b22OThGf4tpFI7tlTOd6C5P1R0HJJ0Y4S24RsMo9d
         on6WMcic/OSpVOieMLcUXphs/gSUgG49CoY5MfbRSPXcrPVpJNVYt2BX/pxYjcX8GNuf
         QST2SB7esOl/N1XN8Q3nG029xY7RroPpXUnqM+L552JoEGA2oOCfr18SzfOgHFi0/IRk
         tg+w==
X-Gm-Message-State: APjAAAVNBNPGxJNfYjD8LqezpKtFaav79s4xK/yppkI1UGauviMRg6wN
        FWTPZmXVSRE8ny/cyi/arPQ=
X-Google-Smtp-Source: APXvYqzyUz8wAkDi95tv5DYR8E7lqBwsyRSIPQdGPKpFANXrXx6N5XnD9lczxplfC7vKSE/qRPgYXA==
X-Received: by 2002:a5d:9f4a:: with SMTP id u10mr1590817iot.243.1564662786029;
        Thu, 01 Aug 2019 05:33:06 -0700 (PDT)
Received: from [192.168.1.10] (072-182-052-210.res.spectrum.com. [72.182.52.210])
        by smtp.googlemail.com with ESMTPSA id b8sm58783772ioj.16.2019.08.01.05.33.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 05:33:05 -0700 (PDT)
Subject: Re: [PATCH v2 7/7] n_tty: Provide an informational line on VSTATUS
 receipt
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arseny Maslennikov <ar@cs.msu.ru>
Cc:     Jiri Slaby <jslaby@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Vladimir D. Seleznev" <vseleznv@altlinux.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Pavel Machek <pavel@ucw.cz>
References: <20190625161153.29811-1-ar@cs.msu.ru>
 <20190625161153.29811-8-ar@cs.msu.ru> <20190730161940.GA15798@kroah.com>
From:   Rob Landley <rob@landley.net>
Message-ID: <c6750387-8888-0b48-1d82-fd13c4466aa9@landley.net>
Date:   Thu, 1 Aug 2019 07:35:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190730161940.GA15798@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 7/30/19 11:19 AM, Greg Kroah-Hartman wrote:
> On Tue, Jun 25, 2019 at 07:11:53PM +0300, Arseny Maslennikov wrote:
>> If the three termios local flags isig, icanon, iexten are enabled
>> and the local flag nokerninfo is disabled for a tty governed
>> by the n_tty line discipline, then on receiving the keyboard status
>> character n_tty will generate a status message and write it out to
>> the tty before sending SIGINFO to the tty's foreground process group.
>>
>> This kerninfo line contains information about the current system load
>> as well as some properties of "the most interesting" process in the
>> tty's current foreground process group, namely:
>>  - its PID as seen inside its deepest PID namespace;
>>    * the whole process group ought to be in a single PID namespace,
>>      so this is actually deterministic
>>  - its saved command name truncated to 16 bytes (task_struct::comm);
>>    * at the time of writing TASK_COMM_LEN == 16
>>  - its state and some related bits, procps-style;
>>  - for S and D: its symbolic wait channel, if available; or a short
>>    description for other process states instead;
>>  - its user, system and real rusage time values;
>>  - its resident set size (as well as the high watermark) in kilobytes.
> 
> Why is this really all needed as we have the SysRq handlers that report
> all of this today?

People were lamenting the lack of siginfo in linux back in May, I offered to try
to implement it, several people jumped in to offer suggestions, and it turns out
you can't really do it without kernel support.

https://twitter.com/landley/status/1131764323196522498

 >> The "most interesting" process is chosen as follows:
>>  - runnables over everything
>>  - uninterruptibles over everything else
>>  - among 2 runnables pick the biggest utime + stime
>>  - any unresolved ties are decided in favour of greatest PID.
> 
> This does not feel like something that the tty core code should be doing
> at all.

I couldn't figure out how to do it without kernel support when I tried.

http://lists.landley.net/pipermail/toybox-landley.net/2019-May/010461.html

Rob
