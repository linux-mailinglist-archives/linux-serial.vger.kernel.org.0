Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3732711833
	for <lists+linux-serial@lfdr.de>; Thu,  2 May 2019 13:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfEBLdN (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 2 May 2019 07:33:13 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]:42454 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfEBLdN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 2 May 2019 07:33:13 -0400
Received: by mail-lj1-f178.google.com with SMTP id r72so1826173ljb.9
        for <linux-serial@vger.kernel.org>; Thu, 02 May 2019 04:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qVFah4rxlea4NvGzxcSgojiQwwje8YG+C0Gi7vR3PU4=;
        b=qvYK+d96O9hSEJNMT5PrNc2noLhObQhQyz5iCmSKFY48dHUvsqA8cRA5HUZO/y+Ung
         /i84StLm1NoVdEcepXGbhS7zs6OMXY2mNijinSL4FNREoIFDpsTnMEi1qT5I2tYUxZ3U
         vfgriEJnqbsorahCFZcmhX6CtW1v2qKnZ1edMnts35/myWqcHB6neifD+zdhyOiY+TMU
         W6FykYjKcc3Mj1LC0bu84pxdltf7C1vDaB5ddQdvej3c++p+1GigD5dPc6a9hcL6lR+J
         CsCozwSSQEy7fxV9T2iZa+5E9mWchOr5xGNO3GLvaRQR9sX1paxcYkdKg+kmBnyLUM5s
         vtLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qVFah4rxlea4NvGzxcSgojiQwwje8YG+C0Gi7vR3PU4=;
        b=OBW3+0vv4l9ZsUeuxvjoq6eCWH5IpegCFKIMxN6aW5mQnE9ehqtWthGomFUNojo1kL
         ICJkeo6BlyM6fNNjem8PzGS0LL+85/kHC5M524f86zrZV5U9cuXWx5JlSGk2pZ7/9GO0
         hUe2Y4mbz3HeZZ15sMTM28oZ4w6WWZQ/3OiWnwmXDPfvKG/KrzWGkmQPjXe1sw+Kx6Cp
         LHV3BY6RgOA4BOYomLqoRMQNn8FcqbsmH9+0gndE528OD3PFy4ToJxbtRZshzRitTQC2
         51z6Ea5Sm4FDKBnDhOnUS+Mp781pLE51pY7hn2T2cDVaACGrIYTVocGUHAi14ulvr/7y
         ikLQ==
X-Gm-Message-State: APjAAAVRr2lGfIZ9vHNzraT/ekt/UozpmHTlQfmhWbmYOCDLeLEmLsc2
        43i9JGjarDTeyBrQj4R4nevlVA8lum4I1g7fqs8IBhk5
X-Google-Smtp-Source: APXvYqxVtYv6Z9kKqgxvj7kWOQzQyAL1jeXr8qe2xzCHj6I4vWt17/m4tdEEzeSCQ/by0c6QzB4D+SIsxSbC9lhs7lc=
X-Received: by 2002:a2e:7318:: with SMTP id o24mr1502267ljc.138.1556796719898;
 Thu, 02 May 2019 04:31:59 -0700 (PDT)
MIME-Version: 1.0
References: <kcis.DC82F67FDB724ECD9A98DE07DACAC907@DHPLMX01>
In-Reply-To: <kcis.DC82F67FDB724ECD9A98DE07DACAC907@DHPLMX01>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 2 May 2019 08:31:54 -0300
Message-ID: <CAOMZO5DmeaxZTvOLeJrvb8_YbzTuYQVUZhLU1z2s-tm98gPf1A@mail.gmail.com>
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

On Thu, May 2, 2019 at 6:40 AM Christoph Niedermaier
<cniedermaier@dh-electronics.com> wrote:
>
> I have tested the patch with kernel version 5.1-rc7 and I could not reproduce the loss of characters any more.

Excellent. I have just sent a formal patch.

> Couldn't it perhaps be better to name the define SW2ISO_IMX6SX instead of SW2ISO_IMX6X?

Yes, I have changed it in the forma patch. Please reply with your
Tested-by when you have a chance.

Thanks
