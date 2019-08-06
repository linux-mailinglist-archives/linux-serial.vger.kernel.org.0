Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D001483D8D
	for <lists+linux-serial@lfdr.de>; Wed,  7 Aug 2019 00:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbfHFWwT (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 6 Aug 2019 18:52:19 -0400
Received: from bonobo.elm.relay.mailchannels.net ([23.83.212.22]:63129 "EHLO
        bonobo.elm.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726133AbfHFWwT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 6 Aug 2019 18:52:19 -0400
X-Sender-Id: dreamhost|x-authsender|robert.middleton@rm5248.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 5D1CF1A19A5
        for <linux-serial@vger.kernel.org>; Tue,  6 Aug 2019 22:52:17 +0000 (UTC)
Received: from pdx1-sub0-mail-a59.g.dreamhost.com (100-96-15-65.trex.outbound.svc.cluster.local [100.96.15.65])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id D73A31A1840
        for <linux-serial@vger.kernel.org>; Tue,  6 Aug 2019 22:52:16 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|robert.middleton@rm5248.com
Received: from pdx1-sub0-mail-a59.g.dreamhost.com ([TEMPUNAVAIL].
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.17.5);
        Tue, 06 Aug 2019 22:52:17 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|robert.middleton@rm5248.com
X-MailChannels-Auth-Id: dreamhost
X-Minister-Grain: 45b0561f5b579de3_1565131937151_815107334
X-MC-Loop-Signature: 1565131937151:1791166454
X-MC-Ingress-Time: 1565131937151
Received: from pdx1-sub0-mail-a59.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a59.g.dreamhost.com (Postfix) with ESMTP id 045E184AED
        for <linux-serial@vger.kernel.org>; Tue,  6 Aug 2019 15:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=rm5248.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=rm5248.com; bh=JXZucfnrwFvCOCVdxiaN3SEUd+c=; b=
        Ytn2qbP07mMSttMBpFjI7LTboAnzXjTsXpDg4olodwKaKJR8fvEyf30i4flgbcRh
        X8YTwCv/ywaPgjIGDjJpB5n6xfLgBBsm3g6JBfZ0Riti/dEqeh62zjE/LD//XP5s
        lGUBkuHy4VimAzQ4FfFRxzOe+mwAlia1fsMW5sDZEEQ=
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: robert.middleton@rm5248.com)
        by pdx1-sub0-mail-a59.g.dreamhost.com (Postfix) with ESMTPSA id C6A4C847C0
        for <linux-serial@vger.kernel.org>; Tue,  6 Aug 2019 15:52:13 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id d17so96777636oth.5
        for <linux-serial@vger.kernel.org>; Tue, 06 Aug 2019 15:52:13 -0700 (PDT)
X-Gm-Message-State: APjAAAVKbykVDviaPl11y9jZitT+b/TG9KQbQI/7kxu//pTyo/zb1mpq
        SsOgd2Si8VCl2MvpzpuVtpzR9cIb9w1uiZkplko=
X-Google-Smtp-Source: APXvYqyOYDah+NG7nsbaP0IXSZMkcXPv9PXjsKOc8IbM3SLGVz+kpXGn/aO7f5fpwnB6PZPnjK0AyfDLYMkkXtua748=
X-Received: by 2002:a5e:8f42:: with SMTP id x2mr5907720iop.35.1565131933112;
 Tue, 06 Aug 2019 15:52:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190805100518.9818-1-andriy.shevchenko@linux.intel.com>
 <20190805100518.9818-2-andriy.shevchenko@linux.intel.com> <CAKpcJVZTy963y3TOXSYSBFVOpVTWEOyJKUYxv1pHNGz3Y1aPTA@mail.gmail.com>
 <20190805142147.GK23480@smile.fi.intel.com> <CAKpcJVYfcVAmoB63EbmJaix6v+2JJ5BujAcdduQLcw-ES+f3ZQ@mail.gmail.com>
 <20190806152407.GF30120@smile.fi.intel.com> <20190806153110.GG30120@smile.fi.intel.com>
In-Reply-To: <20190806153110.GG30120@smile.fi.intel.com>
X-DH-BACKEND: pdx1-sub0-mail-a59
From:   Robert Middleton <robert.middleton@rm5248.com>
Date:   Tue, 6 Aug 2019 18:52:01 -0400
X-Gmail-Original-Message-ID: <CAKpcJVYTC8MN6A51iip=cyvkfXVy2NS-c3FyhAi9qcxsgJkQRw@mail.gmail.com>
Message-ID: <CAKpcJVYTC8MN6A51iip=cyvkfXVy2NS-c3FyhAi9qcxsgJkQRw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] serial: 8250_exar: Refactor exar_shutdown()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-VR-OUT-STATUS: OK
X-VR-OUT-SCORE: -100
X-VR-OUT-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudduuddgudeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuggftfghnshhusghstghrihgsvgdpffftgfetoffjqffuvfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepgghfjgfhfffkuffvtgesthdtredttddtjeenucfhrhhomheptfhosggvrhhtucfoihguughlvghtohhnuceorhhosggvrhhtrdhmihguughlvghtohhnsehrmhehvdegkedrtghomheqnecukfhppedvtdelrdekhedrvddutddrgedunecurfgrrhgrmhepmhhouggvpehsmhhtphdphhgvlhhopehmrghilhdqohhtuddqfheguddrghhoohhglhgvrdgtohhmpdhinhgvthepvddtledrkeehrddvuddtrdeguddprhgvthhurhhnqdhprghthheptfhosggvrhhtucfoihguughlvghtohhnuceorhhosggvrhhtrdhmihguughlvghtohhnsehrmhehvdegkedrtghomheqpdhmrghilhhfrhhomheprhhosggvrhhtrdhmihguughlvghtohhnsehrmhehvdegkedrtghomhdpnhhrtghpthhtoheplhhinhhugidqshgvrhhirghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

