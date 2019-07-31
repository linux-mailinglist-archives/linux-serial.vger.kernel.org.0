Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8027B7EB
	for <lists+linux-serial@lfdr.de>; Wed, 31 Jul 2019 04:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbfGaCIq (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 30 Jul 2019 22:08:46 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43404 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbfGaCIq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 30 Jul 2019 22:08:46 -0400
Received: by mail-io1-f68.google.com with SMTP id k20so132782644ios.10;
        Tue, 30 Jul 2019 19:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DVKzHn3AiDgjL2TSg70JGryYa6JNjz51534bP69c4bo=;
        b=OeaMkMEsI0c0wtZUN+ae2Xn9kjhZ9iycRduxtwit3OvqnZ7+66zbECfBpwh9M5583+
         5YSqKnM4g351WOoqyE5uJr+IgWqaSgSRAOlY6wG13/K2Z9sAC1Tq3ODYJU9WYDuaJ+AP
         4R0PzIW1WVCOiX/6mm2LjHL9uDhwWOAnheTwmJK9sQjRsK35ohqiccygKWdkMYRc9N6M
         Oqp34wdkpLCiQiFGICLfACjNLAD/h2tu3JAzUI07NigSijAHzYHj968PXbLngpTRd5BG
         222nfDSZoFysH3qAdwjghAMXz6eeaDNJQYuehGiATicDemBv1HbnS/ykAEI9zSGLRjhl
         bjqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DVKzHn3AiDgjL2TSg70JGryYa6JNjz51534bP69c4bo=;
        b=b5i//Az+jubxFqihP8RfUzrfAY7lrJOzwwf9itz8f7v2v4vQvU+NZlw+F9O2iDa8ud
         Bul4vMq4HMSJIv86mzfFgx8OSfuH41zG/PATDTlwtpZ4ep4aFbJGdZ1iPoffbdZcZ555
         1EXzZGSADkeL/B+tKIR+jdkJtwoKt+j/cvOA/NmIlmrfQMGpfLd0Lvtqv/3ntjhZvivZ
         kcQDs6M97k4ukF4AqNceaASgtehIo0aeBcb6HcPgAFewIcf6pQBanUnXNpwbhZkTOg2y
         2B2lX3gWZtwK3fL0A28JXoqv05xukWNieFonjHuiz/7h54uY4gZ59nFUZAYKAZC2uERI
         HxWw==
X-Gm-Message-State: APjAAAUAArcIkeOZpC/Db8rQn5Ss+ifcLrLUQxmXQToc31BsFCP3DCPw
        6FqPu9DGZZqb5hRcjDVR1Vr8OvfDd0KLcX6vFOY=
X-Google-Smtp-Source: APXvYqwzQGth7oDH1CzaOi1cJBfASBrA30/A2aXvOg9sbA1+0FSzmDX0r4QTTBczMvKibOuiCz07Lx32jw0WvFyrjbM=
X-Received: by 2002:a02:3b62:: with SMTP id i34mr126559340jaf.91.1564538925626;
 Tue, 30 Jul 2019 19:08:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190729195226.8862-1-andrew.smirnov@gmail.com>
 <20190729195226.8862-7-andrew.smirnov@gmail.com> <20190730155112.GA11837@kroah.com>
In-Reply-To: <20190730155112.GA11837@kroah.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Tue, 30 Jul 2019 19:08:34 -0700
Message-ID: <CAHQ1cqHhjj5UO=J1YahN8T0uav7BQ05Wsqr1esHR8nhZhsygeA@mail.gmail.com>
Subject: Re: [PATCH 06/24] tty: serial: fsl_lpuart: Drop unnecessary
 sg_set_buf() call
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Chris Healy <cphealy@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Lucas Stach <l.stach@pengutronix.de>,
        Jiri Slaby <jslaby@suse.com>, dl-linux-imx <linux-imx@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jul 30, 2019 at 8:51 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jul 29, 2019 at 12:52:08PM -0700, Andrey Smirnov wrote:
> > Sg_init_one() will already call sg_set_buf(), so another explicit call
> > right after it is unnecessary. Drop it.
> >
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Cc: Stefan Agner <stefan@agner.ch>
> > Cc: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
> > Cc: Chris Healy <cphealy@gmail.com>
> > Cc: Cory Tusar <cory.tusar@zii.aero>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Jiri Slaby <jslaby@suse.com>
> > Cc: linux-imx@nxp.com
> > Cc: linux-serial@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  drivers/tty/serial/fsl_lpuart.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> > index 1b3f2a87e558..b600f591c8c2 100644
> > --- a/drivers/tty/serial/fsl_lpuart.c
> > +++ b/drivers/tty/serial/fsl_lpuart.c
> > @@ -1144,7 +1144,6 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
> >               return -ENOMEM;
> >
> >       sg_init_one(&sport->rx_sgl, ring->buf, sport->rx_dma_rng_buf_len);
> > -     sg_set_buf(&sport->rx_sgl, ring->buf, sport->rx_dma_rng_buf_len);
> >       nent = dma_map_sg(sport->port.dev, &sport->rx_sgl, 1, DMA_FROM_DEVICE);
> >
> >       if (!nent) {
>
> This patch doesn't apply, is it already in the tree from someone else?
>

Yeah, looks like d9aa9ab4fe6b5c43b9ccb8a0811dadcfe40ea27f from your
tty tree already covered this and I didn't have it in my tree. Will
drop in v2.

Thanks,
Andrey Smirnov
