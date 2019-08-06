Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44BD7832F7
	for <lists+linux-serial@lfdr.de>; Tue,  6 Aug 2019 15:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731026AbfHFNlB (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 6 Aug 2019 09:41:01 -0400
Received: from egyptian.birch.relay.mailchannels.net ([23.83.209.56]:28301
        "EHLO egyptian.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728156AbfHFNlB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 6 Aug 2019 09:41:01 -0400
X-Sender-Id: dreamhost|x-authsender|robert.middleton@rm5248.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id B0EDF231B5
        for <linux-serial@vger.kernel.org>; Tue,  6 Aug 2019 13:40:58 +0000 (UTC)
Received: from pdx1-sub0-mail-a17.g.dreamhost.com (100-96-29-186.trex.outbound.svc.cluster.local [100.96.29.186])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id D8BB622C28
        for <linux-serial@vger.kernel.org>; Tue,  6 Aug 2019 13:40:57 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|robert.middleton@rm5248.com
Received: from pdx1-sub0-mail-a17.g.dreamhost.com ([TEMPUNAVAIL].
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.17.5);
        Tue, 06 Aug 2019 13:40:58 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|robert.middleton@rm5248.com
X-MailChannels-Auth-Id: dreamhost
X-Glossy-Eyes: 3280383b15580ca5_1565098858375_3774995549
X-MC-Loop-Signature: 1565098858375:740417424
X-MC-Ingress-Time: 1565098858374
Received: from pdx1-sub0-mail-a17.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a17.g.dreamhost.com (Postfix) with ESMTP id 62EEC7F5FB
        for <linux-serial@vger.kernel.org>; Tue,  6 Aug 2019 06:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=rm5248.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=rm5248.com; bh=A5qq2WUObNrR7T8Dxp8X+EdWcg8=; b=
        inW7mXIPjAzHLDrCclR6lrl7qWNf14TWwnLzI6TECIDNSxKPed5qyEKCq7lUw9Am
        9+lzlJG0E63xdln/V59vOw54E2+AB2HWADMQledpJU/HzXs/9qLqImRCYrOm1jpz
        zaVxhMBlQ7kc5bD4HYIIB1TxvMiH1ZkBWdJcFSdHeJQ=
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: robert.middleton@rm5248.com)
        by pdx1-sub0-mail-a17.g.dreamhost.com (Postfix) with ESMTPSA id DE4977F5F1
        for <linux-serial@vger.kernel.org>; Tue,  6 Aug 2019 06:40:54 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id n5so92602505otk.1
        for <linux-serial@vger.kernel.org>; Tue, 06 Aug 2019 06:40:54 -0700 (PDT)
X-Gm-Message-State: APjAAAUHsDfRzLx8awhDmSkQYLU/uhQBlSa0S+KhyB9wVOQnaRrx7JSV
        OJfgXiNlhUKp5rfaYO8gFkr4c+yTidMWopaI79I=
X-Google-Smtp-Source: APXvYqwHSIYZgGPpOiefnw7+omkmy+S3AeCsAHOiulsvQkBC1R69Xs+NdV85A0D+XRqcIn3GE3mP2vbyNC1GHQjn6Do=
X-Received: by 2002:a5d:9e49:: with SMTP id i9mr3647535ioi.290.1565098853486;
 Tue, 06 Aug 2019 06:40:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190805100518.9818-1-andriy.shevchenko@linux.intel.com>
 <20190805100518.9818-2-andriy.shevchenko@linux.intel.com> <CAKpcJVZTy963y3TOXSYSBFVOpVTWEOyJKUYxv1pHNGz3Y1aPTA@mail.gmail.com>
 <20190805142147.GK23480@smile.fi.intel.com>
In-Reply-To: <20190805142147.GK23480@smile.fi.intel.com>
X-DH-BACKEND: pdx1-sub0-mail-a17
From:   Robert Middleton <robert.middleton@rm5248.com>
Date:   Tue, 6 Aug 2019 09:40:41 -0400
X-Gmail-Original-Message-ID: <CAKpcJVYfcVAmoB63EbmJaix6v+2JJ5BujAcdduQLcw-ES+f3ZQ@mail.gmail.com>
Message-ID: <CAKpcJVYfcVAmoB63EbmJaix6v+2JJ5BujAcdduQLcw-ES+f3ZQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] serial: 8250_exar: Refactor exar_shutdown()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-VR-OUT-STATUS: OK
X-VR-OUT-SCORE: -100
X-VR-OUT-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddruddutddgieejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuggftfghnshhusghstghrihgsvgdpffftgfetoffjqffuvfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepgghfjgfhfffkuffvtgesthdtredttddtjeenucfhrhhomheptfhosggvrhhtucfoihguughlvghtohhnuceorhhosggvrhhtrdhmihguughlvghtohhnsehrmhehvdegkedrtghomheqnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepvddtledrkeehrddvuddtrdehtdenucfrrghrrghmpehmohguvgepshhmthhppdhhvghlohepmhgrihhlqdhothduqdhfhedtrdhgohhoghhlvgdrtghomhdpihhnvghtpedvtdelrdekhedrvddutddrhedtpdhrvghtuhhrnhdqphgrthhhpeftohgsvghrthcuofhiuggulhgvthhonhcuoehrohgsvghrthdrmhhiuggulhgvthhonhesrhhmhedvgeekrdgtohhmqedpmhgrihhlfhhrohhmpehrohgsvghrthdrmhhiuggulhgvthhonhesrhhmhedvgeekrdgtohhmpdhnrhgtphhtthhopehlihhnuhigqdhsvghrihgrlhesvhhgvghrrdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Aug 5, 2019 at 10:22 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Aug 05, 2019 at 09:49:24AM -0400, Robert Middleton wrote:
>
> Thanks for testing, my comments below.
>
> > Unfortunately this will re-introduce the bug that it was attempting to
> > solve, that is ensuring that the buffer in the kernel and the buffer
> > on the chip are clear before going into shutdown on the chip.
> > Breaking at the beginning of the loop means that the kernel has
> > written everything to the internal buffer on the chip, but until the
> > LSR bits are clear the bytes have not been transmitted yet.
>
> So, the difference here, that you have a long delay with mdelay(1) which
> "fixes" your issue.

