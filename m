Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB5F3DDD05
	for <lists+linux-serial@lfdr.de>; Sun, 20 Oct 2019 08:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbfJTG2V (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sun, 20 Oct 2019 02:28:21 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33813 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbfJTG2U (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 20 Oct 2019 02:28:20 -0400
Received: by mail-pf1-f196.google.com with SMTP id b128so6345592pfa.1
        for <linux-serial@vger.kernel.org>; Sat, 19 Oct 2019 23:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wgqwns+hXYlSxJb2/VobANvdUKdOXivh+q41F1ES4Nk=;
        b=ZvSf/8aPJ9MsgJaYsRxF7Rpo8M7PDOxPTRnEJplhfTWI+ABwxCZ+ahAwvqwwaGQd0z
         JBO82f2Y9tzCP61IzToilaUKcwt05di8ppCXTy7dvT+HGr2IeC9ETazGZgOGb+hny8T4
         MmFrcPFrIiDoWot3DY8yaOBM3UDav4lrpsDpUx7j8dE4tgXSAO2IlTqbqBDEx0gXf2Tk
         /fcGQRSMZuwuZ1+oCFVdfedGkPt1+POKQ3ye5B1Hb8r9QzJ01Qzehx5U6ChzKxa6lKJg
         N4mofxDNN0QyXvLn3qq7wogcUCzUkaOq1GMmqzlLqLXmNGCMuKFbSFVQTP0rJxTIhTt+
         vuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wgqwns+hXYlSxJb2/VobANvdUKdOXivh+q41F1ES4Nk=;
        b=Fd93xpIGHQnRks+rIWxURBX1yC1rERVrOzq+olROEtnna3Q0hy2JpeDg1zg+QqDmUD
         FlOWrCHrbxSJdvU8RioI0MYkVPhdfmZ2pUBClrMpd86yAha3wgHMcZTnhg5+K92bNPk8
         x6KNNSMill3JBjre8c2C/3HiLZsO8w6WCWJHhofGBxh6+Amwlx/y1iq1MAXt0j1wvW1w
         2FNQmMLXPABp0RaYAXgM7hUeP5rgQbRnJ1UnxeTtR/SfltVzsUi+PbcDN2Vnjd+ffq2f
         9kZoLKB5nzxUgxadwMQxOoaQ2hOcRPUekyqrtca8ehZCFqxMK+tBY3Lb+Fz3lFCuaaAJ
         pV9g==
X-Gm-Message-State: APjAAAWkI4brocYuUpqH9ei3Lhw/Izycn6dSw55oPl6OS2pyXCJCrSrR
        LQFRHkRxfTLCbSkxE0ElkHnaYOCgHZk=
X-Google-Smtp-Source: APXvYqxjgI/2skCFot/VDHR94bcjYOqbYYT9ScjTN8xIax6hdVMPTwOkmT3PsqR8jycWnjGXxbx18A==
X-Received: by 2002:a65:5cc5:: with SMTP id b5mr7654291pgt.137.1571552899940;
        Sat, 19 Oct 2019 23:28:19 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id o64sm24649254pjb.24.2019.10.19.23.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2019 23:28:19 -0700 (PDT)
Date:   Sat, 19 Oct 2019 23:28:16 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     agross@kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: serial: msm_serial: Fix flow control
Message-ID: <20191020062816.GE1669@tuxbook-pro>
References: <20191019210616.41199-1-jeffrey.l.hugo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191019210616.41199-1-jeffrey.l.hugo@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat 19 Oct 14:06 PDT 2019, Jeffrey Hugo wrote:

> hci_qca interfaces to the wcn3990 via a uart_dm on the msm8998 mtp and
> Lenovo Miix 630 laptop.  As part of initializing the wcn3990, hci_qca
> disables flow, configures the uart baudrate, and then reenables flow - at
> which point an event is expected to be received over the uart from the
> wcn3990.  It is observed that this event comes after the baudrate change
> but before hci_qca re-enables flow. This is unexpected, and is a result of
> msm_reset() being broken.
> 
> According to the uart_dm hardware documentation, it is recommended that
> automatic hardware flow control be enabled by setting RX_RDY_CTL.  Auto
> hw flow control will manage RFR based on the configured watermark.  When
> there is space to receive data, the hw will assert RFR.  When the watermark
> is hit, the hw will de-assert RFR.
> 
> The hardware documentation indicates that RFR can me manually managed via
> CR when RX_RDY_CTL is not set.  SET_RFR asserts RFR, and RESET_RFR
> de-asserts RFR.
> 
> msm_reset() is broken because after resetting the hardware, it
> unconditionally asserts RFR via SET_RFR.  This enables flow regardless of
> the current configuration, and would undo a previous flow disable
> operation.  It should instead de-assert RFR via RESET_RFR to block flow
> until the hardware is reconfigured.  msm_serial should rely on the client
> to specify that flow should be enabled, either via mctrl() or the termios
> structure, and only assert RFR in response to those triggers.
> 

I traced msm_reset() and msm_set_mctrl() and I get the following:
       swapper/0-1     [000] d..1     3.091726: msm_set_mctrl: msm_set_mctrl() reset rfr
       swapper/0-1     [000] d..1     3.117046: msm_set_mctrl: msm_set_mctrl() reset rfr
       swapper/0-1     [000] d..1     3.125484: msm_set_termios: msm_reset() set rfr
       swapper/0-1     [003] d..1     4.491430: msm_set_termios: msm_reset() set rfr
       swapper/0-1     [003] d..1     4.491733: msm_set_mctrl: msm_set_mctrl() auto rfr
           login-313   [001] d..1    78.010785: msm_set_mctrl: msm_set_mctrl() reset rfr
           login-313   [001] d..1    78.011007: msm_set_termios: msm_reset() set rfr
           login-313   [001] d..1    78.011021: msm_set_mctrl: msm_set_mctrl() auto rfr
           login-313   [001] d..1    78.063330: msm_set_termios: msm_reset() set rfr
           login-313   [001] d..1    78.063641: msm_set_termios: msm_reset() set rfr

So while your change does make sense for BT, wouldn't this mean that
with your patch and a 4-pin UART for the console I would end this dance
with receive flow blocked?

Regards,
Bjorn

> Fixes: 04896a77a97b ("msm_serial: serial driver for MSM7K onboard serial peripheral.")
> Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
> ---
>  drivers/tty/serial/msm_serial.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
> index 3657a24913fc..aedabf7646f1 100644
> --- a/drivers/tty/serial/msm_serial.c
> +++ b/drivers/tty/serial/msm_serial.c
> @@ -987,7 +987,7 @@ static void msm_reset(struct uart_port *port)
>  	msm_write(port, UART_CR_CMD_RESET_ERR, UART_CR);
>  	msm_write(port, UART_CR_CMD_RESET_BREAK_INT, UART_CR);
>  	msm_write(port, UART_CR_CMD_RESET_CTS, UART_CR);
> -	msm_write(port, UART_CR_CMD_SET_RFR, UART_CR);
> +	msm_write(port, UART_CR_CMD_RESET_RFR, UART_CR);
>  
>  	/* Disable DM modes */
>  	if (msm_port->is_uartdm)
> -- 
> 2.17.1
> 
