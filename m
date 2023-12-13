Return-Path: <linux-serial+bounces-634-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B658089F1
	for <lists+linux-serial@lfdr.de>; Thu,  7 Dec 2023 15:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88ECE1F212E7
	for <lists+linux-serial@lfdr.de>; Thu,  7 Dec 2023 14:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C868341239;
	Thu,  7 Dec 2023 14:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NXQ5OSNO"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947C710F8
	for <linux-serial@vger.kernel.org>; Thu,  7 Dec 2023 06:11:01 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5d77a1163faso5908907b3.0
        for <linux-serial@vger.kernel.org>; Thu, 07 Dec 2023 06:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701958261; x=1702563061; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4c23Qqi3a2Hf5J7gfxXHXb1GanE4tjJ0ZroI12SpwMs=;
        b=NXQ5OSNOnqA77nlisp9QyvczrnhUlBDnnrCuklXZdo1xqSlkZg4KCMWQfVzcJWgTVu
         jasb1iQBzcgsDbpcEzrwBlJ/El9QpO43rFhXWBZC5lmRN1oLeWIB9nvx6IqlhmbLRMCO
         Y9ziWMTOHCTgUATkd2S8t3PTIs3AU13RT4dPHALnXIJKx5DqY8QuojSN7ZiuzzpJ7C15
         9lEhnqgTXxh7hmOzvTkfbsM0yoUce7SgDjZIUXaxeuMXMH8KUk3oMI9gXFjeUbqbSbbO
         IUA6jkxFZ+7qWoAzgCnM5vnnYfN1PSbiI2ba3KHshTv2aGHWyo465ARgHISze2V/+9dj
         J7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701958261; x=1702563061;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4c23Qqi3a2Hf5J7gfxXHXb1GanE4tjJ0ZroI12SpwMs=;
        b=YITIlMjP23/QWM72wM1IaBOTTgUTjZCKAUanne4KHH2p6H+BCdAG1DjiJ08l1yRSWd
         CMSSEMED+8mMyZ5SPPCBmN0QNT3Jt3YPv6+3u1Bapj9OHPdqewCA7zy2uhOsul/XXEyF
         hlLpChYYo8e9BZOIWelq8mrP7enuXHS6zD+WQJAo2U1WD/OfBWZrDbLP0TubxjV84MtL
         7IldXGIZRMQDzqYIxMJBxluEmcCbsZVBilYvXFkmQiDwkZdO5nD2yH/ZiLuhghcVjJT/
         cC2vQKQ56er8NBiqBENP87lCroYsdzAtTrskuxJ6uaz9n/bSrR7HBBPPtvfilqKU/ydE
         orCQ==
X-Gm-Message-State: AOJu0Yz1FmmDDTxv8xvgGd3FUqxPj6RPNVz36Ds+Q8+yfnhUFuisjQMb
	ANc/SMzzNLtnsvb5FRJOwwr0UkX3ObDqZ0Wlthx0Ww==
X-Google-Smtp-Source: AGHT+IHfZOsvWx7k5rwa8TLVbgwGAOeipHp5OxEj3mr89LZ/jCXwE4d7P8+lZhGKK91ejVX5+Ylua/a48gfeqRdku6s=
X-Received: by 2002:a0d:df15:0:b0:5d7:f0fe:2258 with SMTP id
 i21-20020a0ddf15000000b005d7f0fe2258mr3385408ywe.39.1701958260622; Thu, 07
 Dec 2023 06:11:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206073712.17776-1-jirislaby@kernel.org> <20231206073712.17776-17-jirislaby@kernel.org>
In-Reply-To: <20231206073712.17776-17-jirislaby@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 7 Dec 2023 15:10:24 +0100
Message-ID: <CAPDyKFo2TPVqd_1_SvQL0xiqgn8ipUq4Z1txxo5nFNsYYk4CZg@mail.gmail.com>
Subject: Re: [PATCH 16/27] tty: mmc: sdio: use u8 for flag
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Dec 2023 at 08:37, Jiri Slaby (SUSE) <jirislaby@kernel.org> wrote:
>
> Switch character types to u8. To conform to characters in the rest of
> the tty layer.
>
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc@vger.kernel.org

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/mmc/core/sdio_uart.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/sdio_uart.c b/drivers/mmc/core/sdio_uart.c
> index 370fadf1d6d1..575ebbce378e 100644
> --- a/drivers/mmc/core/sdio_uart.c
> +++ b/drivers/mmc/core/sdio_uart.c
> @@ -354,12 +354,11 @@ static void sdio_uart_stop_rx(struct sdio_uart_port *port)
>
>  static void sdio_uart_receive_chars(struct sdio_uart_port *port, u8 *status)
>  {
> -       unsigned int flag;
>         int max_count = 256;
>
>         do {
>                 u8 ch = sdio_in(port, UART_RX);
> -               flag = TTY_NORMAL;
> +               u8 flag = TTY_NORMAL;
>                 port->icount.rx++;
>
>                 if (unlikely(*status & (UART_LSR_BI | UART_LSR_PE |
> --
> 2.43.0
>

