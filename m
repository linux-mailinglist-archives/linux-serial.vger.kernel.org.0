Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4168531C
	for <lists+linux-serial@lfdr.de>; Wed,  7 Aug 2019 20:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388612AbfHGSmI (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 7 Aug 2019 14:42:08 -0400
Received: from bonobo.elm.relay.mailchannels.net ([23.83.212.22]:41068 "EHLO
        bonobo.elm.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389214AbfHGSmH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Aug 2019 14:42:07 -0400
X-Sender-Id: dreamhost|x-authsender|robert.middleton@rm5248.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 83201342055
        for <linux-serial@vger.kernel.org>; Wed,  7 Aug 2019 18:42:06 +0000 (UTC)
Received: from pdx1-sub0-mail-a24.g.dreamhost.com (100-96-145-213.trex.outbound.svc.cluster.local [100.96.145.213])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id B6BC3342325
        for <linux-serial@vger.kernel.org>; Wed,  7 Aug 2019 18:42:04 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|robert.middleton@rm5248.com
Received: from pdx1-sub0-mail-a24.g.dreamhost.com ([TEMPUNAVAIL].
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.17.5);
        Wed, 07 Aug 2019 18:42:06 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|robert.middleton@rm5248.com
X-MailChannels-Auth-Id: dreamhost
X-Power-Occur: 1058a3115f642596_1565203325211_4218160234
X-MC-Loop-Signature: 1565203325211:4224315937
X-MC-Ingress-Time: 1565203325211
Received: from pdx1-sub0-mail-a24.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a24.g.dreamhost.com (Postfix) with ESMTP id 7649F7FB6B
        for <linux-serial@vger.kernel.org>; Wed,  7 Aug 2019 11:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=rm5248.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=rm5248.com; bh=JaEKbLXIkpxMmYTDfWGSsACrSNk=; b=
        mn/p4yH7z6ZuRJdrcflfgD0xvkUwhxjYZFP2A9iLGgJJkjBF+hjQt6SIer5sE6t5
        bbN6nntJLAb5ikKSjDf+iswcr8yB419odK1c/Lc9R5r/5VeIxxH/rJjHT8zEPkcJ
        vxOIlNuEsfn+gZAjewZHY14+AtI2UgZyVKFSG1m9Kbk=
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: robert.middleton@rm5248.com)
        by pdx1-sub0-mail-a24.g.dreamhost.com (Postfix) with ESMTPSA id 3D87A7FB67
        for <linux-serial@vger.kernel.org>; Wed,  7 Aug 2019 11:42:00 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id j19so31666632otq.2
        for <linux-serial@vger.kernel.org>; Wed, 07 Aug 2019 11:42:00 -0700 (PDT)
X-Gm-Message-State: APjAAAWJfpPQYpKEF95eu2mX2IxXl+2b6dTfIe1Qgqx96IkvSbNaDu4J
        wBPj9F6fc/RVO53HN2eJzNnxDhWekHEiShY/L7M=
X-Google-Smtp-Source: APXvYqzUS10Xca+x+fUwso4yw2s9UHf8rho6bWTrn1Z5IuBMRRUCPde+VSWWrMKC50y+H3RDDyT8J0+dLhJRYyoA7AA=
X-Received: by 2002:a02:9f07:: with SMTP id z7mr11621473jal.29.1565203319291;
 Wed, 07 Aug 2019 11:41:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190805100518.9818-1-andriy.shevchenko@linux.intel.com>
 <20190805100518.9818-2-andriy.shevchenko@linux.intel.com> <CAKpcJVZTy963y3TOXSYSBFVOpVTWEOyJKUYxv1pHNGz3Y1aPTA@mail.gmail.com>
 <20190805142147.GK23480@smile.fi.intel.com> <CAKpcJVYfcVAmoB63EbmJaix6v+2JJ5BujAcdduQLcw-ES+f3ZQ@mail.gmail.com>
 <20190806152407.GF30120@smile.fi.intel.com> <20190806153110.GG30120@smile.fi.intel.com>
 <CAKpcJVYTC8MN6A51iip=cyvkfXVy2NS-c3FyhAi9qcxsgJkQRw@mail.gmail.com>
 <CAKpcJVaL-BqL0G=_hT6WHz6kCr05sHS1jDQnaM0s_WFWCb6n_A@mail.gmail.com> <20190807150425.GC30120@smile.fi.intel.com>
In-Reply-To: <20190807150425.GC30120@smile.fi.intel.com>
X-DH-BACKEND: pdx1-sub0-mail-a24
From:   Robert Middleton <robert.middleton@rm5248.com>
Date:   Wed, 7 Aug 2019 14:41:47 -0400
X-Gmail-Original-Message-ID: <CAKpcJVYmTK-kw5eZJtcMWBSMmOk4ijqu-1oh9cEswi4q98QHAg@mail.gmail.com>
Message-ID: <CAKpcJVYmTK-kw5eZJtcMWBSMmOk4ijqu-1oh9cEswi4q98QHAg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] serial: 8250_exar: Refactor exar_shutdown()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-VR-OUT-STATUS: OK
X-VR-OUT-SCORE: -100
X-VR-OUT-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudduvddguddvkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucggtfgfnhhsuhgsshgtrhhisggvpdfftffgtefojffquffvnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeggfhgjhfffkffuvfgtsehttdertddttdejnecuhfhrohhmpeftohgsvghrthcuofhiuggulhgvthhonhcuoehrohgsvghrthdrmhhiuggulhgvthhonhesrhhmhedvgeekrdgtohhmqeenucfkphepvddtledrkeehrddvuddtrdegheenucfrrghrrghmpehmohguvgepshhmthhppdhhvghlohepmhgrihhlqdhothduqdhfgeehrdhgohhoghhlvgdrtghomhdpihhnvghtpedvtdelrdekhedrvddutddrgeehpdhrvghtuhhrnhdqphgrthhhpeftohgsvghrthcuofhiuggulhgvthhonhcuoehrohgsvghrthdrmhhiuggulhgvthhonhesrhhmhedvgeekrdgtohhmqedpmhgrihhlfhhrohhmpehrohgsvghrthdrmhhiuggulhgvthhonhesrhhmhedvgeekrdgtohhmpdhnrhgtphhtthhopehlihhnuhigqdhsvghrihgrlhesvhhgvghrrdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Aug 7, 2019 at 11:04 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Aug 07, 2019 at 09:48:03AM -0400, Robert Middleton wrote:
> > > I'll try to get some firm results in the morning; otherwise I won't be
> > > able to check until early next week as I will be away from the
> > > hardware.
> >
> > After doing more testing, I think that I finally have something that
> > is working fully at all baud rates.  I've tested this at
> > 115200,9600,and 4800, testing via: echo "the quick brown fox jumps
> > over the lazy dog" > /dev/ttySx
> >
> > Removing the check to uart_circ_empty in the while loop makes it more
> > reliable, however it will occasionally fail and only transmit the
> > first part of the message(at 4800, it will transmit only "t", at
> > 115200 it will transmit "the quick bro").
>
> I'm not sure about the loop for uart_circ_empty(). Can you try 2-3 kB of text
> at lower baud rate, let's say 2400 or so?

