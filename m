Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAB0EDA47
	for <lists+linux-serial@lfdr.de>; Mon,  4 Nov 2019 09:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbfKDID7 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 4 Nov 2019 03:03:59 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40711 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbfKDID5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 4 Nov 2019 03:03:57 -0500
Received: by mail-lf1-f66.google.com with SMTP id f4so11481036lfk.7
        for <linux-serial@vger.kernel.org>; Mon, 04 Nov 2019 00:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LxAxNMBVL+dSGienin6qaCrk7en5CTrpwUxUJmlZZRg=;
        b=TrDTWGfMBfFjlWZ8uZDUT0w3BNWxwNGte+a8IpvcI6chs9MWID54loPeAyScghAAh8
         c7UhsZiHgMWlgfVzsY3JlounwUiaxX53oS0f2R2DthwMn0wijXA35T62J9fbrpjvwxSd
         vvkuLYbB2jATrla63DCyxhxyaqfj/lNl8Jy6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LxAxNMBVL+dSGienin6qaCrk7en5CTrpwUxUJmlZZRg=;
        b=URPAMBMhvarb0AbVcVw9Om9LCKHtIzlgBiXKJ9OMJTD/64G+XC9TrzIRee9Ifq4eXy
         wbKlhZghlIB1IV5/hZv4sQzpmbsf9odxQuV+FS0DjAiU1ye84O8lmtAX0imHKoqE6naU
         ydoa+4xFrGUM5wKTdKetg4hGO+0pivDjqm2GtWs93UY94Mogg2y+99ND7jxyKXmu0Jw9
         PwxXLSdG2zpsBW3Z/sPfRP+LnwqLHatHpYc+2K6NwKGWQX/p3lNkdcMM9Bn5dGCumIpv
         7H1gTk1FPYbbls8tfe9fjtJaCflTzlofa5QG9tQlhhAT2iru5NGikHe7nC9db0vp7t3r
         N0ow==
X-Gm-Message-State: APjAAAWfwwPQc03MPd6BwdlQC9SpgpoGy39wJt7fPj4vDamyaJmMYpFv
        yqNWOyq8mTVUM7lNX6ws3W+1qRnsFWzoOw==
X-Google-Smtp-Source: APXvYqwZ6WMPtJAcL4H1FSM0qke7qolXLVZOH2UexXvXSedbKeL3kV7Vji/MC2YFBHtLQv0vvrHfxw==
X-Received: by 2002:ac2:4357:: with SMTP id o23mr3316354lfl.51.1572854634877;
        Mon, 04 Nov 2019 00:03:54 -0800 (PST)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id e2sm6742553lfc.2.2019.11.04.00.03.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 00:03:54 -0800 (PST)
Subject: Re: [PATCH v3 31/36] serial: ucc_uart: stub out soft_uart_init for
 !CONFIG_PPC32
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, linux-serial@vger.kernel.org
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <20191101124210.14510-1-linux@rasmusvillemoes.dk>
 <20191101124210.14510-32-linux@rasmusvillemoes.dk>
 <53c1c463-53fc-2005-3b62-a6f430815b45@c-s.fr>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <6d1e4a08-4107-753f-8701-d3acb44b0104@rasmusvillemoes.dk>
Date:   Mon, 4 Nov 2019 09:03:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <53c1c463-53fc-2005-3b62-a6f430815b45@c-s.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 01/11/2019 17.27, Christophe Leroy wrote:
> 
> 
> Le 01/11/2019 à 13:42, Rasmus Villemoes a écrit :
>> The Soft UART hack is only needed for some PPC-based SOCs. To allow
>> building this driver for non-PPC, guard soft_uart_init() and its
>> helpers by CONFIG_PPC32, and use a no-op soft_uart_init() otherwise.
> 
> I don't like too much ifdefs in C files, especially arch specific ifdefs
> in generic drivers.

Me neither. However,

> How do we get the QE version on ARM ?
> 
> Wouldn't it be cleaner to create a helper for getting the QE version,
> which would be defined in an arch specific header file, calling
> mfspr(SPRN_SVR) on powerpc and whatever needed on arm ?

First, that would mean we'd have to introduce "depends on PPC32 || ARM"
rather than drop "depends on PPC32". Second, the way the SOC version is
being used to construct the name of the microcode blob seems very
ppc-specific, so I don't see how one can reasonably define an interface
that would work for all architectures. But it's also kind of moot since
the ARM SOCs don't need this workaround.

IMO, having to add qe-specific code to arch/ is a cure worse than the
disease. I'd much rather add arch-specific code to qe.

Rasmus
