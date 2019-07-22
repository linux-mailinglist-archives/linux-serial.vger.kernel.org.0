Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77368701CF
	for <lists+linux-serial@lfdr.de>; Mon, 22 Jul 2019 15:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbfGVN5x (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 22 Jul 2019 09:57:53 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39134 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728637AbfGVN5w (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Jul 2019 09:57:52 -0400
Received: by mail-lj1-f193.google.com with SMTP id v18so37657515ljh.6
        for <linux-serial@vger.kernel.org>; Mon, 22 Jul 2019 06:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=fCMx7KLosHFbgae9ScFTq6i/Za6Qpfm7uxFK3ITffxE=;
        b=QIhR8VcusTi+BJlFo+wD9KS67mSsIdcxqflU9AibXMwuObgWmyT9LQgtD9YTz0H+ww
         CVu91GkksnAIubo9dXZV+0MF4nx7musgl8XN2zFaOsvvKcIm6MC0TXaH95bjgk8zChPs
         tiFNIFsmLVoQbTrJVvdX4A2/Hv/XjWwEjFZdB0504tVXs1wFgSjO9xlKPss875xqPXDt
         0EhKwPe+QyUItamvkIiNrKLAwfoWlMOTy1Ebs/UkDwTEKxRRo6rzGBKGyIZP94+2K+Qt
         JrWM+zSu0Bd39KLJF73zV0dd9mEVvT0seHxIXAV8lMzyRylep5F7SzREBOGdENqiiZR5
         SF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=fCMx7KLosHFbgae9ScFTq6i/Za6Qpfm7uxFK3ITffxE=;
        b=uYzAC86ZgKkHiTHoOx2lsLz4dcZTTnzcfW51nRchrAvdY4KCKn57OGC+ynlKIXzWO+
         SNhy3s0dd7cwJCbeLmOKWuPrF6qmOBpmlDJY2h8PNce464c/ge0REnENmd+q3DPErgHQ
         6pLHF2u8Q59JdbjqydQJigbF6q4dN/LADIYbZI0vP9yH0salrpBDjnaG5AxIAe/8jYK4
         dB5sm9Je9K3idsAyR0wNTDBV9gRN79V6ZZe66rGjlyMRlaIlJwZch0GYiehV+Hx8XWF0
         dph6FjoqvrtCJWouA/Zrw0CJsVgjkjBO49o7KMNfcjf6T/FOpeCUCu2Y8F4QRa3sU7lY
         KEEA==
X-Gm-Message-State: APjAAAW7bTixEU/r3h+7/BeSR29X5xTxhbNMo2qWjHR23qHGdNkaAHeB
        OLNvcM2cF1z9+57eA2Vwj0I=
X-Google-Smtp-Source: APXvYqwBK8uvo+DJD4GxsoVOHdnu74BtLYrwR6BCeehLVZyL99tko++CmwogdOypaNDHh0YtOmUSWQ==
X-Received: by 2002:a2e:9685:: with SMTP id q5mr22202686lji.227.1563803870732;
        Mon, 22 Jul 2019 06:57:50 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id t25sm6029513lfg.7.2019.07.22.06.57.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 06:57:50 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v5 1/3] serial: imx: set_termios(): do not enable autoRTS if RTS is unset
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
        <1563787330-1394-1-git-send-email-sorganov@gmail.com>
        <1563787330-1394-2-git-send-email-sorganov@gmail.com>
        <20190722095405.qdc77cb2qrgltzrx@pengutronix.de>
Date:   Mon, 22 Jul 2019 16:57:49 +0300
In-Reply-To: <20190722095405.qdc77cb2qrgltzrx@pengutronix.de> ("Uwe
        \=\?utf-8\?Q\?Kleine-K\=C3\=B6nig\=22's\?\= message of "Mon, 22 Jul 2019 11:54:05
 +0200")
Message-ID: <877e8a5fz6.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:

> On Mon, Jul 22, 2019 at 12:22:08PM +0300, Sergey Organov wrote:
>> Don't let receiver hardware automatically control RTS output if it
>> was requested to be inactive.
>> 
>> To ensure this, set_termios() shouldn't set UCR2_CTSC bit if UCR2_CTS
>> (=TIOCM_RTS) is cleared. Added corresponding check in imx_uart_rts_auto()
>> to fix this.
>> 
>> Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>
> I think it's a bit bold to add a review-tag for me here. The best reason
> for that that I'm aware of is that I wrote for v4: "[I]f you update the
> commit log as agreed already before and even add a comment in
> imx_uart_rts_auto along the lines of ... you can have my Ack." which IMO
> isn't good enough to justify a "Reviewed-by". I wouldn't even add an
> Acked-by: without the other person being able to actually see the
> changed patch (but this might be arguable).

I'll do whatever you say. Should I remove the Reviewed-by: you, or is it
OK to leave it in, to avoid re-iterating again?

Best Regards,

-- Sergey
