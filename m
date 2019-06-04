Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95F3333E17
	for <lists+linux-serial@lfdr.de>; Tue,  4 Jun 2019 06:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfFDEmx (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 4 Jun 2019 00:42:53 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35494 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfFDEmx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 4 Jun 2019 00:42:53 -0400
Received: by mail-lf1-f68.google.com with SMTP id a25so15360846lfg.2
        for <linux-serial@vger.kernel.org>; Mon, 03 Jun 2019 21:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qX/3VNW4dD6b8zeXj0zxREbJZsBec1oYxxyfUmRhjC4=;
        b=Vare54z9K14h+exOSv7zUrmZNQr11sPibZzJROgsaDQVwiaMY3dW4QjUovJh6ZYCu/
         Vy72lNowgCm54KKrdPuX1tU1zRbioyBHUaKA+dy7SVCQD3IzrLxNY2hcG/Cq/1neIbzw
         wbP4cA8RFEPuCknHGz2W/FNTPfq2pc5zkkR0PC6fVWS9fMReIuSglN3lKcky8/b9zQLj
         G3CTajAws/1DCKlQ4/mg2FZIFw5kuCA8Kg5nrfi/Hu/VSB5uTdnafXMJp4q0r2njNTqr
         Xx9NBZl0MONo2wx3nIogsVNGoawiWiJ6p7R2KUZ4Q6BD2pHkFgl1fAYRFOVE8bguMjnS
         5H/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=qX/3VNW4dD6b8zeXj0zxREbJZsBec1oYxxyfUmRhjC4=;
        b=R4BYvRRFu/2R961zI9UD8+trGImNrbatSh7Z3392WPKwbJhoJVYMkzyGIN5dYch0uy
         VsHf2rClgcIpVYB7hwWvEYgJPZY3aW1npqzUOYTAIV3wy6QSUxu8U50QMQC+Yeh2pOwj
         hgawHkdaq6EmxBZnFQpL+PvKNhPAyHn32ywnJZph+r9xT37iA4PIe2Py4gPTNgYyDLXt
         mIemsDmcyD9kDOBIohGdhqnvIvAVbqOsP+FCY7mwWoy0hIpQ5x+lL0eqT6xB/KPsyzYv
         bfHLhgDyKiib7v2ud/tF8Y7xtf7me05cYh6sf1BDqpn1wuLKLDZsOdmqSG8xhSwUui/f
         lQ6g==
X-Gm-Message-State: APjAAAVTk2yDzmiF9+Zk1AG4SqSs7WrrZm7tvzI6FWbOOf62wuO/1cW8
        nqqsktXsi9b2SiCnFcgpxCI=
X-Google-Smtp-Source: APXvYqxc5J8cQNVriy07KppdU7+H2u1R1jhY8yL+vzqrcPPe3K4pzKMGKFT5G4Hg+2IYBLN7ymEHLQ==
X-Received: by 2002:ac2:569c:: with SMTP id 28mr2615907lfr.147.1559623371659;
        Mon, 03 Jun 2019 21:42:51 -0700 (PDT)
Received: from osv ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id n7sm3043486lfi.68.2019.06.03.21.42.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 21:42:50 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 2/8] serial: imx: fix breaking RTS/CTS handshake by mctrl change
References: <20190530152950.25377-1-sorganov@gmail.com>
        <20190530152950.25377-3-sorganov@gmail.com>
        <20190530203931.n6b22ktbzuyg67sd@pengutronix.de>
        <87woi7ur1g.fsf@javad.com>
        <20190531062809.nacg54russc3wvcz@pengutronix.de>
        <20190531135438.bqrpek6niddnrqmo@shell.armlinux.org.uk>
        <87r28ea2qa.fsf@javad.com>
        <20190601161256.4zuhqzrdskjdymu5@pengutronix.de>
        <20190601193436.irs6sdknz755uyem@shell.armlinux.org.uk>
        <875zpm7ty1.fsf@javad.com>
        <20190603154041.disl65ibr5zasqor@shell.armlinux.org.uk>
Date:   Tue, 04 Jun 2019 07:42:49 +0300
In-Reply-To: <20190603154041.disl65ibr5zasqor@shell.armlinux.org.uk> (Russell
        King's message of "Mon, 3 Jun 2019 16:40:41 +0100")
Message-ID: <87v9xm0xme.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Russell King - ARM Linux admin <linux@armlinux.org.uk> writes:

> On Mon, Jun 03, 2019 at 03:08:06PM +0300, Sergey Organov wrote:
>> Russell King - ARM Linux admin <linux@armlinux.org.uk> writes:
>> 
>> [...]
>> 
>> > If we want the kernel to stop reading the FIFO, we would have to add
>> > additional complexity to a lot of serial drivers, and a capability
>> > which tells the kernel that they support this behaviour - why do we
>> > want individual drivers to have to implement this?
>> 
>> How does it work when no handshake is configured? Drivers continue to
>> read FIFOs/TxDs and drop data when software buffers are full, spending
>> CPU cycles on nothing?
>
> I assume what you mean by "no handshake" is "no flow control",

Yes, "no flow control" I mean, thanks for clarifying!

> then yes, the CPU continues to read the FIFO and drops the received
> characters on the floor.

This is a surprise and the core source of my misunderstanding of how
system works.

The only remaining question (now unrelated to the patch) is why it works
this way, see below.

> When no flow control is configured, it means there is no way to signal
> to the remote end that there is congestion at the receiving end, and
> if there is no buffer space available, where would you expect the
> received characters to be stored?

They would be dropped by hardware, exactly the way you are describing:

> If the CPU were to stop reading the FIFO, the result would be that the
> FIFO fills, and then any further characters received get discarded by
> the hardware (instead of the CPU) and the hardware marks an overrun
> error.

That's what would happen indeed. What's the problem, exactly? Why CPU
needs to spend its cycles performing this work when hardware happily
does it at no cost?

-- Sergey
