Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1294C865
	for <lists+linux-serial@lfdr.de>; Thu, 20 Jun 2019 09:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbfFTH3E (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 20 Jun 2019 03:29:04 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36965 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfFTH3E (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 20 Jun 2019 03:29:04 -0400
Received: by mail-ed1-f67.google.com with SMTP id w13so3243046eds.4
        for <linux-serial@vger.kernel.org>; Thu, 20 Jun 2019 00:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=muFIBU04nedkMvW05G83il5jWwKX3i1QXu16v8H8Fxk=;
        b=p8I9tcPC11GtW9EovVAar8TDLl6XYxD8sbn9kbpvqBNmfGCkXX4t5mNRpp2rcKvEOb
         DhQOjxwlvFY/naFz/TG/p18EGM5flCdJZmegqonseBPL2XH8YXyR8VZV/PbVCVrAMqon
         hz6V067gQOvzg6EexqsPhLZs9zt0pDlU6T/RfXAtSPGE4dSQYyIp9/TajPo8yVwGlMcl
         L0WoZ94ISgldJ8zHC+0u0s/yrl0InjNxXHBrklbE+4O01jGk6sPYmXxIiTe5JGanwE8g
         P8KradBKF8u2VlaZoLPf4et5p/m0IjRqZ9kXbWKteuXvESOtJQo+oi7RrMFm9NJquNI5
         GAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=muFIBU04nedkMvW05G83il5jWwKX3i1QXu16v8H8Fxk=;
        b=sse9B8NDdygFDLGMnDbwtdWMqw0V1i9349gpND89e6es4hJwkmkvfKF0NW9SYgqpyq
         CpKY7EnGtPn8C2HMbWPOzn+gJcBNzwvQZDJpt6eNeK7EqrDIDDid9Yao+pOd3hs0Xuf5
         pY56Qreg+h9TtKJke95xk5jHB0HuNY0ORLg5KhbgmM1aOhLQpWH/dw2GiPyhlwOf665e
         P9fYi+y3VD0B4/1+7JVBThTLg1GdZJs48/K1AWpZ3TRAvY4BPYGckXgf8lOYHC4sWGMI
         WtWpEZrZVP9CJh3bx5nGAEqfrV8xAQWiCUT4BC8iXOV8pI1rUa4HWaRIyT+iGvg1gzEz
         6pwA==
X-Gm-Message-State: APjAAAXJ3l2Jt2m6D9Mt8T6fY/xEqKXDuTkKWTFD8eaSXm/bHkw0Azym
        jSw3ZqAG7qzybGRUrgrsh4djK+NqpiUSg6vD9s4=
X-Google-Smtp-Source: APXvYqynwu6mDH4i459p5hWpeH9ZcrZc4yf19+UNKayuPFwJMwnTi1sLA/SlUil8mlfJt8HDIP9qU/X+iX8edN6l7mk=
X-Received: by 2002:a50:972a:: with SMTP id c39mr102495631edb.46.1561015742643;
 Thu, 20 Jun 2019 00:29:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190619081639.325-1-o.barta89@gmail.com> <20190619112052.GD9224@smile.fi.intel.com>
In-Reply-To: <20190619112052.GD9224@smile.fi.intel.com>
From:   Oliver Barta <o.barta89@gmail.com>
Date:   Thu, 20 Jun 2019 09:28:46 +0200
Message-ID: <CALJK04OjK7=iQyH=1RnU9un=hZusMCbE-54-RMSdcRruE9j7Ow@mail.gmail.com>
Subject: Re: [PATCH] Revert "serial: 8250: Don't service RX FIFO if interrupts
 are disabled"
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-serial@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jun 19, 2019 at 1:20 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Jun 19, 2019 at 10:16:39AM +0200, Oliver Barta wrote:
> > This reverts commit 2e9fe539108320820016f78ca7704a7342788380.
> >
> > Reading LSR unconditionally but processing the error flags only if
> > UART_IIR_RDI bit was set before in IIR may lead to a loss of transmission
> > error information on UARTs where the transmission error flags are cleared
> > by a read of LSR. Information are lost in case an error is detected right
> > before the read of LSR while processing e.g. an UART_IIR_THRI interrupt.
> >
>
> Perhaps Fixes tag?
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>

Thank you for the review. I also thought about the Fixes tag but
finally decided not to use it. It is a simple revert, i.e. the subject
of the commit which would be mentioned by the Fixes tag is in the new
subject anyway and the commit ID is referred in the first line of the
commit message body. The Fixes tag would not add any additional
information. I also checked a couple of recent revert commits in the
kernel and noticed that many of them actually don't have this tag.

> > Signed-off-by: Oliver Barta <o.barta89@gmail.com>
> > ---
> >  drivers/tty/serial/8250/8250_port.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> > index d2f3310abe54..682300713be4 100644
> > --- a/drivers/tty/serial/8250/8250_port.c
> > +++ b/drivers/tty/serial/8250/8250_port.c
> > @@ -1869,8 +1869,7 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
> >
> >       status = serial_port_in(port, UART_LSR);
> >
> > -     if (status & (UART_LSR_DR | UART_LSR_BI) &&
> > -         iir & UART_IIR_RDI) {
> > +     if (status & (UART_LSR_DR | UART_LSR_BI)) {
> >               if (!up->dma || handle_rx_dma(up, iir))
> >                       status = serial8250_rx_chars(up, status);
> >       }
> > --
> > 2.20.1
> >
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

Best regards,
Oliver Barta
