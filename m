Return-Path: <linux-serial+bounces-5971-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE10D96F7CD
	for <lists+linux-serial@lfdr.de>; Fri,  6 Sep 2024 17:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 656E5283B7F
	for <lists+linux-serial@lfdr.de>; Fri,  6 Sep 2024 15:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0E71D1F69;
	Fri,  6 Sep 2024 15:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kruces-com.20230601.gappssmtp.com header.i=@kruces-com.20230601.gappssmtp.com header.b="pT9LGt6H"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8D01D1F56
	for <linux-serial@vger.kernel.org>; Fri,  6 Sep 2024 15:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725635213; cv=none; b=q2Cydx+6ZnQ2bVM534Td5shJqdocecAIq02KUsdzHuthcVXpoKooSeKrsLj+ZOtqqsA2rdnHE/djNh+aiAtP5zGnMGUIOwjcRAgAIAp2s3b+XRuNcY0CLcURFQHxHrJetwQozMAKl1FBbcutuntMAhJ2BfL67W4ClqOl1P072Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725635213; c=relaxed/simple;
	bh=aQLKfK6IyeVlvPZdEpJhpjuD9yzE9AaUJBwaw3oLa4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lehgj0tUbgRuDYC6D3IPhZu/vRA3DNjoWiNv5py+7Zv+VmSAvp0rAyMWTfiaT0LSFpWCEBwFs9KON6XRUh4Cji1ZBwxYY5qS37Vu8xb5zWCbcBe224Dg954qROYzRdy3pR7DlZ+n1IeOoy+OhM8d1qIF0XnkCMdeM6H/Hfq3FMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kruces.com; spf=pass smtp.mailfrom=kruces.com; dkim=pass (2048-bit key) header.d=kruces-com.20230601.gappssmtp.com header.i=@kruces-com.20230601.gappssmtp.com header.b=pT9LGt6H; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kruces.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kruces.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8ce5db8668so57311666b.1
        for <linux-serial@vger.kernel.org>; Fri, 06 Sep 2024 08:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kruces-com.20230601.gappssmtp.com; s=20230601; t=1725635209; x=1726240009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9ZAlMwEyYD75XfvfcvFROEESwWLuQ5Z/p2zffJIs9s=;
        b=pT9LGt6HoMXbBN6Jb11wMUrNNRszdLRxKwZK2np3gYd6xtdWx554OI2X6ryv7x9sj9
         egV7RxfVPXlVEjVEwOV6azELU6NUOQaQNtn2aVi+XPx+YdBiWBYOg9Lkhjh6JrumSZEW
         k/zixBuf4n/9A48lPNSgALlpPuXeiQnbBj/byCznMYchDb89+DpEC+nE4hdiZ/kKn6tu
         5fKVm8pN72HP+YyC1eAEk9GUuNaEAB+h1qBYMAmyu5CymxP/sTv8BRWh2XO2OZgODq+U
         EHJ+4rGLO2kBF6JQEOWkfsuIk4st0Uq6uoyK++ASAT6H6TDKRIVkKm+uBy9kvt2vPtZ/
         78nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725635209; x=1726240009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h9ZAlMwEyYD75XfvfcvFROEESwWLuQ5Z/p2zffJIs9s=;
        b=s6vaaXMvZA2d8BbEZBTxKfKbjsixEkYWTolmaiLabhNs/79yExRYYy6Sm3gt0G3SPu
         2O9sTQIDCyrhWh7aUvoYmHH1rP6BpSet0DQECzEJvi+MdEJT/GLZj9bY1+zgFIVzY8D/
         ea82ufks93q8/f/t6TVW/uwTxw683vxipBIXCaoUqtbF8Exf/0RWbe9b6+90+rw/z/cu
         3nCXPgSHWZNo79RZeimP7l60UaAf9dK67PfK6lb32RH8Yh/D8EzGjt7ZfX7RvfNZrDHK
         tau7T3a1G90GIBDxRQTJ14ljzDJFDCH8146CPlpXIC/IhysvU3pihF836TOGCYTjiX+g
         lZhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWO2v6SO/5x/thBRrYf8FpDjP+8U2kQznOMVC1j80t+eGDQcO9V6uPXVu7mF/jAbV9zgxTT5DZBxAhAUjk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1pRTAnC8UWfuUqtHYYQkScrMjvPjlQO1VwpofPpVh0POffiFe
	/6lJCHz++6ViM41W8wm6H6v5c6kegxTIMZtmVhABPxy/Tz5J3IiGXTWjwMpGhvsA49I0v2pDJWH
	tGm3ivKb06ph/T1QFYEPJPthHU8cFPro/yLbb4A==