The important fix is really this part:
lsr = serial_in(up, UART_LSR);
if (lsr & (UART_LSR_TEMT | UART_LSR_THRE))

Both of those bits must be set before the shutdown can occur.  The
msleep(1) is so that it is not a busy loop(maybe usleep_range would be
better?).  If the transmitter is not empty and the transmitter FIFO is
not empty, when the shutdown occurs the remaining data will be
discarded by the exar chip.  Assuming the FIFO on the exar is full(256
bytes to transmit), it would take ~250ms to transmit all of the bytes
at 9600 baud, so our check would happen ~250 times(assuming mdelay(1)
sleeps for 1ms and not up to 20).

This is based off of the reference driver from Max Linear:
https://github.com/rm5248/exar-driver/blob/5dcbac6aa564cf5604512ecd6c9e02c577b70fa2/xr17v35x.c#L1282

>
> I guess the third patch in this series makes it again not-working.
> Can you check and confirm that?

I don't see a third patch.

>
> Or even better, replace entire loop with one usleep_range() call and play with
> numbers there, like (10, 20), (100, 150), (1000, 1100). Probably you can start
> with udelay(2) followed up by above list.
>
> If my theory is correct you will see at some point the problem will disappear.

It would probably disappear, but if you remove the entire loop and LSR
check you can't be sure that the data has actually been transmitted
out of the exar chip.  Likely this would result in a different number
of bytes being dropped depending on the baud rate and how large the
buffer was when shutdown occurs.

>
> > I'm not positive that the uart_circ_empty needs to be checked in the
> > first place; I had put it in because the serial8250_tx_chars does that
> > before stopping the tx, and I assume that there could be a potential
> > race condition where the kernel has not yet written all the data to
> > the exar, but the exar has finished transmitting all the data in its
> > transmit buffer(I am not sure how likely this is to happen).
>
> tty gets uninitialized before ->shutdown() happen, it also set's TTY IO error
> condition, which has been checked in tty_write(). I'm sure new data will not
> come at this point.

That makes sense; thanks for the information.  The TTY layer is rather
complicated for somebody like me who doesn't look at it a lot.


-Robert Middleton
