Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30879507101
	for <lists+linux-serial@lfdr.de>; Tue, 19 Apr 2022 16:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352550AbiDSOxM (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 19 Apr 2022 10:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbiDSOxL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 19 Apr 2022 10:53:11 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69683A5CE
        for <linux-serial@vger.kernel.org>; Tue, 19 Apr 2022 07:50:28 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id r1so15838507vsi.12
        for <linux-serial@vger.kernel.org>; Tue, 19 Apr 2022 07:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=cvfYEjF7QKOIf/caSAhp4YLSCOj7kiNo1L7dgNRsEag=;
        b=Gb+Z3IFX9COAUQCfYxti9iFS4xdKrEymMrowyIyUh49H0nsCxBl2EmpZJvbknz8KbL
         HZuYNOW7y9108mHtpTlU21rOYgxpM2k2fKaQ73bCuremvTGFF8rJ9LunzkDJttdnmQWZ
         I+TvR0fvJAPOnpRzyUuPXNKhtplTi18+Wx+pS/3rpKVlYw+5QGaRexViBCTe4+l3Nld0
         xm8TJj8zW5gJV+93DL6y4Uejp0A+18h8luk+9UB/phuNhjK5hUwDZrCiPknNOtQbxM6Y
         1E0V39lHAZIGbzmp9172jb+ZjLfH/n8I2YfKQD6OBj7CMKd07iMUhkBixIqOxYHo97ub
         hqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=cvfYEjF7QKOIf/caSAhp4YLSCOj7kiNo1L7dgNRsEag=;
        b=d9DWgDyha6AuX6mTsXgvMBlz0QDf6QJCFxWJunmUKyrf/XzyZS2ZtWxhcaLKw2EQoi
         0mHlnG1eB3Ny/rg6fnmHo281059/XEJiZDwy3sF8TfYU5Ci69gTSI95lz/EGHBBZsawW
         bPb+e36nSk5nm0ghG85JJfMFSZQl7KkwbXwajdIxOEfQ/42i7Z6lx777oyMYdplhfiYF
         LCFWAFm5SL+YXyN8M4gM2lEZgUIJXtAphOS2RP9rXv/ttOJoKYykHScfU5LPQrneqHS2
         XPxgXCCsr/QXTHVtLdPat9Cm1FcadcKOeW4rJwIwUXrXHjc4JGMmVnAVngDrXJdj6FK4
         ERIA==
X-Gm-Message-State: AOAM531zZ530RlLUIrrHE/G7/C4gdVcx/+NQH6bFF/bcvMvtMyT0hFbr
        5hp7+ZOjJxw5hAS3tmaziIUPjxfUb0D0R/AiUdM=
X-Google-Smtp-Source: ABdhPJzyA8zotx1ZtqWqqaFXJh3wbl+uWWLQpB87fd8QWG8ggEuLXrsXfgUnhWn/siSYFK/Yabp2feoiTZn5EWDFq0s=
X-Received: by 2002:a67:e3a5:0:b0:32a:31a6:8257 with SMTP id
 j5-20020a67e3a5000000b0032a31a68257mr4616996vsm.62.1650379827609; Tue, 19 Apr
 2022 07:50:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:cd27:0:b0:2ae:a55:e491 with HTTP; Tue, 19 Apr 2022
 07:50:26 -0700 (PDT)
Reply-To: uchennailobitenone@gmail.com
From:   uchenna <robertandersonhappy2@gmail.com>
Date:   Tue, 19 Apr 2022 16:50:26 +0200
Message-ID: <CABzJeR_NDxdtJ1QTZujUBSTVmEZyBBwL2p1c2F7efjHXxGsjjw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Gratulacje!

Organizacja Narod=C3=B3w Zjednoczonych dosz=C5=82a do wniosku, =C5=BCe z po=
moc=C4=85 nowo
wybranego prezydenta z powodu Covid-19 (koronawirusa) zostanie
wyp=C5=82acona kwota sze=C5=9Bciu milion=C3=B3w dolar=C3=B3w (6.000.000 dol=
ar=C3=B3w)
szcz=C4=99=C5=9Bliwym beneficjentom na ca=C5=82ym =C5=9Bwiecie. r=C3=B3=C5=
=BCne kraje i globalne
zagro=C5=BCenie dla tak wielu istnie=C5=84 ludzkich.

 Organizacja Narod=C3=B3w Zjednoczonych zleci=C5=82a szwajcarskiemu bankowi
=C5=9Bwiatowemu uwolnienie p=C5=82atno=C5=9Bci funduszu kompensacyjnego we =
wsp=C3=B3=C5=82pracy
z bankiem IBE w Wielkiej Brytanii.

P=C5=82atno=C5=9B=C4=87 zostanie przekazana na kart=C4=99 bankomatow=C4=85 =
Visa i wys=C5=82ana do
szcz=C4=99=C5=9Bliwego beneficjenta, kt=C3=B3ry z=C5=82o=C5=BCy wniosek za =
po=C5=9Brednictwem banku
IBE w Wielkiej Brytanii za po=C5=9Brednictwem dyplomatycznej firmy
kurierskiej znajduj=C4=85cej si=C4=99 w pobli=C5=BCu kraju beneficjenta.

S=C4=85 to informacje wymagane przez kierownictwo Zjednoczonego Kr=C3=B3les=
twa,
aby przekaza=C4=87 wyp=C5=82at=C4=99 funduszu kompensacyjnego do progu kraj=
u
beneficjenta.

1. Twoje imi=C4=99 i nazwisko:
2. Adres domowy:
3. Miasto:
4. Kraj:
5. Zaw=C3=B3d:
6. P=C5=82e=C4=87:
7. Stan cywilny:
8. Wiek:
9. Paszport / dow=C3=B3d osobisty / prawo jazdy
10. Numer telefonu:
Skontaktuj si=C4=99 z naszym identyfikatorem e-mail agenta:
nazwa solomo brandy

ADRES EMIL (solomonbrandyfiveone@gmail.com ) dla Twojej p=C5=82atno=C5=9Bci=
 bez zw=C5=82oki,

Pozdrowienia
Pani Mary J. Robertson.
