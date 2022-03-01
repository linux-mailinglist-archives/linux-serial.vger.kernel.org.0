Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93544C8C33
	for <lists+linux-serial@lfdr.de>; Tue,  1 Mar 2022 14:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233990AbiCANDf (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 1 Mar 2022 08:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234890AbiCANDe (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 1 Mar 2022 08:03:34 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85B65FF2E
        for <linux-serial@vger.kernel.org>; Tue,  1 Mar 2022 05:02:52 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id bc27so5470232pgb.4
        for <linux-serial@vger.kernel.org>; Tue, 01 Mar 2022 05:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=xVJHepNq93ePmAbCv1LHbdOWJcqWYQh8v11fr0KUdVw=;
        b=I9+1Zbt0ximD+EfMcIUx3a2l1GIvD6ikd2vWhHQZyGSrsUnAipgBmBGqwkFszTbXbS
         ChKWrg/ujsdeRWu0pTksl/OwARrCKdw6mTc5U2z0E0Jf9Q+830QEiTK4w7DaloN7Pkoh
         nOhY4NVX44D1U/vDoZRtLWHVkchHcMeaIkqUfdOjGK3jPkmRHj2ppVm1CwLeIUIHt/z0
         LelPvGX3XDZG4NRmAU9iuuAJqG8Rj37VwQ2/X+5mtGBiPqQa3ycAs3FR3ZqIaVzBBDKG
         eDW+GskCJ2TkTodwh583qLOSIFzqwxdwiKIenbb1HW82m8AiBJ8IbKAIq4HyUG3rvlpC
         7r/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=xVJHepNq93ePmAbCv1LHbdOWJcqWYQh8v11fr0KUdVw=;
        b=XSCLcGLQcd0Cb4RzALp2gwwzEjQZ6TKbVqh64Es3Uc2NCJ/w71nvARPfIxab9pJR2C
         F4ORDCbivITKOjMqq+p+TXP92R961D5Ur3R6btrSc6CK+d89psI2JQW+x7P6Kjd+N7Wh
         kyphMOZDT/VbjBdTpkmvsIU9dVgpKRTH+g6lv3HfFHEKR7kY+p3G06j78BGGWOyVRvPQ
         IKzdDsmP0UGbkUuKPy+JKJizXRLVIXRzsJQbL366Iig+JCt4YQI3XlYP5lSRXX0qEW+a
         XiIzWWmNe4UUIxDeMUGjMWzBTXqroa7fLyV1iJ2thTTe7sQYN0nus2/mmuYqsLrRMMQP
         Z4ug==
X-Gm-Message-State: AOAM531t+qpZjbjtWug3nemBLcjEe1VUvQWAjr6qRLz9LbxXhFnfdui3
        Ew1/BNBKAvOl9+bI3KwmW8IG1WTJfce05q16fUc=
X-Google-Smtp-Source: ABdhPJys9IiFYGA9Gi+Dczx11GW/scR9xruH4Q88+a/H9Ega/2PnKW9PJf96gUfOM3wyqSklbKU+dtW76pMDESbAwJs=
X-Received: by 2002:a63:2c53:0:b0:373:7234:adf2 with SMTP id
 s80-20020a632c53000000b003737234adf2mr21494162pgs.111.1646139771873; Tue, 01
 Mar 2022 05:02:51 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:90a:4ec6:0:0:0:0 with HTTP; Tue, 1 Mar 2022 05:02:49
 -0800 (PST)
Reply-To: lilywilliam989@gmail.com
From:   Lily William <umarsalehtmw@gmail.com>
Date:   Tue, 1 Mar 2022 05:02:49 -0800
Message-ID: <CAHup-S5p26kZccVy_y2N2Rwwfuu8C1J2k1nOCjAqsphfAFwXZQ@mail.gmail.com>
Subject: Hi Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:542 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4376]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [lilywilliam989[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [umarsalehtmw[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

-- 
Hi Dear,

My name is Lily William, I am from the United States of America. It's my
pleasure to contact you for a new and special friendship. I will be glad to
see your reply so we can get to know each other better.

Yours
Lily
