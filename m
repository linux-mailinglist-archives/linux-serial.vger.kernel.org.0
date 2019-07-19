Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 981C26E585
	for <lists+linux-serial@lfdr.de>; Fri, 19 Jul 2019 14:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbfGSMSR (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 19 Jul 2019 08:18:17 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39726 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfGSMSR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 19 Jul 2019 08:18:17 -0400
Received: by mail-lf1-f66.google.com with SMTP id v85so21575325lfa.6
        for <linux-serial@vger.kernel.org>; Fri, 19 Jul 2019 05:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=sJJ3haStcYVCQLC55Zqi45W+Uiy3h1nIfrW7f0A8CjY=;
        b=IvT3gbmDE5KfscUD4MlFZ8DgTuxdqb8vhDHkn7KRp3eXACtYdlfeseLCD4aXmMaQn2
         StE83aZwsPETq45KDHNy1q/ErF54C2Mhk3AES8ljls1MiMUgr81fEAitAW7W8pxrGjh/
         1kX77DbhKOfBCnMZ7rnL+qkjcqjk8lCkQd0HHWYzA6zIaZOsv3XT44u9Zr8X4XlELYOd
         lW1L/VK5YWLJGIKnorkPkrjVO1ZUi8PDmCsld8olqmLWAPnJuxD4GRl8VETBog+Co5CJ
         WHgZk30tpRVaDw4UDrOMkjVC7FO0pLxCP8phhXlKKXxxoCorjbWsTqVfEJTYLlHWXcSx
         sTDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=sJJ3haStcYVCQLC55Zqi45W+Uiy3h1nIfrW7f0A8CjY=;
        b=ZYYP8KMxpWmuOVg3yYpIwH00LXMlCnpdVx9ZavZecL3pVOaz7VJ1uyKHSx0Cm2LMui
         1qImECokTN31PcTzTcHNvSFI5n13cPHkZvYz0SovtO84DzNFCDacM6E2lU5s64Vg7LpB
         AiVmdfkhDlJyV0XAH9KLrtS8KvyP6JzkmvW93ploNR9C9YFZUqIH4yIbKHi427OCKay/
         7xfGQA0Rnlc30DoRZd7tIj4N041eTZX46NBHPgIhQ7mkKXjbovVAy6MYi8e01Hnl4lpo
         B7cIoIh3/vg2T2GCj1jCdYMLZX2HKC5eFSXoY3tBJMFtohKaBv+0YiiIINvKDuFLMdYS
         ZzGA==
X-Gm-Message-State: APjAAAXSVPS2L5ehf2oxquqKQljUKF4+Zc1bHyNoOLkoX4SWoXbVPeRT
        BIBSK1+hLM4zv5g1ZfvDgZE=
X-Google-Smtp-Source: APXvYqxyI377xpuBRTvwQ07onopaIqNWtwQT6nzJm5OZLgnAIi0mh1DVlznyn1O2xj5L9EkhN/60Bw==
X-Received: by 2002:a19:c514:: with SMTP id w20mr24217711lfe.182.1563538695628;
        Fri, 19 Jul 2019 05:18:15 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id b68sm6435545ljb.0.2019.07.19.05.18.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jul 2019 05:18:14 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/3] serial: imx: set_termios(): do not enable autoRTS if RTS is unset
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
        <1563526074-20399-1-git-send-email-sorganov@gmail.com>
        <1563526074-20399-2-git-send-email-sorganov@gmail.com>
        <20190719091143.uhjxeibtolgswq2l@pengutronix.de>
Date:   Fri, 19 Jul 2019 15:18:13 +0300
In-Reply-To: <20190719091143.uhjxeibtolgswq2l@pengutronix.de> ("Uwe
        \=\?utf-8\?Q\?Kleine-K\=C3\=B6nig\=22's\?\= message of "Fri, 19 Jul 2019 11:11:43
 +0200")
Message-ID: <87h87idxq2.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:

> On Fri, Jul 19, 2019 at 11:47:52AM +0300, Sergey Organov wrote:
>> set_termios() shouldn't set UCR2_CTSC bit if UCR2_CTS (=TIOCM_RTS) is
>> cleared. Added corresponding check in imx_uart_rts_auto() to fix this.
>
> This is not understandable unless you read the reference manual.
>
> In terms understandable without manual, this patch does:
>
> 	Don't let the receiver hardware control the RTS output if it was
> 	requested to be inactive.

I'll fix it, thanks!

>
>> Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
>> Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> ---
>>  drivers/tty/serial/imx.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>> index 57d6e6b..95d7984 100644
>> --- a/drivers/tty/serial/imx.c
>> +++ b/drivers/tty/serial/imx.c
>> @@ -405,7 +405,8 @@ static void imx_uart_rts_inactive(struct imx_port *sport, u32 *ucr2)
>>  /* called with port.lock taken and irqs caller dependent */
>>  static void imx_uart_rts_auto(struct imx_port *sport, u32 *ucr2)
>>  {
>> -	*ucr2 |= UCR2_CTSC;
>> +	if (*ucr2 & UCR2_CTS)
>> +		*ucr2 |= UCR2_CTSC;
>
> I think this patch is wrong or the commit log is insufficient.
> imx_uart_rts_auto() has only a single caller and there ucr2 & UCR2_CTS is
> never true. And CTSC isn't restored anywhere, is it?

This is rebase to 'tty-next' branch, and you need to look at it in that
context. There, ucr2 & UCR2_CTS does already make sense, due to previous
fix that is already there.

Alternatively, look at v3 of the patches, but you basically already did.
It's that the first part of v3 patch series has been already accepted
upstream, and this is the rest of those patches.

Thanks!

-- Sergey
