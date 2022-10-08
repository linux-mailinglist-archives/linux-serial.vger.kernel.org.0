Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C286B5F830E
	for <lists+linux-serial@lfdr.de>; Sat,  8 Oct 2022 07:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiJHFJl (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sat, 8 Oct 2022 01:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiJHFJj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 8 Oct 2022 01:09:39 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3BFCF0
        for <linux-serial@vger.kernel.org>; Fri,  7 Oct 2022 22:09:38 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 81so7808043ybf.7
        for <linux-serial@vger.kernel.org>; Fri, 07 Oct 2022 22:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bfSQPr3TgW686EX+LeFlxkPdbXkbKU9NPtsgw9BN+NU=;
        b=iOm+MuEYUUXlnr78hrQKDk0CS1w8hIhOvK/NaWTosEkL+b10zLg9EdIxYwWGYK35RA
         GfXcfupdsbgTakUblapZpxHFI4YZLuE5p7XkqF31ho+snIsX+OI1leUNeXlnKc1D3b6m
         LmIVA4d+4U08s0NRB7vIGmWhhgDp1b71aRQrKWOUKYPOvZd49/hRIFDoaZ1vBgDZ5R0N
         Jg49ewBCozXzj+pJ44AyXfSbXPoE0JpDFgIekWwTGAaHGcqvOETlC8Vw+yzq5Lx9kRa4
         HPCLzcCycp9RR7B88S+Z25P0HxeaqZU0Nrqb6wGtcocgudrVeA6sReehEzfrL8/B7gdq
         qipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bfSQPr3TgW686EX+LeFlxkPdbXkbKU9NPtsgw9BN+NU=;
        b=W9+RuyuA95OWqTWx7nWzwY0JTuKj0zPnFmQbgZOjiDtZIEE/OhY9MW+x3C3Xt6jcl1
         F5dMF3VH81o5YlApB/CFjdZNBiA9sTDQwTKwJF53NJLW3sBr9QeTAThRB64EbuZ4lrHR
         BtWftKzHilhnolwCLNQ4IY0LEDgJYFyQ+FkQWm93IsHQ9v+YwGCVYGBaNq+4CRaKbijN
         uSY7MaA3mQyZvMxmABWcRmwiuBGzx9cL0zWfIgcl3jxn7P/xCDLCnsMdc78/mgaOGw3y
         MVfM8WFfDxfiLSR2ps7Zp+3RaeK18PH1K8powGanpiUhxFP7wVG9kqycXqi020ESGvre
         j6/g==
X-Gm-Message-State: ACrzQf0CYlNGFPZzkbE8oQ8p5YNVgNhncS9hD/UKMbhWeORsXLgUPO4Q
        B+kVbo75T8n5lR/oTMd+zE6x8yv7Ug411rNmOYI=
X-Google-Smtp-Source: AMsMyM6drQ+Whss3IR9qnj0KdWl9slnzQdxDAbNKAru3mIDONtqm9MEWS0HVMLiWSpW/n+omtuKWcCAC14iF8+i/7ZA=
X-Received: by 2002:a25:dd85:0:b0:6b4:26c9:5bf5 with SMTP id
 u127-20020a25dd85000000b006b426c95bf5mr8143884ybg.640.1665205777286; Fri, 07
 Oct 2022 22:09:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a81:4009:0:0:0:0:0 with HTTP; Fri, 7 Oct 2022 22:09:36 -0700 (PDT)
Reply-To: korblgeorg1000@gmail.com
From:   Korbl Georg <maaaaaaaaaaaaaaaaaaa12456789@gmail.com>
Date:   Sat, 8 Oct 2022 05:09:36 +0000
Message-ID: <CAGS7QOENdym3fF45o-0-uAb5eAbnkHvh_vngO==GY8WV6mtWUw@mail.gmail.com>
Subject: ///////////////////////Good dey
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        FROM_LOCAL_HEX,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b30 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FROM_LOCAL_HEX From: localpart has long hexadecimal sequence
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [maaaaaaaaaaaaaaaaaaa12456789[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [maaaaaaaaaaaaaaaaaaa12456789[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [korblgeorg1000[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Please. I would like to know if you received the message which I sent
to you two days ago concerning humanitarian aid work.
