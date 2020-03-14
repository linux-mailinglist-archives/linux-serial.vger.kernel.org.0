Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C269185395
	for <lists+linux-serial@lfdr.de>; Sat, 14 Mar 2020 01:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgCNA6U (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 13 Mar 2020 20:58:20 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:34939 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbgCNA6U (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 13 Mar 2020 20:58:20 -0400
Received: by mail-pj1-f68.google.com with SMTP id mq3so5269933pjb.0
        for <linux-serial@vger.kernel.org>; Fri, 13 Mar 2020 17:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XkYkz7olGuMoHjxIYMm5YyzLZkVPwk4ncu3nYGmC0LU=;
        b=hIzbj4tiMzwa7yvFFtYnreJK3Hm4RFPdQYBxc9OLUkJkVaHnGWgdL2WW3Wa2p6TqQe
         jPqXBfZXOQrxKtkIoobRZ7gq4psLmPnMjSSK5yt+utMMVDhdmcqeP6J3iYOn0MXXargV
         wcDJ9Sv78r1FZg64Er4hfwhJixUr9L5uEOVsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XkYkz7olGuMoHjxIYMm5YyzLZkVPwk4ncu3nYGmC0LU=;
        b=Rb2lXS92kUqCVhR3eBOnh+R3Orcstbf0oe/pompVz3AURvCDrJoGE1b2tBRwFs/0Lv
         Mr6Y61vEaUXLB3ycSDzdfRX4PofPuDBEql2EePhJlg4EDXDrTu4+uqpuXWcVgXfEZdFg
         2+TUr2KMGFjmsMSSjhlcUmtnjj/kwjq5zwL9GRJG8MqR2szHkYe/U6hTAAsMw9yhjk8M
         zmKpa77aY58tiJyHXUkiEHEoH/i1zhuJuRCFN10te7Q3/DcFj6dpNR2V3qE8VIijU/KC
         Bf7IPd47Engn6csLDrIH0H79MS3cB/AEkWJwU/33W2MshFEyaoAuuMvoNJBq7/BdwmBu
         zM+A==
X-Gm-Message-State: ANhLgQ3upMoGuJ806g//fl45JhntBOnTLc68WB+9DX7INoN9pIvZ9/Do
        HKjVjpqQ6KLcan42WROc1sM03A==
X-Google-Smtp-Source: ADFU+vvhBGrL9Xnlfe5/hQ6M3VwsQ+6WfaCs3st09JIB8ufa3kMvrkB86gSREv5L7WsZ80wVjP2TnQ==
X-Received: by 2002:a17:902:bf06:: with SMTP id bi6mr16374090plb.30.1584147499410;
        Fri, 13 Mar 2020 17:58:19 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id f19sm16696202pgn.42.2020.03.13.17.58.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2020 17:58:18 -0700 (PDT)
Date:   Fri, 13 Mar 2020 17:58:17 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Akash Asthana <akashast@codeaurora.org>
Cc:     gregkh@linuxfoundation.org, agross@kernel.org,
        bjorn.andersson@linaro.org, wsa@the-dreams.de, broonie@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org,
        linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, swboyd@chromium.org,
        mgautam@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, dianders@chromium.org,
        evgreen@chromium.org
Subject: Re: [PATCH V2 7/8] spi: spi-qcom-qspi: Add interconnect support
Message-ID: <20200314005817.GN144492@google.com>
References: <1584105134-13583-1-git-send-email-akashast@codeaurora.org>
 <1584105134-13583-8-git-send-email-akashast@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1584105134-13583-8-git-send-email-akashast@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On Fri, Mar 13, 2020 at 06:42:13PM +0530, Akash Asthana wrote:
> Get the interconnect paths for QSPI device and vote according to the
> current bus speed of the driver.
> 
> Signed-off-by: Akash Asthana <akashast@codeaurora.org>
> ---
>  - As per Bjorn's comment, introduced and using devm_of_icc_get API for getting
>    path handle
>  - As per Matthias comment, added error handling for icc_set_bw call
> 
>  drivers/spi/spi-qcom-qspi.c | 46 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 45 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
> index 3c4f83b..ad48f43 100644
> --- a/drivers/spi/spi-qcom-qspi.c
> +++ b/drivers/spi/spi-qcom-qspi.c
> @@ -2,6 +2,7 @@
>  // Copyright (c) 2017-2018, The Linux foundation. All rights reserved.
>  
>  #include <linux/clk.h>
> +#include <linux/interconnect.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> @@ -139,7 +140,10 @@ struct qcom_qspi {
>  	struct device *dev;
>  	struct clk_bulk_data *clks;
>  	struct qspi_xfer xfer;
> -	/* Lock to protect xfer and IRQ accessed registers */
> +	struct icc_path *icc_path_cpu_to_qspi;
> +	unsigned int avg_bw_cpu;
> +	unsigned int peak_bw_cpu;

This triplet is a recurring pattern, and is probably not limited to geni SE/QSPI.
On https://patchwork.kernel.org/patch/11436889/#23221925 I suggested the creation
of a geni SE specific struct, however adding a generic convenience struct to
'linux/interconnect.h' might be the better solution:

struct icc_client {
	struct icc_path *path;
	unsigned int avg_bw;
	unsigned int peak_bw;
};

I'm sure there are better names for it, but this would be the idea.
