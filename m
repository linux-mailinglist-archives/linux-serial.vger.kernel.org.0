Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF2B53F283
	for <lists+linux-serial@lfdr.de>; Tue,  7 Jun 2022 01:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbiFFXYY (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 6 Jun 2022 19:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiFFXYX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 6 Jun 2022 19:24:23 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6BA6B0A9
        for <linux-serial@vger.kernel.org>; Mon,  6 Jun 2022 16:24:22 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 25so20486929edw.8
        for <linux-serial@vger.kernel.org>; Mon, 06 Jun 2022 16:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=UAOvT72nEzyjB3EaBfIB4vBLAlWNhJb9FUU2K5PC8fM=;
        b=ZyNlZhAMA+Vquu72ix+yACD2k9XUpvfe00q9XTllGnWXvrTfVGbv7ER0ZTs7prh1QQ
         IKQVOSIqy+g5B9BAkSWEOgDqEJ9mdL7QDP0A0QDcOFI9+7KXAmXuw3bSPtwyJqVyNbXD
         li83yYhq4hUrdd+8h+b8MnAn5wpggwgj071k50QxOYd2koap/WOuuOFvQpfhNLdqSOsS
         II4e0WY+FFjeEiJhCM50l3i5jvpvohYBo8ovqkNqaRBZ+bFMxb4l5mWoJ9C0AxMghZob
         MbmbfB6oNlYFbi10BI3qumpmj0Yw5gAHJ03BRKg8kPp6+oPzIYA9uCKmjvbHaRJRUPdz
         a1fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=UAOvT72nEzyjB3EaBfIB4vBLAlWNhJb9FUU2K5PC8fM=;
        b=zhMLN+8tIFYKFPUC+A1yFICzIA0os7BCPt9HniayJqAzktKEqI07jxqZmznIt6tvhm
         VugV7bqavcukJS9NUCI8c6Kyik+AwfHukSgfHU79/iMTh/FlHyHBr3KxuqUGFdQELuzH
         Odu5wWYLK9d5iZTH7FoUmPF3v9mQD6K+7f6eL3jX9ELPs8b3Cw7HamfKmjMUxH+i14oD
         VjK7NKBP16bdJZJkpDhklOV01rRLeCg1dpQDd66QQt7Q4p1AT8l6wJQWaf5Ij4KC4rHz
         LnsBg/3szsXPX4D0XR0YADhU/VTbT3p/0RZyx+71dCUzzzMJXe16v/6i+qU8K7cg3dNt
         IUpw==
X-Gm-Message-State: AOAM530K0zMJxQbphnXpJOL5zETEy1nNYtqCTJzoRS+DPFvCpkJa6CKX
        fiJh3n7i3rRr18qHRwYs+O3Jr4kifkqcsTll4ts=
X-Google-Smtp-Source: ABdhPJx2nVlwvmVpMc52OZ2y39LFgCUxL1+vZwokztk6TQuKyKGHHCLaXPmpXGA9GDPWfjy0G6tbQtH45M8JtV+pAWo=
X-Received: by 2002:a05:6402:1941:b0:413:2b5f:9074 with SMTP id
 f1-20020a056402194100b004132b5f9074mr30192669edz.414.1654557860333; Mon, 06
 Jun 2022 16:24:20 -0700 (PDT)
MIME-Version: 1.0
Reply-To: jennybezoss14@gmail.com
Sender: evakipkalyakones1@gmail.com
Received: by 2002:a50:44b:0:0:0:0:0 with HTTP; Mon, 6 Jun 2022 16:24:19 -0700 (PDT)
From:   Mrs Jenny Bezos <jennybezos1@gmail.com>
Date:   Mon, 6 Jun 2022 23:24:19 +0000
X-Google-Sender-Auth: 5rMEXiY-8bhKwshQJmvtgmDbxKU
Message-ID: <CA+mKr-+m0L-aPj21sV1XtuT71dN1FQreo0wZ4T7ro9bZCiAPfg@mail.gmail.com>
Subject: Hello Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.8 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FRAUD_5,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM,UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:536 listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.6373]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [evakipkalyakones1[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [evakipkalyakones1[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [jennybezoss14[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.3 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  2.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.6 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  0.0 MONEY_FRAUD_5 Lots of money and many fraud phrases
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

-- 
Dearest Friend,

I am Mrs. Jenny Bezos from America  USA, I decided to donate what I
have to you  for investment towards the good work of charity
organizations, and also  to help the motherless and the less
privileged ones and to carry out charitable works in your Country and
around the World on my Behalf.

I am diagnosing of throat Cancer, hospitalize for good 2 years and
some months now and quite obvious that I have few days to live, and I
am a Widow no child; I decided to will/donate the sum of $7.8 million
to you for the good work of God, and also to help the motherless and
less privilege and also forth assistance of the widows. At the moment
I cannot take any telephone calls right now due to the fact that my
relatives (who have squandered the funds for this purpose before) are
around me and my health also. I have adjusted my will and my Bank  is
aware.

 I have willed those properties to you by quoting my Personal File
Routing and Account Information. And I have also notified the bank
that I am willing to give that property to you for good, effective and
prudent work. It is right to say that I have been directed to do this
by God. I will be going in for a surgery soon and I want to make sure
that I make this donation before undergoing this surgery.  I will need
your support to make this dream come through, could you let me know
your interest to enable me to give you further information. And I
hereby advise you to contact me by this email address.

Thanks
Mrs. Jenny Bezos.
