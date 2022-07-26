Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C92580DED
	for <lists+linux-serial@lfdr.de>; Tue, 26 Jul 2022 09:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238287AbiGZHh7 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 26 Jul 2022 03:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238381AbiGZHh3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 26 Jul 2022 03:37:29 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF1E2C671
        for <linux-serial@vger.kernel.org>; Tue, 26 Jul 2022 00:36:31 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id b34so10392844ljr.7
        for <linux-serial@vger.kernel.org>; Tue, 26 Jul 2022 00:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=iY86TMAyxnock7CH+i0X2ua2PeNscW1BrukEJJiKzEY=;
        b=E1Ry751h9k4nLC3dfGpcf5L8B438cxZNGZPgpRTfvEn91bjpADcWJ7MwncGegtqqPq
         VhlOIBJD07TsR8tJXXlhYx2ED8cNzirwgPPI3miEahyYfUgchmXK3uvfNkAhp2kJsHyM
         yuzw4S+p0spARmPF+Tqw5JdLQEMby8ok3LXyT+0GMSbgsjuvFJNufehw2tlThJWlDVkk
         UcIcG10pEZwzOu325jYflP9IZD8jk8jA7BYM6dl/7GgeIjk1jhCjSJ+Vz/2u8eDaFbzT
         hMkoZyRO9cA/HrSe++R5tU9mAMS5mVKKAajeaRBPf+e5RwUL5ZMnihMUmQy/9fvUQl4C
         HYPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=iY86TMAyxnock7CH+i0X2ua2PeNscW1BrukEJJiKzEY=;
        b=OWyq1uzoSpyfi5XL6TsUvxpx2LN5I7LHcH+Olmyj6ArbmLS1oAjzgWzL2IXzO8o3bz
         h0CODsMvz/nFTjAlXEs038zbFfngiDUaNZd/suM6fbvivzBylsJfofmvBxMsEF2EuElh
         8WWbL3gAoPMJoc7I8Fc+Sl2MxW/oQUI1mm9Hg3mdFAjZuB0Mv5ELJhuiUk/fC2iB9O+Y
         DtNscfRkOJM61ihWBk+Mo/iMzKjGNLp025b9qY4gM4tmQwEX3OTlVzYshvbUxurbT/Lp
         2upIxufyXWpVZxN57WS7bUTD58IH1KZEmtFJeS3GIg3sucemIqfoSQlaLTdDUQuGEouQ
         iqSw==
X-Gm-Message-State: AJIora+Kn0jGNAOjybNTOMpx5w0YFI7zMm55U6gjjF8asvvpX0xH5mFe
        RQKghEdN/jINAOSHWiEQf5nxH6TAKfswpWh97uM=
X-Google-Smtp-Source: AGRyM1sjDyYZRHanw5fS+/xWNtH+ddfPzGh6okTWrCTa9kguKEXH+MXTOF1JkLDDJdsPy1Supz/0mqt12+y0WRrzgkQ=
X-Received: by 2002:a2e:8909:0:b0:25d:efb9:8358 with SMTP id
 d9-20020a2e8909000000b0025defb98358mr5212693lji.461.1658820989853; Tue, 26
 Jul 2022 00:36:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab2:7755:0:b0:14b:e8f8:f790 with HTTP; Tue, 26 Jul 2022
 00:36:29 -0700 (PDT)
Reply-To: cristinacampel@outlook.com
From:   "Mrs. Cristina Campbell" <michellericharrd@gmail.com>
Date:   Tue, 26 Jul 2022 08:36:29 +0100
Message-ID: <CAJLj=HdP5iT4=2+-fanfPV=3=c83MR4=Jzwcz_oaB7sQmUooKg@mail.gmail.com>
Subject: =?UTF-8?B?Q3p5IG1vxbxlc3ogbWkgcG9tw7NjPw==?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Drodzy Umi=C5=82owani,

Przeczytaj to powoli i uwa=C5=BCnie, poniewa=C5=BC mo=C5=BCe to by=C4=87 je=
den z
najwa=C5=BCniejszych e-maili, jakie kiedykolwiek dostaniesz. Nazywam si=C4=
=99
Cristina Campbell, by=C5=82am =C5=BCon=C4=85 zmar=C5=82ego Edwarda Campbell=
a. Pracowa=C5=82 w
Shell Petroleum Development Company London i by=C5=82 r=C3=B3wnie=C5=BC do=
=C5=9Bwiadczony
wykonawca w regionie Azji Wschodniej. Zmar=C5=82 w czwartek 31 lipca 2003
r. w Pary=C5=BCu. Byli=C5=9Bmy ma=C5=82=C5=BCe=C5=84stwem przez siedem lat =
bez dziecka.

