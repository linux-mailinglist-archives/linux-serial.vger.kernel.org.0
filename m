Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17C9C57BD5
	for <lists+linux-serial@lfdr.de>; Thu, 27 Jun 2019 08:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725787AbfF0GRA (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 27 Jun 2019 02:17:00 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37154 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfF0GRA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 27 Jun 2019 02:17:00 -0400
Received: by mail-lf1-f66.google.com with SMTP id d11so732616lfb.4
        for <linux-serial@vger.kernel.org>; Wed, 26 Jun 2019 23:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=XYEjiJTeyQ5U99X7kJjQf+Ev0bkoLJk0WjwJL25Sz9w=;
        b=NuMc6XzOORvmEEOQQTHGNq45yt74PyvbnhxiLeJ/aTXCQqrblvaW2MAXDnub436iW1
         VdZ0gdd0kpK1pdrPj0z7RuHIchRcn1vROhpFvXBMOtvDSERcpLhVbVco1/EhgJHnkIYR
         QgX2leKzsX+EKghX4/vmavhDMrwZidBAc/bLvXok9aSafOnonhW0sLXyLnfeYmPXWFsb
         U3aTB3CAqFk/FMJ/jT9kBr+EcicvVDIQX7/G6fFLKiOVFKLrTFAYjQTyVWPSzg5ukSeh
         wUF7YvBFgzWMfQvLdKzuaz7LQn+OHTs7k9qOewHunVgvcAg2YlV58lwFmCBhXJ8qhRZV
         xpDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=XYEjiJTeyQ5U99X7kJjQf+Ev0bkoLJk0WjwJL25Sz9w=;
        b=JSjD8QJkshqfyjCm9WWt+XHwvEPpHzwAMXzrXGePAPvhrYyAMDd6woBavfUZmXwapC
         hcvDln4NwS72pBTNppcn2EOEvroINNUmJAQD+uli/qHJUSdj09SYK4tazKz1FLMA6UY/
         UYVlFpVbSGyofuyl5fJf7l29Rp8UbhNQveLlxnPLw8IUfo0iIcZ0VPBeFrodhdB0S2X3
         bekebvTJ0opdCp8mLBFUW2UWOL4S+bFjGYamOF2sWw/aiMIbvmhpUKR1TkEtaGWYrKIw
         TsBwN2iPpFPfvmU5tBY+7CRAK6m2bekzy95F3jgKuw6Rv6ToJ2Kz38W9WwQ6poOa9Tb9
         2M9A==
X-Gm-Message-State: APjAAAW1DtMxXE6RKh34c4jB3Xf9XO7/d6JHFGekA348TUvO4mJHd4OG
        Db83i9cMfEOA5Tct76LeAzc=
X-Google-Smtp-Source: APXvYqyhrNzgnfYBH/1xOQhgmByqTyp7L01t2XK4bVMNnxZxMdTuSlT5FKdEfzFMX90At4vQcYRMJQ==
X-Received: by 2002:a19:5515:: with SMTP id n21mr1063065lfe.26.1561616218618;
        Wed, 26 Jun 2019 23:16:58 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id q6sm184064lji.70.2019.06.26.23.16.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 23:16:58 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v2 5/7] serial: imx: set_termios(): do not enable autoRTS if RTS is unset
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
        <1561558293-7683-1-git-send-email-sorganov@gmail.com>
        <1561558293-7683-6-git-send-email-sorganov@gmail.com>
        <20190627054733.wssatfb2i257737m@pengutronix.de>
Date:   Thu, 27 Jun 2019 09:16:57 +0300
In-Reply-To: <20190627054733.wssatfb2i257737m@pengutronix.de> ("Uwe
        \=\?utf-8\?Q\?Kleine-K\=C3\=B6nig\=22's\?\= message of "Thu, 27 Jun 2019 07:47:33
 +0200")
Message-ID: <87tvcbimcm.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:

> On Wed, Jun 26, 2019 at 05:11:31PM +0300, Sergey Organov wrote:
>> set_termios() shouldn't set UCR2_CTSC bit if UCR2_CTS (=TIOCM_RTS) is
>> cleared. Added corresponding check in imx_uart_rts_auto() to fix this.
>> 
>> Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
>> Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> ---
>>  drivers/tty/serial/imx.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>> index e0f5365..4867f80 100644
>> --- a/drivers/tty/serial/imx.c
>> +++ b/drivers/tty/serial/imx.c
>> @@ -405,7 +405,8 @@ static void imx_uart_rts_inactive(struct imx_port *sport, u32 *ucr2)
>>  /* called with port.lock taken and irqs caller dependent */
>>  static void imx_uart_rts_auto(struct imx_port *sport, u32 *ucr2)
>>  {
>> -	*ucr2 |= UCR2_CTSC;
>> +	if (*ucr2 & UCR2_CTS)
>> +		*ucr2 |= UCR2_CTSC;
>>  }
>
> I wonder if this patch is only correct in the presence of the previous
> patch. With the code currently in mainline imx_uart_rts_auto() is only
> called with UCR2_CTS unset.

Yes, exactly.

Thanks!

-- Sergey
