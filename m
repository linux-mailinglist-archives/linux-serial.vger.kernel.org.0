Return-Path: <linux-serial+bounces-3-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D3E7F215D
	for <lists+linux-serial@lfdr.de>; Tue, 21 Nov 2023 00:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2472D1C216CB
	for <lists+linux-serial@lfdr.de>; Mon, 20 Nov 2023 23:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32B23B291;
	Mon, 20 Nov 2023 23:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WHuVffSB"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436F9C8
	for <linux-serial@vger.kernel.org>; Mon, 20 Nov 2023 15:21:00 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-679e7d2d7c4so3623016d6.0
        for <linux-serial@vger.kernel.org>; Mon, 20 Nov 2023 15:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700522459; x=1701127259; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PDE9uf6TJS4VJZQo8P1PD8XGmY54klHhH1bboj6uhLs=;
        b=WHuVffSBHeJ+9OC6SiWLJCIdrpbjD/m0AhU8aWgRvXtx4ADN3eJHb8i3WNNt8XKY6Y
         9JLkRmSeC1RnkH+n11hTHFVyMvjqbX5MaHlDuXGLtlCJmBfaulFXdpidIEqCeMphvvPf
         tO1yRh2SKYdVSWXLWs2QlUrfK9iSIY1LhyzqwA81WV5IOqMBr9Fljzn2dRiJE2UmBxel
         i4iK5s1YAq1apt0AuHCiYZeeWquMp6yjZGTCBsIKwJnic31dm1cg6Fo46vSJ83KGYK4G
         lKRJfKot8iHri9KSET/LMzBJkBTpgzsKl06I+i5dikFo3vCOuLgwtmvEQxEeb3Fa6FGM
         y7Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700522459; x=1701127259;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PDE9uf6TJS4VJZQo8P1PD8XGmY54klHhH1bboj6uhLs=;
        b=J6WX1zSs3NVwUfUTxl4M32IJe5coTfoTzalXyUfelvGf1+vjSNo2E+kXfSeP2v140x
         J+GjctHKr+tXVvLFSI89n2Lk7aOF8DqZuYr4V0Sf/OeIE9+11sf3/TqCUX8YfTeztQgQ
         pV4UdIDWKCg0ztDrWHoMz3GHPBu9FZ6QF9fzJQnHGaTp5XnkKVWF/6681RywNSTND5R9
         i5ptzrrVKDZmzCezZioA+qXoA3+uVMSM+TM3jE81afLBOboWZUsfiRFUi8TV2glrWpcM
         BcPCrLi9PingnpxNO7YFuMJlKHM2nHcWpXzXzeDHrInkRT99jbFM7lBMaiZy3QY/BgN6
         kxsg==
X-Gm-Message-State: AOJu0Yz6V6MtAUQj//PjbRLAuJwRRXObJGPM3B0fE6JyjqF5c3FFVsEe
	xT6ymCXCo6n1NqcdnQCls7iEcM43t1kb/Bh6gp7t1A==
X-Google-Smtp-Source: AGHT+IEIf36/atlYRS4ex1+NljmP+H67rXnsoYzqUWj5sBQBBvshmK0zVcWGVs0uO2q0X3HTu/piwsUGx1LRUA/4v8k=
X-Received: by 2002:a05:6214:27eb:b0:66f:ba8f:39a9 with SMTP id
 jt11-20020a05621427eb00b0066fba8f39a9mr12512023qvb.8.1700522459312; Mon, 20
 Nov 2023 15:20:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231120212037.911774-1-peter.griffin@linaro.org>
 <20231120212037.911774-16-peter.griffin@linaro.org> <5ee955e4-4c22-4696-8001-1e4f24952eeb@roeck-us.net>
 <CADrjBPoHYTZiMCFKBtdaT6hFp9QO=GMzn5yE2k3Dg_mcBhrvkA@mail.gmail.com> <0c37e32f-079c-4b91-a9db-1c1c2df299b1@roeck-us.net>
