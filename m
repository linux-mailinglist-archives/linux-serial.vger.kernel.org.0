Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A02E67DBB5
	for <lists+linux-serial@lfdr.de>; Thu,  1 Aug 2019 14:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731360AbfHAMmD (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 1 Aug 2019 08:42:03 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37974 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731358AbfHAMmC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 1 Aug 2019 08:42:02 -0400
Received: by mail-ot1-f65.google.com with SMTP id d17so74107869oth.5
        for <linux-serial@vger.kernel.org>; Thu, 01 Aug 2019 05:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8uskxS/gtrPQuiJ87KLLKVngRsb10iia7FAnQ4L/FP4=;
        b=EAIcg+8zVmf3aiVkaSk+pQ7W32nML3AqDBA07rhI0mWPYK/3osobGOnAeAR2GlrG5m
         GO67N6l3RvzR1eC9rcIQ/IFgb+zglv9oj8/wU4H08MKHLJJa85rXrV4FO+pKiinnosMb
         mCgSmt1FKFQwTTDk+TptbMlLUZ8htN5s4VI7phJCqz3/9pWvmS+uRts6NzJLSukl5MrM
         EPQfCYOa9Htm7r3gBWUwcksVmOWkRg6/O7wrrJ8ia/a/5YlLOc9KmQFsjW9Ituh5Zqag
         wMzaWeA/jTiW3O6YYUVPnsN+5rZwJnoL7Qdd2VrvWcUzCbJis87TaKZCkTzBY+R8j1L2
         TXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8uskxS/gtrPQuiJ87KLLKVngRsb10iia7FAnQ4L/FP4=;
        b=uW04NEpKqtELTHpM0IyRNRVgLQesYphBfy1F+vkVLKeQKoa8zKQIBK4uY0m7pDyjeW
         yIA7vpyuR+36Zh0ho7xs8dcJx5zGP0ICfhw1oChluu1B+Px1V8kQo8fJQVp80rsPL5Cz
         RkdZTt+xmUwl8abcAX5CxhyY09j8R+GKCHgY9GIh1TzBS+A0fuJQd+kSI+LK7IFL2QEF
         ibsI5G151QAnAsP2bnAtxTmh5c+ur8CgvUoS0VAi9IwwrymwLG8oIFqNAvz26uWDmQ2s
         qum940qu2F6aJIIrfCugYhxhGyS4KZgiRBA/Db/cKPIt3vMWVUd9wnoD6kEVyuYq5bov
         9SQw==
X-Gm-Message-State: APjAAAX98LnmWsuAlOVPq5yvTb8MC1ZyLUvyp7wsdh1BtcHzu+8Ucncq
        XqGteNWt0AQndN1Sz1AHEaA=
X-Google-Smtp-Source: APXvYqyHzZulqNC8IOq14HrLA4yNgQS3ZptHYQMkICdV9xK4l15HxfWQ3z36+yWTTEw4+o1rfM2ftQ==
X-Received: by 2002:a9d:7cd1:: with SMTP id r17mr11015019otn.356.1564663322159;
        Thu, 01 Aug 2019 05:42:02 -0700 (PDT)
Received: from [192.168.1.10] (072-182-052-210.res.spectrum.com. [72.182.52.210])
        by smtp.googlemail.com with ESMTPSA id k135sm25007479oih.1.2019.08.01.05.42.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 05:42:01 -0700 (PDT)
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
 <20190731222359.GA20574@cello> <20190801092020.GB19329@kroah.com>
From:   Rob Landley <rob@landley.net>
Message-ID: <f6b331e1-14ff-040b-be2c-8f1a696a721e@landley.net>
Date:   Thu, 1 Aug 2019 07:44:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190801092020.GB19329@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 8/1/19 4:20 AM, Greg Kroah-Hartman wrote:
>> SysRq is system-wide, whereas this is per-terminal and only cares about
>> one tty which the status char is pressed at and its foreground pgrp
>> (most likely it's the foreground shell job).
>>
>> I hope this is clear enough.
> 
> It is, yes.  My big objection is the crazy code I point out above, as
> well as the "create a totally new interface when we might be able to use
> an existing one" that you need to convince me is really required :)

It's not a new interface, it's a multiple decades old BSD interface our
tcgetattr man page already mentions, which seems to be one of the big things BSD
people miss when using Linux, and which I tried and failed to implement without
kernel support months ago.

I wasn't involved in this kernel patch effort, I got pointed at news coverage
about it by the Android Bionic maintainer:

  http://lists.landley.net/pipermail/toybox-landley.net/2019-June/010536.html

Which is how I wound up cc'd on this thread.

I don't think Android specifically cares about SIGINFO, but they're trying to
support building Android on MacOSX, which means trying to support building it on
FreeBSD, which involves outreach to the BSD community, and they brought up the
lack of ctrl-T and siginfo as a thing they really missed when having to deal
with the Linux command line.

(The fact there _was_ news coverage of the patch for somebody to point me at may
also be an indication of interest floating around out there...)

Rob
