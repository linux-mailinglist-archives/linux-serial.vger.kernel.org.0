Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C58A524B82
	for <lists+linux-serial@lfdr.de>; Thu, 12 May 2022 13:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353195AbiELLVt (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 12 May 2022 07:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353239AbiELLVp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 May 2022 07:21:45 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBE14B847
        for <linux-serial@vger.kernel.org>; Thu, 12 May 2022 04:21:43 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id m190so9119556ybf.4
        for <linux-serial@vger.kernel.org>; Thu, 12 May 2022 04:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=OGjovOLLCNX5QV/XTVfdAcAkHFV5TFmZScvINXsyNcw=;
        b=ItqODeG7JfJNM1d4LJCDqp+qK+8MUctqK03dNaMGXD7aoshbnkvQoIHWVNjhkGVpLm
         JbjTOyd7MB1A3NhhMzni3Smq2PKCmXYPQas1H0/Z0z716saQkbCzQOinVfp1xL3yu9wA
         77M/id8YGn3GwNELVgjCNnKyRiMFYPK7V4SSFtCniUzEouIJIhItjAl7Pd1+KUeHp93P
         kH7IhfTiT8cSCLKoVkwJ3S/Ed53Bk4/lgeLY4gngdpdBVbp9WVhhRH1SH+PLxfzZtaJU
         b9JLuelMNhFh8sDBGk5LvQS941rVUcTeOpaZ8xAKgo/F3oqRObfcCrL3eMe4Qb2cV3Z/
         j4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=OGjovOLLCNX5QV/XTVfdAcAkHFV5TFmZScvINXsyNcw=;
        b=uaIh/uRRUbZOtPBNtfXbyX0wv9t084sCUcxV+auajtm/dWz1/4uHmtOSEOPczoGl4B
         HmI1ts8RFObTAoZDHogPm9gts32Kw3sTFBdudiqwCO8Ze5wEtdmayufGNgfJ6Nc7JcUk
         5BiiJapUzQk1h/BXFBF1Vxn65Fks/d2xsLdZNXUVpGmfsAu4QgPOPOlxJprr0/fdOVd9
         Racn2p8DajKtA80BZL4cz9yq9lfpbTRehW/ynMn88gcL7DILSFQ3kkiMtBw5cDeCtNCW
         sn9vnmgX89c7DWya3B8A3vBfIBFrHks/NpaEuaqyp18QkEPLHiPN5YemU5Q+PMmessC6
         o01g==
X-Gm-Message-State: AOAM532MhwFSuovjKUm503CwfB9Ehga6H7xRhVGkvp96oJA2zL1erUEa
        h7rvbJzGSYs8YKCfxxYJk8bZEtlYpd8uDMmoGA==
X-Google-Smtp-Source: ABdhPJxk8HMrxPEw7jjnMpxREvi5hq/Kkzz02iDCls+05vkMHYXbFbFfq15KsXIHmJg+Sknk8ZqOkAUw9u5ubo7R+EE=
X-Received: by 2002:a25:d801:0:b0:64b:4013:1c44 with SMTP id
 p1-20020a25d801000000b0064b40131c44mr6101109ybg.187.1652354502341; Thu, 12
 May 2022 04:21:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:380b:0:0:0:0 with HTTP; Thu, 12 May 2022 04:21:41
 -0700 (PDT)
Reply-To: rolandnyemih200@gmail.com
From:   Rowland Nyemih <happypalama@gmail.com>
Date:   Thu, 12 May 2022 12:21:41 +0100
Message-ID: <CAJoenewDSSXZmLAoP_gy9dAteVKE_9+gHWRXE34rteAps9e2fg@mail.gmail.com>
Subject: Rowland N.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b42 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4502]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [happypalama[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [rolandnyemih200[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

HI,
Good day.
Kindly confirm to me if this is your correct email Address and get
back to me for our interest.
Sincerely,
Rowland
