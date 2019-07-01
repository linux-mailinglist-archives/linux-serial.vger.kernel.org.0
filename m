Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0158E160F6
	for <lists+linux-serial@lfdr.de>; Tue,  7 May 2019 11:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbfEGJcp (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 7 May 2019 05:32:45 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45504 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbfEGJcp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 7 May 2019 05:32:45 -0400
Received: by mail-wr1-f68.google.com with SMTP id s15so21264225wra.12
        for <linux-serial@vger.kernel.org>; Tue, 07 May 2019 02:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=G7Dumy4AOd1vCBggiJHZKL6Nn0KP4/1BivjvxQRWHRk=;
        b=NKcG+r6/zP79zGYJQFgwyIJuD7cMOk/77HIGMvK1mr6K0hvINAMEtSAJpXL1Bbc1wE
         kiWtshjAD0n63GZ+InjbXUYB+y/J8xLsBihWtOfb74XrJLiQzYcRzW1y9MIbsSFtgDH+
         3HKIAXBuy0mD5UCzu7U6GvNZBu6UKWb8YGpvDpjo2OkM0/r7ophexlilpXli02aeBkbg
         X+Tyoz6UIB7fPDUx+yUlEA4zw4ELZAs7v85oq7yF/NB3EXsf+PxVAY9+YCocUV7/spJg
         3DoyBOxPIbRw9zAxsHjbXC5EMqzT39QDPqSeiYAyGRrs9jMoTMk4Ad1gpSNomauuxUyg
         mLBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=G7Dumy4AOd1vCBggiJHZKL6Nn0KP4/1BivjvxQRWHRk=;
        b=cQHgZkgQYn6VzzJMwdgQcfxcat2s471o8YC5O6cfZuHCjCKV0hl5GcESfQB9e/cfVD
         YgUMc98gg3eDJ3YJ4wN5mVPFxjL/EVn/VrJ87hdVB3bl5zMiVlFn7P/qWmuVyeMrhtA8
         mbijpQn9ecp4GlhDgtMbzkg7kJ9M4m1aFq/oupW6ypukriK0s8pwVERUbsD+uvc3tjug
         KAo4Pzgr3XyR9Ms0qT57usPXB29fr6YYQQUoo55wEZFomZxHbZnmL0oGkIlbKM2fWjtx
         lQUPZI5B/Rc8X4WTrCBYmFNYYkn6Yr/UrAHLFO3fai/YuL4NiBBLwAdii3SYaGeqKyvP
         aKWA==
X-Gm-Message-State: APjAAAU7NbqNyLU5GNuPiR9E2oDIEIy/fHxe4KzjOpd0Y+ipSO1eSpCu
        +Z5YAqK9gmWDccftrsCT2GhXuA==
X-Google-Smtp-Source: APXvYqzzMke6HbKJ7MgmPbfT9g2onn2MByckb//Ing49zbvFroSoe7K25cgK8jM9yeL80ui3gBbjGQ==
X-Received: by 2002:a5d:4642:: with SMTP id j2mr1210049wrs.268.1557221563105;
        Tue, 07 May 2019 02:32:43 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id h24sm15794834wmb.40.2019.05.07.02.32.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 02:32:41 -0700 (PDT)
Date:   Tue, 7 May 2019 10:32:39 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Esben Haabendal <esben@haabendal.dk>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, Enrico Weigelt <lkml@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        He Zhe <zhe.he@windriver.com>, Marek Vasut <marex@denx.de>,
        Douglas Anderson <dianders@chromium.org>,
        Paul Burton <paul.burton@mips.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: 8250: Add support for using platform_device
 resources
Message-ID: <20190507093239.GB4529@dell>
References: <20190430140416.4707-1-esben@geanix.com>
 <20190430153736.GL9224@smile.fi.intel.com>
 <874l6efxta.fsf@haabendal.dk>
 <20190502104556.GS9224@smile.fi.intel.com>
 <87pnp11112.fsf@haabendal.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87pnp11112.fsf@haabendal.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, 02 May 2019, Esben Haabendal wrote:

> Hi Lee
> 
> Could you help clarify whether or not this patch is trying to do
> something odd/wrong?
> 
> I might be misunderstanding Andy (probably is), but the discussion
> revolves around the changes I propose where I change the serial8250
> driver to use platform_get_resource() in favour of
> request_mem_region()/release_mem_region().

Since 'serial8250' is registered as a platform device, I don't see any
reason why it shouldn't have the capability to obtain its memory
regions from the platform_get_*() helpers.

> In my understanding, use of platform_get_resource() is the right thing
> to do in order to integrate properly with with MFD drivers that splits a
> common memory resource in mfd_add_device() using the mem_base argument.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