In-Reply-To: <0c37e32f-079c-4b91-a9db-1c1c2df299b1@roeck-us.net>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Mon, 20 Nov 2023 23:20:47 +0000
Message-ID: <CADrjBPog+7p3Njx4E_gU1uZRrOULNXVV2fbcL5pxce2tM3=Q=g@mail.gmail.com>
Subject: Re: [PATCH v4 15/19] watchdog: s3c2410_wdt: Add support for WTCON
 register DBGACK_MASK bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	mturquette@baylibre.com, conor+dt@kernel.org, sboyd@kernel.org, 
	tomasz.figa@gmail.com, s.nawrocki@samsung.com, linus.walleij@linaro.org, 
	wim@linux-watchdog.org, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, olof@lixom.net, gregkh@linuxfoundation.org, 
	jirislaby@kernel.org, cw00.choi@samsung.com, alim.akhtar@samsung.com, 
	tudor.ambarus@linaro.org, andre.draszik@linaro.org, 
	semen.protsenko@linaro.org, saravanak@google.com, willmcvicker@google.com, 
	soc@kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, kernel-team@android.com, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Guenter,

On Mon, 20 Nov 2023 at 23:03, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 11/20/23 14:45, Peter Griffin wrote:
> > Hi Guenter,
> >
> > Thanks for the review.
> >
> > On Mon, 20 Nov 2023 at 22:00, Guenter Roeck <linux@roeck-us.net> wrote:
> >>
> >> On 11/20/23 13:20, Peter Griffin wrote:
> >>> The WDT uses the CPU core signal DBGACK to determine whether the SoC
> >>> is running in debug mode or not. If the DBGACK signal is asserted and
> >>> DBGACK_MASK is enabled, then WDT output and interrupt is masked.
> >>>
> >>> Presence of the DBGACK_MASK bit is determined by adding a new
> >>> QUIRK_HAS_DBGACK_BIT quirk. Currently only gs101 SoC is known to have
> >>> the DBGACK_MASK bit so add the quirk to drv_data_gs101_cl1 and
> >>> drv_data_gs101_cl1 quirks.
> >>>
> >>> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> >>> ---
> >>>    drivers/watchdog/s3c2410_wdt.c | 32 +++++++++++++++++++++++++++-----
> >>>    1 file changed, 27 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
> >>> index 08b8c57dd812..ed561deeeed9 100644
> >>> --- a/drivers/watchdog/s3c2410_wdt.c
> >>> +++ b/drivers/watchdog/s3c2410_wdt.c
> >>> @@ -34,9 +34,10 @@
> >>>
> >>>    #define S3C2410_WTCNT_MAXCNT        0xffff
> >>>
> >>> -#define S3C2410_WTCON_RSTEN  (1 << 0)
> >>> -#define S3C2410_WTCON_INTEN  (1 << 2)
> >>> -#define S3C2410_WTCON_ENABLE (1 << 5)
> >>> +#define S3C2410_WTCON_RSTEN          (1 << 0)
> >>> +#define S3C2410_WTCON_INTEN          (1 << 2)
> >>> +#define S3C2410_WTCON_ENABLE         (1 << 5)
> >>> +#define S3C2410_WTCON_DBGACK_MASK    (1 << 16)
> >>>
> >>>    #define S3C2410_WTCON_DIV16 (0 << 3)
> >>>    #define S3C2410_WTCON_DIV32 (1 << 3)
> >>> @@ -107,12 +108,16 @@
> >>>     * %QUIRK_HAS_PMU_CNT_EN: PMU block has some register (e.g. CLUSTERx_NONCPU_OUT)
> >>>     * with "watchdog counter enable" bit. That bit should be set to make watchdog
> >>>     * counter running.
> >>> + *
> >>> + * %QUIRK_HAS_DBGACK_BIT: WTCON register has DBGACK_MASK bit. Enables masking
> >>> + * WDT interrupt and reset request according to CPU core DBGACK signal.
> >>
> >> This is a bit difficult to understand. I _think_ it means that the DBGACK_MASK bit
> >> has to be set to be able to trigger interrupt and reset requests.
> >
> > Not quite, it is a bit that controls masking the watchdog outputs when the SoC
> > is in debug mode.
> >
> >> "masking" normally refers to disabling something (at least in interrupt context).
> >> "Enables masking WDT interrupt" sounds like the bit has to be set in order to
> >> be able to disable interupts, and the code below suggests that the bit has to be
> >> set for the driver to work. Is that the case ? It might make sense to explain this
> >> a bit further.
> >
> > Maybe I explained it more clearly in the commit message than the comment
> >
> > "The WDT uses the CPU core signal DBGACK to determine whether the SoC
> > is running in debug mode or not. If the DBGACK signal is asserted and
> > DBGACK_MASK is enabled, then WDT output and interrupt is masked."
> >
> > Is that any clearer? Or maybe simpler again
> >
> > "Enabling DBGACK_MASK bit masks the watchdog outputs when the SoC is
> > in debug mode. Debug mode is determined by the DBGACK CPU signal."
> >
> > Let me know what you think is the clearest and most succinct and I can
> > update the comment.
> >
>
> You are still using the term "masked" which I think just hides what
> the code is really doing. Why not just say "disable" ?

