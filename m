Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4EA199F44
	for <lists+linux-serial@lfdr.de>; Tue, 31 Mar 2020 21:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbgCaTjx (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 31 Mar 2020 15:39:53 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:55963 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbgCaTjx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 31 Mar 2020 15:39:53 -0400
Received: by mail-pj1-f68.google.com with SMTP id fh8so1535341pjb.5
        for <linux-serial@vger.kernel.org>; Tue, 31 Mar 2020 12:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+SEBPmaKCwakluiOKH2/X9qd2KFCw5+klGBkFt7yBuA=;
        b=FV0KFnXnWFV6SBFzOh8FP08ZqhKreHenI9vDUSgbxtfySfNkAdijq6e7XwFFxAvGRk
         QOOtVE6scJLeC6rCVa9ZbNaR72ECMnRJCdJka0ewLjn4VPXY5u9YtSRw8uEBQMmPghng
         3nQ+BVEvaDoDdBzpkRzcfkikbck06smg9Bo5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+SEBPmaKCwakluiOKH2/X9qd2KFCw5+klGBkFt7yBuA=;
        b=GjMG1ADFOaPE+/6TX/tXy2843TuyDUPcf5phnxrmplVdQdau25bz49T19MIC14i5xS
         T5ZVHoryWiGkMKy8NwIQU5ckhYSK9Y7+PrKiUyg6TC+Yz8jMz7yJ9EqzB2wXagrt+Ax6
         Brv75kzUFOqVWK5yAzFcmSLJhUsBngsgsSM6B7oiR1fXtoo1QdalfLTJEogN/tq0Ih1p
         OcAgl6By0dBYSWFiu9NfMUuRVV09/A+AR+WU2cBAM+WZY13DuSLlqBMtxuGoPYgfB3AF
         /kfTR0fAsgKmo6I0WylHw7z9My4ggW5iViBpIJgWVr4sc0UInebEj81GMMjsUOK6QRZz
         iieg==
X-Gm-Message-State: AGi0PuYhjbIhtNxwSb5EliNiBVOmfCgUUmnhpQ3VTYFk5SI91+Gvfid+
        G659BVAKyResIhABfnkMEk2b/A==
X-Google-Smtp-Source: APiQypITpWVqi8mhgij3s8U7rauYobkIxu0/d4+dAG6s7e92YB2WQe21W0C75Mqwdn2vf8vd6SNbAg==
X-Received: by 2002:a17:90a:362a:: with SMTP id s39mr591368pjb.28.1585683591124;
        Tue, 31 Mar 2020 12:39:51 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id e184sm12989883pfh.219.2020.03.31.12.39.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2020 12:39:50 -0700 (PDT)
Date:   Tue, 31 Mar 2020 12:39:49 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Akash Asthana <akashast@codeaurora.org>
Cc:     gregkh@linuxfoundation.org, agross@kernel.org,
        bjorn.andersson@linaro.org, wsa@the-dreams.de, broonie@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org, georgi.djakov@linaro.org,
        linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, swboyd@chromium.org,
        mgautam@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, dianders@chromium.org,
        evgreen@chromium.org
Subject: Re: [PATCH V3 6/8] tty: serial: qcom_geni_serial: Add interconnect
 support
Message-ID: <20200331193949.GK199755@google.com>
References: <1585652976-17481-1-git-send-email-akashast@codeaurora.org>
 <1585652976-17481-7-git-send-email-akashast@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1585652976-17481-7-git-send-email-akashast@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Akash,

On Tue, Mar 31, 2020 at 04:39:34PM +0530, Akash Asthana wrote:
> Get the interconnect paths for Uart based Serial Engine device
> and vote according to the baud rate requirement of the driver.
> 
> Signed-off-by: Akash Asthana <akashast@codeaurora.org>
> ---
> Changes in V2:
>  - As per Bjorn's comment, removed se == NULL check from geni_serial_icc_get
>  - As per Bjorn's comment, removed code to set se->icc_path* to NULL in failure
>  - As per Bjorn's comment, introduced and using devm_of_icc_get API for getting
>    path handle
>  - As per Matthias comment, added error handling for icc_set_bw call
> 
> Changes in V3:
>  - As per Matthias comment, use common library APIs defined in geni-se
>    driver for ICC functionality.
> 
>  drivers/tty/serial/qcom_geni_serial.c | 28 +++++++++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 8c5d97c..2befe72 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -965,6 +965,14 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
>  	ser_clk_cfg = SER_CLK_EN;
>  	ser_clk_cfg |= clk_div << CLK_DIV_SHFT;
>  
> +	/*
> +	 * Bump up BW vote on CPU path as driver supports FIFO mode only.
> +	 * Assume peak_bw as twice of avg_bw.
> +	 */
> +	port->se.from_cpu.avg_bw = Bps_to_icc(baud);
> +	port->se.from_cpu.peak_bw = Bps_to_icc(2 * baud);
> +	geni_icc_vote_on(&port->se);
> +
>  	/* parity */
>  	tx_trans_cfg = readl(uport->membase + SE_UART_TX_TRANS_CFG);
>  	tx_parity_cfg = readl(uport->membase + SE_UART_TX_PARITY_CFG);
> @@ -1202,11 +1210,14 @@ static void qcom_geni_serial_pm(struct uart_port *uport,
>  	if (old_state == UART_PM_STATE_UNDEFINED)
>  		old_state = UART_PM_STATE_OFF;
>  
> -	if (new_state == UART_PM_STATE_ON && old_state == UART_PM_STATE_OFF)
> +	if (new_state == UART_PM_STATE_ON && old_state == UART_PM_STATE_OFF) {
> +		geni_icc_vote_on(&port->se);
>  		geni_se_resources_on(&port->se);
> -	else if (new_state == UART_PM_STATE_OFF &&
> -			old_state == UART_PM_STATE_ON)
> +	} else if (new_state == UART_PM_STATE_OFF &&
> +			old_state == UART_PM_STATE_ON) {
>  		geni_se_resources_off(&port->se);
> +		geni_icc_vote_off(&port->se);
> +	}
>  }
>  
>  static const struct uart_ops qcom_geni_console_pops = {
> @@ -1304,6 +1315,17 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
>  			return -ENOMEM;
>  	}
>  
> +	ret = geni_icc_get(&port->se, "qup-core", "qup-config", NULL);
> +	if (ret)
> +		return ret;
> +	/* Set the bus quota to a reasonable value */
> +	port->se.to_core.avg_bw = console ? GENI_DEFAULT_BW :
> +		Bps_to_icc(CORE_2X_50_MHZ);
> +	port->se.to_core.peak_bw = console ? GENI_DEFAULT_BW :
> +		Bps_to_icc(CORE_2X_100_MHZ);

I'm still unconvinced about the setting of the core bandwidth based on
whether the port is used as console or not. It could possibly break
consoles working at speeds > 115kbs and reserve more bandwidth than
necessary for ports with 'slow' devices.

Why not scale the core bandwidth dynamically? You said earlier that there
is no clear/linear translation of port speed to bandwidth, but you could
use the same logic that is implicitly used here:

	if (baudrate <= 115200) {
		avg_bw = GENI_DEFAULT_BW;
		peak_bw = GENI_DEFAULT_BW;
	} else {
		avg_bw = Bps_to_icc(CORE_2X_50_MHZ);
		peak_bw = Bps_to_icc(CORE_2X_100_MHZ);
	}

This would be more robust, power efficient and future readers of the
code don't have to wonder "why is the console special?" when our
discussions on this will be long forgotten.
