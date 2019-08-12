Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04F9B89E7D
	for <lists+linux-serial@lfdr.de>; Mon, 12 Aug 2019 14:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfHLMfF (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 12 Aug 2019 08:35:05 -0400
Received: from egyptian.birch.relay.mailchannels.net ([23.83.209.56]:51402
        "EHLO egyptian.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726383AbfHLMfF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 12 Aug 2019 08:35:05 -0400
X-Sender-Id: dreamhost|x-authsender|robert.middleton@rm5248.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 289095E3302
        for <linux-serial@vger.kernel.org>; Mon, 12 Aug 2019 12:35:03 +0000 (UTC)
Received: from pdx1-sub0-mail-a72.g.dreamhost.com (100-96-91-66.trex.outbound.svc.cluster.local [100.96.91.66])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 997A75E2B87
        for <linux-serial@vger.kernel.org>; Mon, 12 Aug 2019 12:35:02 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|robert.middleton@rm5248.com
Received: from pdx1-sub0-mail-a72.g.dreamhost.com ([TEMPUNAVAIL].
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.17.5);
        Mon, 12 Aug 2019 12:35:03 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|robert.middleton@rm5248.com
X-MailChannels-Auth-Id: dreamhost
X-Hook-Drop: 04af8831175411de_1565613302885_3467293411
X-MC-Loop-Signature: 1565613302884:2427581219
X-MC-Ingress-Time: 1565613302884
Received: from pdx1-sub0-mail-a72.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a72.g.dreamhost.com (Postfix) with ESMTP id 7A33083E98
        for <linux-serial@vger.kernel.org>; Mon, 12 Aug 2019 05:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=rm5248.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=rm5248.com; bh=XVZpdAUImHm6QhJ2/LtX6enuzUc=; b=
        ZzdchbuoRiOxaqK6A6txJsMiyy4sUQbYPo28l+Ld8MCQ2wY0yCdxCmGIFm+7Slev
        uTFNquHVFA3E0BeimdF3aL/LW1AWYkowMXc0unFQR6C4N0fJW2k6Qc7Zv1is4APP
        0xYgDncVBRS/n9hRa4x2RY1k0zuVd5HkMhEDgjLWAGY=
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: robert.middleton@rm5248.com)
        by pdx1-sub0-mail-a72.g.dreamhost.com (Postfix) with ESMTPSA id 442D083E8A
        for <linux-serial@vger.kernel.org>; Mon, 12 Aug 2019 05:34:57 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id r20so8194600ota.5
        for <linux-serial@vger.kernel.org>; Mon, 12 Aug 2019 05:34:56 -0700 (PDT)
X-Gm-Message-State: APjAAAVhKl68Bkhu6OhTQIF2OlHX6fdTLyOEn8all8Bn5Z+MSZAI7LW3
        9KTR5SC1dKb2cbjen5tPGxc/pmwVRuKq5c+QHmU=
X-Google-Smtp-Source: APXvYqyLWdoUCJ74aD3wVxL4B9m4zCvcPDtYKh3swu6N6ZkBghK7zzW5id3kmVkqdAYRtMcXrVnXV4Jjq7VbwDQ6wuc=
X-Received: by 2002:a02:6a56:: with SMTP id m22mr25489689jaf.114.1565613296298;
 Mon, 12 Aug 2019 05:34:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190805100518.9818-2-andriy.shevchenko@linux.intel.com>
 <CAKpcJVZTy963y3TOXSYSBFVOpVTWEOyJKUYxv1pHNGz3Y1aPTA@mail.gmail.com>
 <20190805142147.GK23480@smile.fi.intel.com> <CAKpcJVYfcVAmoB63EbmJaix6v+2JJ5BujAcdduQLcw-ES+f3ZQ@mail.gmail.com>
 <20190806152407.GF30120@smile.fi.intel.com> <20190806153110.GG30120@smile.fi.intel.com>
 <CAKpcJVYTC8MN6A51iip=cyvkfXVy2NS-c3FyhAi9qcxsgJkQRw@mail.gmail.com>
 <CAKpcJVaL-BqL0G=_hT6WHz6kCr05sHS1jDQnaM0s_WFWCb6n_A@mail.gmail.com>
 <20190807150425.GC30120@smile.fi.intel.com> <CAKpcJVYmTK-kw5eZJtcMWBSMmOk4ijqu-1oh9cEswi4q98QHAg@mail.gmail.com>
 <20190808121148.GT30120@smile.fi.intel.com>
In-Reply-To: <20190808121148.GT30120@smile.fi.intel.com>
X-DH-BACKEND: pdx1-sub0-mail-a72
From:   Robert Middleton <robert.middleton@rm5248.com>
Date:   Mon, 12 Aug 2019 08:34:45 -0400
X-Gmail-Original-Message-ID: <CAKpcJVa59TJduRXKsjx-5=Re6rAQVOsi_11rTLZdE7_vFujMEg@mail.gmail.com>
Message-ID: <CAKpcJVa59TJduRXKsjx-5=Re6rAQVOsi_11rTLZdE7_vFujMEg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] serial: 8250_exar: Refactor exar_shutdown()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Aaron Sierra <asierra@xes-inc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, Jan Kiszka <jan.kiszka@siemens.com>,
        Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Content-Type: text/plain; charset="UTF-8"
X-VR-OUT-STATUS: OK
X-VR-OUT-SCORE: -100
X-VR-OUT-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddruddvgedgheegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuggftfghnshhusghstghrihgsvgdpffftgfetoffjqffuvfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepgghfjgfhfffkuffvtgesthdtredttddtjeenucfhrhhomheptfhosggvrhhtucfoihguughlvghtohhnuceorhhosggvrhhtrdhmihguughlvghtohhnsehrmhehvdegkedrtghomheqnecukfhppedvtdelrdekhedrvddutddrgeeinecurfgrrhgrmhepmhhouggvpehsmhhtphdphhgvlhhopehmrghilhdqohhtuddqfhegiedrghhoohhglhgvrdgtohhmpdhinhgvthepvddtledrkeehrddvuddtrdegiedprhgvthhurhhnqdhprghthheptfhosggvrhhtucfoihguughlvghtohhnuceorhhosggvrhhtrdhmihguughlvghtohhnsehrmhehvdegkedrtghomheqpdhmrghilhhfrhhomheprhhosggvrhhtrdhmihguughlvghtohhnsehrmhehvdegkedrtghomhdpnhhrtghpthhtoheplhhinhhugidqshgvrhhirghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

> 8250 driver has device nodes like /dev/ttySxxx. Just to be sure are you really
> using kernel's native driver?

Yes, I just have a udev rule to make it easier for my testing.

KERNEL=="ttyS6", SYMLINK+="exar_serial"

>
> > At this point, this leads me to believe that there is actually a more
> > fundamental problem with the 8250 driver and flushing data.  I was
> > focusing more on the exar, since that is the only hardware that I have
> > available that uses the 8250 driver.
>
> Hmm... It's weird that no-one else had noticed so far an issue.

That was my thought as well.  My thought is that *normally* this isn't
an issue, since whatever program is writing to the serial port will
keep it open long enough for the data to be transmitted before
exiting, at which point the shutdown gets triggered.

I'll try to keep an eye on this issue at least, and test any patches
as they come.

-Robert Middleton


-Robert Middleton
