Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97AD024D69
	for <lists+linux-serial@lfdr.de>; Tue, 21 May 2019 13:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbfEULAh (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 21 May 2019 07:00:37 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52147 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfEULAh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 21 May 2019 07:00:37 -0400
Received: by mail-wm1-f66.google.com with SMTP id c77so2511365wmd.1
        for <linux-serial@vger.kernel.org>; Tue, 21 May 2019 04:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AcHa5tkB/jbikMam6nxs2ug9pNahKl0kljb9kpCsB0E=;
        b=afF0aJP94yvi/Op0TuZnDyUoz0TLKg+DeQWdNZT/1JBtLNJOf6gXf9HTuG8SZxyIjm
         vMcYp7Gqc3AwqcoyQPpLunIqFsuVZbz5Zlhr7mbNFSpXAZMExKtGY/TPeVEojZ7zhTff
         1hWzKbsmcN8xCSqrG+YmyJSl+Sgcx36fcog1llN6renp6HBvws3Vq/MYfIUB1o0Q2Uqi
         nGflrjZZSXWPW4ZmcWwpLY3LyUNQg/oM2Aw061R2BTfr58ZcHy7SgbgiarI44VRGzXTi
         nlo1nOjXByqC5UTq8oq15r4WAOLjEzO16q1f8CdUNVJ3qqJ7u5MRPRHVH7mbqM4xrNPk
         KnsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AcHa5tkB/jbikMam6nxs2ug9pNahKl0kljb9kpCsB0E=;
        b=ngUKusWr1OT/qxlPFV+AEJW4gSTO/bo0QAfocQ21HTIkyRwVX5Cjukw/1GZKseQgkK
         BtPgPq2x9QWtolBQtpNEoELCkRXlEiBX7SUTTiX6uAmJ6X1zEOj6V+9lH0PkMGJjy+0+
         nXTULqRGlvuyXA1w61O0JWE8EFe1DwxDgx4Ikbn2Ak6gkyK+A4oMagdslcKN5rAD84va
         T9cyZpiPUXBZ4gTXOwdSkPrI4yGQwEXFSdLkejpHO9m2FKMOf/8YzdovecQmhjnmI6NF
         K/IFlKCEtqvpYupbYF6l3HAdfcidg8D77wc6xZ5uORg4GSzN7itEd/Kcf31kccCnudfa
         vatA==
X-Gm-Message-State: APjAAAW2+bP6zGmBXo1Y238ZS7PmjNGaT4LvhBTswxmAob8+GX35dInN
        D4RiQTBBWWR3e3zFPk/BuxjGxRMaIESNkfk64sAwHg==
X-Google-Smtp-Source: APXvYqzj/EYRpJzQtWk8ZgBBiHfEaEekY3UIKJ0hs1Tu1a/5bqEe5OxVQvI/DVDPcEVjx5LtHiKQh28k/0RWdVl8kY4=
X-Received: by 2002:a1c:ca19:: with SMTP id a25mr2931663wmg.105.1558436435061;
 Tue, 21 May 2019 04:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <1558435386-27124-1-git-send-email-shubhrajyoti.datta@xilinx.com>
In-Reply-To: <1558435386-27124-1-git-send-email-shubhrajyoti.datta@xilinx.com>
From:   Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Date:   Tue, 21 May 2019 16:30:24 +0530
Message-ID: <CAKfKVtEQmDEPa5ExPTSzjRA3dwTscw4-P7DUt6R2tHYp6hJLGg@mail.gmail.com>
Subject: Re: [PATCH 2/2] serial: uartps: Add a timeout to the tx empty wait
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc:     linux-serial@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Please ignore will resend.

On Tue, May 21, 2019 at 4:13 PM Shubhrajyoti Datta
<shubhrajyoti.datta@xilinx.com> wrote:
>
> Add a timeout to the tx empty wait.
>
> Reported-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
>  drivers/tty/serial/xilinx_uartps.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xili=
nx_uartps.c
> index 8850790..dc86511 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -26,12 +26,14 @@
>  #include <linux/of.h>
>  #include <linux/module.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/iopoll.h>
>
>  #define CDNS_UART_TTY_NAME     "ttyPS"
>  #define CDNS_UART_NAME         "xuartps"
>  #define CDNS_UART_MAJOR                0       /* use dynamic node alloc=
ation */
>  #define CDNS_UART_FIFO_SIZE    64      /* FIFO size */
>  #define CDNS_UART_REGISTER_SPACE       0x1000
> +#define TX_TIMEOUT             500000
>
>  /* Rx Trigger level */
>  static int rx_trigger_level =3D 56;
> @@ -688,14 +690,18 @@ static void cdns_uart_set_termios(struct uart_port =
*port,
>         unsigned int cval =3D 0;
>         unsigned int baud, minbaud, maxbaud;
>         unsigned long flags;
> -       unsigned int ctrl_reg, mode_reg;
> +       unsigned int ctrl_reg, mode_reg, val;
> +       int err;
>
>         /* Wait for the transmit FIFO to empty before making changes */
>         if (!(readl(port->membase + CDNS_UART_CR) &
>                                 CDNS_UART_CR_TX_DIS)) {
> -               while (!(readl(port->membase + CDNS_UART_SR) &
> -                               CDNS_UART_SR_TXEMPTY)) {
> -                       cpu_relax();
> +               err =3D readl_poll_timeout(port->membase + CDNS_UART_SR,
> +                                        val, (val & CDNS_UART_SR_TXEMPTY=
),
> +                                        1000, TX_TIMEOUT);
> +               if (err) {
> +                       dev_info(port->dev, "timed out waiting for tx emp=
ty");
> +                       return;
>                 }
>         }
>         spin_lock_irqsave(&port->lock, flags);
> --
> 2.1.1
>
> This email and any attachments are intended for the sole use of the named=
 recipient(s) and contain(s) confidential information that may be proprieta=
ry, privileged or copyrighted under applicable law. If you are not the inte=
nded recipient, do not read, copy, or forward this email message or any att=
achments. Delete this email message and any attachments immediately.
