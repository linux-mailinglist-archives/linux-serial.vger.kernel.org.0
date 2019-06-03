Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1F53302E
	for <lists+linux-serial@lfdr.de>; Mon,  3 Jun 2019 14:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbfFCMtu (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 3 Jun 2019 08:49:50 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41012 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbfFCMtu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 3 Jun 2019 08:49:50 -0400
Received: by mail-lj1-f196.google.com with SMTP id s21so5419123lji.8
        for <linux-serial@vger.kernel.org>; Mon, 03 Jun 2019 05:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=X/Fp6iGxHAu/lnalHD1r9Fjglv+z5wxMbn3MXhPZfow=;
        b=eV2d99OQqhdbulGy0D2PByKUNJky+EPuESHMaDG71IZ3uyYUH4YuSNe1dp13skl7KV
         yFe4tmvaRlfhgimX/6OvJhZQGvjRNXmZ+OtvGzo0/D6wezvDGZrUr2eeSoYkjdWAV/kW
         AwA/CsRIINmj2PHw24eccPP0j/UyKpnvYj6CXWqtfA3g8EvBU1msa64HDEiV3AdA0NKr
         6jfBPL7h0+eppQ276ju0chfem25bCzzjRRjDIY5yHg+6BG4+jTUz98PcF5k5QjCQHzH1
         UCmd/sR+tqAFMLAZj8l6D+23Ul4FaQ75vvPHse4v4Jr68AKhg0pJi3gDE9kiJt8mAG1s
         cPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=X/Fp6iGxHAu/lnalHD1r9Fjglv+z5wxMbn3MXhPZfow=;
        b=fRn9Rnk0J3VZyesnT2sO1AQ97B8qnJgG3C5W3nKHqdChW5ieIQrrjL44fIDU3/Rj2q
         uGxxqcB2ZqsD4pNk/F/Q6ub13SWruDbmaTv05wKeGKP0E14ZfkmvbjoYeNYvUqbwoNAT
         LDDilKb92p15T8OWaCAL+y70FaiWmOGAU/AepvUSnfcwQcowBrpFsO8uNEWYxOGmvDlz
         dTCbSn+CGIAbe8uZd3+O06t338XVYZ0xt/hxdZbv2u/lULzKsU+toNxfHRWj/5yqvqVi
         hwWEj56304EqSsKkCA7zmxyidPUjBTKTmtjeKS69jp6/7c6Bsa9vXNOtJXIEWXnoQvZE
         3B7A==
X-Gm-Message-State: APjAAAVG2Uri3de75g/uWAGFmY4ocpPd87/PRSp+dwYPSCwfjKiyA3I6
        szzZLLPiw2xhZen7RBJ1GUqXWNAztgc=
X-Google-Smtp-Source: APXvYqzX+dmnIgVZSHsOgNNILwCL8FcJIpP9VPs28WkN6L00h+oSb1t2AzwjzcEgjN8mppmh/CbuMg==
X-Received: by 2002:a2e:a0d1:: with SMTP id f17mr13049573ljm.117.1559566188368;
        Mon, 03 Jun 2019 05:49:48 -0700 (PDT)
Received: from osv ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id r11sm2487947ljh.90.2019.06.03.05.49.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 05:49:47 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Russell King <linux@armlinux.org.uk>, linux-serial@vger.kernel.org,
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
Date:   Mon, 03 Jun 2019 15:49:46 +0300
In-Reply-To: <20190601161256.4zuhqzrdskjdymu5@pengutronix.de> ("Uwe
        \=\?utf-8\?Q\?Kleine-K\=C3\=B6nig\=22's\?\= message of "Sat, 1 Jun 2019 18:12:56
 +0200")
Message-ID: <87y32i6dg5.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello,

Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:
> Hello,
>
> On Fri, May 31, 2019 at 09:38:37PM +0300, Sergey Organov wrote:
>> Russell King <rmk@armlinux.org.uk> writes:
>> > If this is not done, data loss will occur: characters will be received
>> > from the FIFO, and the attempt to place them into the kernel buffer
>> > will fail, resulting in the characters being discarded.  This would not
>> > be an effective hardware flow control implementation.
>> 
>> Why? Doesn't kernel stop its receiving machinery anyway when software
>> receive buffers get filled?
>> 
>> If it does, that seems logical, then it will rather stop reading from
>> FIFO, and once FIFO fills above threshold (if at all), hardware will
>> de-assert RTS by itself, no complications required.
>
> Not all hardware has a FIFO

Actually, most (all?) have. TxD + shifter = FIFO of depth 1 ;-)

> and the necessary mechanisms to auto-deassert RTS when it fills.

This is correct.

> So there must be support in software to deassert RTS, too.

So there is. The question is why it still needs to be de-asserted
manually when there is hardware support to de-assert it automatically?

Hardware is capable to de-assert RTS automatically. Why do I need to do it
manually? 

I still see this as unnecessary complication of the logic of low-level
driver. (single) Top level could have been smarter to make (multiple)
low-level simpler.

Anyway, to get back to the patches, to fulfill current serial core
requirements, how about this:

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index dff75dc..ea95fe4 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -966,10 +966,17 @@ static void imx_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	if (!(port->rs485.flags & SER_RS485_ENABLED)) {
 		u32 ucr2;
 
+		/*
+		 * Turn off autoRTS (UCR2_CTSC) if RTS is lowered and restore
+		 * autoRTS setting if RTS is raised
+		 */
 		ucr2 = imx_uart_readl(sport, UCR2);
 		ucr2 &= ~(UCR2_CTS | UCR2_CTSC);
-		if (mctrl & TIOCM_RTS)
-			ucr2 |= UCR2_CTS | UCR2_CTSC;
+		if (mctrl & TIOCM_RTS) {
+			ucr2 |= UCR2_CTS;
+			if (port->status & UPSTAT_AUTORTS)
+				ucr2 |= UCR2_CTSC;
+		}
 		imx_uart_writel(sport, ucr2, UCR2);
 	}
 
> And even in the presence of a "smart" FIFO, the software then usually
> knows earlier about having to stop the other side and this might be
> the necessary margin that makes them stop before the local buffer is
> over full.

Suppose you have 4k software buffer and 4k hardware FIFO. Do you argue
wasting 4k of hardware FIFO space by manually stopping sender earlier is
the best thing to do?

It's more logical not to read from FIFO and disable Rx IRQ once there is
no space in the software buffer. Nothing complex. Just saying.

Regards,

-- Sergey