The reason for using the "masked" terminology was that is what the
Watchdog IP TRM uses throughout to describe the feature. But I agree
just saying disable is clearer.

>
> "Setting the DBGACK_MASK bit disables the watchdog outputs when the SoC is
>   in debug mode. Debug mode is determined by the DBGACK CPU signal."
>
> That seems to be much clearer to me, though I think there should still
> be a comment along the line of "disable watchdog output if CPU is in
> debug mode" in the code.

I will update the quirk comment with the less ambiguous wording and
also add an extra comment like you suggest.

>
> That doesn't really explain _why_ the watchdog is disabled in this mode,
> but at least it makes it obvious what is happening.
>
> >>
> >>>     */
> >>>    #define QUIRK_HAS_WTCLRINT_REG                      (1 << 0)
> >>>    #define QUIRK_HAS_PMU_MASK_RESET            (1 << 1)
> >>>    #define QUIRK_HAS_PMU_RST_STAT                      (1 << 2)
> >>>    #define QUIRK_HAS_PMU_AUTO_DISABLE          (1 << 3)
> >>>    #define QUIRK_HAS_PMU_CNT_EN                        (1 << 4)
> >>> +#define QUIRK_HAS_DBGACK_BIT                 (1 << 5)
> >>>
> >>>    /* These quirks require that we have a PMU register map */
> >>>    #define QUIRKS_HAVE_PMUREG \
> >>> @@ -279,7 +284,7 @@ static const struct s3c2410_wdt_variant drv_data_gs101_cl0 = {
> >>>        .cnt_en_reg = GS_CLUSTER0_NONCPU_OUT,
> >>>        .cnt_en_bit = 8,
> >>>        .quirks = QUIRK_HAS_PMU_RST_STAT | QUIRK_HAS_PMU_MASK_RESET | QUIRK_HAS_PMU_CNT_EN |
> >>> -               QUIRK_HAS_WTCLRINT_REG,
> >>> +               QUIRK_HAS_WTCLRINT_REG | QUIRK_HAS_DBGACK_BIT,
> >>>    };
> >>>
> >>>    static const struct s3c2410_wdt_variant drv_data_gs101_cl1 = {
> >>> @@ -291,7 +296,7 @@ static const struct s3c2410_wdt_variant drv_data_gs101_cl1 = {
> >>>        .cnt_en_reg = GS_CLUSTER1_NONCPU_OUT,
> >>>        .cnt_en_bit = 7,
> >>>        .quirks = QUIRK_HAS_PMU_RST_STAT | QUIRK_HAS_PMU_MASK_RESET | QUIRK_HAS_PMU_CNT_EN |
> >>> -               QUIRK_HAS_WTCLRINT_REG,
> >>> +               QUIRK_HAS_WTCLRINT_REG | QUIRK_HAS_DBGACK_BIT,
> >>>    };
> >>>
> >>>    static const struct of_device_id s3c2410_wdt_match[] = {
> >>> @@ -408,6 +413,21 @@ static int s3c2410wdt_enable(struct s3c2410_wdt *wdt, bool en)
> >>>        return 0;
> >>>    }
> >>>
> >>> +static void s3c2410wdt_mask_dbgack(struct s3c2410_wdt *wdt, bool mask)
> >>
> >> I think I must be missing something. This is only ever called with mask==true,
> >> meaning the bit, if present, is always set.
> >>
> >> Why not call the function s3c2410wdt_set_dbgack() and drop the unnecessary
> >> parameter ?
> >
> > I can update like you suggest, it would simplify the logic a little bit.
> >
>
> Please do.

Will do

Thanks,

Peter

