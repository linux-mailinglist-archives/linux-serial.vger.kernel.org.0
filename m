Return-Path: <linux-serial+bounces-130-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5517F4964
	for <lists+linux-serial@lfdr.de>; Wed, 22 Nov 2023 15:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A497628165C
	for <lists+linux-serial@lfdr.de>; Wed, 22 Nov 2023 14:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250B14EB24;
	Wed, 22 Nov 2023 14:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HJDGRWx6"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED77819E
	for <linux-serial@vger.kernel.org>; Wed, 22 Nov 2023 06:51:53 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-da7238b3eb4so6776931276.1
        for <linux-serial@vger.kernel.org>; Wed, 22 Nov 2023 06:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700664713; x=1701269513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9DGSyICg2UnFy89hoBrUfL2K8aP2Q1z48SMPJPGtT4=;
        b=HJDGRWx6OVLMEvjYutpG1W0BFytUXG6cCQHZJ+yiTehnNDWp5tknygiXWU2V437aPX
         RstXbKnivA8m7wg1hcn5QDtCwIxBYZUFvFiASNUbWgFlpFuAX7Ky8+ELKBj27eQzq/o+
         mjdwQGCbmg7TnuPzbUiCutMzFmzs95tkvFLNPlSX/NH06a7jn8fpRQTQrMRdHi26DmDZ
         tnBNusR095Qj/jmtL7w2dBmH/h9r2Ly7jB/n9sE80V6njUF7/egT0T01UAqglJ4bID2a
         iH0TXE97NWvPgaUyo+ZF2avm1Ft1qYLjFc1tPuaXlQh/CrfpeeH1MLQcQl7MqcQdAncx
         qYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700664713; x=1701269513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N9DGSyICg2UnFy89hoBrUfL2K8aP2Q1z48SMPJPGtT4=;
        b=G0yyisWmTUGYdPpC2/R9wsyOILrqaScMe5VR455sKpdMBDwQnxppWCzlD7O5ndRJJC
         cP6qKmh3v90YLfwXGuJWSoHT84SXeqBxqE2Pr9O1aBgzIowEyGYjIPbAX6YRr26iK2fs
         DbzNonl5G/YG+twDvkEBZzeMzw6zIdETGn8AETFSJ7diahXmwlXg26sjPh5dKQauZHhF
         Th5alHM6M6Vx6aAZn9cA4lhacNBExcN1zrLxquRNjUvNR3zIorC0tnDEpTMmK2PfI5zH
         RNFAKFbqNGl2vmGDDmbhLSym7Bk9WV6eDIQUVLRf54TfXKtn44fBKwnmJ9qZzi2vjekd
         HHFQ==
X-Gm-Message-State: AOJu0YzFEKnnH389b0FYipOZIvjLnIQdrpphfWNA8MtHPmaG7GRAZWsF
	TuFLc46Jx7HK0aqXp/9Bg5fNpLWsw1TxLxGnPjyWzO5Dk3cjOcCD
X-Google-Smtp-Source: AGHT+IHErISS2aCORuJ1o2xpc892jJljh9u/+IMFcw6qxFkWRmNcuOAbMDuv+QoPeRA+g6GClPHH4TZv1k0CJCSnY00=
X-Received: by 2002:a25:a2cb:0:b0:da0:46fa:cabe with SMTP id
 c11-20020a25a2cb000000b00da046facabemr2303572ybn.7.1700664713109; Wed, 22 Nov
 2023 06:51:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122074535.184384-1-gregory.clement@bootlin.com>
In-Reply-To: <20231122074535.184384-1-gregory.clement@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 22 Nov 2023 15:51:41 +0100
Message-ID: <CACRpkdY6CtReAOr9oiVZ-97YRpyNCN_s1E_-j6zYuZbtmis80A@mail.gmail.com>
Subject: Re: [PATCH] ARM: PL011: Fix DMA support
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: Russell King <linux@armlinux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, 
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 8:47=E2=80=AFAM Gregory CLEMENT
<gregory.clement@bootlin.com> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> Since there is no guarantee that the memory returned by
> dma_alloc_coherent() is associated with a 'struct page', using the
> architecture specific phys_to_page() is wrong, but using
> virt_to_page() would be as well.
>
> Stop using sg lists altogether and just use the *_single() functions
> instead. This also simplifies the code a bit since the scatterlists in
> this driver always have only one entry anyway.
>
> gcl: Add a commit log from the initial thread:

First I thought this was Grant C. Likely, but now I realized it is
Gregory :)

> https://lore.kernel.org/lkml/86db0fe5-930d-4cbb-bd7d-03367da38951@app.fas=
tmail.com/
>
> Fixes: cb06ff102e2d7 ("ARM: PL011: Add support for Rx DMA buffer polling.=
")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Tested-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Fair enough.

>  struct pl011_sgbuf {
> -       struct scatterlist sg;
> -       char *buf;
> +       dma_addr_t              dma;
> +       size_t                  len;
> +       char                    *buf;
>  };

Should this struct really be named "pl011_sgbuf" after this?

It breaks Rusty Russell's API naming rules.

What about renaming it pl011_dmabuf?

> @@ -369,18 +371,11 @@ static int pl011_fifo_to_tty(struct uart_amba_port =
*uap)
>  static int pl011_sgbuf_init(struct dma_chan *chan, struct pl011_sgbuf *s=
g,

And then parameters and variables named "sg" don't make much sense
either, so just db or so for "dma buffer" if you wanna keep it short.

Yours,
Linus Walleij

