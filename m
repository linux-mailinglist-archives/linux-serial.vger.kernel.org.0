Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDF280396
	for <lists+linux-serial@lfdr.de>; Sat,  3 Aug 2019 02:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387650AbfHCAwl (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 2 Aug 2019 20:52:41 -0400
Received: from bonobo.elm.relay.mailchannels.net ([23.83.212.22]:22500 "EHLO
        bonobo.elm.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387633AbfHCAwl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 2 Aug 2019 20:52:41 -0400
X-Sender-Id: dreamhost|x-authsender|robert.middleton@rm5248.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 4A4795E1A5E
        for <linux-serial@vger.kernel.org>; Sat,  3 Aug 2019 00:52:39 +0000 (UTC)
Received: from pdx1-sub0-mail-a28.g.dreamhost.com (100-96-84-65.trex.outbound.svc.cluster.local [100.96.84.65])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id A5C585E1209
        for <linux-serial@vger.kernel.org>; Sat,  3 Aug 2019 00:52:38 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|robert.middleton@rm5248.com
Received: from pdx1-sub0-mail-a28.g.dreamhost.com ([TEMPUNAVAIL].
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.17.5);
        Sat, 03 Aug 2019 00:52:39 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|robert.middleton@rm5248.com
X-MailChannels-Auth-Id: dreamhost
X-Skirt-Bubble: 4f784cdd65a8a810_1564793559123_327339892
X-MC-Loop-Signature: 1564793559122:2727512266
X-MC-Ingress-Time: 1564793559122
Received: from pdx1-sub0-mail-a28.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a28.g.dreamhost.com (Postfix) with ESMTP id 10D9883A16
        for <linux-serial@vger.kernel.org>; Fri,  2 Aug 2019 17:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=rm5248.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=rm5248.com; bh=GkS9vutrTvPrDu94PEWu/XRKolI=; b=
        Mq7g1yZPkiVpBFUm5WxUrKTM6t+eJREc8R0YJHhIwYNY2IE+4aP25wzUDUi2DdYD
        RD0iDnYBBJd/QN+U5bksUTCwoBdU5dtMx7wKuHZp7zBh7obV6WzVM4rqG83NjkBk
        gK33XJjmyH1AxxmQv6r6FrLXrpBZtVNFo5uq0n87y4g=
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: robert.middleton@rm5248.com)
        by pdx1-sub0-mail-a28.g.dreamhost.com (Postfix) with ESMTPSA id D8BF283A11
        for <linux-serial@vger.kernel.org>; Fri,  2 Aug 2019 17:52:36 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id j5so151862701ioj.8
        for <linux-serial@vger.kernel.org>; Fri, 02 Aug 2019 17:52:36 -0700 (PDT)
X-Gm-Message-State: APjAAAVRj/wKSU+GZrZ3GPCAWwOL/9NTcABFHh2zdBoVZGGpZVm+dYiM
        G2lnze5qe0m8ztt/rOoja78WCpsuLIjNzlG2+f0=
X-Google-Smtp-Source: APXvYqxBmQG4pw2wpyIQmjjZ8WhDUiYNQPU2ru5lgHPf27/r2Yur7dpK4iMKYIh7OQ1xM+MByMTf2Wo+r+yEqvAjuO4=
X-Received: by 2002:a5d:8411:: with SMTP id i17mr99617884ion.83.1564793556104;
 Fri, 02 Aug 2019 17:52:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190802153422.11131-1-andriy.shevchenko@linux.intel.com> <20190802153422.11131-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20190802153422.11131-2-andriy.shevchenko@linux.intel.com>
X-DH-BACKEND: pdx1-sub0-mail-a28
From:   Robert Middleton <robert.middleton@rm5248.com>
Date:   Fri, 2 Aug 2019 20:52:25 -0400
X-Gmail-Original-Message-ID: <CAKpcJVb6W+_VbPdYVB6fNpy5h=u=Dv_-AwZLuFZ8=Ypj=620rw@mail.gmail.com>
Message-ID: <CAKpcJVb6W+_VbPdYVB6fNpy5h=u=Dv_-AwZLuFZ8=Ypj=620rw@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] serial: 8250_exar: Refactor exar_shutdown()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-VR-OUT-STATUS: OK
X-VR-OUT-SCORE: -100
X-VR-OUT-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddruddttddggedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuggftfghnshhusghstghrihgsvgdpffftgfetoffjqffuvfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepgghfjgfhfffkuffvtgesthdtredttddtjeenucfhrhhomheptfhosggvrhhtucfoihguughlvghtohhnuceorhhosggvrhhtrdhmihguughlvghtohhnsehrmhehvdegkedrtghomheqnecukfhppedvtdelrdekhedrudeiiedrgeefnecurfgrrhgrmhepmhhouggvpehsmhhtphdphhgvlhhopehmrghilhdqihhouddqfhegfedrghhoohhglhgvrdgtohhmpdhinhgvthepvddtledrkeehrdduieeirdegfedprhgvthhurhhnqdhprghthheptfhosggvrhhtucfoihguughlvghtohhnuceorhhosggvrhhtrdhmihguughlvghtohhnsehrmhehvdegkedrtghomheqpdhmrghilhhfrhhomheprhhosggvrhhtrdhmihguughlvghtohhnsehrmhehvdegkedrtghomhdpnhhrtghpthhtoheplhhinhhugidqshgvrhhirghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Andy,

Correct me if I'm wrong here, but will that still work correctly?
That will break once the buffer on the exar chip is clear, but there
could potentially be characters still in the kernel
buffer(uart_circ_empty would not be true)

-Robert Middleton

On Fri, Aug 2, 2019 at 11:34 AM Andy Shevchenko
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
>  drivers/tty/serial/8250/8250_exar.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
> index 873aa6b0c2f3..f81d5c4fa232 100644
> --- a/drivers/tty/serial/8250/8250_exar.c
> +++ b/drivers/tty/serial/8250/8250_exar.c
> @@ -169,19 +169,16 @@ static void xr17v35x_set_divisor(struct uart_port *p, unsigned int baud,
>  static void exar_shutdown(struct uart_port *port)
>  {
>         unsigned char lsr;
> -       bool tx_complete = 0;
>         struct uart_8250_port *up = up_to_u8250p(port);
>         struct circ_buf *xmit = &port->state->xmit;
> -       int i = 0;
> +       unsigned int i = 1000;
>
>         do {
>                 lsr = serial_in(up, UART_LSR);
>                 if (lsr & (UART_LSR_TEMT | UART_LSR_THRE))
> -                       tx_complete = 1;
> -               else
> -                       tx_complete = 0;
> +                       break;
>                 msleep(1);
> -       } while (!uart_circ_empty(xmit) && !tx_complete && i++ < 1000);
> +       } while (!uart_circ_empty(xmit) && --i);
>
>         serial8250_do_shutdown(port);
>  }
> --
> 2.20.1
>
