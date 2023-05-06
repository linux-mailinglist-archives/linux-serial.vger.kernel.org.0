Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574606F925B
	for <lists+linux-serial@lfdr.de>; Sat,  6 May 2023 15:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbjEFN7d (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sat, 6 May 2023 09:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbjEFN7c (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 6 May 2023 09:59:32 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAC92452B
        for <linux-serial@vger.kernel.org>; Sat,  6 May 2023 06:59:31 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-958bb7731a9so520348566b.0
        for <linux-serial@vger.kernel.org>; Sat, 06 May 2023 06:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683381570; x=1685973570;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Yk2ZAoW+pxo/MiMBjqX3UORnaIwGKzfMAfunn0eCutA=;
        b=UY/JBxBzhBIwnxHUQIdF9RkJ+cJ29AnPTHkx7LpVNxpdBn8E4COSo6nfYGH/q9Xo8F
         NoGEnZJ2jkB5uaMilOQ0+itAPtkwnk85m5ypW/nRJ5+Sv1oBGuBoiBUaAwGyzRzdwC8S
         DLDiUCIYeKqm2hOsymYNe3o+8fu/urDIe4CQ+SIFzzNBeOLh0eO3BYh0SpBU9b4xOVD9
         eZgXb6r3XUBzGsE38jlEkz9Un6wdE4dnlcmpktuCZ5WMy3uQTfNn+JbauWGOfU2LFtdu
         aMTcdOms6Ec6M/wkbdDogCK2wikzsaEhg5K2i7uNJQ32DfDeD++Py3+TlecsI9C7KP+v
         /lcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683381570; x=1685973570;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yk2ZAoW+pxo/MiMBjqX3UORnaIwGKzfMAfunn0eCutA=;
        b=A23EPyUDngcZ8bXuRnEsdnm9/gsaGYScbVRDSsgfYfj0zGNYUakHn3Mj/PI75OLJRb
         RlFMTIecrKhz6jabtnOdo9xdsRij+lF77TN7DAsaWYO+s0JtVXnxy7hCKwdvS+nsV9z6
         q/lUgRs5FgHumlrEOiZt/qbTl8GKbkiQmgE9xA2rHRLsXiMvNVyLGEhtFZ2jLOSh3eLF
         Oe31ku4sFeSUzNLnkelf6knKzcjP8i90YOGZJyIpOPQfFY+oJu3r9qCUY71RBGzouNoP
         VWThmDJhRuChqI6o0zZfKBf1Br3sQV4pXmLLev3ASIQL7CWFwCB/bRUrZB06byytRZfy
         EaYg==
X-Gm-Message-State: AC+VfDwVn3ukBMCN3xAuxSYMXLvp1cQy3YDoK0LP/Vq9e20IqHNfc4TK
        wDHi7mDXyXwbnGOWnsn6S6Ys9WN8KTG9Co6yoPU=
X-Google-Smtp-Source: ACHHUZ5POeupXCb/799lm6SI1+k+sFeGxmJU9F6FXImgHaVzimSPBDN3pmjCXRzpMO8l0b/5fFqryvU38+T05ZYEPaw=
X-Received: by 2002:a17:907:7e92:b0:958:5c21:3fa7 with SMTP id
 qb18-20020a1709077e9200b009585c213fa7mr4896751ejc.25.1683381569423; Sat, 06
 May 2023 06:59:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a98:df8a:0:b0:1ca:7b2f:6afd with HTTP; Sat, 6 May 2023
 06:59:28 -0700 (PDT)
Reply-To: justinekevin013@gmail.com
From:   justine <directorpaulnavas@gmail.com>
Date:   Sat, 6 May 2023 13:59:28 +0000
Message-ID: <CAJnQhZM7up4yxCAS+emyJZ2gbpkRY-wbvxf52Eew69BeHD=+jw@mail.gmail.com>
Subject: Hello,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=3.8 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This is second time i sent you message without respond i hope all is
well. I have something important to discuss with you.

Yours sincerely
Mrs Justine
---------------------------------------------------------------------

To ju=C5=BC drugi raz, kiedy wys=C5=82a=C5=82em Ci wiadomo=C5=9B=C4=87 bez =
odpowiedzi, mam
nadziej=C4=99, =C5=BCe wszystko jest w porz=C4=85dku. Mam z tob=C4=85 co=C5=
=9B wa=C5=BCnego do
om=C3=B3wienia.

Z powa=C5=BCaniem
Pani Justyno