So at the lower baud rate, it does not transmit all of the data,
probably because the timeout eventually stops it.  However, it does
get back into a very weird state that I have seen before, where
opening up the port again will cause it to transmit some of the
previously-buffered data.  See below for some more details.

> > I've found that breaking it
> > into two loops, one checking the uart_circ_empty and the other doing
> > the LSR check is reliable at all baud rates.
>
> If my suspicion is correct, the shutdown of the port will take ages which is
> inappropriate.

The shutdown probably does take a while, but the fact that not all of
the data is transmitted is what tripped me up in the first place and
sent me down this track trying to figure out why all of the data was
not being transmitted out of the serial port properly.

The previous hardware used an FTDI USB to serial converter to send
serial data, and changing to the exar caused some of our applications
to stop working. They do a similar thing to echoing from the terminal,
that is they come up, send a command, and then exit.  I tried just now
with an FTDI cable and got some interesting results vs. using the
exar.  The data(3kB) gets fully transmitted when I do 'cat
lorem-ipsum.txt > /dev/ttyUSB0', but when I do it via 'cat
lorem-ipsum.txt > /dev/exar-serial' it will timeout after a second.
Doing an 'echo "" > /dev/exar-serial' will send more of the text,
until it stops again.  I have to do this about 5 times before all of
the data gets transmitted over the serial port.  This is also at 2400
baud on both the exar and the FTDI.

At this point, this leads me to believe that there is actually a more
fundamental problem with the 8250 driver and flushing data.  I was
focusing more on the exar, since that is the only hardware that I have
available that uses the 8250 driver.

-Robert Middleton
