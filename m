Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76FFA62F5D0
	for <lists+linux-serial@lfdr.de>; Fri, 18 Nov 2022 14:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241772AbiKRNTi (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 18 Nov 2022 08:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241464AbiKRNTi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Nov 2022 08:19:38 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C766667111
        for <linux-serial@vger.kernel.org>; Fri, 18 Nov 2022 05:19:36 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id bp15so8131434lfb.13
        for <linux-serial@vger.kernel.org>; Fri, 18 Nov 2022 05:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qObpje25bi55psFyDnPfevWhMqPCqDfh0xUyNaa1Rek=;
        b=Y+glzrXGWZUxAFAqVxiqwMqxBHJ+OTsmZwChsn+DrGnbhUdWnuemTB6gMpWm91qTuV
         PgnE6+iHehbsaQkJMculFN4IpCChcNEfSf0YPFB4oBM3aYM8sznCP2OLnUPFBMENGB/Q
         4FO4omAImuFh6quMcAK/aErtCNTHjbhn2rD+GvTHCg8G5FO2wpXWetVNX2d5U7947MPi
         MXdlX0fucjfw/IDdP1XFfdXtV4wefj/NuLngvU2Qi+6WeqqRZdRacai3Gn3aVPcjV4h1
         HvDbqc7kU9q+z0HPoOSjDMMNAUW4SM4ALIIIzeAzfGNCY48LZjZ+Bi9dCs+p9uVM8AoZ
         iApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qObpje25bi55psFyDnPfevWhMqPCqDfh0xUyNaa1Rek=;
        b=XGZTsqQlx1QCfAI9C5A7TxNCVqnrr8Mn0OshFPnIORYmCrAvqoOYph5168IvxxvQ1G
         FkxB4nesddTymyApW/+rgHho9IQ3k+lUGfE6amgVHciJkITjmhbAb+rNsFf6HKRHpyll
         XUlAyzPm1iagLPkIbm7nGhAuytyTjTlkfU6h0Ah7ye8/bp/doWxTaBy6pu1k8Tj8qurz
         6wk0FuC8uhPk8tBDDGKdnsdPJf60pFhqlMLiz5rQCFey2qynW55BhgA0ZPQFB8wHHcjA
         Ap2farFClXzfiXF7jqDoXbgZh6BSw8eyf8+kGtCRDK2A5QNFu4V2CtVo7zlP4bJBehVY
         vEiQ==
X-Gm-Message-State: ANoB5pm1jRnzGferKM2vcqijPNM3k8CuWMp266T+JB3LZQ3F1Xyh5/6w
        Cxa/NaA4G5ClexYayCifNW3hWw==
X-Google-Smtp-Source: AA0mqf6WFCzgPSYM8syPXnlsNA4atiiA0iwKUAebRQ2q10HEIV4UaQ6RteziHLu4sqrkpHeFLdk0lA==
X-Received: by 2002:a05:6512:3d10:b0:4b4:1177:a64c with SMTP id d16-20020a0565123d1000b004b41177a64cmr2731972lfv.647.1668777575155;
        Fri, 18 Nov 2022 05:19:35 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id s22-20020a056512315600b00497a0ea92desm655787lfi.135.2022.11.18.05.19.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 05:19:34 -0800 (PST)
Message-ID: <5f3fc637-4f8e-2699-2142-67d6fadf3ab7@linaro.org>
Date:   Fri, 18 Nov 2022 14:19:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH 02/15] tty: serial: qcom-geni-serial: remove unused
 symbols
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20221118122539.384993-1-brgl@bgdev.pl>
 <20221118122539.384993-3-brgl@bgdev.pl>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221118122539.384993-3-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 18/11/2022 13:25, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Drop all unused symbols from the driver.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>   drivers/tty/serial/qcom_geni_serial.c | 15 ---------------
>   1 file changed, 15 deletions(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 9f2212e7b5ec..7af5df6833c7 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -42,20 +42,11 @@
>   #define UART_TX_PAR_EN		BIT(0)
>   #define UART_CTS_MASK		BIT(1)
>   
> -/* SE_UART_TX_WORD_LEN */
> -#define TX_WORD_LEN_MSK		GENMASK(9, 0)
> -
>   /* SE_UART_TX_STOP_BIT_LEN */
> -#define TX_STOP_BIT_LEN_MSK	GENMASK(23, 0)
>   #define TX_STOP_BIT_LEN_1	0
> -#define TX_STOP_BIT_LEN_1_5	1
>   #define TX_STOP_BIT_LEN_2	2
>   
> -/* SE_UART_TX_TRANS_LEN */
> -#define TX_TRANS_LEN_MSK	GENMASK(23, 0)
> -
>   /* SE_UART_RX_TRANS_CFG */
> -#define UART_RX_INS_STATUS_BIT	BIT(2)
>   #define UART_RX_PAR_EN		BIT(3)
>   
>   /* SE_UART_RX_WORD_LEN */
> @@ -66,12 +57,9 @@
>   
>   /* SE_UART_TX_PARITY_CFG/RX_PARITY_CFG */
>   #define PAR_CALC_EN		BIT(0)
> -#define PAR_MODE_MSK		GENMASK(2, 1)
> -#define PAR_MODE_SHFT		1
>   #define PAR_EVEN		0x00
>   #define PAR_ODD			0x01
>   #define PAR_SPACE		0x10
> -#define PAR_MARK		0x11
>   
>   /* SE_UART_MANUAL_RFR register fields */
>   #define UART_MANUAL_RFR_EN	BIT(31)
> @@ -80,11 +68,8 @@
>   
>   /* UART M_CMD OP codes */
>   #define UART_START_TX		0x1
> -#define UART_START_BREAK	0x4
> -#define UART_STOP_BREAK		0x5
>   /* UART S_CMD OP codes */
>   #define UART_START_READ		0x1
> -#define UART_PARAM		0x1
>   
>   #define UART_OVERSAMPLING	32
>   #define STALE_TIMEOUT		16
