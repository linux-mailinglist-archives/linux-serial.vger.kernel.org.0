Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EACFC5FFC98
	for <lists+linux-serial@lfdr.de>; Sun, 16 Oct 2022 01:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiJOX0K (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sat, 15 Oct 2022 19:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiJOX0J (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 15 Oct 2022 19:26:09 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25193FA29
        for <linux-serial@vger.kernel.org>; Sat, 15 Oct 2022 16:26:02 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id j7so13015955wrr.3
        for <linux-serial@vger.kernel.org>; Sat, 15 Oct 2022 16:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6aF9nFwwA4H8y+DQySeTN9I4LSFxeOQ6cH2LPftSBU4=;
        b=Y20Ob9ciuVze9ya2LUog/LVE/aKMnR3J9ypMrS5aRaTXXlhI74+vQLJBBTs4s68i7G
         qQmwWgLFtyUYAbD+vhKmI/P2wZUr5e4nDZraqCtBrBeunMXAHdmZx2RqbLLhiRPfnUxL
         WHJL99yDu5E0Ez+q6IjZ2xMYFwaiUG8LABoAsrgu0CtrSFsShrFAbSjy7nWstXzOivS3
         8oc5UUWZ/eb9TRS+LC319O7BgJAbrzIXDT3CYY03PionaWn/KJUugPPAVPo7ge7l0vRa
         dfM3pbaEj0VwMKdsED3pWjEHaOgcs1I/JO8F9RXDXSB1cd/Pt3gIi2VDeAKf4Ld9qpU0
         dTJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6aF9nFwwA4H8y+DQySeTN9I4LSFxeOQ6cH2LPftSBU4=;
        b=iMIVlCXZy+OG+kZaKHEK+arPdO3BW8wMwNOy2hAg/I3H5BQKpStXkwrcK5ehvzrVoZ
         cUpCUggB0g6V4n9NoUT0ABf79b4D0sbDq1OOVh/fV76qQ4fsIdlhqra0uVgc95kSaHur
         Pnct3xV7/mr0JKRcw8UwtNmM+32iphk2X9BzQr3hOAWG30Pc9DttzbceMBZRul7iWhwY
         PwzH8v/X4Qjm4OcVFnLP99uIH11KShav9fvqej+a+BKNZduV3vxBydQoTVebWoXDyvcY
         UhGn/KpUnoWwZQeTz1FYL0XJo6j1pQBUwhTMIthFDWa1boCLx+2Fp0sEYMf5NO+Ap4z/
         qqIg==
X-Gm-Message-State: ACrzQf3/ujJA7J7HmA5G/aqUdyfVRpDBAH7vz3/QJQveGUndkSXmC+hE
        eSFXJfvSYd0k8dbJrzoyH8lV/i2p47N24NZ3Vj8=
X-Google-Smtp-Source: AMsMyM6kU3pXsSNGiL94HkY9zUeCM238G3f3ObmM9kxNfzpZlI2TlsUSYeRHlOblHRQRA7PSyQ1JFO2+CWXfSN0jY3g=
X-Received: by 2002:adf:e19e:0:b0:22e:64de:39fa with SMTP id
 az30-20020adfe19e000000b0022e64de39famr2322766wrb.369.1665876361181; Sat, 15
 Oct 2022 16:26:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6000:1f8f:0:0:0:0 with HTTP; Sat, 15 Oct 2022 16:26:00
 -0700 (PDT)
Reply-To: richardwahl9035@gmail.com
From:   Richard Wahl <cgichuhi872@gmail.com>
Date:   Sun, 16 Oct 2022 02:26:00 +0300
Message-ID: <CANQzO9V0MWwohW3nxnUgZu81Vy34g+V4c1avuU9uL3TMV-4LFA@mail.gmail.com>
Subject: Re,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.4 required=5.0 tests=BAYES_80,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,REPTO_419_FRAUD_GM_LOOSE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:42d listed in]
        [list.dnswl.org]
        *  2.0 BAYES_80 BODY: Bayes spam probability is 80 to 95%
        *      [score: 0.8172]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [richardwahl9035[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [cgichuhi872[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [cgichuhi872[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  1.0 REPTO_419_FRAUD_GM_LOOSE Ends-in-digits Reply-To is similar to
        *      known advance fee fraud collector mailbox
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

--=20
Sch=C3=B6nen Tag,

Ich bin Herr Richard Wahl, Sie haben eine Spende von 700.000,00 =E2=82=AC. =
Ich
habe ein gewonnen
Gl=C3=BCck in der Power-Ball-Lotterie und ich spende einen Teil davon an Te=
n
Lucky People und Ten Charity Organisation. Ihre E-Mail kam heraus
siegreich, also antworte mir dringend f=C3=BCr weitere Informationen unter:
richardwahl9035@gmail.com
Aufrichtig,
Herr Richard Wah7
