Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C164C63D3D6
	for <lists+linux-serial@lfdr.de>; Wed, 30 Nov 2022 11:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbiK3Kz0 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 30 Nov 2022 05:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233224AbiK3KzY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 30 Nov 2022 05:55:24 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4DF1BEB2
        for <linux-serial@vger.kernel.org>; Wed, 30 Nov 2022 02:55:23 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id ha10so40432847ejb.3
        for <linux-serial@vger.kernel.org>; Wed, 30 Nov 2022 02:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EjV9DTB1mJdAPNCdvlTdjWS7TDInneUcAlM7/HFWxXs=;
        b=dadsL1gXbhXWgtHEZtQmwUJhgkblh2FSrfEAm0i8klAAEYQjCNfK3CYlAeAb1cekB2
         6HIlsSzdlSVAPrwnp+ryBbCgHtMvU/u5cBi5cKPVVRzI6QGi9Yt2GgNdPWvINzxjzdc6
         U/KF/faT2g+2dvOKciNG5wN0srqsEfvS8fabMmUdyvwlOGcX1t6zMCGutAm7QRAaShyz
         4zOh7vVkJOd11Hl1p6CdF9WbmaZmNflZzZbm5buIiCax0xATt9SqOEqZDBOzfjulLXsI
         54iFjGhPfMgovR+qn4lMSXf9OqVTH/s4ju587wOLNbWtz6X2uVIhN4WXL+zk4W2A/TMD
         Xl4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EjV9DTB1mJdAPNCdvlTdjWS7TDInneUcAlM7/HFWxXs=;
        b=WozC3InhuYyh4fiWE2KRqviwoy7Jm17MzyXCMOVOGYD9cfyYWFgXtz4oucv7qM2Tck
         3IOQE9CLt2WAKqyuMgPq7go2l7QhSuNN8RMGnocBAQ/5Evdrdjc+HfIcRdFad6LDRW6Z
         lGz9zAQphsFJwxoKJ2Lcm3WihX4XQ7+Sp90cq32TywQgVSpZiP8Wq1TDSQRmNJuLDQTe
         9MPo4CSXxOqjn9koxNOaAFG5QWSa293kITBPRwTiF7dAJ6nhRjwMLr/e8GPOA/gHjPn6
         z57XF0EFxVrPpslSkNIxMiZXBNWvPkTfdQFKt8TxTWzkniPcgKnoyiyZzoKprEZNcH90
         mAFg==
X-Gm-Message-State: ANoB5pmaukQOnitB2+47NpW7HuKHtqOVcnskWow4jeCJAH/jiLDIFIJ8
        yoXPf+hSlVOKgBnBI5UyNOusLwIBdfpWgrXnnIs=
X-Google-Smtp-Source: AA0mqf6XZskPVQhfnPoByOgo66TqppSgNVrW9FJ3b1FMLIZQVCxlyb1dz+Ws+gsr6YoEKrFiYeQXHrzIJ5/xQVVQS/4=
X-Received: by 2002:a17:907:9852:b0:7a8:a957:5b4e with SMTP id
 jj18-20020a170907985200b007a8a9575b4emr11338132ejc.305.1669805722057; Wed, 30
 Nov 2022 02:55:22 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6f02:8488:b0:26:b0b8:addf with HTTP; Wed, 30 Nov 2022
 02:55:21 -0800 (PST)
Reply-To: felixdouglas212@gmail.com
From:   "Mr. Douglas Felix" <felixdou123@gmail.com>
Date:   Wed, 30 Nov 2022 10:55:21 +0000
Message-ID: <CAE7V6wxQpeO1fsaYR7TgYdyVJre5AxaX7pMmS6G50f6BOVBTjA@mail.gmail.com>
Subject: =?UTF-8?B?4LiC4Lit4LmD4Lir4LmJ4LmA4Lib4LmH4LiZ4Lin4Lix4LiZ4LiX4Li14LmI4LiU4Li1?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4995]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [felixdou123[at]gmail.com]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:642 listed in]
        [list.dnswl.org]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [felixdou123[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [felixdouglas212[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

LS0gDQrguK3guLXguYDguKHguKXguJbguLnguIHguKrguYjguIfguJbguLbguIfguITguLjguJPg
uYDguKHguLfguYjguK3guKrguLHguJvguJTguLLguKvguYzguJfguLXguYjguYHguKXguYnguKfg
uYLguJTguKLguITguLLguJTguKfguYjguLINCuC4oeC4teC4iOC4lOC4q+C4oeC4suC4ouC4leC4
reC4muC4geC4peC4seC4muC4iOC4suC4geC4hOC4uOC4kyDguYHguJXguYjguJfguLXguYjguJng
uYjguLLguJvguKPguLDguKvguKXguLLguJTguYPguIjguITguLfguK3guITguLjguJPguYTguKHg
uYjguYDguITguKLguYPguKrguYjguYPguIjguJfguLXguYjguIjguLDguJXguK3guJrguIHguKXg
uLHguJoNCuC4geC4o+C4uOC4k+C4suC4leC4reC4muC4geC4peC4seC4muC4quC4s+C4q+C4o+C4
seC4muC4hOC4s+C4reC4mOC4tOC4muC4suC4ouC5gOC4nuC4tOC5iOC4oeC5gOC4leC4tOC4oQ0K
DQrguILguK3guYHguKrguJTguIfguITguKfguLLguKHguJnguLHguJrguJbguLfguK0NCuC4l+C4
meC4suC4ouC4hOC4p+C4suC4oS4g4LiU4Lix4LiB4Lil4Liy4LiqIOC5gOC4n+C4peC4tOC4geC4
i+C5jC4NCg==
