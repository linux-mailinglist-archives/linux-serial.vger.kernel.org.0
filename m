Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 552A576E6D
	for <lists+linux-serial@lfdr.de>; Fri, 26 Jul 2019 18:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbfGZQCV (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 26 Jul 2019 12:02:21 -0400
Received: from bonobo.elm.relay.mailchannels.net ([23.83.212.22]:43944 "EHLO
        bonobo.elm.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726000AbfGZQCV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Jul 2019 12:02:21 -0400
X-Sender-Id: dreamhost|x-authsender|robert.middleton@rm5248.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id AA952502A48
        for <linux-serial@vger.kernel.org>; Fri, 26 Jul 2019 16:02:19 +0000 (UTC)
Received: from pdx1-sub0-mail-a51.g.dreamhost.com (100-96-38-36.trex.outbound.svc.cluster.local [100.96.38.36])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 17034502914
        for <linux-serial@vger.kernel.org>; Fri, 26 Jul 2019 16:02:19 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|robert.middleton@rm5248.com
Received: from pdx1-sub0-mail-a51.g.dreamhost.com ([TEMPUNAVAIL].
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.17.3);
        Fri, 26 Jul 2019 16:02:19 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|robert.middleton@rm5248.com
X-MailChannels-Auth-Id: dreamhost
X-Tart-Wide-Eyed: 1c38954c66bc46e0_1564156939442_3034841074
X-MC-Loop-Signature: 1564156939442:3703579499
X-MC-Ingress-Time: 1564156939442
Received: from pdx1-sub0-mail-a51.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a51.g.dreamhost.com (Postfix) with ESMTP id A3FF4847E0
        for <linux-serial@vger.kernel.org>; Fri, 26 Jul 2019 09:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=rm5248.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=rm5248.com; bh=0kfJ9DQGyZ9gYHlDQPkSCvGaOL8=; b=
        Kan6kB+JNOVeyPOIE/iGJ82W2Ts0x4/uEu0V/nsmTjAPeSDYILAOiDKQca6j4pyx
        0AG9cZoBeS2RqHCfzn/AxlYgGAVl/JJHzHYL324Oyy2e5vWgjVDJQ4cPiOkV4yTt
        397I6KCPCs+t9b8j1UfWNX2YPvKzajRKTy5tQ/+QBf0=
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: robert.middleton@rm5248.com)
        by pdx1-sub0-mail-a51.g.dreamhost.com (Postfix) with ESMTPSA id 366FE847DE
        for <linux-serial@vger.kernel.org>; Fri, 26 Jul 2019 09:02:16 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id i10so105750834iol.13
        for <linux-serial@vger.kernel.org>; Fri, 26 Jul 2019 09:02:16 -0700 (PDT)
X-Gm-Message-State: APjAAAWmkTeofbEW8tCW85dnF+5jZY/uip4UiQIx2nY1aclAz4VVRNgi
        sCuvCzgN5lYRqk0WTEErm4tEF+NDTIrfKuySXrI=
X-Google-Smtp-Source: APXvYqyke2AnFaFzrUfiQaq3EamphpGUXeIpWwCB9Q5I4y1VrAT5MYAX2Uo0oT3abOtOYJCecc18CrSMHX1XnDC+TDE=
X-Received: by 2002:a6b:6a01:: with SMTP id x1mr50014173iog.77.1564156935405;
 Fri, 26 Jul 2019 09:02:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190723143632.22427-1-robert.middleton@rm5248.com> <20190725100229.GB20445@kroah.com>
In-Reply-To: <20190725100229.GB20445@kroah.com>
X-DH-BACKEND: pdx1-sub0-mail-a51
From:   Robert Middleton <robert.middleton@rm5248.com>
Date:   Fri, 26 Jul 2019 12:02:06 -0400
X-Gmail-Original-Message-ID: <CAKpcJVZpB-b=Z9r-q9fxoN-asiLnde3ea+8G=XGmyigWOWXmgQ@mail.gmail.com>
Message-ID: <CAKpcJVZpB-b=Z9r-q9fxoN-asiLnde3ea+8G=XGmyigWOWXmgQ@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250_exar: Clear buffer before shutdown
To:     Greg KH <greg@kroah.com>
Cc:     linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-VR-OUT-STATUS: OK
X-VR-OUT-SCORE: -100
X-VR-OUT-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrkeeggdeljecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucggtfgfnhhsuhgsshgtrhhisggvpdfftffgtefojffquffvnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeggfhgjhfffkffuvfgtsehttdertddttdejnecuhfhrohhmpeftohgsvghrthcuofhiuggulhgvthhonhcuoehrohgsvghrthdrmhhiuggulhgvthhonhesrhhmhedvgeekrdgtohhmqeenucfkphepvddtledrkeehrdduieeirdehfeenucfrrghrrghmpehmohguvgepshhmthhppdhhvghlohepmhgrihhlqdhiohduqdhfheefrdhgohhoghhlvgdrtghomhdpihhnvghtpedvtdelrdekhedrudeiiedrheefpdhrvghtuhhrnhdqphgrthhhpeftohgsvghrthcuofhiuggulhgvthhonhcuoehrohgsvghrthdrmhhiuggulhgvthhonhesrhhmhedvgeekrdgtohhmqedpmhgrihhlfhhrohhmpehrohgsvghrthdrmhhiuggulhgvthhonhesrhhmhedvgeekrdgtohhmpdhnrhgtphhtthhopehlihhnuhigqdhsvghrihgrlhesvhhgvghrrdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

> What if the hardware is locked up?  Will this sit and spin forever?

I assume so; what is the correct way to do this?  The
manufacturer-provided drivers do something similar but with a counter
that will count up to 1000 before exiting the loop so as to not lock
up.

> Shouldn't you also have a timeout for the flush?

Flush from the system?  The problem that I have been seeing is that
when you do something like "echo text > /dev/ttyS1", only the first
character will be printed out.  This (should) be waiting for that to
happen, since it checks the hardware to ensure that the hardware
buffers are clear and that there are no more characters waiting to be
written to the hardware buffer.

I'm also not sure if the above means that there is a problem with the
serial_8250 driver in general, as I don't have another piece of
hardware available that uses that driver.

-Robert Middleton
