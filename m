Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD6491C733
	for <lists+linux-serial@lfdr.de>; Tue, 14 May 2019 12:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbfENKrq (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 14 May 2019 06:47:46 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44427 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfENKrp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 May 2019 06:47:45 -0400
Received: by mail-wr1-f68.google.com with SMTP id c5so18605403wrs.11
        for <linux-serial@vger.kernel.org>; Tue, 14 May 2019 03:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=5gH8SCU/PfgFL5qEKFSie+aHi1qe4cMAqpYxa6KsVr0=;
        b=fZ8OmwN3LUlRQYZcNOrplAIIuTozu0QQ5MxVQASFRednsF/M7Dj5xVDBEWiKdhET1t
         zTNFaVuzuUn5QArZyZf2Wcq0rgARGXJw9unRfiYbQJgjOByk6guGFdDyYrywgNwUJnu1
         7saI7oyKJeDEkIGN/h7D3c1A1+uN5Z9LQFo9tGCD9J2Qd0gAPThHRzZSOTL8LFX1LCJQ
         IyF+RmpegWQG4WwDYeF+u9ClHSf6hG6Dn3uLK8l7qk7jTOjavlaB7/oNUOiUkXCRS6qB
         sh2CQj5p6qAkXEe/LdjQKkn4aOF9LvEZq9JDqSQ+mER/lSsV+QfPYv/Q5hLqIliufVfa
         rphg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5gH8SCU/PfgFL5qEKFSie+aHi1qe4cMAqpYxa6KsVr0=;
        b=WophrlpODJiC6+nU2CiHnsdLllnfXMmnTE+Q88X8bHQcddTaPS4asRoBCWjXYnu48M
         XLJv3OiRtxN1jr8zUcgKb0WMcP5MxYFNOTtXT9DuHD1fyAFealWyXDqxY8a+dkSqzg9r
         KNKcQ+USeHIupFg/gNYsA3/UfVbmPe2CUAFGAd2EwQjzE8IZs2fQ+M2cKnyaUCOan466
         ie37WRTcncq4euxJzg0cI/jq8dNAFPOCtdPdht5qAkjr/ssIshBxZP9ICgFw741/C5et
         H8li5KKOPbO+m1QGggRqlfPWZ4w2MVaKNeeEyOAR7LYelAKTfZuZOevDiGKRG0tpCGy6
         itrg==
X-Gm-Message-State: APjAAAV6WNF5xcN96XnfNHJiC4l1tZbaRcFAs7n4Cl9pRmvSG6R53sun
        r/7EtN7VyvEDpv2hfUkcOXV8NQ==
X-Google-Smtp-Source: APXvYqwN77j5a17Ol6619bFQGaGTN4yqAu8K0d9UvECNwiucQ8+X3xiYOAbaiWYhA9TMxstw+mcKMQ==
X-Received: by 2002:a5d:4945:: with SMTP id r5mr20197015wrs.328.1557830864276;
        Tue, 14 May 2019 03:47:44 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id t18sm35338093wrg.19.2019.05.14.03.47.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 03:47:43 -0700 (PDT)
Date:   Tue, 14 May 2019 11:47:41 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Esben Haabendal <esben@haabendal.dk>
Cc:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Nishanth Menon <nm@ti.com>,
        Vignesh R <vigneshr@ti.com>, Tony Lindgren <tony@atomide.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] serial: 8250: Add support for 8250/16550 as MFD
 function
Message-ID: <20190514104741.GO4319@dell>
References: <20190426084038.6377-1-esben@geanix.com>
 <20190426084038.6377-3-esben@geanix.com>
 <20190507114905.GB29524@dell>
 <87o94ejwrx.fsf@haabendal.dk>
 <20190507133844.GA6194@dell>
 <87bm05mpmx.fsf@haabendal.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bm05mpmx.fsf@haabendal.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, 14 May 2019, Esben Haabendal wrote:

> Lee Jones <lee.jones@linaro.org> writes:
> 
> > On Tue, 07 May 2019, Esben Haabendal wrote:
> >
> >> Lee Jones <lee.jones@linaro.org> writes:
> >> 
> >> > On Fri, 26 Apr 2019, Esben Haabendal wrote:
> >> >
> >> >> The serial8250-mfd driver is for adding 8250/16550 UART ports as functions
> >> >> to an MFD driver.
> >> >> 
> >> >> When calling mfd_add_device(), platform_data should be a pointer to a
> >> >> struct plat_serial8250_port, with proper settings like .flags, .type,
> >> >> .iotype, .regshift and .uartclk.  Memory (or ioport) and IRQ should be
> >> >> passed as cell resources.
> >> >
> >> > What?  No, please!
> >> >
> >> > If you *must* create a whole driver just to be able to use
> >> > platform_*() helpers (which I don't think you should), then please
> >> > call it something else.  This doesn't have anything to do with MFD.
> >> 
> >> True.
> >> 
> >> I really don't think it is a good idea to create a whole driver just to
> >> be able to use platform_get_*() helpers.  And if I am forced to do this,
> >> because I am unable to convince Andy to improve the standard serial8250
> >> driver to support that, it should be called MFD.  The driver would be
> >
> > I assume you mean "shouldn't"?
> 
> Of-course.
> 
> >> generally usable for all usecases where platform_get_*() works.
> >> 
> >> I don't have any idea what to call such a driver.  It really would just
> >> be a fork of the current serial8250 driver, just allowing use of
> >> platform_get_*(), supporting exactly the same hardware.
> >> 
> >> I am still hoping that we can find a way to improve serial8250 to be
> >> usable in these cases.
> >
> > Me too.
> 
> Unfortunately, I don't seem to be able to convince Andy to accept
> something like that.

Andy is not he Maintainer.

What are Greg and Jiri's opinions?

> I might have to do this out-of-tree :(

Well that would suck!

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
