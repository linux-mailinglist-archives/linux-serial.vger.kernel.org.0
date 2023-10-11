Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0685E7C496B
	for <lists+linux-serial@lfdr.de>; Wed, 11 Oct 2023 07:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjJKFvb (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 11 Oct 2023 01:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjJKFva (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 11 Oct 2023 01:51:30 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54C1CA
        for <linux-serial@vger.kernel.org>; Tue, 10 Oct 2023 22:51:28 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-279294d94acso503175a91.0
        for <linux-serial@vger.kernel.org>; Tue, 10 Oct 2023 22:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1697003488; x=1697608288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZgOOUrxhrQpKc0UcO6mj9tBnrpY40gn5l4EwRcu1NOI=;
        b=BBi47a0d566uAZLf74tOZs1i4XMtlk8eUoxA0YLHzNJyaMusR9TcGhPGokZjl5ln0U
         IzVnafrv1kV+fiwNyN2a1FSBE2YjZoajroOV/AR7Cyi7kB9q6tT9coTOdOY6J0Lw3uDT
         T8QZ2zmqeHXENIC9goCzxe0mPR72xr20vE2VqXn2R5t9Xl7EEXutZ7zJKkM4LMEoS9AJ
         Hm+09KxzGAxoq5a4gDnw5G3o3zcrKaZNaBnzNQSqnl6WAJyt9anQ4rkXmnXgKTUYWfC4
         tv6llJs5kqPNvZA2m5iaj+LKIA6CiUvDriFzNPV4D9iHLB359OmfAFQNcrSCOf6qm7MO
         mMHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697003488; x=1697608288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZgOOUrxhrQpKc0UcO6mj9tBnrpY40gn5l4EwRcu1NOI=;
        b=LKq02V2z/G2J2F3OtIAqFxm6Pkez7mAfw3eR4PJQysTp/tVWdSJfonZpdoDgSkicZW
         FlW/cXx3iDLgkRI3ij30Vjc3Ojco8qL1Xw3+DGfcKwO59HlYzk8x7cUo2xeaWN9rsLIX
         FrkbHGHNvKcQ+0fGLzWLEyTOr7QBdKgFeKJimU35dqGev2I9A7+A/VxuGGBAaPwON0bz
         UWvkTEc5DXNr4ud50Ll3EFwJaFQ6b/T79gcnn9vlnETVuDUgL3Ss8xFiZX2koFzjDsBn
         QlLUpzvBnJpG+fiRWBow+x3R17s75BTF/ubzR27Z7/sPSKFR1VnvEcEkMfFRx4s6YOqg
         S0sg==
X-Gm-Message-State: AOJu0Yzpk8FYMCeoMpcj36KdLDECVrtFXrlwWHTvCtDGaACbIl9NCPAW
        97ALAr/jhQ/B0wl+Lb5v/L3RoQ7qAXTerePvfXMCEA==
X-Google-Smtp-Source: AGHT+IEAxE7QdFbbOPuVcJD52vAqLrqPEDqxTXMyXoDEBFNSRVwd6lB/XppSiIl4XgAPPxR1exDjPPNx2wJzk6+Jr1M=
X-Received: by 2002:a17:90a:af86:b0:277:4be4:7a84 with SMTP id
 w6-20020a17090aaf8600b002774be47a84mr25295223pjq.19.1697003487902; Tue, 10
 Oct 2023 22:51:27 -0700 (PDT)
MIME-Version: 1.0
References: <20231010170503.657189-1-apatel@ventanamicro.com>
 <20231010170503.657189-6-apatel@ventanamicro.com> <2023101045-hazard-popcorn-7d19@gregkh>
In-Reply-To: <2023101045-hazard-popcorn-7d19@gregkh>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Wed, 11 Oct 2023 11:21:17 +0530
Message-ID: <CAK9=C2WvfPg1tCpNLgDteaQGBVAsPL3S+vdvgEsBb8PCx2W8xw@mail.gmail.com>
Subject: Re: [PATCH 5/6] tty: Add SBI debug console support to HVC SBI driver
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Atish Patra <atishp@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Oct 10, 2023 at 10:42=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Oct 10, 2023 at 10:35:02PM +0530, Anup Patel wrote:
> > --- a/drivers/tty/hvc/hvc_riscv_sbi.c
> > +++ b/drivers/tty/hvc/hvc_riscv_sbi.c
> > @@ -15,6 +15,7 @@
> >
> >  #include "hvc_console.h"
> >
> > +#ifdef CONFIG_RISCV_SBI_V01
>
> Please no #ifdef in a .c file, that's not a good style for Linux code at
> all.
>
> And what if you want to build the driver for both options here?  What
> will happen?

Okay, I will remove all #ifdef from .c file

>
> > +static int hvc_sbi_dbcn_tty_put(uint32_t vtermno, const char *buf, int=
 count)
> >  {
> > -     return PTR_ERR_OR_ZERO(hvc_alloc(0, 0, &hvc_sbi_ops, 16));
> > +     phys_addr_t pa;
> > +     struct sbiret ret;
> > +
> > +     if (is_vmalloc_addr(buf))
> > +             pa =3D page_to_phys(vmalloc_to_page(buf)) + offset_in_pag=
e(buf);
> > +     else
> > +             pa =3D __pa(buf);
> > +
> > +     ret =3D sbi_ecall(SBI_EXT_DBCN, SBI_EXT_DBCN_CONSOLE_WRITE,
> > +#ifdef CONFIG_32BIT
> > +               count, pa, (u64)pa >> 32,
> > +#else
> > +               count, pa, 0,
> > +#endif
>
> This is not how to do an api, sorry, again, please no #ifdef if you want
> to support this code for the next 20+ years.

Sure, I will update like you suggested.

>
> thanks,
>
> gre gk-h

Thanks,
Anup
