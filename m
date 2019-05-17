Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36C4621742
	for <lists+linux-serial@lfdr.de>; Fri, 17 May 2019 12:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbfEQKu4 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 17 May 2019 06:50:56 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46407 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727689AbfEQKu4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 17 May 2019 06:50:56 -0400
Received: by mail-lj1-f193.google.com with SMTP id h21so5831058ljk.13
        for <linux-serial@vger.kernel.org>; Fri, 17 May 2019 03:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kEU6fWjzkzqv9SRv8NcfTyeO+J/oLvpwUjWxmmSbKOc=;
        b=gmJ8bSOwQEmlSl9bcD+oxfuvmzAUIZSt2m9B3Oxt+6B6+jfzENpi0Qwid1DnD8WFVM
         Nj04YDneWTocnxOtGJH/d1pnOpM0qtLQcv7Dzc0u/xpWthBACmgevIRmaWtigboPJGt1
         BdWnAi9YjL5WD1FfhaRA54D+hKxlI7w1lgZC9EX5vnQH9NTWUqsIeTOvgVyEnXwkJ62Z
         9mx6EU4tfLRRvbC9/O1832T2sAWNU+ljuu5GEZp/ZI3gXji793diepJ2trijF1o42MXs
         cZ2GOx/34GYuAzVO/HlQIMBaW1wlvJfHT3a9mbA2RCQY/mcP+AjtI1bzYb0Sk31rr3vF
         8k4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kEU6fWjzkzqv9SRv8NcfTyeO+J/oLvpwUjWxmmSbKOc=;
        b=EAsOzT1KouR1bIsxXZ3Fyk8YrB9zIJLvETrBjTiRhgtkh9WtBE+/79Ly4RXACtgrPO
         NjLtfH+laZmqcpsVt7c3zFLAVPO9fEJACJZN8begBnZ/2OFMcihZGH7mCOWoyR6TNmh0
         55t3uRvmblbQ38dPtDqngmu70XJcw7ZHWRLYJUD9hmnFuu6EOiwisc7Tzq46BlSmyA8L
         wBlsEFU/PFTb6VRdyP+WQvB5uTb6EBxg476ocMDcBNXKZYmXRMquyutdI5FroKm+YzpT
         jOq9IpRUKyzPt+iwj/G0qL18y9yK4ZiLRH96UVLKkBJ7w1UywmTZx869XXHtELq8t8hZ
         5jdw==
X-Gm-Message-State: APjAAAU8m8c156cTurf0UpFOx9QrKwJqVanqsKcb9Foy04/ehuCtP7Dk
        z5aMwj7FI55A8WnLVEqx8czI6m/hWfOs+6GUAICZxSef
X-Google-Smtp-Source: APXvYqy0YhjsEq2M9raFUg0ZSJZei8ocmMjCtvd2J906CaHcAlFT492j3Wc1CJjCagx7mEdwLCRW6XKDyUp99443Xg8=
X-Received: by 2002:a2e:8956:: with SMTP id b22mr20972607ljk.134.1558090254931;
 Fri, 17 May 2019 03:50:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190517100138.12910-1-s.hauer@pengutronix.de>
In-Reply-To: <20190517100138.12910-1-s.hauer@pengutronix.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 17 May 2019 07:50:46 -0300
Message-ID: <CAOMZO5Dr_4re5FZTgAwURKvLHwM-8Ae6EZ6uk8WmuEpy+sX5Zw@mail.gmail.com>
Subject: Re: [PATCH] serial: imx: remove log spamming error message
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-serial@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, May 17, 2019 at 7:38 AM Sascha Hauer <s.hauer@pengutronix.de> wrote:
>
> Each time the DMA engine signals a transaction error the driver prints
> a message at error level. Getting transaction errors is pretty much
> expected on baudrate mismatches and the correspoding error counters
> are increased in this case properly. Remove the error message which
> is possibly repeated at a very high rate which can lock up the whole
> system.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
