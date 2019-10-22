Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34A18E01DF
	for <lists+linux-serial@lfdr.de>; Tue, 22 Oct 2019 12:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729810AbfJVKRs (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 22 Oct 2019 06:17:48 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34100 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfJVKRs (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 22 Oct 2019 06:17:48 -0400
Received: by mail-lj1-f196.google.com with SMTP id j19so16566368lja.1
        for <linux-serial@vger.kernel.org>; Tue, 22 Oct 2019 03:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UPQHJmcEnXeH/iiZIyJlOmriHnC0d9InpVAG+IS31RU=;
        b=h/3Uo75yRFQRRe+mjVmd8cMUmSai80wzLccdR09BlGw6HnocUgAczaz4IgYFRWgG3H
         OJdRbFB9Mz9fLShfMfIQz/v973qofYhFRWlTSouwX+s3dVq2XD/i9xdJL7HBCWbL6ait
         GeYoY67YnMUOYKMguf97VQFeB/gYvg8+cWRaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UPQHJmcEnXeH/iiZIyJlOmriHnC0d9InpVAG+IS31RU=;
        b=coicvJ12u1+bj0Ti968TNxo8s25HhWlVMUBQEe2CzExg7rOZ20daLiiqa3NSR7IZGh
         oItX4UM6+WZ3JWASkEMdPmSdV5bwXrlS6u+KzHzadTib8EIrDKhja3DF8mS5fm9fx4ao
         P1sBraY2gnNKrswKEdj9P5qH2yV6P0dYFOJoe7N1IHNUFLQOffyN/zVS7JsBksbeAmVv
         MoWRaCKHxsIUkgeITPsnaeKve8t9afObjFZyrTXCxaBEAazFF2swunf9AnI5eqnKKnRi
         KENlkCVxWg6JkdzSCUOMwMfJQVwUfb1zVYBUD1GZwq53ncrNHlpLuGrQ+p1DUIq/lorn
         d1vw==
X-Gm-Message-State: APjAAAXdKfAVEMlMCkrZVWzCzIxP80cRTzTmyNZ7vE9URqBW9GR9/9OV
        8NwN+m6lWuhKeOlsmPJoHC8muhus8oSlMxbA
X-Google-Smtp-Source: APXvYqwrLO6yXk3q5+ZZIbKEWNFhquBa+3kRuXdGYBzSGzi6Tc86djtM/ixn33Sd74ROetfVBAw3WQ==
X-Received: by 2002:a2e:8716:: with SMTP id m22mr10796456lji.102.1571739466229;
        Tue, 22 Oct 2019 03:17:46 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id b19sm7866434lji.41.2019.10.22.03.17.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 03:17:45 -0700 (PDT)
Subject: Re: [PATCH 0/7] towards QE support on ARM
To:     Qiang Zhao <qiang.zhao@nxp.com>, Leo Li <leoyang.li@nxp.com>
Cc:     Timur Tabi <timur@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Jiri Slaby <jslaby@suse.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <VE1PR04MB6687DA0268FAF03D3E77A23B8F6C0@VE1PR04MB6687.eurprd04.prod.outlook.com>
 <e02fa027-9c78-3272-d2d7-7ad2b0ed3ab0@rasmusvillemoes.dk>
 <CADRPPNREUK1SVxO4P5qb2COn+T04dtYgpVEzrveKUt16hBqAtQ@mail.gmail.com>
 <679bf33b-8c05-b77a-0cb2-d79dc5bfbe75@rasmusvillemoes.dk>
 <CADRPPNSiMUy77Dhxjg03sHDxyZzWf_BP8a5+fCncbynyO_cNGg@mail.gmail.com>
 <VE1PR04MB676825D5709839AEF75ED44C91680@VE1PR04MB6768.eurprd04.prod.outlook.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <43033011-1a2a-dea3-e3c9-75895f997407@rasmusvillemoes.dk>
Date:   Tue, 22 Oct 2019 12:17:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <VE1PR04MB676825D5709839AEF75ED44C91680@VE1PR04MB6768.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 22/10/2019 04.24, Qiang Zhao wrote:
> On Mon, Oct 22, 2019 at 6:11 AM Leo Li wrote

>> Right.  I'm really interested in getting this applied to my tree and make it
>> upstream.  Zhao Qiang, can you help to review Rasmus's patches and
>> comment?
> 
> As you know, I maintained a similar patchset removing PPC, and someone told me qe_ic should moved into drivers/irqchip/.
> I also thought qe_ic is a interrupt control driver, should be moved into dir irqchip.

Yes, and I also plan to do that at some point. However, that's
orthogonal to making the driver build on ARM, so I don't want to mix the
two. Making it usable on ARM is my/our priority currently.

I'd appreciate your input on my patches.

Rasmus

