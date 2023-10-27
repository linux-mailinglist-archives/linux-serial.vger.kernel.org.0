Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F2B7D9A90
	for <lists+linux-serial@lfdr.de>; Fri, 27 Oct 2023 15:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345999AbjJ0N6a (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 27 Oct 2023 09:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345943AbjJ0N63 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 27 Oct 2023 09:58:29 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6549D
        for <linux-serial@vger.kernel.org>; Fri, 27 Oct 2023 06:58:27 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-5068b69f4aeso3741e87.0
        for <linux-serial@vger.kernel.org>; Fri, 27 Oct 2023 06:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698415105; x=1699019905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I06EvxGHjZIwzPaPsKm9/VYgT9VaTOcKNELZpAZ5HrU=;
        b=KiDDIyprEcJVCVmoweCtPehc+Vg6X8MUb5dDi9WQuSu9LQ0a+x+OfZqqqxL715gOX+
         0qDXV50eolsqFP16jD6T0TUB77GYw6abFYW1hXdZBDg1+DwZqRYUAwjUR3lUdW6MU6MN
         Va4j2KzZYiZHqzhWyJUr0Vc4NqTcDO4F+EMFHm2YySdSvh4WYBdieFaN9A9rO2gcNu/U
         o1zHP7k8YYQOUSay/2R3iwtcF+mlTMr0LJoje5kJoGGI2Rt+aofMJ642eHa32lhYEGeB
         2yPhgNjQ6H1EwrFqQN8oS1jkYuITmmWVYHi9gCRVvIH5tfT19ec+O9Gvp9CirwDYbkGb
         6odw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698415105; x=1699019905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I06EvxGHjZIwzPaPsKm9/VYgT9VaTOcKNELZpAZ5HrU=;
        b=GPWzdOjn/xrSvX4R4jc2GXlEwX1kd8XSWdoKphhzw2sYHgI8a2r9ya7P0o8RwbD2i/
         7UvfEP6YQ2DFKi0eXAefwGf+iQcDmtxhnGaSAvG+IydOCe3G3ZC5LEH0ECEKFYaGPEhs
         D/FuAphfDpIi6K3Uyi4X+oCPQMRDTzJ16jAkAQCS5eHGJqZF6YpkoDkgM/6fjNCIQmh4
         3ADltbLVPK1ML3i8j+Kfz4jzqC74BmjM+AlIxWBM5HhsDgnSyR9mdi0EvQKaTJOmVkO0
         gUKXBC1GgWL3KbpLMYazZ1cVuvJ26kyeX5gQfa8NNB8QTun7ON6XV8g7HWg2l/Esf43M
         Rwvg==
X-Gm-Message-State: AOJu0Ywih98q+F+HxamYJGcZQHtqFQQSG4zX0bzUGHzkRPOErWWvAcbP
        O0u7pHl3xDSGQTASBO91FGqKA2QmJJYepDp1uGFpwbJk6zboDOlyVxcOUe15
X-Google-Smtp-Source: AGHT+IFMpr3rofEls+Hd9p5f+Lak9nJ0j0GM2NNACzWdEkHubF8mqlzEXV87LiJ5AZJIJ4B4kF8LTdf+dUTHIzJ9GaQ=
X-Received: by 2002:a05:6512:36c9:b0:507:8c80:f1d1 with SMTP id
 e9-20020a05651236c900b005078c80f1d1mr84936lfs.2.1698415105199; Fri, 27 Oct
 2023 06:58:25 -0700 (PDT)
MIME-Version: 1.0
References: <20231026135628.2800617-1-vamshigajjela@google.com> <2023102712-frolic-bush-3d67@gregkh>
In-Reply-To: <2023102712-frolic-bush-3d67@gregkh>
From:   VAMSHI GAJJELA <vamshigajjela@google.com>
Date:   Fri, 27 Oct 2023 19:28:12 +0530
Message-ID: <CAMTSyjpzrwnbzcjm1nO9Zi7sn7yOGb8sxMjEJGgZoQLgDCx99g@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] serial: core: Update uart_poll_timeout() function
 to return unsigned long
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, ilpo.jarvinen@linux.intel.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, Subhash Jadavani <sjadavani@google.com>,
        Channa Kadabi <kadabi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Oct 27, 2023 at 12:13=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Oct 26, 2023 at 07:26:28PM +0530, Vamshi Gajjela wrote:
> > From: VAMSHI GAJJELA <vamshigajjela@google.com>
>
> Please use lower case letters like I think you mean to?
Sure, I will update.
>
> Also, where are patches 1/3 and 2/3 of this series?  I can't do anything
> without them as well.
1/3 is dropped:
https://lore.kernel.org/lkml/CAMTSyjqc118-by6LRHaSN7k8fOcR6K0kmYXdthPD7rqJu=
YOaVw@mail.gmail.com/
2/3 is a clean up:
https://lore.kernel.org/lkml/CAMTSyjpiz_LVtVAzaNpD-xThtp6sKNy-Uvkr+CaH9b10V=
RYD9A@mail.gmail.com/
for 2/3 waiting on response from Ilpo J=C3=A4rvinen

>
> > The function uart_fifo_timeout() returns an unsigned long value, which
> > is the number of jiffies. Therefore, change the variable timeout in the
> > function uart_poll_timeout() from int to unsigned long.
> > Change the return type of the function uart_poll_timeout() from int to
> > unsigned long to be consistent with the type of timeout values.
> >
> > Signed-off-by: VAMSHI GAJJELA <vamshigajjela@google.com>
> > ---
> > v3:
> > - updated description
> > v2:
> > - unsigned long instead of unsigned int
> > - added () after function name in short log
> > - updated description
> >
> >  include/linux/serial_core.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> > index bb6f073bc159..6916a1d7e477 100644
> > --- a/include/linux/serial_core.h
> > +++ b/include/linux/serial_core.h
> > @@ -773,9 +773,9 @@ static inline unsigned long uart_fifo_timeout(struc=
t uart_port *port)
> >  }
> >
> >  /* Base timer interval for polling */
> > -static inline int uart_poll_timeout(struct uart_port *port)
> > +static inline unsigned long uart_poll_timeout(struct uart_port *port)
> >  {
> > -     int timeout =3D uart_fifo_timeout(port);
> > +     unsigned long timeout =3D uart_fifo_timeout(port);
> >
> >       return timeout > 6 ? (timeout / 2 - 2) : 1;
>
> So we are now doing 64bit math?  Did that just make things slower?
>
> What bug is this actually fixing?  How have you tested this to verify it
> works?
>
> thanks,
>
> greg k-h
