Return-Path: <linux-serial+bounces-1573-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D2E82F4C1
	for <lists+linux-serial@lfdr.de>; Tue, 16 Jan 2024 19:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3B701F251F5
	for <lists+linux-serial@lfdr.de>; Tue, 16 Jan 2024 18:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C38E1CF99;
	Tue, 16 Jan 2024 18:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w9zb9cRi"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66771D525
	for <linux-serial@vger.kernel.org>; Tue, 16 Jan 2024 18:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705431513; cv=none; b=rULqSlTQT6cEpDrzuVF6mi308f4kHQb7YrQMbWOOUsJhbFZKZ0RRv7t/JaqQBUPebQtmpKUt31KyE8LHj4IWPidpjJY742dMBbveAeobboX8AkzAk/tW3l02ZVoQfsNcD8g+fIzkSwR7VJBwYv1uj7PYf5z7rWofxHA2apkhcNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705431513; c=relaxed/simple;
	bh=1jSYDldNul1j+TFKQiGTnHjckSElbNdeSAqEGrBnCdU=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=Xw5pH3QtefE8vOm2VH5XyGfm/XCe4vETdT3NX5e/pCjs82bexxqo5/kC1xPm2tYSpgSICZVd/9y066wuH28PdwL849BfckTv4rzCqnWz4RK3Do0rRPpNUoZ53WlWi9cI+hXvMquHIJOFTigrLqKA9lzlYDxSsITRdOO/hFmC1iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w9zb9cRi; arc=none smtp.client-ip=209.85.216.43
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-28e81a5266aso581543a91.3
        for <linux-serial@vger.kernel.org>; Tue, 16 Jan 2024 10:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705431511; x=1706036311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2oCdAkKnavoOvVi1SZjHevpM3/FRNgveC7ge77+X6CM=;
        b=w9zb9cRi71lygKp+HSDf4iWagK+HZnSC9uTpCMtXN03+m8mN381ZitBODRuoK4Pp7Q
         f8lr8o3MUDBt3g2Cvloc/P2gDLx1BxThKn55KIVl7AYiNzptWmLMrRa/wn/D/MuMrPEu
         dyrrqtUJmecrM93Fc68+UlzOCD33A5fSQCPAZ5MfDzsM9/zwppWe0ZsDgLgmbgh8w6qW
         ek1zBAI74xbYxWi7zeMLUQhNJ72LoVAi7EU+Qk3rlaDDMmNPlt7z/lSAfZB4hPJa16xy
         p88yXV/WULa2v8y1DL2p7WsW+4v4JVLGxSt2FoMEYUcEDZYF0LBQeTdgwhAk9Ti7HK8L
         k56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705431511; x=1706036311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2oCdAkKnavoOvVi1SZjHevpM3/FRNgveC7ge77+X6CM=;
        b=MV+qLuEjn9QWV26RqESxsZBS/JSioHxBFsVnH+0VkoKP44FdyYL1TMhdz6VgSwuypV
         8QsRUubmpIFKkRITP8aW8vVLE0u3pF/6PbfqitkEjfe2JbkLUM/JujHKQ1kIsGfi38IP
         KDqsuvplt1yqG4LH4w+GXKfOZ4uMnlo+HSi9QxnKFJhmqI3uBadG82RQcbwIagdhXDlq
         hNK49mF5uab9cKyMKb5TObWcjTfJwGClb/t4ouETki3YSyG3kUq5LaqkG5oA/4pePbcZ
         jwEN25x+SgCHvHaaCD6KtfLmRFQJkDz0eLH7E9xPrAXRJ/AT51JmL5JB36W3Upw0UnNm
         MOJQ==
X-Gm-Message-State: AOJu0YwqngMnhu+IeYA1YZU6WBNc+tpDrQgefMAJqf4OOcH0Z1mRXJ5b
	mvqlayHE/KYYfESaIc7dsD+d8MZNfADds+3mtSTX3wi5GcHU2g==
X-Google-Smtp-Source: AGHT+IFTfsSveHFMNr40yZrksNylXfdqszYw2WgUnOkQYDVCAXRAzwVkTTSb/r4m+jO096qstDbuM72Gp4j3TBGx6rM=
X-Received: by 2002:a17:90b:a10:b0:28e:81a6:f92f with SMTP id
 gg16-20020a17090b0a1000b0028e81a6f92fmr815117pjb.82.1705431511355; Tue, 16
 Jan 2024 10:58:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110102102.61587-1-tudor.ambarus@linaro.org> <20240110102102.61587-16-tudor.ambarus@linaro.org>
In-Reply-To: <20240110102102.61587-16-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 16 Jan 2024 12:58:20 -0600
Message-ID: <CAPLW+4nyZH55w16QTE4COGqov09KJGTGQJqO9jHdMOddigN38w@mail.gmail.com>
Subject: Re: [PATCH 15/18] tty: serial: samsung: change return type for s3c24xx_serial_rx_fifocnt()
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	andre.draszik@linaro.org, peter.griffin@linaro.org, kernel-team@android.com, 
	willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 4:25=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
.org> wrote:
>
> Change the return type of the s3c24xx_serial_rx_fifocnt() method to
> ``unsigned int`` as the method only returns the fifo size and does not
> handle error codes.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/tty/serial/samsung_tty.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsun=
g_tty.c
> index 37c0ba2a122c..436739cf9225 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -590,8 +590,8 @@ static inline const struct s3c2410_uartcfg
>         return ourport->cfg;
>  }
>
> -static int s3c24xx_serial_rx_fifocnt(const struct s3c24xx_uart_port *our=
port,
> -                                    u32 ufstat)
> +static unsigned int
> +s3c24xx_serial_rx_fifocnt(const struct s3c24xx_uart_port *ourport, u32 u=
fstat)
>  {
>         const struct s3c24xx_uart_info *info =3D ourport->info;
>
> --
> 2.43.0.472.g3155946c3a-goog
>
>

