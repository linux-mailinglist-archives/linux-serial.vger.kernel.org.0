Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D090646272
	for <lists+linux-serial@lfdr.de>; Wed,  7 Dec 2022 21:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiLGUhQ (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 7 Dec 2022 15:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiLGUhP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Dec 2022 15:37:15 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C265BC5C
        for <linux-serial@vger.kernel.org>; Wed,  7 Dec 2022 12:37:14 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id r11so16343331oie.13
        for <linux-serial@vger.kernel.org>; Wed, 07 Dec 2022 12:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=duG4073yog6ZDCWn5gRxVQ94Hax7BsJvOpMzZEtv1jU=;
        b=SS7IsUxAXZ/uzlBRmoZlkG9B4HiVF1eDxZs9iA97EBg1BUMhr0/OrJIx3YGmEXGNvu
         0wYLVw5DShuApU/GXY2l+yGhEJaHU1CfE9WKyhBDnxUs58m4jonnDZAZQ9Z7x8ekmj+x
         hFZ1/MY7qVxSLlYOEqhWeKK3tkF35au5GQtpaxuL3aijl6fZvIaSNYa6ppyOwcxKd2jJ
         b6oBkJKciI990PeaFgQkp+1JiDUdCTetMoLWPYQEBxvwE0y/IK0EYbd5SbB7MPtzs9Af
         /FMgRb6tJkNUe6fzhrz3lq8DaQ7Vig9MyuItm+jk9thqEnrOS4ApEZTBvWxeSDBxHvcd
         c+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=duG4073yog6ZDCWn5gRxVQ94Hax7BsJvOpMzZEtv1jU=;
        b=aOtDXSlx6R1ek/7+hLVydAdw111N3Pi8Cy8gpq4c5oZxSgh7VCUQgMrLbt8PPJWxwu
         ErY3bB7Lj4Q6A+/1Wm42+W15x/21Ox9hkg8h168p68exGOY6k5ZLnZvwKAnMANwANo8v
         CZUy+RCRcshvACoBc2xEOcCHPIXlih1hvsKiq8woGosrnwCtnptfij8EkLz5vQS114AM
         E5F29wMpVJLXZsYkwfjpScG2CcMJr06ZtrYH27Yp82op1xiLnkRBCzp7+RhKmczNOjDL
         /f1Yv4/Fp+Zdy2P2crt5R2FgLiRcNEeObOAUh+lCk+wXXCcilaDmdgnacEzyeDPOQfbx
         NCQA==
X-Gm-Message-State: ANoB5pkMMyL6ajxaBXNPvo+W+XwBK8DfrR+2a9tJyj4kkiC5+tM2mOuF
        hHfAxfrSmCs5ZZpAl+L7oyNPFa4ntxE3ZNN+w0I=
X-Google-Smtp-Source: AA0mqf5xdRW5SYd7b9Myku0aqFRQVBBp0iqZFAWB3667drDaw5/eZEo3oYtVmsLHRKGLZXSiBvrSkEuAm4CpPMYYgzw=
X-Received: by 2002:a05:6808:684:b0:35a:534a:4505 with SMTP id
 k4-20020a056808068400b0035a534a4505mr47292708oig.189.1670445434113; Wed, 07
 Dec 2022 12:37:14 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6358:4045:b0:e0:3dc0:ba04 with HTTP; Wed, 7 Dec 2022
 12:37:13 -0800 (PST)
Reply-To: un.online.coordinator.files@gmail.com
From:   Mrs Anne Gray <kodjoakpadja@gmail.com>
Date:   Wed, 7 Dec 2022 20:37:13 +0000
Message-ID: <CAHw_9RXamYVJc3_q933ayBNB=+J2sYBAdt2H8MWJtEaJ7sExiw@mail.gmail.com>
Subject: d4re332
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

-Witaj m=C3=B3j przyjacielu
Wierz=C4=99, =C5=BCe otrzymasz m=C3=B3j pierwszy e-mail. Nazywam si=C4=99 P=
ani Anna Gray i
zapewniam, =C5=BCe jest to uczciwy e-mail. Pisz=C4=99, aby poinformowa=C4=
=87 Ci=C4=99, =C5=BCe
jeste=C5=9B w=C5=9Br=C3=B3d tych, kt=C3=B3rzy otrzymali nasz=C4=85 aprobat=
=C4=99!
Z powa=C5=BCaniem,
Pani Anny Grey