Czytaj=C4=85c to, nie chc=C4=99, =C5=BCeby=C5=9B mi wsp=C3=B3=C5=82czu=C5=
=82a, poniewa=C5=BC wierz=C4=99, =C5=BCe kiedy=C5=9B
wszyscy umr=C4=85. Zdiagnozowano u mnie raka prze=C5=82yku i m=C3=B3j lekar=
z
powiedzia=C5=82 mi, =C5=BCe nie wytrzymam d=C5=82ugo z powodu moich skompli=
kowanych
problem=C3=B3w zdrowotnych.

Chc=C4=99, aby B=C3=B3g by=C5=82 dla mnie mi=C5=82osierny i przyj=C4=85=C5=
=82 moj=C4=85 dusz=C4=99, wi=C4=99c
postanowi=C5=82am dawa=C4=87 ja=C5=82mu=C5=BCn=C4=99 organizacjom charytaty=
wnym / ko=C5=9Bcio=C5=82om /
=C5=9Bwi=C4=85tyniom buddyjskim / meczetom / dzieciom bez matki / mniej
uprzywilejowanym i wdowom, poniewa=C5=BC chc=C4=99, aby to by=C5=82 jeden z=
 ostatnich
dobrych uczynk=C3=B3w Robi=C4=99 to na ziemi, zanim umr=C4=99. Do tej pory =
rozdawa=C5=82em
pieni=C4=85dze niekt=C3=B3rym organizacjom charytatywnym w Szkocji, Walii,
Panamie, Finlandii i Grecji. Teraz, gdy moje zdrowie tak bardzo si=C4=99
pogorszy=C5=82o, nie mog=C4=99 ju=C5=BC tego robi=C4=87.

Kiedy=C5=9B poprosi=C5=82am cz=C5=82onk=C3=B3w rodziny, aby zamkn=C4=99li j=
edno z moich kont i
przekazali pieni=C4=85dze, kt=C3=B3re tam mam, na organizacje charytatywne =
w
Austrii, Polsce, Niemczech, W=C5=82oszech i Szwajcarii, odm=C3=B3wili i
zatrzymali pieni=C4=85dze dla siebie. Dlatego nie ufam im wi=C4=99cej, poni=
ewa=C5=BC
wydaje si=C4=99, =C5=BCe nie maj=C4=85 do czynienia z tym, co im zostawi=C5=
=82em. Ostatnie
z moich pieni=C4=99dzy, o kt=C3=B3rych nikt nie wie, to ogromny depozyt
got=C3=B3wkowy w wysoko=C5=9Bci 6 milion=C3=B3w dolar=C3=B3w ameryka=C5=84s=
kich, kt=C3=B3ry mam w
banku w Tajlandii, gdzie zdeponowa=C5=82em fundusz. Chc=C4=99, =C5=BCeby=C5=
=9B wykorzysta=C5=82
ten fundusz na programy charytatywne i wspiera=C5=82 ludzko=C5=9B=C4=87 w s=
woim
kraju, je=C5=9Bli tylko b=C4=99dziesz szczery.

Podj=C4=99=C5=82am t=C4=99 decyzj=C4=99, bo nie mam dziecka, kt=C3=B3re odz=
iedziczy te
pieni=C4=85dze, nie boj=C4=99 si=C4=99 =C5=9Bmierci st=C4=85d wiem dok=C4=
=85d id=C4=99. Wiem, =C5=BCe b=C4=99d=C4=99 na
=C5=82onie Pana. Jak tylko otrzymam Twoj=C4=85 odpowied=C5=BA, podam Ci kon=
takt z
Bankiem i wydam upowa=C5=BCnienie, kt=C3=B3re upowa=C5=BCni Ci=C4=99 jako p=
ierwotnego
beneficjenta tego funduszu do natychmiastowego rozpocz=C4=99cia programu
charytatywnego w Twoim kraju.

Tylko =C5=BCycie prze=C5=BCyte dla innych jest warte zachodu. Chc=C4=99, =
=C5=BCeby=C5=9B zawsze
si=C4=99 za mnie modli=C5=82. Ka=C5=BCda zw=C5=82oka w Twojej odpowiedzi da=
 mi mo=C5=BCliwo=C5=9B=C4=87
znalezienia innej osoby w tym samym celu. Je=C5=9Bli nie jeste=C5=9B
zainteresowany, przepraszam za kontakt. Mo=C5=BCesz si=C4=99 ze mn=C4=85 sk=
ontaktowa=C4=87
lub odpowiedzie=C4=87 na m=C3=B3j prywatny e-mail: (cristinacampel@outlook.=
com).

Dzi=C4=99kuj=C4=99,
Z powa=C5=BCaniem,
Pani Cristina Campbell
E-mail; cristinacampel@outlook.com
