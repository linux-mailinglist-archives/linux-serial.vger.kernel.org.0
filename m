Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99B3759E0A
	for <lists+linux-serial@lfdr.de>; Fri, 28 Jun 2019 16:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfF1Oki (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 28 Jun 2019 10:40:38 -0400
Received: from bonobo.elm.relay.mailchannels.net ([23.83.212.22]:61025 "EHLO
        bonobo.elm.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726655AbfF1Okg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 28 Jun 2019 10:40:36 -0400
X-Sender-Id: dreamhost|x-authsender|robert.middleton@rm5248.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id E10E7142DA9
        for <linux-serial@vger.kernel.org>; Fri, 28 Jun 2019 14:34:13 +0000 (UTC)
Received: from pdx1-sub0-mail-a22.g.dreamhost.com (100-96-85-75.trex.outbound.svc.cluster.local [100.96.85.75])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 37D83142DFC
        for <linux-serial@vger.kernel.org>; Fri, 28 Jun 2019 14:34:13 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|robert.middleton@rm5248.com
Received: from pdx1-sub0-mail-a22.g.dreamhost.com ([TEMPUNAVAIL].
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.17.2);
        Fri, 28 Jun 2019 14:34:13 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|robert.middleton@rm5248.com
X-MailChannels-Auth-Id: dreamhost
X-Coil-Shade: 457bfd4846247c23_1561732453736_2788362413
X-MC-Loop-Signature: 1561732453736:3112620258
X-MC-Ingress-Time: 1561732453735
Received: from pdx1-sub0-mail-a22.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a22.g.dreamhost.com (Postfix) with ESMTP id 8506E83A61
        for <linux-serial@vger.kernel.org>; Fri, 28 Jun 2019 07:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=rm5248.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to
        :content-type; s=rm5248.com; bh=2KHV3LxOrG1z5kgedv6NdWAU8eI=; b=
        KpYglYWS/A74dzgzzpm/8bwA6EGNss58YpUs1Tps/RluoEU0Mm1epiGfHnbOcx0P
        hG910r+8Xr+pt72jP72uNwOBC8x8M6tsHs2R2PbOg9I60yysENyMr1eNNGAOhr2V
        14yZ39KKCxgdxK8yaPjm+et8FfofnMrT0RXHBs7ZYPI=
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: robert.middleton@rm5248.com)
        by pdx1-sub0-mail-a22.g.dreamhost.com (Postfix) with ESMTPSA id 51B6483A9D
        for <linux-serial@vger.kernel.org>; Fri, 28 Jun 2019 07:33:57 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id e3so12888472ioc.12
        for <linux-serial@vger.kernel.org>; Fri, 28 Jun 2019 07:33:56 -0700 (PDT)
X-Gm-Message-State: APjAAAXsNlIqkpEaDGyXLaSAnMgHtsvryiVkBK8r4Q1UM2OQuAuXYXuM
        UnoP9SdBeb9bSrgZzBlw+VvUBSCB7mN5h4RLQ/0=
X-Google-Smtp-Source: APXvYqyyri27ertW2A97Kw0I67W+w2fXMZFuE3TjNUi1LNit3Q3dWfdC/iiFPPPETYisyScTJ7/WCceiCUgjK8cmPgY=
X-Received: by 2002:a5e:da47:: with SMTP id o7mr11444193iop.83.1561732430975;
 Fri, 28 Jun 2019 07:33:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAKpcJVav5-_VdakmPYatZ5iZa38=_wN-gd4yhsx0Pfo+zR+2-Q@mail.gmail.com>
In-Reply-To: <CAKpcJVav5-_VdakmPYatZ5iZa38=_wN-gd4yhsx0Pfo+zR+2-Q@mail.gmail.com>
X-DH-BACKEND: pdx1-sub0-mail-a22
From:   Robert Middleton <robert.middleton@rm5248.com>
Date:   Fri, 28 Jun 2019 10:33:39 -0400
X-Gmail-Original-Message-ID: <CAKpcJVb+59BEb6++O=h0_t0z8hDs+zSwHO5-TNDZgrX-YX2SUg@mail.gmail.com>
Message-ID: <CAKpcJVb+59BEb6++O=h0_t0z8hDs+zSwHO5-TNDZgrX-YX2SUg@mail.gmail.com>
Subject: Re: Issue with XR17V35X
To:     linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-VR-OUT-STATUS: OK
X-VR-OUT-SCORE: 0
X-VR-OUT-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrvddtgdektdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucggtfgfnhhsuhgsshgtrhhisggvpdfftffgtefojffquffvnecuuegrihhlohhuthemuceftddtnecunecujfgurhepgghfjgfhfffkuffvtgesthdtredttddtjeenucfhrhhomheptfhosggvrhhtucfoihguughlvghtohhnuceorhhosggvrhhtrdhmihguughlvghtohhnsehrmhehvdegkedrtghomheqnecukfhppedvtdelrdekhedrudeiiedrgeeinecurfgrrhgrmhepmhhouggvpehsmhhtphdphhgvlhhopehmrghilhdqihhouddqfhegiedrghhoohhglhgvrdgtohhmpdhinhgvthepvddtledrkeehrdduieeirdegiedprhgvthhurhhnqdhprghthheptfhosggvrhhtucfoihguughlvghtohhnuceorhhosggvrhhtrdhmihguughlvghtohhnsehrmhehvdegkedrtghomheqpdhmrghilhhfrhhomheprhhosggvrhhtrdhmihguughlvghtohhnsehrmhehvdegkedrtghomhdpnhhrtghpthhtoheplhhinhhugidqshgvrhhirghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

I have fixed the problem for my use-case with the following patch to
not clear the FIFOs if there is still data to be transmitted:

diff --git a/drivers/tty/serial/8250/8250_port.c
b/drivers/tty/serial/8250/8250_port.c
index d2f3310abe54..569a76d1b00a 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2441,7 +2441,10 @@ void serial8250_do_shutdown(struct uart_port *port)
      */
     serial_port_out(port, UART_LCR,
             serial_port_in(port, UART_LCR) & ~UART_LCR_SBC);
-    serial8250_clear_fifos(up);
+    if (serial_in(up, UART_LSR) & UART_LSR_TEMT){
+        /* Check if transmitter is empty before clearing FIFOs */
+        serial8250_clear_fifos(up);
+    }

 #ifdef CONFIG_SERIAL_8250_RSA
     /*

I'm not sure if this is correct/the best way to do it, since I am not
sure if this is common to all drivers under 8250 or only for the Exar
chip.  I can also provide a proper patch via e-mail if that makes
sense.

-Robert Middleton

On Thu, Jun 27, 2019 at 6:54 PM Robert Middleton
<robert.middleton@rm5248.com> wrote:
>
> Hi all,
>
> I've encountered a problem with the driver for the XR17V358
> PCIe-to-serial converter.  When I try to send data to the chip, it is
> only transmitted properly if I am also reading from the tty at the
> same point.  That is the following sequence in the terminal works:
>
> cat /dev/ttyS13 &
> echo "this is a test" > /dev/ttyS13
>
> The data "this is a test" will be sent correctly out the serial port.
> However, if I don't cat it and do just the following:
>
> echo "this is a test" > /dev/ttyS13
>
> then I will occasionally get the first character('t'), occasionally
> nothing, but never the entire message and never more than one byte.
>
> I tried to track this down earlier today, but I haven't been able to
> figure out where exactly it is going wrong.  Has anybody else seen
> this?  Does anybody know what exactly to look for to fix this?  I was
> poking around alot in 8250_port.c, since that seems to be where most
> of this is happening, but I wasn't sure if this is an exar-specific
> thing or if it is a problem with all 16550-compatible UARTs.
>
> -Robert Middleton
