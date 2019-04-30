Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8EBFCFC
	for <lists+linux-serial@lfdr.de>; Tue, 30 Apr 2019 17:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbfD3Pfc (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 30 Apr 2019 11:35:32 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]:39180 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfD3Pfc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 30 Apr 2019 11:35:32 -0400
Received: by mail-lj1-f178.google.com with SMTP id q10so13215535ljc.6
        for <linux-serial@vger.kernel.org>; Tue, 30 Apr 2019 08:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dbHSEqNDiOxiHzZiYNZUUpwTRk0HKkvunAYxy9ES2/8=;
        b=rseMb/TMnUkjY/Q1nBBHmXfBRzen2JNFiVyu7sAXB7R7vj4iaHt6pQ+2mgJnacTZiL
         YeWYW6d7Ljw/fsDRz6vN0WECs6Z09eIpm3XY8u3otZz72BVIDCdvcIZl0NCiO5LmWcVz
         P0IW97FTbdE7o0QXblhwygTtnZ7/3ADIwx3RnHZEq9A1CEPbGQ6crn8qzoZSZ8+36Crt
         k7VBVljrq7PkGaYO6t8rHXiS+JHKPwqaKAt8FaljDfQCSf3RZqGvle/jSwe8oU0iEmt7
         3dfPOLHyu8gQpgNQ+HCwnpIlwsRUzkuZ9pBwUlUUuMekcDoAhQBszS5j4yu/JNA7GG80
         pJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dbHSEqNDiOxiHzZiYNZUUpwTRk0HKkvunAYxy9ES2/8=;
        b=OpDzlbI3EYOD1p3VAY6HYHHos5/svAkyUwK0NxP91ZbLqRSm98vqVEqcci8xxKTXwN
         27KOZ1qsT/hlAZSWxQsvGDemsqxaxwbyBx7TezEFWQgUvRDI1uo7Z6pamECk4aypjUIu
         ELTJ+Yub8tQM8r8xDiMc87KCGhqJTySyBxyX5VwnUv58aINmRkSgrEiEee85bM++YrpH
         RyyXkgOLgequUkPlZ+WMdK5TIkQmlS/YJYDTpRcmJqHhOjNsfMI47VZNFqIY6I2edJ0m
         ywVYG/6dLSH5j3c0+87fXg0TxWsVJpyigrGaXqQ4nokbuF7AQ6JxYf3TQ8wG+IXxYNBI
         0pug==
X-Gm-Message-State: APjAAAWRiYoJB+wwC7E85PV8+WXNcacsHkLbl8ZQoPv4INH/5E5QRSIg
        lsr9Zd5eglqA1X4W4ULiCAcOcK7izuv5Lse6ecY=
X-Google-Smtp-Source: APXvYqy70rrpqiD3zNRcskZueJKPlnS7E1HY0wIxZYJ3X0k88dn9bOeW8SVy801mQKldub9s61qt4ukXhfh956Wk7ik=
X-Received: by 2002:a2e:9753:: with SMTP id f19mr38837420ljj.54.1556638530065;
 Tue, 30 Apr 2019 08:35:30 -0700 (PDT)
MIME-Version: 1.0
References: <kcis.E7DDD7DFA27C49D7987A7EAB797CB891@DHPLMX01>
In-Reply-To: <kcis.E7DDD7DFA27C49D7987A7EAB797CB891@DHPLMX01>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 30 Apr 2019 12:35:21 -0300
Message-ID: <CAOMZO5C=E461yvHJ1PS7JE_ivS1cn82SKT2vvFDOjHqUnZUqaQ@mail.gmail.com>
Subject: Re: cpu power up timing changes causes UART rx character loss on imx6ull
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Christoph,

On Tue, Apr 30, 2019 at 11:10 AM Christoph Niedermaier
<cniedermaier@dh-electronics.com> wrote:
>
> Hello,
>
> I have found out that the commit 1e434b703248 ("ARM: imx: update the cpu power up timing setting on i.mx6sx") causes UART rx character loss on imx6ull.
> The commit is designed for imx6sx, but it also changes the cpu power up timing of the imx6ull, because function imx6sx_cpuidle_init() is also used for imx6ull.
>
> After receiving of 32 characters correctly, the following characters 33-36 gets lost if there is no delay in the transmission.
> I connect the imx6ull with a native PC COM port.
>
> If I revert the commit I will receive all characters correctly.

Thanks for the report.

It seems we need to change sw2iso only for mx6sx and not for imx6ul.

Could you please test the following patch?
http://code.bulix.org/crpbf9-684699

Thanks
