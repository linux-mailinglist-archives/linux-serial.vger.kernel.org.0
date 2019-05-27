Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E845E2B8C1
	for <lists+linux-serial@lfdr.de>; Mon, 27 May 2019 18:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbfE0QMv (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 27 May 2019 12:12:51 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38550 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbfE0QMs (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 May 2019 12:12:48 -0400
Received: by mail-wm1-f68.google.com with SMTP id t5so23468wmh.3
        for <linux-serial@vger.kernel.org>; Mon, 27 May 2019 09:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5mEyxNiTxG7QHCldnzuLItg2WJUiLZE71Nb5mEMikHM=;
        b=Qdfu7lKbLkMVRKD6Gk7EDaRAOh0aHQeWqxjDWZvknbEkiHbKsi7MUieqe1q8sGforH
         it5X5CBTkk6qo5HNbES2BPpxyemCI6jyrLk3xnUgbwWjJoh/Ow0M4+2IUTCZAGqEAbQg
         D0qw0M8yy/tOMTfXLx4t+bVdXWkasDV0e1OK68nTpcw+pdg9fQzg8WsSX9LDU1q4YbYp
         XGdy2qR8AMJSV8pK7CtZCuNJ4/EuRlo04Ka/dr8MNMdo1w/xpqZtNZjyObGnL/bJnBku
         wRBWl2UF2uz7+wSaRjYdJPxBfPcfgsTQ1KJJ5tL5gE/AyiKI7Ifo582sH7jV988+ie2c
         xTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=5mEyxNiTxG7QHCldnzuLItg2WJUiLZE71Nb5mEMikHM=;
        b=PkXyox2SzNWRbn5iBpkfiRheTrJOsQqrDXtA+F51yEfug4LiLvwdbE1SMe4sejxohw
         1G6NqUtWw5Z1SvdE9TALqaBzecf2QLEK0F/9cyqUXrhefdGoQFQ5Jj6TY3OttQTExbFx
         pRt3IifXGkvtDL0CrnTmq5jr+imXKueAWSWJkyTzI6Q/IS+TTnDpIiQoWeXUrKoDUYAz
         mr7TX2xOOhJ8hxu6TNVX3pJi0afIfV2U2MviaybkvTaXR+g6XX6nFZNMYIT57NE+CZDe
         xIjkv86D9yy2IWofSdqUWJ5Zm3VKFvX0EZshcHDQ+Gc4XGIs7eDNBtEoWmZQoQkFTNCw
         JEHw==
X-Gm-Message-State: APjAAAW0VldOK6ntIhyO6hzQ7i7FErXLtKXCoaSK+PzIb/W1l7Nrg8j3
        AAV+W/PGjba8WGCuhVWn7YAihA==
X-Google-Smtp-Source: APXvYqxdhEw7utvMO4VRArF33KJ19jG5BwvZVlrj9QcVk6+kzn3PBObGHvAKrpcEoNeAF24NJ1LU5g==
X-Received: by 2002:a05:600c:228c:: with SMTP id 12mr14844150wmf.91.1558973565870;
        Mon, 27 May 2019 09:12:45 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id j123sm21766217wmb.32.2019.05.27.09.12.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 09:12:45 -0700 (PDT)
From:   Loys Ollivier <lollivier@baylibre.com>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial\@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-riscv\@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "gregkh\@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 0/2] tty: serial: add DT bindings and serial driver for the SiFive FU540 UART
References: <20190413020111.23400-1-paul.walmsley@sifive.com>
        <7hmukmew5j.fsf@baylibre.com>
        <883f3d5f-9b04-1435-30d3-2b48ab7eb76d@wdc.com>
Date:   Mon, 27 May 2019 18:12:43 +0200
In-Reply-To: <883f3d5f-9b04-1435-30d3-2b48ab7eb76d@wdc.com> (Atish Patra's
        message of "Thu, 18 Apr 2019 18:04:34 -0700")
Message-ID: <86sgszq3k4.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu 18 Apr 2019 at 18:04, Atish Patra <atish.patra@wdc.com> wrote:

> On 4/18/19 4:22 PM, Kevin Hilman wrote:
>> Hi Paul,
>>
>> Paul Walmsley <paul.walmsley@sifive.com> writes:
>>
>>> This series adds a serial driver, with console support, for the
>>> UART IP block present on the SiFive FU540 SoC.  The programming
>>> model is straightforward, but unique.
>>>
>>> Boot-tested on a SiFive FU540 HiFive-U board, using BBL and the
>>> open-source FSBL (with appropriate patches to the DT data).
>>>
>>> This fifth version fixes a bug in the set_termios handler,
>>> found by Andreas Schwab <schwab@suse.de>.
>>>
>>> The patches in this series can also be found, with the PRCI patches,
>>> DT patches, and DT prerequisite patch, at:
>>>
>>> https://github.com/sifive/riscv-linux/tree/dev/paulw/serial-v5.1-rc4
>>
>> I tried this branch, and it doesn't boot on my unleashed board.
>>
>> Here's the boot log when I pass the DT built from your branch via
>> u-boot: https://termbin.com/rfp3.
>>
>
> Unfortunately, that won't work. The current DT modifications by OpenSBI.
>
> 1. Change hart status to "masked" from "okay".
> 2. M-mode interrupt masking in PLIC node.
> 3. Add a chosen node for serial access in U-Boot.
>
> You can ignore 3 for your use case. However, if you pass a dtb built from source
> code, that will have hart0 enabled and M-mode interrupts enabled in DT.

Atish,
I'm trying to get the kernel boot with the current linux kernel DT from
Paul's patch series [0].

Could you point me to some documentation on 2. ?
Or do you know of a way to disable M-mode interrupts from U-boot ?

[0]: https://lore.kernel.org/patchwork/project/lkml/list/?series=390077

Thanks,
Loys

>
> Not sure if we should do these DT modifications in U-Boot as well.
>
