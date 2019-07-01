Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 088C7240AA
	for <lists+linux-serial@lfdr.de>; Mon, 20 May 2019 20:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfETStn (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 20 May 2019 14:49:43 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41980 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfETStm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 20 May 2019 14:49:42 -0400
Received: by mail-pf1-f193.google.com with SMTP id q17so7644249pfq.8
        for <linux-serial@vger.kernel.org>; Mon, 20 May 2019 11:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vJJECp0MXM+eJWnIRjXUD1/ASNuSVEfMK8V8t4znXkU=;
        b=HZXj+31ZYY4EetINXb7mkWZbDqY6Fg0lbVDC/GCSkTgV+0v3J6syLMb4kqRIvDjfP1
         NHHUIG4SKCx6HjQqY7b6xrv1Gx8dMUYN23qnyrYbxywzlaFq52q5kGkC4L5/rrSXkYkm
         f/OFSAsNoVnXqzbvPzHeIRxiLwh9Ksv6pCHXKgn1wrIzTwKiB54+hV3nccBldLcUxNlZ
         Sw0jTEsPeXnzCQtgYY9KKr49XedDbtVQnTEmoYYYWR0yZ/jGhqj3SQEVBVAZRz6Rhxlt
         +TFjSThQet9+AJ6FRVSdSTeM8I+1P1QRzVmazrDlt3e0GYa3qIAgAJro5NxY6SLMPzeI
         5SMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vJJECp0MXM+eJWnIRjXUD1/ASNuSVEfMK8V8t4znXkU=;
        b=lUHyqnLJOYPs9l08alZfnXQL8zRhBA0m6JF9pXuIEhkHwa5gEq8GaZwPZ/dyRn5lDb
         a1MgjcjXwnhAyrcVvEbP2jvw7Ak/2NQq6VneY8ov541DvQ9uB3DWB/6+I71WmUHgP0U6
         Mpyh/7DVDE2l2cojROdBscV58mrYgCG6qBPd3qT3Ac2kSNiOACEKheEWlX7QYCk4fDP0
         3HSkSEV5alVtOaL8/8NAqn8YuhlryUKcLsy69TJeXHYmGiB4fRCnt/7yrqg1nh1lqpxA
         n+ceMxPFyad/GRVVMGJWNSwFIYbZSmFqdcypShspPJdl3Tpdayo88hVu9V1V1Day+uFH
         +lew==
X-Gm-Message-State: APjAAAXDSVU+2WO3WU2U65WlwCq6jJrUlVuDPltWjC2OtVgCD1kvUxO6
        vJ6nzJfFMNNEtkCfjC3+k+v0bw==
X-Google-Smtp-Source: APXvYqxTXwbbq3D+od0+Bx4gQ0t6J+1TElbsgm6HtmILrAJ+dXlh61nvDyLEYwaqO6JbRCWRpYRL0Q==
X-Received: by 2002:a62:604:: with SMTP id 4mr82640684pfg.38.1558378181831;
        Mon, 20 May 2019 11:49:41 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v40sm25152531pgn.17.2019.05.20.11.49.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 11:49:41 -0700 (PDT)
Date:   Mon, 20 May 2019 11:50:08 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc:     agross@kernel.org, david.brown@linaro.org,
        gregkh@linuxfoundation.org, sboyd@kernel.org, jslaby@suse.com,
        keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tty: serial: msm_serial: Fix XON/XOFF
Message-ID: <20190520185008.GX2085@tuxbook-pro>
References: <20190520183848.27719-1-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520183848.27719-1-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon 20 May 11:38 PDT 2019, Jorge Ramirez-Ortiz wrote:

> When the tty layer requests the uart to throttle, the current code
> executing in msm_serial will trigger "Bad mode in Error Handler" and
> generate an invalid stack frame in pstore before rebooting (that is if
> pstore is indeed configured: otherwise the user shall just notice a
> reboot with no further information dumped to the console).
> 
> This patch replaces the PIO byte accessor with the word accessor
> already used in PIO mode.
> 
> Fixes: 68252424a7c7 ("tty: serial: msm: Support big-endian CPUs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

You missed Stephen's

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Regards,
Bjorn

> ---
>  drivers/tty/serial/msm_serial.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
> index 109096033bb1..23833ad952ba 100644
> --- a/drivers/tty/serial/msm_serial.c
> +++ b/drivers/tty/serial/msm_serial.c
> @@ -860,6 +860,7 @@ static void msm_handle_tx(struct uart_port *port)
>  	struct circ_buf *xmit = &msm_port->uart.state->xmit;
>  	struct msm_dma *dma = &msm_port->tx_dma;
>  	unsigned int pio_count, dma_count, dma_min;
> +	char buf[4] = { 0 };
>  	void __iomem *tf;
>  	int err = 0;
>  
> @@ -869,10 +870,12 @@ static void msm_handle_tx(struct uart_port *port)
>  		else
>  			tf = port->membase + UART_TF;
>  
> +		buf[0] = port->x_char;
> +
>  		if (msm_port->is_uartdm)
>  			msm_reset_dm_count(port, 1);
>  
> -		iowrite8_rep(tf, &port->x_char, 1);
> +		iowrite32_rep(tf, buf, 1);
>  		port->icount.tx++;
>  		port->x_char = 0;
>  		return;
> -- 
> 2.21.0
> 