> One more though. Let's consider your code carefully.
>
> do {
>         lsr = serial_in(up, UART_LSR);
>         if (lsr & (UART_LSR_TEMT | UART_LSR_THRE))
>                 tx_complete = 1;
>         else
>                 tx_complete = 0;
>
> Here we set a boolean to be true or false, fine...
>
>         msleep(1);
>
> ...wait for some undefined long time...
>
> } while (!uart_circ_empty(xmit) && !tx_complete && i++ < 1000);
>
> ...first conditional is to check kernel buffer for emptiness, and since it's an
> AND operation in use, break if it false...
>
> (In comparison to what I proposed, the difference is, that I'm not reading
>  register and waiting for some milliseconds)
>
> ...then, you check a boolean variable...
>
> (similar what I have done with a 'break' statement)
>
> ...and at last we have check the iteration counter.
>
> (this same in both cases).
>
> So, I'm puzzled how your cases works reliably if it based on msleep().
> With enough slow baud rate you won't get fix working AFAIU.
> Where am I wrong?

It seems as though you are right here - I thought I had tested this
with a slower baud, but I may have only tested it with a small
string(at which point the problem does not show up, or only shows up
rarely).  All of my serial ports are running at 115200, but lowering
that can cause it to fail.

I have it working reliably at the moment, but I need to run a few more
tests to check it.  It does look like the uart_circ_empty() is an
invalid check though; removing it does allow for everything to be
transmitted at a lower baud rate(although still using msleep, not
usleep_range).  It seems that subtle changes in how this function
works cause it to be unreliable again - I have been changing
msleep/usleep_range, as well as the iterations, and removing the
uart_circ_emtpy, and I get different results depending on the
settings.

I'll try to get some firm results in the morning; otherwise I won't be
able to check until early next week as I will be away from the
hardware.

-Robert Middleton
