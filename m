Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 062862959E
	for <lists+linux-serial@lfdr.de>; Fri, 24 May 2019 12:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390201AbfEXKW2 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 24 May 2019 06:22:28 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34369 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389448AbfEXKW2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 24 May 2019 06:22:28 -0400
Received: by mail-wm1-f67.google.com with SMTP id e19so1588189wme.1
        for <linux-serial@vger.kernel.org>; Fri, 24 May 2019 03:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VckbwsaqxCWYJ3+xkcRYBwTkgfTC5IcPs57wTWTAXlc=;
        b=u0JJueyGsa3sYwitkkv0S49MpHD6CbQWp0D0B+MIY1kMwVyB/OVtCfQbBIGD/GTTrt
         InBUM4zEEHEECDSfCfvDZ6TMvDBkUaVknlM8QIU8PjXd7BSs5ajksj22QW6GfkWVyrWF
         PRsCTLJPIlnQnDdBNhdR3SPqZqscL8eM6idyPaN8ojC7f8o+4U/XRmzf1Bo5HV8PCRMI
         4+pnTfU3j237lc/esMAZuUezpL4bjrKrRCwEB/ImEg5Gva9EgbzkpUDc/IYG5twbzX9M
         QTYIf9bowHEI5JTW/siqZqrvlcm9kIhw/aF+IcC9hk+29gLUG42qsOy636JrwgwxKizd
         BkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VckbwsaqxCWYJ3+xkcRYBwTkgfTC5IcPs57wTWTAXlc=;
        b=sXA++ITCcttZEXLrurqVUsCHN2XwH5cdZl6UjlMj6eA630731JNaXQkEwWFYxJ1BQr
         nHNkoFdVKhT0qVOZUTBWy1LaTo5rVhOHdh96kxnyP9ZZjOKOTeJUqXDi2LwqB3oXKRHy
         A8Kv8l5TG9Kf6RWX/w9F9dpAP624+7arbPTGcLohrPPW9q+RVSWiz5ZOzIegH9gt8qXn
         LyDTM3uxKeNaRamKMpgMcYL/4dYmmfxuv4p7lJqpKLiGX6NjN+v2VFl9TaZrdYY1v1Hh
         rVVXLz501Bnp2OLplxclM2dvi51kHZVGOz4BXcs7X6Fh29MDzxdpLh/0vW38MIm4O0LC
         32sA==
X-Gm-Message-State: APjAAAV7KPVqQ8DqhtwxEguGKcn/tWmTZGtO+tsJU7Iq29fNwGP85FeV
        DMD1ypopUo39mepKft2fVoV1dHP1TBn6RZXfau19Dw==
X-Google-Smtp-Source: APXvYqxjyztjd3Ij/vKYotk7k6oQzMIk/DFvauJShIe3rnao3++ct0y0mBDsBaC3dOmqI+xOTGvbomSRB64Bvom5fWY=
X-Received: by 2002:a1c:cf4f:: with SMTP id f76mr16180324wmg.18.1558693346341;
 Fri, 24 May 2019 03:22:26 -0700 (PDT)
MIME-Version: 1.0
References: <1558436618-26194-1-git-send-email-shubhrajyoti.datta@gmail.com> <20190524075211.GB13559@kroah.com>
In-Reply-To: <20190524075211.GB13559@kroah.com>
From:   Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Date:   Fri, 24 May 2019 15:52:16 +0530
Message-ID: <CAKfKVtFyMJyKyA5UpKP+x7qPWJGHy6qHX5Dz8cV0eLXTui=E-g@mail.gmail.com>
Subject: Re: [PATCHv2 2/2] serial: uartps: Add a timeout to the tx empty wait
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, May 24, 2019 at 1:22 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, May 21, 2019 at 04:33:38PM +0530, shubhrajyoti.datta@gmail.com wrote:
> > From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> >
> > In case the cable is not connected then the target gets into
> > a infinite wait for tx empty.
> > Add a timeout to the tx empty wait.
> >
> > Reported-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
> > Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> > ---
> >  drivers/tty/serial/xilinx_uartps.c | 14 ++++++++++----
> >  1 file changed, 10 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> > index 8850790..dc86511 100644
> > --- a/drivers/tty/serial/xilinx_uartps.c
> > +++ b/drivers/tty/serial/xilinx_uartps.c
> > @@ -26,12 +26,14 @@
> >  #include <linux/of.h>
> >  #include <linux/module.h>
> >  #include <linux/pm_runtime.h>
> > +#include <linux/iopoll.h>
> >
> >  #define CDNS_UART_TTY_NAME   "ttyPS"
> >  #define CDNS_UART_NAME               "xuartps"
> >  #define CDNS_UART_MAJOR              0       /* use dynamic node allocation */
> >  #define CDNS_UART_FIFO_SIZE  64      /* FIFO size */
> >  #define CDNS_UART_REGISTER_SPACE     0x1000
> > +#define TX_TIMEOUT           500000
> >
> >  /* Rx Trigger level */
> >  static int rx_trigger_level = 56;
> > @@ -688,14 +690,18 @@ static void cdns_uart_set_termios(struct uart_port *port,
> >       unsigned int cval = 0;
> >       unsigned int baud, minbaud, maxbaud;
> >       unsigned long flags;
> > -     unsigned int ctrl_reg, mode_reg;
> > +     unsigned int ctrl_reg, mode_reg, val;
> > +     int err;
> >
> >       /* Wait for the transmit FIFO to empty before making changes */
> >       if (!(readl(port->membase + CDNS_UART_CR) &
> >                               CDNS_UART_CR_TX_DIS)) {
> > -             while (!(readl(port->membase + CDNS_UART_SR) &
> > -                             CDNS_UART_SR_TXEMPTY)) {
> > -                     cpu_relax();
> > +             err = readl_poll_timeout(port->membase + CDNS_UART_SR,
> > +                                      val, (val & CDNS_UART_SR_TXEMPTY),
> > +                                      1000, TX_TIMEOUT);
> > +             if (err) {
> > +                     dev_info(port->dev, "timed out waiting for tx empty");
> > +                     return;
>
> Also, shouldn't this be an error?  Why not tell the caller something
> went wrong?

Will  do in next version
>
> thanks,
>
> greg k-h
