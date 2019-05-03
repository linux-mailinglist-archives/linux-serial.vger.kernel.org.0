Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71376133D7
	for <lists+linux-serial@lfdr.de>; Fri,  3 May 2019 21:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfECTFM (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 3 May 2019 15:05:12 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:39049 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfECTFM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 3 May 2019 15:05:12 -0400
Received: by mail-it1-f196.google.com with SMTP id t200so10668324itf.4
        for <linux-serial@vger.kernel.org>; Fri, 03 May 2019 12:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=WUEvVuMZ7YPl2dVmcnur9vXgWXYbDp4Kv2NYf/KfC/E=;
        b=YyLoqA+MOSgu5Z/mdOZYresCbnsrP9MOECqAR4bgemiqd1NPH4z1kTNshqMr1wGxrO
         1ulkumKpTQ6uWLtA2Ene+eq+HrTs1KZoMqs9xg+p39iicmy0zTCL7uVABR+WOuDZA063
         +oNPgr10wY9fURWnsMIn4Glzq/w4seTiQt6nzHUkagCRCpv7txThNbb5poKXXUtiaq0C
         amJC+5CNfkSN3LxFTXn27zjZN09O67v/k/iPmRYOidALpODycYOWZxGJ1kWkYY3q8zeE
         jHByq6IVQuw2xmMN/9K1zm6po5Ybx+hPTG4ELBhJgSBqEWzHWP+zmvqJygso2YzaXz1P
         hhwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=WUEvVuMZ7YPl2dVmcnur9vXgWXYbDp4Kv2NYf/KfC/E=;
        b=YtNrkIwIzfhR37I0GekWbbHV4Tkd9pvN1OozNRyvE4Iq5LLSnBT7R9RnomVMBFng4r
         8nMdt/IZClbKE4wPJxcw3aCZAWUef1xlEfC3gI8n//6Qaa+RRo3TDtR6oo/cDRz0eSJl
         ETpGEl+8ZNpJRVftbXteqSEcObZDGFE5PWSXA0u/c2teaDEYPXGWIE0kRw6HgGE4m9tN
         PZlIudCwmpFNKdfm5O0T9dkvMHR/koAhsZ+EocTdp84/jeCToevIZi1brSYzGovsfnVJ
         jZyoFPkVwabd2OU1dsA584r5p+GxVxuVDscS+//G3sm4Wmh72cyYNTqtxVOtxHMUiyfn
         FJaw==
X-Gm-Message-State: APjAAAX0JePspLMPmbk30WVwTVRnInF1Z5f6guV2yIVI89EqFm+Clf0i
        2H8fJQM/uFezxUDiSS7CmdR6Sw==
X-Google-Smtp-Source: APXvYqzFS3nViSd8Ml55qWBQUACdB1pGNmsO/5+y7g1p6Gt2X232FHXVSyZ7sg92TLGrQz/n1IlHPQ==
X-Received: by 2002:a02:1146:: with SMTP id 67mr8522400jaf.10.1556910311443;
        Fri, 03 May 2019 12:05:11 -0700 (PDT)
Received: from localhost (74-95-18-198-Albuquerque.hfc.comcastbusiness.net. [74.95.18.198])
        by smtp.gmail.com with ESMTPSA id d193sm1154451iog.34.2019.05.03.12.05.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 12:05:10 -0700 (PDT)
Date:   Fri, 3 May 2019 12:05:09 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Kevin Hilman <khilman@baylibre.com>
cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <atish.patra@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 0/2] tty: serial: add DT bindings and serial driver
 for the SiFive FU540 UART
In-Reply-To: <7hsgtwlm5t.fsf@baylibre.com>
Message-ID: <alpine.DEB.2.21.9999.1905031141530.4777@viisi.sifive.com>
References: <20190413020111.23400-1-paul.walmsley@sifive.com> <7hmukmew5j.fsf@baylibre.com> <883f3d5f-9b04-1435-30d3-2b48ab7eb76d@wdc.com> <7h5zr9dcsi.fsf@baylibre.com> <f2bb876c-2b44-663b-ea06-d849f721fb6c@wdc.com> <7htvetbupi.fsf@baylibre.com>
 <alpine.DEB.2.21.9999.1904191407310.5118@viisi.sifive.com> <7hsgtwlm5t.fsf@baylibre.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, 2 May 2019, Kevin Hilman wrote:

> Paul Walmsley <paul.walmsley@sifive.com> writes:
> 
> > I'd recommend testing the DT patches with BBL and the open-source FSBL.  
> > That's the traditional way of booting RISC-V Linux systems.
> 
> OK, but as you know, not the tradiaional way of booting most other linux
> systems.  ;)
> 
> I'm working on getting RISC-V supported in kernelCI in a fully-automated
> way, and I don't currently have the time to add add support for BBL+FSBL
> to kernelCI automation tooling, so having u-boot support is the best way
> to get support in kernelCI, IMO.

That's great.  Please keep hacking away on RISC-V support for kernelCI.  
My point is just that the U-boot and OpenSBI software stack you're working 
with is not going to be useful for automatic tests of some kernel patches 
yet.  That stack is still very new, and was written around a non-upstream 
set of DT data.  We are in the process of posting and merging patches to 
fix that, but it's going to take a few releases of both the kernel and 
those other boot stack components until things are sorted out in a more 
durable way.


- Paul
