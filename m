Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD2281DDD
	for <lists+linux-serial@lfdr.de>; Mon,  5 Aug 2019 15:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbfHENtc (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 5 Aug 2019 09:49:32 -0400
Received: from egyptian.birch.relay.mailchannels.net ([23.83.209.56]:5962 "EHLO
        egyptian.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726620AbfHENtc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 5 Aug 2019 09:49:32 -0400
X-Sender-Id: dreamhost|x-authsender|robert.middleton@rm5248.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 7D03F1A2A98
        for <linux-serial@vger.kernel.org>; Mon,  5 Aug 2019 13:49:30 +0000 (UTC)
Received: from pdx1-sub0-mail-a97.g.dreamhost.com (100-96-4-69.trex.outbound.svc.cluster.local [100.96.4.69])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id C7FAA1A2C8A
        for <linux-serial@vger.kernel.org>; Mon,  5 Aug 2019 13:49:29 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|robert.middleton@rm5248.com
Received: from pdx1-sub0-mail-a97.g.dreamhost.com ([TEMPUNAVAIL].
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.17.5);
        Mon, 05 Aug 2019 13:49:30 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|robert.middleton@rm5248.com
X-MailChannels-Auth-Id: dreamhost
X-Continue-Name: 6566a0b640f81211_1565012970294_2588290853
X-MC-Loop-Signature: 1565012970294:2775304319
X-MC-Ingress-Time: 1565012970293
Received: from pdx1-sub0-mail-a97.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a97.g.dreamhost.com (Postfix) with ESMTP id 3B6877F7EB
        for <linux-serial@vger.kernel.org>; Mon,  5 Aug 2019 06:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=rm5248.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=rm5248.com; bh=hXrTs7NXfGAX4YqQeo1d7UNZS3k=; b=
        Hsgii4MMNwJzByWjbo7yoq0zsZJhtL1Gch1/7MHViH6Vz/Ue1Nuz9stiFTyrdETO
        Mp6c9izQw/QsHIvD0ATEy9T5pfCIHxXm6Vgzgg4KwLQd6x9cncWgyvHP+DGF8xp3
        2GiS6B40u+sN2LeHBW3kRb4hzVOPpfrGt8keUmstdTg=
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: robert.middleton@rm5248.com)
        by pdx1-sub0-mail-a97.g.dreamhost.com (Postfix) with ESMTPSA id 046D27F682
        for <linux-serial@vger.kernel.org>; Mon,  5 Aug 2019 06:49:26 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id k8so167462673iot.1
        for <linux-serial@vger.kernel.org>; Mon, 05 Aug 2019 06:49:26 -0700 (PDT)
X-Gm-Message-State: APjAAAXOZEzwA3hzNvIWQuckbuwTZ9fO8zYa6ln/60yy+Eda9l0O5SCg
        iYfBy2wPwNyot43wlmGpV74Eu0I2Zud3modyx/4=
X-Google-Smtp-Source: APXvYqycF+5chysjqGNCKWDb68GxI+mL8MhIflFlcgeQFjziuKFUabhWi7OCBS023J2NZObMpwFjS+5GU6R118BECPw=
X-Received: by 2002:a6b:ec06:: with SMTP id c6mr14940010ioh.198.1565012966219;
 Mon, 05 Aug 2019 06:49:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190805100518.9818-1-andriy.shevchenko@linux.intel.com> <20190805100518.9818-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20190805100518.9818-2-andriy.shevchenko@linux.intel.com>
X-DH-BACKEND: pdx1-sub0-mail-a97
From:   Robert Middleton <robert.middleton@rm5248.com>
Date:   Mon, 5 Aug 2019 09:49:24 -0400
X-Gmail-Original-Message-ID: <CAKpcJVZTy963y3TOXSYSBFVOpVTWEOyJKUYxv1pHNGz3Y1aPTA@mail.gmail.com>
Message-ID: <CAKpcJVZTy963y3TOXSYSBFVOpVTWEOyJKUYxv1pHNGz3Y1aPTA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] serial: 8250_exar: Refactor exar_shutdown()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-VR-OUT-STATUS: OK
X-VR-OUT-SCORE: -100
X-VR-OUT-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddruddtjedgieekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuggftfghnshhusghstghrihgsvgdpffftgfetoffjqffuvfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepgghfjgfhfffkuffvtgesthdtredttddtjeenucfhrhhomheptfhosggvrhhtucfoihguughlvghtohhnuceorhhosggvrhhtrdhmihguughlvghtohhnsehrmhehvdegkedrtghomheqnecukfhppedvtdelrdekhedrudeiiedrgeefnecurfgrrhgrmhepmhhouggvpehsmhhtphdphhgvlhhopehmrghilhdqihhouddqfhegfedrghhoohhglhgvrdgtohhmpdhinhgvthepvddtledrkeehrdduieeirdegfedprhgvthhurhhnqdhprghthheptfhosggvrhhtucfoihguughlvghtohhnuceorhhosggvrhhtrdhmihguughlvghtohhnsehrmhehvdegkedrtghomheqpdhmrghilhhfrhhomheprhhosggvrhhtrdhmihguughlvghtohhnsehrmhehvdegkedrtghomhdpnhhrtghpthhtoheplhhinhhugidqshgvrhhirghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Andy,

Unfortunately this will re-introduce the bug that it was attempting to
solve, that is ensuring that the buffer in the kernel and the buffer
on the chip are clear before going into shutdown on the chip.
Breaking at the beginning of the loop means that the kernel has
written everything to the internal buffer on the chip, but until the
LSR bits are clear the bytes have not been transmitted yet.

I'm not positive that the uart_circ_empty needs to be checked in the
first place; I had put it in because the serial8250_tx_chars does that
before stopping the tx, and I assume that there could be a potential
race condition where the kernel has not yet written all the data to
the exar, but the exar has finished transmitting all the data in its
transmit buffer(I am not sure how likely this is to happen).

-Robert Middleton

On Mon, Aug 5, 2019 at 6:05 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> First of all, boolean variable should be assigned with boolean values.
> Second, it's not needed at all in this case.
>
> Drop unneeded boolean variable and use 'break' statement instead.
>
> While here, change iterations to be more visible by moving the number of them
> to the variable definition block.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: Check kernel buffer first as in the original conditional (Robert)
>  drivers/tty/serial/8250/8250_exar.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
> index 873aa6b0c2f3..8f9baae92831 100644
> --- a/drivers/tty/serial/8250/8250_exar.c
> +++ b/drivers/tty/serial/8250/8250_exar.c
> @@ -169,19 +169,18 @@ static void xr17v35x_set_divisor(struct uart_port *p, unsigned int baud,
>  static void exar_shutdown(struct uart_port *port)
>  {
>         unsigned char lsr;
> -       bool tx_complete = 0;
>         struct uart_8250_port *up = up_to_u8250p(port);
>         struct circ_buf *xmit = &port->state->xmit;
> -       int i = 0;
> +       unsigned int retries = 1000;
>
>         do {
> +               if (uart_circ_empty(xmit))
> +                       break;
>                 lsr = serial_in(up, UART_LSR);
>                 if (lsr & (UART_LSR_TEMT | UART_LSR_THRE))
> -                       tx_complete = 1;
> -               else
> -                       tx_complete = 0;
> +                       break;
>                 msleep(1);
> -       } while (!uart_circ_empty(xmit) && !tx_complete && i++ < 1000);
> +       } while (--retries);
>
>         serial8250_do_shutdown(port);
>  }
> --
> 2.20.1
>
