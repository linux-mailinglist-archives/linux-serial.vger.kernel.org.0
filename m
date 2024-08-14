Return-Path: <linux-serial+bounces-5500-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2FA951A81
	for <lists+linux-serial@lfdr.de>; Wed, 14 Aug 2024 14:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E990FB2298A
	for <lists+linux-serial@lfdr.de>; Wed, 14 Aug 2024 12:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815DE1AC442;
	Wed, 14 Aug 2024 12:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zINyAg13"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A36143C7B
	for <linux-serial@vger.kernel.org>; Wed, 14 Aug 2024 12:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723636904; cv=none; b=p9Mtl1+3aloUtFu2A90k4aNTDV0nR7B+zdh6i77wXRp6fDmAohpuHRiD2QgNc2KgHuN4ae8HfKyS5dzV1SWf1kxYOToeBZ9Y68h8BIfe8vGzQrfnH+himx6aDr7efiSIvV0k8gZRE44xH+kNRB56nG0EQ3wOchZ1xoXIWX9iIS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723636904; c=relaxed/simple;
	bh=8v3FACRVLInU72mQIn8ZRnsPtKqtsflxvY7ocPKv6dM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D5VxVxKXrAGtwnWb7L1SeGbC6iu4Bf/ZVMa7q9Zg+1/k0yz1VJLaji4H3K4pcXLNxmFxYIL1QYydfmyr1ioRoetrGl2c4dOY+VpDYQRzmdw1LgowkY+WFeIWFzBEyuUkA11kF5uWwKaslTMKIGF3gw9MJH3S3QDXcnDeJzcY4C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zINyAg13; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-260209df55dso3662146fac.2
        for <linux-serial@vger.kernel.org>; Wed, 14 Aug 2024 05:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723636902; x=1724241702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8v3FACRVLInU72mQIn8ZRnsPtKqtsflxvY7ocPKv6dM=;
        b=zINyAg13YdK7MglUCLhzDYqw9OjPfxnYEo+sN3/xRW5WBzt0MJvh0NSqKlHAizH0nM
         WI5o1zlCUFV0IGxOv9cxz4x2Tlu/dmgNNS9Er5qqnm0UljoTH+5V0NTcj+aXQ1DoMqa4
         DrIpCiVt9kfnpoN/UO4hGF+OaAtcFMhs1gMT9S33BVlKjg9dPu8glO73JSrS9Ox04X+Z
         voVeb0xzHBiD4J0Kk6SPxukogAPXUx9gPy6wkX8GKw9N4abs1gDC02fTZlbfff76MmtG
         P39MbfY3Pf24KtbDWwPpJ3GOHWi68wlcFWRyFTXuzjw1oZ8IYb5MavpIBn2fyInKZHhw
         5H9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723636902; x=1724241702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8v3FACRVLInU72mQIn8ZRnsPtKqtsflxvY7ocPKv6dM=;
        b=KdHe9TlI7KKI6VTle/NPKkbNOqgm33Jf1PdP3xc8aRMpIQTDRpT7bMGTxfsAfW9k7J
         YwLU8Z1SP/hpw5TyCKJfCEO/HT6E7KMYkenj+q200p/4L/hprQaQmSRN8rpna2FWUvqL
         76a020VpA3kRraZWV/RWeAeLJw48ghhDzZenG9VKaImdpA2lcrmzIStkpzogjTrBFvuc
         ecMPdsn0E/VJioIF51XnPw/dY7X7hLeq8gLVbAeQK+R/DGlpFPTHKmfcgvzuVRb/yJ1P
         XUUIYSP4QqhGpvWK2nAYjHi6uDelwIExB9RtSKc4GRGhCsxtuNT1a2aXLlIu8eBVOX2D
         Un0Q==
X-Forwarded-Encrypted: i=1; AJvYcCU9osb5KGFFKivrm7LTOvTAXmhCNKMSMVUyY4qKCbY41BBxZM1IkJQKRPrgXAk0jGpQ4GhCNKqRKchTUmTYnOKGrEJDFOG04DM4E4le
X-Gm-Message-State: AOJu0Yw9YoJf834CbU/vKaGQhDEVqBqtha6YX5tMZ0iW21/eiH4tFy02
	hpo2Q4XhDB5snS1Nt/XlJeh29Q1VR9WoqqjHv1GL/MhJ8HZs8sqyhSLmmswFkqjtdbuTctYtnoR
	gQBqHpnYS6asA9hzH4hMBAPDBIz1QMKM5OcCr+A==
X-Google-Smtp-Source: AGHT+IEXSwpG1/ytUAZ81Sed/BezfzFf7vKHrDMjRAM0bw/+RsQs5+LfgEea53duY74tvzqpXFM+Zl+QBtuu66uJRnY=
X-Received: by 2002:a05:6871:e014:b0:268:79bd:9edb with SMTP id
 586e51a60fabf-26fe5c707b0mr2896389fac.47.1723636901739; Wed, 14 Aug 2024
 05:01:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240728114200.75559-1-wahrenst@gmx.net> <20240728130029.78279-1-wahrenst@gmx.net>
 <20240728130029.78279-6-wahrenst@gmx.net> <65de7db8-4f81-4c31-be8d-3a03c9aee989@gmx.net>
 <CAD=FV=W7sdi1+SHfhY6RrjK32r8iAGe4w+O_u5Sp982vgBU6EQ@mail.gmail.com>
