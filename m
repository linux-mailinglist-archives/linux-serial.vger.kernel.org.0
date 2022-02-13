Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC1C4B3BE2
	for <lists+linux-serial@lfdr.de>; Sun, 13 Feb 2022 15:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236617AbiBMOrP (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sun, 13 Feb 2022 09:47:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbiBMOrO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 13 Feb 2022 09:47:14 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44EB6423
        for <linux-serial@vger.kernel.org>; Sun, 13 Feb 2022 06:47:08 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id l19so19060404pfu.2
        for <linux-serial@vger.kernel.org>; Sun, 13 Feb 2022 06:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Xmjq8muvZH/FL73jrL5x6SrlpvY9Sys6n8v/EYhDMxo=;
        b=jPE6/gM9Ybm6uwSKeoT3kIx4QTmNCRn5YR7g14urorFyz0wOLNJMHevG849ugIxYm8
         SVMr+kBrKLgOjU4ZJLFg3m4EsovmW859rosNNhfnF9ul+Qxc1Va7mS/9uqd7/wWzRuQa
         Xkw0LdyQymnbPRBILwQ5TXcDNOSyQX/qs0Gtd1GKWijebxgWQocuUzjLvPCgBJW94cY6
         fRUPoy4csqkORcqHvhm06ZX/ue4Aw/6OVe/pDu+9AnqeRcGAkOW8J994tm/lY1p8xrtj
         MvIA3EDLmn8/i8xd0cGTtNDuXunG8dIp79RwLVrHxtw4K/qkHua/aqCsmHmES4X1YrSJ
         1srA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=Xmjq8muvZH/FL73jrL5x6SrlpvY9Sys6n8v/EYhDMxo=;
        b=WUQJn4nI2jN/OBuWFo8vxzT7n7Z/3WxmJI+C4ddRuvH+Z9bcEUJ6tafemRjafWr8cs
         9+fwmd0Xx85TKerB4L2nFiw9NwahgW6q6FqsQXlkwNQN64xInq/6n+BW8GlVclTYQfVK
         r3oEk8ymL2z4xmGcKLwshbs/pBRpJk3MI8N9xoLdSVODctSzPzAkG+C4NRFGWR6BAF0s
         oYii/5Ob9x7R/SVNoz6x4lS1awB9kEbao7kwgjahQxgNjnb9ruRfkZFzOtUXuwqGd+rG
         Tp5WcPjdPELDfn7RAJyg0dzQa6jTfGnKtLgib9lePftJtp7tq2R7uvEPTfEZriOelitq
         fDrw==
X-Gm-Message-State: AOAM532LUbmJ5tKqM4Lruor4dUBiH4C389sHn6gOcfgWu4xqzyICLdfc
        6tqezCkjQGyjy4/GmAB3E8SuQi54JskFzlvxS2w=
X-Google-Smtp-Source: ABdhPJzvHxOIQUZZ53uYwJ0rkUjnTxogMuTzSzq0OEz1dQR3DjVtDoEOR4r2NTEbh5cEDFajk3WWs3HfyyRAqKIhM/Q=
X-Received: by 2002:a05:6a00:b50:: with SMTP id p16mr10332564pfo.22.1644763628288;
 Sun, 13 Feb 2022 06:47:08 -0800 (PST)
MIME-Version: 1.0
Sender: chervronrecruitment962@gmail.com
Received: by 2002:a05:6a10:fd94:0:0:0:0 with HTTP; Sun, 13 Feb 2022 06:47:07
 -0800 (PST)
From:   "Mr.Aliou Traore" <mralioutraore44@gmail.com>
Date:   Sun, 13 Feb 2022 14:47:07 +0000
X-Google-Sender-Auth: wqs3k4LVbYRAJuGH1Ne91ZkeQcY
Message-ID: <CAKdFRE4pQPAR=6kz=csg3yX3im_N8LfWGThNcyNBd0BK3qC5Tg@mail.gmail.com>
Subject: From Mr.Aliou Traore
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=3.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,MILLION_HUNDRED,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello,

I am indeed sorry for contacting you through this means. However, I
assure you that it is discreet and totally legit. I am Mr.Aliou
Traore, one of the Roch Marc Christian Kabor=C3=A9 top bodyguard Presidents
of Burkina faso that was overthrown by soldiers in a coup on January
27, 2022.  I am sure you are aware of the political situation in my
country, Burkina Faso. As a result, Gold belonging to the first Top
bodyguard of Roch Marc Christian Kabor=C3=A9 that was killed doing the coup
on January 27, 2022 was with me and I have moved them to the bank and
converted Gold to Cash.

I need your help to secure these funds of ($10,200,000.00 Million
Dollars Ten million two hundred thousand dollars) I shall explain
fully to you the position and your stake too on receipt of your
positive response so we can proceed.

Or you can delete this message if you are disinterested.

Regards

From Mr.Aliou Traore
