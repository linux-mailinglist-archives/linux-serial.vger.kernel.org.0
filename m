Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF8E53146E
	for <lists+linux-serial@lfdr.de>; Mon, 23 May 2022 18:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238627AbiEWQLn (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 23 May 2022 12:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238605AbiEWQLj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 May 2022 12:11:39 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19232B1AA
        for <linux-serial@vger.kernel.org>; Mon, 23 May 2022 09:11:32 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id r22so5392086ual.3
        for <linux-serial@vger.kernel.org>; Mon, 23 May 2022 09:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=GYaXnbwRqNnqLI5PzHW8lwPHCCjceVjMfcx/8J6upao=;
        b=j6T4oSDKc9KQOUh/oVB06aRaASWjssiFwbwZ6m49FEELG/0jyH6WnyJD8wkPQtaqnv
         AtraE8p4ciOqUd/sdYsqkdc9Hadj1vXkJqtQDxIuTeWNwLVYVhVycZGN1M88uYt7chQu
         tobP3wgVs7IfiQTPnCyB3OBZSeXsaEMERTtQ0nsG4qcCqO2/TpWJpUL8FOhBj/ZPGIcY
         BcalH8DvsdZE0Cw4fBCX4ZsFlaompBCVFdBrnk+oozMRTUUhMzsBP9rm/958En4UosHQ
         smM9e90GHxhXuf6it9V8MzNl/ZKQItWprfVDWVF/+8EpBhtVkvJW0lPu+by/VBh9oObB
         gnSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=GYaXnbwRqNnqLI5PzHW8lwPHCCjceVjMfcx/8J6upao=;
        b=EgiBB3CCNDbzZkjIRBpzf/KNVcoJ7qYvECR/sEXQh9fQathvUQqoWzne0f/uZqGwG9
         q3FduLKXhCev1/mONmpgi+DV2BqoTKkX9+mIGRVCudooBl0/eEfU6JLo2ArCxRmww4Yy
         6sFpzn4PBs9Z53ZEXuDXksL27bE+aXDFrvjwn8pNp+Vr1rZuHgkhiuZzeJJIV9nH/q2x
         4t0BgvepSRzyjalxkaAJ3i6Om3ZemBGr5LrL72ZwVchJZ1N5l/3ow/g4CeC35v7UG02s
         55o0e+b3IPzYFRPeWLeORsrkA4gcd1u0gjOIr8+z9QwMl5WsBSCeT5BJa1a43svJwIEt
         D98A==
X-Gm-Message-State: AOAM531vsNOlRs45BBtXglUVBM+zFH2SCXcCw4C+eI97Q0W6fqHbGcY5
        y8XYZFuY5VlfSibhDaA7UoXTG2RM6Ic4dGBLqso=
X-Google-Smtp-Source: ABdhPJwRVFIXzxPs2RpqKNfu2QGCqdhHv1FSF7Zd4nNA0tZhrG9UbgDgL+L8rZAo+EAHw3lAX1X12LSw1gW+j3cRjA4=
X-Received: by 2002:ab0:2b88:0:b0:35d:4e7d:a727 with SMTP id
 q8-20020ab02b88000000b0035d4e7da727mr7552348uar.112.1653322291627; Mon, 23
 May 2022 09:11:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6102:3049:0:0:0:0 with HTTP; Mon, 23 May 2022 09:11:31
 -0700 (PDT)
Reply-To: rkeenj7@gmail.com
From:   "keen J. Richardson" <rkekere8@gmail.com>
Date:   Mon, 23 May 2022 16:11:31 +0000
Message-ID: <CAMoyxWoo8aQ=fZfHUr4QpQLv-s_oZFH7kjbjL+sBYvw=RFtmUw@mail.gmail.com>
Subject: =?UTF-8?Q?Dobr=C3=BD_den?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: Yes, score=5.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:942 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [rkeenj7[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [rkekere8[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [rkekere8[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.3 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

LS0gDQpOxJtrZHkgbWludWzDvSB0w71kZW4gdsOhbSBieWwgemFzbMOhbiBlLW1haWwgcyBvxI1l
a8OhdsOhbsOtbQ0Ka2R5xb4ganNlbSBvZCB2w6FzIHDFmWVsYWRpbCBlLW1haWwsIGFsZSBrIG3D
qW11IHDFmWVrdmFwZW7DrSBqc3RlIHNlIG5pa2R5DQpuZW9idMSbxb5vdmFsIG9kcG92xJtkxJt0
Lg0KUHJvIGRhbMWhw60gdnlzdsSbdGxlbsOtIGxhc2thdsSbIG9kcG92xJt6dGUuDQoNClMgw7pj
dG91IFbDocWhLA0KaG9ybGl2w70gSi4gUmljaGFyZHNvbg0K
