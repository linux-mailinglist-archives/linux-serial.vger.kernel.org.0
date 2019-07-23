Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB89716C9
	for <lists+linux-serial@lfdr.de>; Tue, 23 Jul 2019 13:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389135AbfGWLQO (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 23 Jul 2019 07:16:14 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33652 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbfGWLQN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Jul 2019 07:16:13 -0400
Received: by mail-lf1-f65.google.com with SMTP id x3so29148656lfc.0
        for <linux-serial@vger.kernel.org>; Tue, 23 Jul 2019 04:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=uWLrxdB1YlL1e2yILO6RKcVIPzmT+Y8FCjuyUQsFapw=;
        b=A3pVnUnVpzwovSwDrm+a8OLwwKS+QU9e/Cvpit+/NfXEElXL82NrIC1Xv7vplT2g7q
         1A3m/Tm6bv23Wf4x8b6Gyb8qGGETYqu1E8Pw8L7N0XR0PIewVkR8FOqWgbM25RvZgs3F
         wCG6CdP3NnJcZRWGGdjssi649RFMJYu2UlYBO8p6pdcmJqot2qGu0mC4CK7zKXbZfr9J
         hIqiHKlUOyhjjnpm67YEX+DWGiBmFRYuUi2rhk3nibw1eO3iBhijTqskIKWY/qYyHXxR
         GzaZoYXKftfBtCkgLAWbe/D9ysUlPUTrKgbUGCiBW+XTlumPwisxfqA/h7YcVS0P68Ao
         6YqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=uWLrxdB1YlL1e2yILO6RKcVIPzmT+Y8FCjuyUQsFapw=;
        b=rCZNTDE2GSDM87hhPblwHM+zqKK53e0M+KxGTCXQPuGWZK7ZjkVSTROmLA1iA47k6f
         /zK2ypBoFGIc6JJfblvB0m/1QZFNodeJT82EyVH6KBawxIT3g2jRBxQDbW5BYBj6OXg6
         QV8LfLRvurmPg7NGucUrthlFr3PSrkp/m4CGpm6jTee8j0JCLQv4MaKdAA2F/ms5gNYx
         pg6Q6UcQraVnMuKdTvLBue1g3jfDlPvke7fY6tKmFA3rKt4UUjde05q7rcFznI+3shrO
         iB5HHDT4p/RkmY1xH/BEppxWtEoBHy8i8mlgGbhq5afTNB/q8SyXlyfIcabwdm4Ca3xM
         /wNw==
X-Gm-Message-State: APjAAAW1NmyuqKGjEM8WB9fThg/YRgJ0/hLBrG7EgmpxlcMH4EW3BlI0
        p6sKaYII+ch5N1tZPqBS/PE=
X-Google-Smtp-Source: APXvYqws8VXn9UlrFkCScVrd/Ljm5RWIohBgoNuqABIXkTQJLxsYj2xrhuC95qkvGa/TTaDrTfzDeg==
X-Received: by 2002:ac2:51a3:: with SMTP id f3mr7266804lfk.94.1563880571771;
        Tue, 23 Jul 2019 04:16:11 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id t63sm7929211lje.65.2019.07.23.04.16.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 04:16:11 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v6 2/3] serial: imx: set_mctrl(): correctly restore autoRTS state
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
        <1563823331-5629-1-git-send-email-sorganov@gmail.com>
        <1563823331-5629-3-git-send-email-sorganov@gmail.com>
        <20190722202406.hr74mg64sxoovah7@pengutronix.de>
        <87h87d1509.fsf@osv.gnss.ru>
        <20190723094902.r7v5wzu4lkicrs3o@pengutronix.de>
Date:   Tue, 23 Jul 2019 14:16:09 +0300
In-Reply-To: <20190723094902.r7v5wzu4lkicrs3o@pengutronix.de> ("Uwe
        \=\?utf-8\?Q\?Kleine-K\=C3\=B6nig\=22's\?\= message of "Tue, 23 Jul 2019 11:49:02
 +0200")
Message-ID: <87muh5ypae.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:

> On Tue, Jul 23, 2019 at 12:20:38PM +0300, Sergey Organov wrote:
>> Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:
>> 
>> > On Mon, Jul 22, 2019 at 10:22:10PM +0300, Sergey Organov wrote:
>> >> imx_uart_set_mctrl() happened to set UCR2_CTSC bit whenever TIOCM_RTS
>> >> was set, no matter if RTS/CTS handshake is enabled or not. Now fixed by
>> >> turning handshake on only when CRTSCTS bit for the port is set.
>> >>
>> >> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>
> Oh, you added my Ack for patches 2 and 3, too, even before I looked
> again on those :-|

Oops, I thought you've looked at all 3 before starting to comment.

-- Sergey
