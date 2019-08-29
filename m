Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E997BA14EE
	for <lists+linux-serial@lfdr.de>; Thu, 29 Aug 2019 11:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725776AbfH2J3e (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 29 Aug 2019 05:29:34 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42353 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfH2J3d (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 29 Aug 2019 05:29:33 -0400
Received: by mail-lf1-f65.google.com with SMTP id u13so1944627lfm.9
        for <linux-serial@vger.kernel.org>; Thu, 29 Aug 2019 02:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=v1px0W6bor2CfhPl25Y0ywBmbArn00ubd+4d/DuNCK0=;
        b=NKGnK19uqLGAKQXSs+atbdwj8hRsWaXT4FlPLpSJdUlnH6zdVtQauqF3lzCUjfOonG
         HATPI/FJxO7g0U5MCBWPIR4f7oypsViQAmM+Hn32+ohZq87h52MiQgRNkUiBF/mnpRVw
         YBOpTZDZp4Ne5j1YPqiW/YexvF8OYxoIZPE2vc3Dj6ZECCR90YPlq49V3F311jlqLX9M
         byj1NU0Mi+Kq/zps+os307K8gJqXGJvNkH04+XLQuPCtfjHgSKxR3SxxXfb7MfXoKEl0
         Z2FUAu2H1ChvUZlUY7Oq5HvJGMfcUtxor7LvPnhWnjU8T5dffAzx9X7agW50oTKVEVES
         xvcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=v1px0W6bor2CfhPl25Y0ywBmbArn00ubd+4d/DuNCK0=;
        b=PEZYAgR56z7W3WQVgi+n7sLeVYDGA1CMc0NCeQzzgVU6auz77rCGqiuSC/QtFloqU/
         9x2Mpq7w1EKTCDZ81pRARnLwkZo0kSJJ1S9qHi2s7ZpxA/KbZPJz3rxLlcNoimI8oKhF
         GBPqqlolupPvGsUImNLCk6mryhgDC1q4DG09F3UwyKyfOa/xGRnXty8FVyZxtwkUGdT7
         nD7c7Exj4efF64IAN/uj443rtLJFlrKLHjO+69ibTFT1q7kSZNkoHrfctaMEawhRjCZy
         XTnbB1eS61W9UR/H+fViF6b/AcX4Hdu5PIMtAjhZiuwHYmPNw3R52qpkxoT7LWy/P30f
         Horw==
X-Gm-Message-State: APjAAAX2G+o+QSdN/bnz0Iix5vbFyfdtYJ1TqHOLIPHjTvP7lI15b6mf
        eiEXdjVgswCkar5hFsCtLCc=
X-Google-Smtp-Source: APXvYqyVG+0WeyEyz74rQn1zSW2gqBZ4RLGyOoeHkStHtatQqi6oOyga4lMgKC5AxJd+zcCceGU0Zw==
X-Received: by 2002:ac2:5097:: with SMTP id f23mr5693194lfm.130.1567070972047;
        Thu, 29 Aug 2019 02:29:32 -0700 (PDT)
Received: from mobilestation (mail.baikalelectronics.com. [87.245.175.226])
        by smtp.gmail.com with ESMTPSA id u9sm305021lja.27.2019.08.29.02.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 02:29:31 -0700 (PDT)
Date:   Thu, 29 Aug 2019 12:29:30 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Jan =?utf-8?Q?Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>
Cc:     linux-serial@vger.kernel.org,
        Joe Burmeister <joe.burmeister@devtank.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2] tty: max310x: Fail probe when external clock crystal
 is not stable
Message-ID: <20190829092929.7jdctqkg7r7xetky@mobilestation>
References: <13ea227620aaad8a7231d42ed03a8508297d4eb3.1567027079.git.jan.kundrat@cesnet.cz>
 <7b65026af26581722b37347b4557057ba86504a8.1567027079.git.jan.kundrat@cesnet.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7b65026af26581722b37347b4557057ba86504a8.1567027079.git.jan.kundrat@cesnet.cz>
User-Agent: NeoMutt/20180716
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Jan,

On Wed, Aug 28, 2019 at 10:29:30PM +0200, Jan Kundrát wrote:
> On (some) of my boards, it appears that it takes up to three *checks* of
> this register's value for the external crystal to settle so that it is
> reported as "ready" by the chip. For example, on one of these boards it
> always succeeds upon a third try no matter if the individual waits are
> for 1ms or for 10ms. The original timeout of 10ms is therefore not ideal
> as it was generating false warnings on working HW for me. Let's solve
> this by retrying up to 20 times (i.e., 200ms).
> 
> With this retrying in place, it is now also possible to fail device
> initialization altogether. A stable clock is really required in order to
> use this UART, so log an error message and bail out if the chip keeps
> saying "nope".
> 
> Tested on several MAX14830 PCBs.
> 
> Signed-off-by: Jan Kundrát <jan.kundrat@cesnet.cz>
> ---
>  drivers/tty/serial/max310x.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> index 0e0c2740ec7e..e8cd09d3e86f 100644
> --- a/drivers/tty/serial/max310x.c
> +++ b/drivers/tty/serial/max310x.c
> @@ -610,11 +610,14 @@ static int max310x_set_ref_clk(struct device *dev, struct max310x_port *s,
>  
>  	/* Wait for crystal */
>  	if (xtal) {
> -		unsigned int val;
> -		msleep(10);
> -		regmap_read(s->regmap, MAX310X_STS_IRQSTS_REG, &val);
> +		unsigned int val, i;
> +		for (i = 0; i < 20 && !(val & MAX310X_STS_CLKREADY_BIT); ++i) {

Don't you get a "'val' used uninitialized" compile-time warning here? Anyway
it must be zeroed before usage otherwise you might occasionally/permanently
end up with skipping this loop and the next conditional statement.

Though the former code was also buggy since in case if regmap_read() method
returned a non-zero value, the 'val' variable would be left uninitialized.
But this is a generic problem of the driver code, since it's a bit clumsy
at some places (I mean magic number literals and return values left untested).

I would also suggest to define and use the constants like MAX310X_XTAL_WAIT_RETRIES
and MAX310X_XTAL_WAIT_DELAY, so to parametrise this check-delay-loop.
Though it is up to you and the driver maintainer whether it's necessary to be
done.

-Sergey

> +			msleep(10);
> +			regmap_read(s->regmap, MAX310X_STS_IRQSTS_REG, &val);
> +		}
>  		if (!(val & MAX310X_STS_CLKREADY_BIT)) {
> -			dev_warn(dev, "clock is not stable yet\n");
> +			dev_err(dev, "clock is not stable\n");
> +			return -EAGAIN;
>  		}
>  	}
>  
> @@ -1301,6 +1304,10 @@ static int max310x_probe(struct device *dev, struct max310x_devtype *devtype,
>  	}
>  
>  	uartclk = max310x_set_ref_clk(dev, s, freq, xtal);
> +	if (uartclk < 0) {
> +		ret = uartclk;
> +		goto out_uart;
> +	}
>  	dev_dbg(dev, "Reference clock set to %i Hz\n", uartclk);
>  
>  	for (i = 0; i < devtype->nr; i++) {
> -- 
> 2.21.0
> 
> 
