Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2DE65CD3C
	for <lists+linux-serial@lfdr.de>; Wed,  4 Jan 2023 07:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbjADGkh (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 4 Jan 2023 01:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233456AbjADGkM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 4 Jan 2023 01:40:12 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9288F183AF
        for <linux-serial@vger.kernel.org>; Tue,  3 Jan 2023 22:40:09 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id b145so18082065pfb.2
        for <linux-serial@vger.kernel.org>; Tue, 03 Jan 2023 22:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sm2IrX2as+k9LNhXBii+2EPLTtwp8Q7bZRIteVKR48Y=;
        b=lxucC7WdJqs/f6vnO0xyjDIiYvkO1zIUbY5dvzc1gS3dAy3OfQQYNJY3qgkIp4IvGC
         Oi3Qiq2J4RL2YPCvlge/HIY6+nyJiUXFhgSIFyzAmwWVXagd97/PUtXlb5jfygBt6BRf
         fwWN260uJVbK/yc9R8WuWezkJeUQdhpjES8XGIHyH3AdF/AFkNlz+YfQuZN2gO1EmOPc
         8KKIj6/qhE8i3Fe0WWEG9u5kvwBFlkiVo2YRHtZuVzM09AJ0QQD44w0muYyCcKVpzTF1
         KpA5Z3tjS1NOBVAYcaIMzzN2x6CIMAwuhChhhugpiMtk+ck5Mr24ICxbQ/8nSTPVum7J
         QJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sm2IrX2as+k9LNhXBii+2EPLTtwp8Q7bZRIteVKR48Y=;
        b=70LB6ai0mBsJP5Nct9GYTSEwK173vUgwXsCh8sUfJqLT1AfIbUQbJhP+BUlCAD3Wis
         Zl5IzNJMdeUqQrhuc0V55ZBhQXx4AhY/XurjJ8C2CcirHNVm4YfY5oalQbMDezRHzPR2
         G3z5AVAXDKtXz5pCgPheTBRuXc9z/D5Sc8xXOZfhFCTL7188uAi0CMjkwOSKs4Y4XfH1
         BEWoW0Bq+AwnO6tIO+mxW+Yj/EIJqgEOUdwuMKXpg162X93DnhxxBDCbl9GnSArHsP3e
         VCbRFZHQyYmQVJcG7oKgdXr3jJPRdhvUDjsVwujyIztbK63ri4k1oAilL4gLlLyKXMeQ
         bU/A==
X-Gm-Message-State: AFqh2koHVrF9mrHZVR3+KeE2Qm6/zp6uArFuWtRupmzqhDui2bV6aWK3
        fzGBX8v8MEFo+Ytb9bjWbAH/BIpTHoE53bhTJm8=
X-Google-Smtp-Source: AMrXdXtzEgdGNYXviASYnSqNJC0ZiQxlpsBhKtwlV/fC9EHlEQAD4b0ufCVYBzwI8FMubEJLf3ti+D5YEYUYV8QjtJ4=
X-Received: by 2002:a62:1d07:0:b0:582:e7c:f6f3 with SMTP id
 d7-20020a621d07000000b005820e7cf6f3mr1157112pfd.8.1672814408803; Tue, 03 Jan
 2023 22:40:08 -0800 (PST)
MIME-Version: 1.0
Reply-To: mrs.maryander1947@gmail.com
Sender: mrs.janeval197@gmail.com
Received: by 2002:a05:7300:7652:b0:94:fcda:856a with HTTP; Tue, 3 Jan 2023
 22:40:08 -0800 (PST)
From:   "Mrs. Mary Anderson" <amrsmary16@gmail.com>
Date:   Wed, 4 Jan 2023 06:40:08 +0000
X-Google-Sender-Auth: jTqv_0vHyo2y0EStaK-jLA4ClSk
Message-ID: <CAL+V8fx8n5YVCBnyPw3TzcFWBtXqZO5w+9A_JwP7BB54jJSoEA@mail.gmail.com>
Subject: Dear Beloved,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM,UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5800]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:431 listed in]
        [list.dnswl.org]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mrs.janeval197[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mrs.maryander1947[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [amrsmary16[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  1.7 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello,

Dear Beloved,

I am Mrs. Mary Anderson, It is understandable that you may be a bit
apprehensive because you do not know me, I found your email address
from a Human resources database and decided to contact you. I would
love to employ you into my charity work, I am ready to donate some
money to you to carry on the Charity work in your country. Please
reply so that i will give you further details and tell you about
myself.

Yours Sincerely
Mrs. Mary Anderson
