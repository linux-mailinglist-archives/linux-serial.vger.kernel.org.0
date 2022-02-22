Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7784BF482
	for <lists+linux-serial@lfdr.de>; Tue, 22 Feb 2022 10:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiBVJQp (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 22 Feb 2022 04:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiBVJQo (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 22 Feb 2022 04:16:44 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD23108BC4
        for <linux-serial@vger.kernel.org>; Tue, 22 Feb 2022 01:16:19 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id p184-20020a1c29c1000000b0037f76d8b484so1244696wmp.5
        for <linux-serial@vger.kernel.org>; Tue, 22 Feb 2022 01:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=FyG0ATSkb5fmrso4VuDc0KiEUJrvvMWML2pstdAYUxY=;
        b=g70QSCVynDCSH5YlQ1Yr0Qv4OZV8KowxxqHhkorcetuz6aZqVN6VNVvUV5MjsmvomQ
         KSJouIYrRX7RQdPI1zFgmzaqHg7dwQd4M22TJgGzUDF+yTpOPDlPBKcjwlwz1ueOybun
         jRtUDDNkmvGfqntge2Dg+DnG1pINg6mKLC/my1THcwHOXwf16qLWo57B5Cef3GlAHkWR
         2NuNcXabWJIJ3zGoT9y3QYPj1uByG1pFcJorMLQZTe3MMsHrIEyjeVusmtZd5CaR9bdW
         J6GZWUn0JU8xlqCygboz+Z3YF32foe/cKYjf0HuyYCD3xZfHGKU9z23V2tbnf3DxArrY
         drNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=FyG0ATSkb5fmrso4VuDc0KiEUJrvvMWML2pstdAYUxY=;
        b=wDjIhX2NNb8iPor/l/BDdmACwMNRfuqtIL6VU7/uLvoCsiD78apwIihteMYhQAsjws
         DwkPZnYbfDwq6NY+kunCyw3DRVgWPlKFhqEGtB5pSUOjpZewSQ5zWtfiEhKAH/5pwMU7
         vrWHqkeaZPSQRZFVT7O8LgBkTi5sijSPkfS2AZZ+plnjR3icpY6HiSbO84C7QtXpYmGG
         oXkeS6DRrjQDpHJfiCGKaxDRQ86mF11jwDf6TPtkWuRp2v2iVWR3cKmwsb8qJZCbySKv
         fN/nCbwxUicBCoyFX1iLuULhQZiOO90NOaqaZSU5WmfuIc+jitItSqU6o7zEZRVCDMTe
         Fl3g==
X-Gm-Message-State: AOAM531XjLjiko5Jqm+63046kmBc8pEy4NpvflM1X7aePPTKdATtyZW7
        60c9RNZW3yhDOoR8BDApFYQ=
X-Google-Smtp-Source: ABdhPJyhAaWJleu5ZLTtnN0Tkx4oeoLtiUpHfOsyI/Gkg1I2e5BZHkz/UaE6NyFHdmPR5XvGH1fIuQ==
X-Received: by 2002:a7b:c245:0:b0:37c:440:c17 with SMTP id b5-20020a7bc245000000b0037c04400c17mr2459033wmj.130.1645521378376;
        Tue, 22 Feb 2022 01:16:18 -0800 (PST)
Received: from [192.168.0.133] ([5.193.8.34])
        by smtp.gmail.com with ESMTPSA id r12sm20996900wrz.50.2022.02.22.01.16.14
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 22 Feb 2022 01:16:16 -0800 (PST)
Message-ID: <6214a9e0.1c69fb81.3df85.bbcb@mx.google.com>
From:   Mrs Maria Elisabeth Schaeffler <garyvernon830@gmail.com>
X-Google-Original-From: Mrs Maria Elisabeth Schaeffler
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Spende
To:     Recipients <Mrs@vger.kernel.org>
Date:   Tue, 22 Feb 2022 13:16:09 +0400
Reply-To: mariaeisaeth001@gmail.com
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,TO_MALFORMED,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hallo,

Ich bin Frau Maria Elisabeth Schaeffler, eine deutsche Wirtschaftsmagnatin,=
 Investorin und Philanthropin. Ich bin der Vorsitzende von Wipro Limited. I=
ch habe 25 Prozent meines pers=F6nlichen Verm=F6gens f=FCr wohlt=E4tige Zwe=
cke ausgegeben. Und ich habe auch versprochen zu geben
der Rest von 25% geht dieses Jahr 2021 an Einzelpersonen. Ich habe mich ent=
schlossen, Ihnen 1.500.000,00 Euro zu spenden. Wenn Sie an meiner Spende in=
teressiert sind, kontaktieren Sie mich f=FCr weitere Informationen.

Sie k=F6nnen auch =FCber den untenstehenden Link mehr =FCber mich lesen


https://en.wikipedia.org/wiki/Maria-Elisabeth_Schaeffler

Sch=F6ne Gr=FC=DFe
Gesch=E4ftsf=FChrer Wipro Limited
Maria-Elisabeth_Schaeffler
Email: mariaeisaeth001@gmail.com=20
