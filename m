Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8579F70951
	for <lists+linux-serial@lfdr.de>; Mon, 22 Jul 2019 21:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfGVTJq (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 22 Jul 2019 15:09:46 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33504 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730907AbfGVTJp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Jul 2019 15:09:45 -0400
Received: by mail-lf1-f67.google.com with SMTP id x3so27545120lfc.0
        for <linux-serial@vger.kernel.org>; Mon, 22 Jul 2019 12:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=+zMDB24dspP/iLIXMIj9PpmNMrfDvY3AO+F+yJyhMms=;
        b=iutFyec6hc915R8rCnn5qldGN5JVyOYP9XgzoCcaJ4+EacXfe0BzRc7lYWC8Eb+oCA
         Q/Tmn8ORaGElv7kU9dn94J1DNHDf+bDxc7nO/mLN8+5nhGaW6mRd1ykNPXxTHDzTu5Cf
         aXFxNDliNUIjwQRZqi9T4n3eZqAG8pGvjTVJPApKiVyOt/KxDskNykMz3MZQ7r/giR1v
         TPzJEVZyYYNuAl0xTuKxbPpGZb9LK5KBp9Ck0qGRwXNZUdeNS6hVl7zcbcTvuOnO61Qa
         gfJZEFxLw/8wbWWaLVfa32IOJSEThyCpYGN/xAtN/2u28Dt3JpmW1vaqtP7XErUvtIuc
         y7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=+zMDB24dspP/iLIXMIj9PpmNMrfDvY3AO+F+yJyhMms=;
        b=POuZzpj2cfNMo0+9wNOEHn3fdwe07YtCHX3PpU6tOurg2cy4/YxokaLhtjutLhTA/w
         q3wI6Yh++4q7NNDz78ApYtVcvpjH9JGopdfnKHRP8aim+Fg2STjMv1aB7wUXpxpsZzRa
         3h9u1dJeoIDLM3HNcXj3KKzQ04xdzsGLHPodFzX8RDlp12FJYq1Hu8GdqEpJDfCdU8k5
         kKCKzFlEA7ZnAM7GJmox3G1SkkTrtVTrLRAil5yX93vdIgleFEzkDeMXL6692T6y53Ll
         9hG4RtxI2/Yw7AOkh/GP18rNN+4tZfCyaAeoLNiUAx/7k13yO57mDtmyeUpWmqee0AAh
         U+mw==
X-Gm-Message-State: APjAAAU1sl6D0CBprgNAiD6SO4ROE+pXxwzpIdR9q/2dwRQxXb0Ieb8e
        rllS3IPjcbwIby5IxmL0npQ=
X-Google-Smtp-Source: APXvYqzqFtNrgXV2AySCjJd/ErFDFPZuPAegcl22U/fmZ8t9ZQc6/B8kO2pUO9rgReQIlzBAk/InQw==
X-Received: by 2002:ac2:5690:: with SMTP id 16mr31731048lfr.43.1563822583269;
        Mon, 22 Jul 2019 12:09:43 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id j7sm8492361lji.27.2019.07.22.12.09.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 12:09:42 -0700 (PDT)
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
        <877e8a5fz6.fsf@osv.gnss.ru>
        <20190722162011.wv36d7epunjm4h4t@pengutronix.de>
Date:   Mon, 22 Jul 2019 22:09:41 +0300
In-Reply-To: <20190722162011.wv36d7epunjm4h4t@pengutronix.de> ("Uwe
        \=\?utf-8\?Q\?Kleine-K\=C3\=B6nig\=22's\?\= message of "Mon, 22 Jul 2019 18:20:11
 +0200")
Message-ID: <87ftmx3myy.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:

> On Mon, Jul 22, 2019 at 04:57:49PM +0300, Sergey Organov wrote:
>> Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:
>> 
>> > On Mon, Jul 22, 2019 at 12:22:08PM +0300, Sergey Organov wrote:
>> >> Don't let receiver hardware automatically control RTS output if it
>> >> was requested to be inactive.
>> >> 
>> >> To ensure this, set_termios() shouldn't set UCR2_CTSC bit if UCR2_CTS
>> >> (=TIOCM_RTS) is cleared. Added corresponding check in imx_uart_rts_auto()
>> >> to fix this.
>> >> 
>> >> Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>> >
>> > I think it's a bit bold to add a review-tag for me here. The best reason
>> > for that that I'm aware of is that I wrote for v4: "[I]f you update the
>> > commit log as agreed already before and even add a comment in
>> > imx_uart_rts_auto along the lines of ... you can have my Ack." which IMO
>> > isn't good enough to justify a "Reviewed-by". I wouldn't even add an
>> > Acked-by: without the other person being able to actually see the
>> > changed patch (but this might be arguable).
>> 
>> I'll do whatever you say. Should I remove the Reviewed-by: you, or is it
>> OK to leave it in, to avoid re-iterating again?
>
> I'd like to have it an Acked-by.

OK, will do, thanks!

-- Sergey
