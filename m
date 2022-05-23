Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A07F5313E1
	for <lists+linux-serial@lfdr.de>; Mon, 23 May 2022 18:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238705AbiEWQRa (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 23 May 2022 12:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238702AbiEWQR1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 May 2022 12:17:27 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E700E66AC4
        for <linux-serial@vger.kernel.org>; Mon, 23 May 2022 09:17:05 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id j7so3503682vsp.12
        for <linux-serial@vger.kernel.org>; Mon, 23 May 2022 09:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=GYaXnbwRqNnqLI5PzHW8lwPHCCjceVjMfcx/8J6upao=;
        b=bKUojZg1kbR7hyTyTsXPIJDpRzUBKJENAaEIx4f7ZJ/qCK4VNDfjoE0R1+WOH+atSx
         LSER/kzxOBZdBFGuEjsBSDyH/0QYP09Z7Ka84nU3J+wXPazSLvppHxi+PxgUToB2jAj5
         eOUSlxuqPp3nQufWZXxfUFiACTVBkSBhVey5F9x2QMrhKQtpbxIakF0/+XfZGwJimc8y
         c04xE9ernsIXxzNaVgvVGcRuQh43uLd8PBQJ1lLOjMMXdbJAZn2KUa77QfLCT1R2Mu6U
         377UmqyI82hwpyqGLpfihbozLYmwr2P3zGRxnDuBb5kDP/vyxpJxzeVgtzyx4HaQHQZj
         Qbpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=GYaXnbwRqNnqLI5PzHW8lwPHCCjceVjMfcx/8J6upao=;
        b=jmaQn65FB39zTYt1MWIx/TOfP4w1zwFDuruztLjRdxPjRbCi0nHLzsXc+HYUXThXov
         uwDfmM5vUq4e4K1pvyAa9l4wgu0fXiut807apCtTSTL97yNV5v4wH56bU6OxX3g6MTW/
         yEhn+cJtJ1sRLCZ2QrvekT92JxGQ5hfotGU/sBq8iFrdrBLaDuwazk9FObVf+9phYD3k
         02EWQG0tH+GSnfyeXS2TDEISTKq3JihN8JOwATMz3GYSnRzINpb13AbkrlnuS9Pd5sAo
         RiH+zoOh1UhRBUSIWjGmG87iUA05lZiv/huU7b0X089G0wI7igLjnnsLLgSqLkhQXRxp
         mY1w==
X-Gm-Message-State: AOAM530obusClVJOnxB5cSVRkAUMnmZOrkHH2YlYKQaxUexFRbZGGKxW
        5l8caYQ0OY3otu/br4fiM48hTd3FBxJIkwh0vVg=
X-Google-Smtp-Source: ABdhPJy3WQcVPv2KCVfRzfkuskPttqqeo2OzJPbTSS1XmCy6PLxSa7rdZ/Rv9q+/GPQoBA4AUjKDWZbXty+5nOSlg70=
X-Received: by 2002:a05:6102:ed4:b0:337:972f:61d8 with SMTP id
 m20-20020a0561020ed400b00337972f61d8mr4685935vst.40.1653322624657; Mon, 23
 May 2022 09:17:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6102:3049:0:0:0:0 with HTTP; Mon, 23 May 2022 09:17:04
 -0700 (PDT)
Reply-To: rkeenj7@gmail.com
From:   "keen J. Richardson" <rkekere8@gmail.com>
Date:   Mon, 23 May 2022 16:17:04 +0000
Message-ID: <CAMoyxWq0rgXM9wxC9rpV34c-y-uZLBWjx2DPmNpbu0vis47pXQ@mail.gmail.com>
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
        *      [2607:f8b0:4864:20:0:0:0:e44 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5128]
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