X-Google-Smtp-Source: AGHT+IE5oYDSfTzIe6hHUgUBH7wdkZoXXSF0xeHeSRG+IYdoi10a74SFm4+xUjHqeOxdrh5qK7III9nawL/szJxa908=
X-Received: by 2002:a17:906:c141:b0:a8b:ddf4:46f1 with SMTP id
 a640c23a62f3a-a8bddf45606mr100660666b.63.1725635208952; Fri, 06 Sep 2024
 08:06:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906-macos-build-support-v2-0-06beff418848@samsung.com>
 <20240906-macos-build-support-v2-7-06beff418848@samsung.com> <CAHC9VhQkstJ8Ox-T+FLU34s9U0gezRba6bMA-tUPs80u6sVh2g@mail.gmail.com>
In-Reply-To: <CAHC9VhQkstJ8Ox-T+FLU34s9U0gezRba6bMA-tUPs80u6sVh2g@mail.gmail.com>
From: "Daniel Gomez (Samsung)" <d+samsung@kruces.com>
Date: Fri, 6 Sep 2024 17:06:22 +0200
Message-ID: <CABj0suCtCfd58+i0s5LzsTUwwd=1o1nMRvmqsxsraJcTiX2mSQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] selinux: move genheaders to security/selinux/
To: Paul Moore <paul@paul-moore.com>
Cc: da.gomez@samsung.com, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Lucas De Marchi <lucas.demarchi@intel.com>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	William Hubbs <w.d.hubbs@gmail.com>, Chris Brannon <chris@the-brannons.com>, 
	Kirk Reiser <kirk@reisers.ca>, Samuel Thibault <samuel.thibault@ens-lyon.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Simona Vetter <simona.vetter@ffwll.ch>, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	speakup@linux-speakup.org, selinux@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-serial@vger.kernel.org, llvm@lists.linux.dev, 
	Finn Behrens <me@kloenk.dev>, gost.dev@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 4:54=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Fri, Sep 6, 2024 at 7:01=E2=80=AFAM Daniel Gomez via B4 Relay
> <devnull+da.gomez.samsung.com@kernel.org> wrote:
> >
> > From: Masahiro Yamada <masahiroy@kernel.org>
> >
> > This tool is only used in security/selinux/Makefile.
> >
> > There is no reason to keep it under scripts/.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >  scripts/remove-stale-files                                    | 3 +++
> >  scripts/selinux/Makefile                                      | 2 +-
> >  scripts/selinux/genheaders/.gitignore                         | 2 --
> >  scripts/selinux/genheaders/Makefile                           | 3 ---
> >  security/selinux/.gitignore                                   | 1 +
> >  security/selinux/Makefile                                     | 7 ++++=
+--
> >  {scripts/selinux/genheaders =3D> security/selinux}/genheaders.c | 0
> >  7 files changed, 10 insertions(+), 8 deletions(-)
>
> Did you read my comments on your previous posting of this patch?  Here
> is a lore link in case you missed it or it was swallowed by your
> inbox:
>
> https://lore.kernel.org/selinux/3447459d08dd7ebb58972129cddf1c44@paul-moo=
re.com

Apologies for the unnecessary noise. I=E2=80=99ll review your feedback and
revisit the patch accordingly.

Daniel

>
> Unless there is an serious need for this relocation, and I don't see
> one explicitly documented either in this patchset or the previous, I
> don't want to see this patch go upstream.
>
> --
> paul-moore.com

