Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4EA5A4FCC
	for <lists+linux-serial@lfdr.de>; Mon, 29 Aug 2022 17:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiH2PGb (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 29 Aug 2022 11:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiH2PGa (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 29 Aug 2022 11:06:30 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5F88C00F
        for <linux-serial@vger.kernel.org>; Mon, 29 Aug 2022 08:06:29 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id t140so10660451oie.8
        for <linux-serial@vger.kernel.org>; Mon, 29 Aug 2022 08:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc;
        bh=TrYLNmHMfL2YwnKDzOCdO7Jrlbbexw6rsutI3mWrjc8=;
        b=VdvCdSUey//OBkIN+4SLPWTbLU4uj2CqSJ2SwAPziqeCr3xQNVREYOr4ewFG01O8B+
         F8NPuB39fvaSRFV152FH49aZdPZ2Lx3Bx/TqKAm4t703IFw3CoKB/sGe3otzS/9nXQV4
         Jep1bTq1NoPa0q/wbLnEDmgI0jJH62XXCluUEbpSsOAEkb5An8JwJ0KqnHqhwPAc+YPg
         jjzG8DYpnVVA3Fct2VUt1sYHvqLP/+3i3E3CBaV2BcWU2FJPlzHV8zor6ctirWreSZ0S
         VYM41avx4ogYGFfhOlI0qRbs2z6ZGV2vBKonvB1Ga+365LVASEUDxxPpgTYEB0zuZ4MR
         pmgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc;
        bh=TrYLNmHMfL2YwnKDzOCdO7Jrlbbexw6rsutI3mWrjc8=;
        b=vg084aJtLTALU10Wgj3V6183HAwEsveYRCSpGPL+IX1P9rpdu5NCTcVFNu+y4jU8GQ
         I58HoUCcJ+OXN1B3RqJk4J1g8tkcUJ3Ug0xqALq+dHJjatP3jQoAYHGkWZ8tGWyA/g/l
         5PFfg8l1vr3/cVy1jmMCYM0c9+GDMTK0GcYIKchtBIXvYFhk0QqgzyU6dSBsO/guYHTX
         nF6Dw+/DWhHA3VeKsrDuMmFFExahLEUMwx1ytldEaK4Rfowv5jmdIS4YeQ9M18S4auLQ
         foEO7GP8ibDagYuN0KxcmVRU+Q9b6UkAr2Jfx7QBjf/gh54HdNWnGoJ68eNuxwlBwBwn
         O/7g==
X-Gm-Message-State: ACgBeo2D7y/uFQD1JPJirI9aDQGioLPx8aU2z618yVFyT64MP0JaIB6q
        a9kKzpoQnznZhRY5fw1fIKDsluJ0S+LNZgyWqqIAnOc1H63b9w==
X-Google-Smtp-Source: AA6agR6U4eGoX85/lf7EBwdkX1x4cOxMOZZ/hXl1j1vH361c0EYRpbhRnwrux4W/BjJUetfq9IgmJKBCR3Lmb1+d6Fg=
X-Received: by 2002:a05:6808:ecc:b0:33a:3979:a148 with SMTP id
 q12-20020a0568080ecc00b0033a3979a148mr7209282oiv.149.1661785588025; Mon, 29
 Aug 2022 08:06:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6820:625:0:0:0:0 with HTTP; Mon, 29 Aug 2022 08:06:27
 -0700 (PDT)
Reply-To: georgebrown0004@gmail.com
From:   george brown <moordavis0002@gmail.com>
Date:   Mon, 29 Aug 2022 17:06:27 +0200
Message-ID: <CALTCcCzEwHYXYhOLOch2ZhyeYF=hGfoMrQkmtAQ8eKNGfW07Pg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Ahoj

Jmenuji se George Brown, povol=C3=A1n=C3=ADm jsem pr=C3=A1vn=C3=ADk. Chci v=
=C3=A1m nab=C3=ADdnout
nejbli=C5=BE=C5=A1=C3=AD p=C5=99=C3=ADbuzn=C3=BD m=C3=A9ho klienta. Zd=C4=
=9Bd=C3=ADte =C4=8D=C3=A1stku (8,5 milionu $)
dolar=C5=AF, kter=C3=A9 m=C5=AFj klient nechal v bance p=C5=99ed svou smrt=
=C3=AD.

M=C5=AFj klient je ob=C4=8Dan va=C5=A1=C3=AD zem=C4=9B, kter=C3=BD zem=C5=
=99el p=C5=99i autonehod=C4=9B se svou =C5=BEenou
a jedin=C3=BD syn. Budu m=C3=ADt n=C3=A1rok na 50 % z celkov=C3=A9ho fondu,=
 zat=C3=ADmco 50 % ano
b=C3=BDt pro tebe.
Pro v=C3=ADce informac=C3=AD pros=C3=ADm kontaktujte m=C5=AFj soukrom=C3=BD=
 e-mail zde:
georgebrown0004@gmail.com

P=C5=99edem d=C4=9Bkuji,
pane George Browne,
