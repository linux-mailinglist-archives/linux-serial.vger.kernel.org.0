Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4654A45E21
	for <lists+linux-serial@lfdr.de>; Fri, 14 Jun 2019 15:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfFNN2W (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 14 Jun 2019 09:28:22 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33291 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727729AbfFNN2W (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Jun 2019 09:28:22 -0400
Received: by mail-lj1-f193.google.com with SMTP id h10so2438619ljg.0
        for <linux-serial@vger.kernel.org>; Fri, 14 Jun 2019 06:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=JP80xhJ18NHJTNjcJo/Bl2P17GO3TeYYX7NMTL4bldU=;
        b=jCVPuxQ4FkNfKFICCJ64CLjzX0+2/2H8B3cvdNjNlaHJN3AGvmifoDziGRvHPB3bgH
         UfFkggC1blN1qF45kN3uCp/vUPVwn+JV4CJZc85fSxWXq/Ti/faPBRxBI9rzkV2lXulY
         bJ/DEz6FhlV4wqqB5jVVt5vtfkhWvrounG0i//kCKtY/9kUN9ncnqCs9ADEwPjmi40rS
         Q0LG3UZxOuI90zQgTl++h0vly8VtJ6vZHm6v8Urc/cvAfgg8JQ0ARw0AEimXmuE+IJZA
         /zlPF3ikSVP0kAvJpudoTzNTQTi6cFN5858U8g8CKebCNEulNlXVHBPofwwTthcl0O4K
         c+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=JP80xhJ18NHJTNjcJo/Bl2P17GO3TeYYX7NMTL4bldU=;
        b=C2ce3FLy6HW8bJ3iH3jMZZ8n6CRwvcpRxDHTubOSuaEQ5Mdjto0L+saJFLYH3qqjrZ
         Zm+56Ihx1M4dN4RHI78oaVBxUFnREVrCcqVTP9zwpisCR3gaMQ3Gh1U79bXapP2S9hE7
         6AST3HEisyZuCN+bZkRZDzc/uCgY43vuPHT+GdHWFOXEMgEwowFtdUkSdsZeLcc6U6bx
         WEE7PmCIwOjI2/IScc98iob5rQIcX3zp7WwpchQyy7s/lCtxWMRHIK3haiT4ZKEZnPGn
         eZFZtGrpMDM2fBAIJoS6+qOYjKLWUgjja47krmYZfHuv57J2KkZkwLh856NQuWt8lFD4
         oWgQ==
X-Gm-Message-State: APjAAAU4g9JHpIJQHogsODO59iD/l1cAkr/ZxsA6xwXNzqF6wKNlEPOl
        eB7B+bbUwVllbVcCWRJLuOk=
X-Google-Smtp-Source: APXvYqztMxGSY6Lx00111C1VMpGUt2o8MjP80aHxfw8oK8R/O4efjZgP55gdmTrXrRjqaACcbG3gIQ==
X-Received: by 2002:a2e:9e4c:: with SMTP id g12mr25744328ljk.3.1560518899979;
        Fri, 14 Jun 2019 06:28:19 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id b11sm597852ljf.8.2019.06.14.06.28.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 06:28:18 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Lothar =?utf-8?Q?Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH RFC 5/7] serial: imx: set_termios(): preserve RTS state
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
        <1560514294-29111-1-git-send-email-sorganov@gmail.com>
        <1560514294-29111-6-git-send-email-sorganov@gmail.com>
        <20190614150551.1472b154@karo-electronics.de>
Date:   Fri, 14 Jun 2019 16:28:17 +0300
In-Reply-To: <20190614150551.1472b154@karo-electronics.de> ("Lothar
 \=\?utf-8\?Q\?Wa\=C3\=9Fmann\=22's\?\=
        message of "Fri, 14 Jun 2019 15:05:51 +0200")
Message-ID: <87blz09tzi.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Lothar Waßmann <LW@KARO-electronics.de> writes:
> Hi,
>
> On Fri, 14 Jun 2019 15:11:32 +0300 Sergey Organov wrote:
>> imx_set_termios() cleared RTS on every call, now fixed.
>> 
>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> ---
>>  drivers/tty/serial/imx.c | 12 ++++++++----
>>  1 file changed, 8 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>> index 8ee910f..de23068 100644
>> --- a/drivers/tty/serial/imx.c
>> +++ b/drivers/tty/serial/imx.c
>> @@ -1564,6 +1564,13 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
>>  
>>  	spin_lock_irqsave(&sport->port.lock, flags);
>>  
>> +	/*
>> +	 * Read current UCR2 and save it for future use, then clear all the bits
>> +	 * except those we will or may need to preserve.
>> +	 */
>> +	old_ucr2 = imx_uart_readl(sport, UCR2);
>> +	ucr2 = old_ucr2 & (UCR2_TXEN | UCR2_RXEN | UCR2_ATEN | UCR2_CTSC);
>> +
>>  	ucr2 = UCR2_SRST | UCR2_IRTS;
> s/=/|=/

Nice catch!

Thanks,

-- Sergey Organov
