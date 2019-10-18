Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 504BBDD0A4
	for <lists+linux-serial@lfdr.de>; Fri, 18 Oct 2019 22:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbfJRUwL (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 18 Oct 2019 16:52:11 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37533 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436486AbfJRUwK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Oct 2019 16:52:10 -0400
Received: by mail-wr1-f65.google.com with SMTP id p14so7594834wro.4
        for <linux-serial@vger.kernel.org>; Fri, 18 Oct 2019 13:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=uGEXsE8/NXoRF+D14w+boPYF50JZvz72YuC6YAN3OA0=;
        b=IBXlhzy0RGoAwB2ojEYPz7abKSVVtIzYBJwWK4c2HgNYuYnc1H23Y0feBGiRroGP5j
         JubIc4JzQMtDXZ7uQ2jlmTdmFKQ4Bt4Hz0G5tO902wI3BGWJDjMXjHQyCP4UQrcIkQmy
         OLOi1qgwk8pQzNaoyvNk5TUdcbynJpX0xd/4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uGEXsE8/NXoRF+D14w+boPYF50JZvz72YuC6YAN3OA0=;
        b=gkpEzRFEjVi7dnm7fQQv1tY37tCUShqJQz/PPMqxAYMQW2bOpA257EeUxgHrP3tw70
         npfhNIPrUym3TZj6x6xXqUeIVi3b8NAcRxO601CgSaADbLo+84vbvfoojDh66z+9nADp
         hSJLvYxs0ShpUWaBl3bD7gEz7CvRSM52T+W2HtbwrMvR21+zybzuz5FrZ27fnoPMLAek
         kqXsEQ39tk1IkaG7DCZ04Gdsjt8T718K+6BD7b2BR2pqglsLViWzXaYS9kqKBDoFbv3x
         bKiibzGPHZxEX18Y4Ob3aXvVprkAX9ud0GHztwZKPgYQl7pWqO12P4dTDqnabx2/+00W
         p99Q==
X-Gm-Message-State: APjAAAVXyU527JEylSTOogHvdiq8vGH6d5fLq/NIaXLo/d1ezlDZ0uN/
        c+FOmPSOOwsqO0BCdOSrkIAXN9Ma+s8YNlK8
X-Google-Smtp-Source: APXvYqz0kY5/OxYYxhR/1u58qGdFKWyMZCctPVLRK43Po/wT6eyex+6FLmeTJjDYNDpKlXaZ7a7AbA==
X-Received: by 2002:adf:9101:: with SMTP id j1mr8966445wrj.71.1571431925821;
        Fri, 18 Oct 2019 13:52:05 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id n15sm8053302wrw.47.2019.10.18.13.52.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 13:52:05 -0700 (PDT)
Subject: Re: [PATCH 0/7] towards QE support on ARM
To:     Leo Li <leoyang.li@nxp.com>, Qiang Zhao <qiang.zhao@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Timur Tabi <timur@kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <VE1PR04MB6687DA0268FAF03D3E77A23B8F6C0@VE1PR04MB6687.eurprd04.prod.outlook.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <e02fa027-9c78-3272-d2d7-7ad2b0ed3ab0@rasmusvillemoes.dk>
Date:   Fri, 18 Oct 2019 22:52:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <VE1PR04MB6687DA0268FAF03D3E77A23B8F6C0@VE1PR04MB6687.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 18/10/2019 22.16, Leo Li wrote:
> 
>>
>> There have been several attempts in the past few years to allow building the
>> QUICC engine drivers for platforms other than PPC. This is (the beginning of)
>> yet another attempt. I hope I can get someone to pick up these relatively
>> trivial patches (I _think_ they shouldn't change functionality at all), and then
>> I'll continue slowly working towards removing the PPC32 dependency for
>> CONFIG_QUICC_ENGINE.
> 
> Hi Rasmus,
> 
> I don't fully understand the motivation of this work.  As far as I know the QUICC ENGINE is only used on PowerPC based SoCs. 

Hm, you're not the Leo Li that participated in this thread
<https://lore.kernel.org/lkml/AM3PR04MB11857AE8D2B0BE56121B97D391C90@AM3PR04MB1185.eurprd04.prod.outlook.com/T/#u>?


 Can you give an example on how is it used on ARM system?

LS1021A, for example, which is the one I'm aiming for getting fully
supported in mainline.
<https://www.nxp.com/products/processors-and-microcontrollers/arm-processors/layerscape-communication-process/qoriq-layerscape-1021a-dual-core-communications-processor-with-lcd-controller:LS1021A>

The forks at https://github.com/qoriq-open-source/linux.git have various
degrees of support (grep for commits saying stuff like "remove PPCisms"
- some versions can be found on
<https://lore.kernel.org/lkml/?q=remove+ppcisms>). Our current kernel is
based on commits from the now-vanished 4.1 branch, and unfortunately at
least the 4.14 branch (LSDK-18.06-V4.14) trivially doesn't build on ARM,
despite the PPC32 dependency having been removed from CONFIG_QUICC_ENGINE.

>>
>> Tested on an MPC8309-derived board.
> 
> MPC8309 is also PPC based.

True, of course. This is just some first few steps, and I'm not claiming
that this is sufficient to make the QE drivers build on ARM yet. But I
have a customer with both mpc8309-based and ls1021a-based platforms, and
they want to run the same, as-close-to-mainline-as-possible, kernel on
both. So I will take a piecemeal approach, and try to make sure I don't
break the ppc boards in the process (just building and booting one board
is of course not sufficient, but better than nothing). Once I get to
actually build some of the QE drivers for ARM, I'll of course also test
them.

Rasmus
