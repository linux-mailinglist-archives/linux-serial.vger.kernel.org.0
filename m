Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 364008A78D
	for <lists+linux-serial@lfdr.de>; Mon, 12 Aug 2019 21:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfHLTwN (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 12 Aug 2019 15:52:13 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40275 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbfHLTwM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 12 Aug 2019 15:52:12 -0400
Received: by mail-qt1-f196.google.com with SMTP id e8so3567167qtp.7
        for <linux-serial@vger.kernel.org>; Mon, 12 Aug 2019 12:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=kEkVLWwqovwyFjtoRAd3ZuRhWq4pA+S9mUWyYQC3ODQ=;
        b=Go1xYdCnowLCjBoQHanBZc7stvpdCA4G/sIQJnrvYOMObBB2RF6oSbhmlUQOeUImJi
         FjU3UE6ZPgHFVoFvHQajdt5DYsYDsfr3MtE4zVRqViB/uQewO2eXWYVzND9A6/k4syDI
         KiQJ6kbVnAeos66Zydq4l49v2EO55bXWiaIY8YW1yEmsocbSrMGpDqu+fWwU8vgoLsAL
         BjBZUWdKUw5Ietmf5bF6Q/S0JeYR6CXwsVmVc2s/Qsj4Yz5gyHXdmhwnwpT0kgnEBwjL
         P516qLnaRnN3sZ9sXUHu8h9MiftUXkp2Ylvq4VMfyG9py3890rhln94s9T5uukkQHTwY
         uSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=kEkVLWwqovwyFjtoRAd3ZuRhWq4pA+S9mUWyYQC3ODQ=;
        b=jyZUAjm5qz+4h8isAJ77i3pCokDWD5TEp68McKUAtvM9401N0ikEZQOrypxMzMSddZ
         3GnH417pgMjuE2F9P5+uwtfwpqk5ezNmf120oCl12srDDMwRdRDI22URuHXXI7yc5eKN
         19Pf4d3SyilFoRE1TEZz6VBSVpkge3OHNZMQegvH8ZB30SVIBvxYOgGom0gJ2ieWE0JR
         Iynlm4oh0EStEJD9u5v7KNfCrVvrk9b8cx7I1mahA71STyY0srVBpxuYAw9WtW9USgXD
         z4sikY8XBUL3kOT7BhhAf7hMCe/AOW8+GCSGfDPnvU4TG0JvUdeKaVBO88caU3SLbAX4
         hA5A==
X-Gm-Message-State: APjAAAUfCIIo5wH/zQGYkMKDTGaM9RLFvYax8m6SfobTjptIcerBG0Cg
        EAc+arnIblwVwXYPoC0mfL+RCA==
X-Google-Smtp-Source: APXvYqy2g/f0DiyWHWOpG/JWWUORJpCznhP/S1XW87hCBQrOyaFf5OKJtY8YQ6WH8wMHkAb2ye+Nzw==
X-Received: by 2002:ac8:376c:: with SMTP id p41mr11767771qtb.306.1565639531882;
        Mon, 12 Aug 2019 12:52:11 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id g24sm3920710qtc.38.2019.08.12.12.52.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 12:52:11 -0700 (PDT)
Date:   Mon, 12 Aug 2019 12:52:02 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Evgeniy Polyakov <zbr@ioremap.net>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        netdev@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v4 7/9] mfd: ioc3: Add driver for SGI IOC3 chip
Message-ID: <20190812125202.46608b74@cakuba.netronome.com>
In-Reply-To: <20190811093212.88635fb1a6c796a073ec71ff@suse.de>
References: <20190809103235.16338-1-tbogendoerfer@suse.de>
        <20190809103235.16338-8-tbogendoerfer@suse.de>
        <20190809142222.4558691e@cakuba.netronome.com>
        <20190811093212.88635fb1a6c796a073ec71ff@suse.de>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, 11 Aug 2019 09:32:12 +0200, Thomas Bogendoerfer wrote:
> > Also please don't use stdint types in the kernel, please try checkpatch
> > to catch coding style issues.  
> 
> my patch already reduces them and checkpatch only warns about usage of printk
> for the network part. Changing that to dev_warn/dev_err in the mfd patch didn't
> seem the right thing to do. As I'm splitting the conversion patch into a few
> steps I could also replace the printks.

Thanks for looking into it. I was referring to the use of uint32_t
instead of u32. Perhaps checkpatch has to be motivated with the --strict
option to point those out?
