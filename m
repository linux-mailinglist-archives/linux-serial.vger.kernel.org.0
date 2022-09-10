Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACDE5B43B2
	for <lists+linux-serial@lfdr.de>; Sat, 10 Sep 2022 04:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiIJCAz (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 9 Sep 2022 22:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiIJCAy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 9 Sep 2022 22:00:54 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4995C7E00C
        for <linux-serial@vger.kernel.org>; Fri,  9 Sep 2022 19:00:50 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id 134so1592768vkz.11
        for <linux-serial@vger.kernel.org>; Fri, 09 Sep 2022 19:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=B/bzVap7w2nbpPLUVaGrgo7Id2TJpqaHDpbbBhcEalA=;
        b=gKgQqD+SMVmL1T52pVA/kTkZ9J1hcU385nqjj+1JiScSZi4YzOErGKRklfMW3mtkSo
         7BahxzH/SF4fafDfdtk95E9VH2BbCCQsUsdqsTswEovOJvHuZQhrys9mIYw8vxsoNisR
         A04aSYyxmk/iaGSGATWvAn6WbOO/NeZ6j8NoFhDBKVwjjOIrf4jNGRKloldLTWSnhezM
         IRRF0LP3ruMJaP9kC2l48aMQyuiri1GZS/vHJt/Oa0KeHB7Sw6KOTrj28PBcZpZcaGow
         JesxPZvSHkdiL8CmqaLB2mEKpgXZ2/Ff8jmScf25m+mFfzQhWERMdKK/5Szal+aB336Y
         hdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=B/bzVap7w2nbpPLUVaGrgo7Id2TJpqaHDpbbBhcEalA=;
        b=guvHwyXQJtjXGbGC1J3T5Vk+4GBbiAAOfZrExBdWd4WkqFzZAv7G2WvhINurtIX27W
         IPeroKBARwilrambdZWWSmEY4fL3C7B9F4CKh2TcmID5gU4aV6T+9FAXqBBoA8WrTWQh
         YbQocznkMZj9UaA2ugqM9Nkipjz7uCcLbxrPKFkCaCgI9ERQxbxSHegWjehYOjyWwqiU
         +HOqYKy1OJmK3NvBdfU5qpYjOIK+lD1UOxiJtlWVmCaC7lQkZ5Ooj+LfjxmmOtyOHI5X
         PWK5fSNr+yz+gv4WJC1s+3qT0Z/+2A/HqRmTsoqfgobbMT1lzrsSscwqknBJ5AmqAmVK
         1srA==
X-Gm-Message-State: ACgBeo2oT1Ew688f+cguaBUfkgmAcgPUg7PM+mLIMlcHVZtCUfXeyQaL
        je+hFo1Bha57f93XYqgwjgCKikNFCB52+6P63gs=
X-Google-Smtp-Source: AA6agR5jF6nDIUflt8C7EdKHaSszyzaWXZpDP4oyZmaFmyKkVlqu+I1hPg4l5JAFhrgvip+HSyD0fomCu9Nt/h/lT4U=
X-Received: by 2002:a1f:9c52:0:b0:389:404d:44bc with SMTP id
 f79-20020a1f9c52000000b00389404d44bcmr6057953vke.23.1662775249283; Fri, 09
 Sep 2022 19:00:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:1a19:0:b0:2f5:5f8f:da6a with HTTP; Fri, 9 Sep 2022
 19:00:48 -0700 (PDT)
Reply-To: daviesmarian100@gmail.com
From:   Marian <ikoroezinne0@gmail.com>
Date:   Sat, 10 Sep 2022 02:00:48 +0000
Message-ID: <CALHpY0581f_8VuJwOuJDETqXsAQhxJ1ZAUGrYNRFht5ay0ft+Q@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:a36 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4998]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ikoroezinne0[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ikoroezinne0[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [daviesmarian100[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

-- 
Hello
