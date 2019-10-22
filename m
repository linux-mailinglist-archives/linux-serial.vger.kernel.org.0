Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7E79E01B7
	for <lists+linux-serial@lfdr.de>; Tue, 22 Oct 2019 12:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731331AbfJVKMg (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 22 Oct 2019 06:12:36 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41077 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731589AbfJVKMf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 22 Oct 2019 06:12:35 -0400
Received: by mail-lj1-f196.google.com with SMTP id f5so16534134ljg.8
        for <linux-serial@vger.kernel.org>; Tue, 22 Oct 2019 03:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hjSv+wwiORAZwQroV0MjPyGZjVfHuvomytZjWA/sFNI=;
        b=Ic0hqL5AEydTjmoYQ4tUn1uoaJcRLZ+2GEpJ1kQHS1/OR4c9etzeWrdKjwV8o1tcLD
         LPpA2VaMo3XUzapC0wtQpSC2SFXhaBgPzMavdDagC7dYu7RNq+FMhBB+Ew5Kwqtg4jPM
         juN3r0sW/bDp/bnW5U/eHm7+dlCaX6fr83uZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hjSv+wwiORAZwQroV0MjPyGZjVfHuvomytZjWA/sFNI=;
        b=qLGeaXGxH1gKlJYfFLpggW2V71L5TAmpG3p4FqCswkI8Ju6NY+sClPtfTGSXowvHkp
         AMiub4xNozTWe/9PLzsCZNG0JM3eA2JR3qNu2yIm4GeXa77tzZN3rhpfQmfR0OoN9TJ4
         8RXbgmJlQk2A2hgxMQTxG99j2ZlkeZ2pgvXMY3lFs5HCMpZls4qSAFcBJaEpfPdDK3mN
         JPTdkrGLNBVYnysjl/rj7Kumo0BJB4qCKhvwsF62NR+DcO8eMucmh8dWstex0noG9wYr
         JGgVNe89d32ZjeTUKVVK8I1h9ZseUPTOfwWLTyNabsnpG+3oQyj3mfWvmEvoroK2W3vf
         zxAQ==
X-Gm-Message-State: APjAAAVsfBtejV4OXZjvKe2M8tBUCdCvv/n8GuqxSjdXfC6vqZL2cdUt
        neM6WDO2yTNBHYDurfGEmr4qAuoE1Sari5i5
X-Google-Smtp-Source: APXvYqytv4x9SX0QXXZ5y785ZosmmkK9pTamMTH5LXkfjr+9GoKrqEXh83aR0//s2xRSFOK5cvBzdQ==
X-Received: by 2002:a05:651c:1042:: with SMTP id x2mr18711751ljm.127.1571739150552;
        Tue, 22 Oct 2019 03:12:30 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id a7sm3846380ljn.4.2019.10.22.03.12.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 03:12:29 -0700 (PDT)
Subject: Re: [PATCH 0/7] towards QE support on ARM
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Timur Tabi <timur@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Jiri Slaby <jslaby@suse.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Qiang Zhao <qiang.zhao@nxp.com>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <VE1PR04MB6687DA0268FAF03D3E77A23B8F6C0@VE1PR04MB6687.eurprd04.prod.outlook.com>
 <e02fa027-9c78-3272-d2d7-7ad2b0ed3ab0@rasmusvillemoes.dk>
 <CADRPPNREUK1SVxO4P5qb2COn+T04dtYgpVEzrveKUt16hBqAtQ@mail.gmail.com>
 <679bf33b-8c05-b77a-0cb2-d79dc5bfbe75@rasmusvillemoes.dk>
 <CADRPPNSiMUy77Dhxjg03sHDxyZzWf_BP8a5+fCncbynyO_cNGg@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <a2bfec28-1e5c-f3f1-56e7-b11b4c23aabe@rasmusvillemoes.dk>
Date:   Tue, 22 Oct 2019 12:12:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CADRPPNSiMUy77Dhxjg03sHDxyZzWf_BP8a5+fCncbynyO_cNGg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 22/10/2019 00.11, Li Yang wrote:
> On Mon, Oct 21, 2019 at 3:46 AM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>>

>>> Can you try the 4.14 branch from a newer LSDK release?  LS1021a should
>>> be supported platform on LSDK.  If it is broken, something is wrong.
>>
>> What newer release? LSDK-18.06-V4.14 is the latest -V4.14 tag at
>> https://github.com/qoriq-open-source/linux.git, and identical to the
> 
> That tree has been abandoned for a while, we probably should state
> that in the github.  The latest tree can be found at
> https://source.codeaurora.org/external/qoriq/qoriq-components/linux/

Ah. FYI, googling "LSDK" gives https://lsdk.github.io as one of the
first hits, and (apart from itself being a github url) that says on the
front page "Disaggregated components of LSDK are available in github.".
But yes, navigating to the Components tab and from there to lsdk linux
one does get directed at codeaurora.

>> In any case, we have zero interest in running an NXP kernel. Maybe I
>> should clarify what I meant by "based on commits from" above: We're
>> currently running a mainline 4.14 kernel on LS1021A, with a few patches
>> inspired from the NXP 4.1 branch applied on top - but also with some
>> manual fixes for e.g. the pvr_version_is() issue. Now we want to move
>> that to a 4.19-based kernel (so that it aligns with our MPC8309 platform).
> 
> We also provide 4.19 based kernel in the codeaurora repo.  I think it
> will be helpful to reuse patches there if you want to make your own
> tree.

Again, we don't want to run off an NXP kernel, we want to get the
necessary pieces upstream. For now, we have to live with a patched 4.19
kernel, but hopefully by the time we switch to 5.x (for some x >= 5) we
don't need to supply anything other than our own .dts and defconfig.

>> Yes, as I said, I wanted to try a fresh approach since Zhao
>> Qiang's patches seemed to be getting nowhere. Splitting the patches into
>> smaller pieces is definitely part of that - for example, the completely
>> trivial whitespace fix in patch 1 is to make sure the later coccinelle
>> generated patch is precisely that (i.e., a later respin can just rerun
>> the coccinelle script, with zero manual fixups). I also want to avoid
>> mixing the ppcism cleanups with other things (e.g. replacing some
>> of_get_property() by of_property_read_u32()). And the "testing on ARM"
>> part comes once I get to actually building on ARM. But there's not much
>> point doing all that unless there's some indication that this can be
>> applied to some tree that actually feeds into Linus', which is why I
>> started with a few trivial patches and precisely to start this discussion.
> 
> Right.  I'm really interested in getting this applied to my tree and
> make it upstream.  Zhao Qiang, can you help to review Rasmus's patches
> and comment?

Thanks, this is exactly what I was hoping for. Even just getting these
first rather trivial patches (in that they don't attempt to build for
ARM, or change functionality at all for PPC) merged for 5.5 would reduce
the amount of out-of-tree patches that we (and NXP for that matter)
would have to carry. I'll take the above as a go-ahead for me to try to
post more patches working towards enabling some of the QE drivers for ARM.

Rasmus
