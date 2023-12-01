Return-Path: <linux-serial+bounces-382-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 885638010B0
	for <lists+linux-serial@lfdr.de>; Fri,  1 Dec 2023 18:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B9FE281ACB
	for <lists+linux-serial@lfdr.de>; Fri,  1 Dec 2023 17:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD1C4D12C;
	Fri,  1 Dec 2023 17:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2D7pzVc"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79F5133;
	Fri,  1 Dec 2023 09:03:09 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-67a9be1407aso3180156d6.0;
        Fri, 01 Dec 2023 09:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701450189; x=1702054989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c3Y5WlluNSG52Oh+RdmatqU/FPHpilvW0wo2a8wMtzM=;
        b=m2D7pzVcoi24CicR2Lxu4tdcTFdL5+xS/neCTf8HxqbnvHwAcdEC9enE73iP0wn1ji
         wsP/14ZxYoUmNtoFf59Q7CfhlhmBvYmLIX95X1OInym4dFzszozSGjEEWipDY5n1QwQE
         5oK+b3t3xyC6RYaK5saQNJqjmaGY0EbdCvGNK38Pys9W9uOPFdQXTYDEmrSWdU1hN7IY
         IKd7e02vVMihfrBBfhsIHuhtaYAKDlfpzfKYbd0zMdUbXI4AP5CmAat7l8r1iO8u9OrV
         KoB4Fe+61GJrot+i3MQGYy5HjfZumgAvlNeHoM+COORByt7KQs7yayP7BdkQ3YRgtgiD
         s38w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701450189; x=1702054989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c3Y5WlluNSG52Oh+RdmatqU/FPHpilvW0wo2a8wMtzM=;
        b=ogBfUJjRf2tYZENyqZM6TqNgFt3MA3vZ13PJ4JlQ4JoDcYOPw7zplIXMd5W+YdYNVt
         VVdSX9JLG7CTTr+MhX+EM+VxbnEOBft5zBkPDo9OJnOrwwCNzySZgrgD4MtbFGiNBudx
         kGnCHLwb/XYv68eUkKUrEjPYTec76mqKOvHy4OtMM9oTj311tPgg20ZPNnXJdEDMBwWS
         a6hVAcLl4Y5LpsBzt02qEFOb6zA70DeZK3dT3uOQXrzWgbFRqn0ZCq8eXHGpYlcpyd1M
         jWrvxRvdTi9vAm8XJnPgjaJvzdMPQGXdgwLb/mgwvG1TpHWXK3uuKfqgWjkj24hYWMSI
         SqzA==
X-Gm-Message-State: AOJu0YzxTTdCLibjfVtzPLj1lq36lJ50E2SVgI8r7vbAmwrRYYL6XB1l
	hYjnmyN9f/GC2WxTMkZXrfpvePJShE7+Xee7BNR/XwCB9Sfs4A==
X-Google-Smtp-Source: AGHT+IHkW94Rn0OtDnloPqiS5e/fIK1HP8bF4z4jorVnA1687IcHdprRTtd2wRxkyZd1fh+ZAKtEAnx09pPNZ6JeQZA=
X-Received: by 2002:a0c:ed52:0:b0:67a:1e8d:6f89 with SMTP id
 v18-20020a0ced52000000b0067a1e8d6f89mr26121941qvq.44.1701450188706; Fri, 01
 Dec 2023 09:03:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bd91db46c50615bc1d1d62beb659fa7f62386446.1701446070.git.jan.kundrat@cesnet.cz>
 <f66cf0a3-4d63-4548-8648-e93a1ef995e2@sirena.org.uk>
In-Reply-To: <f66cf0a3-4d63-4548-8648-e93a1ef995e2@sirena.org.uk>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 1 Dec 2023 19:02:32 +0200
Message-ID: <CAHp75Vc4tB_CuT-e+gofanWK=mss-k_A-mqPo-8+Rv-aQ8tu_w@mail.gmail.com>
Subject: Re: [PATCH] tty: max310x: work around regmap->regcache data corruption
To: Mark Brown <broonie@kernel.org>
Cc: =?UTF-8?B?SmFuIEt1bmRyw6F0?= <jan.kundrat@cesnet.cz>, 
	Cosmin Tanislav <cosmin.tanislav@analog.com>, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 1, 2023 at 6:21=E2=80=AFPM Mark Brown <broonie@kernel.org> wrot=
e:
> On Fri, Dec 01, 2023 at 03:51:51PM +0100, Jan Kundr=C3=A1t wrote:
>
> > The TL;DR summary is that the regmap_noinc_write spills over the data
> > that are correctly written to the HW also to the following registers in
> > the regcache. As a result, regcache then contains user-controlled
> > garbage which will be used later for bit updates on unrelated registers=
.
>
> > I was investigating a regression that happened somewhere between 5.12.4
> > (plus 14 of our patches) and v6.5.9 (plus 7 of our patches). Our
>
> Can you reproduce this with current kernels?  That's not even an up to
> date v6.5 - we're up to v6.5.13 now from the looks of things including
> one upstream fix that looks potentially relevant.

Indeed, the 984a4afdc87a ("regmap: prevent noinc writes from
clobbering cache") seems quite relevant.

--=20
With Best Regards,
Andy Shevchenko