In-Reply-To: <CAD=FV=W7sdi1+SHfhY6RrjK32r8iAGe4w+O_u5Sp982vgBU6EQ@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 14 Aug 2024 14:01:05 +0200
Message-ID: <CAPDyKFpj0C1Bifmx=4zH3r8YooOrNfn_iDB+1sfRb0gTaKnT2Q@mail.gmail.com>
Subject: Re: [PATCH V2 14/16] WIP: usb: dwc2: Implement recovery after PM
 domain off
To: Stefan Wahren <wahrenst@gmx.net>, Doug Anderson <dianders@chromium.org>
Cc: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Minas Harutyunyan <hminas@synopsys.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Lukas Wunner <lukas@wunner.de>, 
	Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Artur Petrosyan <Arthur.Petrosyan@synopsys.com>, Peter Robinson <pbrobinson@gmail.com>, 
	dri-devel@lists.freedesktop.org, bcm-kernel-feedback-list@broadcom.com, 
	linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kernel-list@raspberrypi.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Maxime Ripard <mripard@kernel.org>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Jiri Slaby <jirislaby@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Aug 2024 at 21:57, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Mon, Aug 12, 2024 at 4:48=E2=80=AFPM Stefan Wahren <wahrenst@gmx.net> =
wrote:
> >
> > Hi Doug,
> >
> > Am 28.07.24 um 15:00 schrieb Stefan Wahren:
> > > DO NOT MERGE
> > >
> > > According to the dt-bindings there are some platforms, which have a
> > > dedicated USB power domain for DWC2 IP core supply. If the power doma=
in
> > > is switched off during system suspend then all USB register will lose
> > > their settings.
> > >
> > > So use the power on/off notifier in order to save & restore the USB
> > > registers during system suspend.
> > sorry for bothering you with this DWC2 stuff, but it would great if you
> > can gave some feedback about this patch.
>
> Boy, it's been _ages_ since I looked at anything to do with dwc2, but
> I still have some fondness in my heart for the crufty old driver :-P I
> know I was involved with some of the patches to get
> wakeup-from-suspend working on dwc2 host controllers in the past but,
> if I remember correctly, I mostly shepherded / fixed patches from
> Rockchip. Not sure I can spend the days trawling through the driver
> and testing things with printk that really answering properly would
> need, but let's see...
>
>
> > I was working a lot to get
> > suspend to idle working on Raspberry Pi. And this patch is the most
> > complex part of the series.
> >
> > Would you agree with this approach or did i miss something?
> >
> > The problem is that the power domain driver acts independent from dwc2,
> > so we cannot prevent the USB domain power down except declaring a USB
> > device as wakeup source. So i decided to use the notifier approach. Thi=
s
> > has been successful tested on some older Raspberry Pi boards.
>
> My genpd knowledge is probably not as good as it should be. Don't tell
> anyone (aside from all the people and lists CCed here). ;-)
>
> ...so I guess you're relying on the fact that
> dev_pm_genpd_add_notifier() will return an error if a power-domain
> wasn't specified for dwc2 in the device tree, then you ignore that
> error and your callback will never happen. You assume that the power
> domain isn't specified then the dwc2 registers will be saved?
>
> I guess one thing is that I'd wonder if that's really reliable. Maybe
> some dwc2 controllers lose their registers over system suspend but
> _don't_ specify a power domain? Maybe the USB controller just gets its
> power yanked as part of system suspend. Maybe that's why the functions
> for saving / restoring registers are already there? It looks like
> there are ways for various platforms to specify that registers are
> lost in some cases...
>
> ...but I guess you can't use the existing ways to say that registers
> are lost because you're trying to be dynamic. You're saying that your
> registers get saved _unless_ the power domain gets turned off, right?
> ...and the device core keeps power domains on for suspended devices if
> they are wakeup sources, which makes sense.
>
> So with that, your patch sounds like a plausible way to do it. I guess
> one other way to do it would be some sort of "canary" approach. You
> could _always_ save registers and then, at resume time, you could
> detect if some "canary" register had reset to its power-on default. If
> you see this then you can assume power was lost and re-init all the
> registers. This could be pretty much any register that you know won't
> be its power on default. In some ways a "canary" approach is uglier
> but it also might be more reliable across more configurations?
>
> I guess those would be my main thoughts on the topic. Is that roughly
> the feedback you were looking for?

Thanks Doug for sharing your thoughts. For the record, I agree with
these suggestions.

Using the genpd on/off notifiers is certainly fine, but doing a
save/restore unconditionally via some of the PM callbacks is usually
preferred - if it works.

Kind regards
Uffe

