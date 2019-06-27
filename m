Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF9C57D8C
	for <lists+linux-serial@lfdr.de>; Thu, 27 Jun 2019 09:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfF0H6R (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 27 Jun 2019 03:58:17 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41477 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfF0H6R (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 27 Jun 2019 03:58:17 -0400
Received: by mail-lj1-f195.google.com with SMTP id 205so1323390ljj.8
        for <linux-serial@vger.kernel.org>; Thu, 27 Jun 2019 00:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=SrYQt9XAw3qaOEUzWG3cFurd2CYrY9c39EX9R/cNWh4=;
        b=huMpTxcnNLTOaj70bYRxPO+C7I0mOoL9g1iWzizVLS6EsGGCEQttonGaS03GdnX4B+
         +1orA1/erkY6wioCaiVZANaA3/qnuiyphMwyR9R/cZg5ZRhKbyYtOndIXo6kTqjtU1lS
         cO70uX8vNHULIRetLEPQcNZag4Fjhl40MQUwTPxlf5XSdgWespvp4wwugdLTR+P4k+aM
         qIpAKip1ijdQuWWCTg52CnWYypdWIwOQvzdAnWnJ3bjgVirWUBMReQFY0kuPi5tOukAb
         JiTRMVYpo7RtwBcAmElpNFiMfaJJZWCvuLr4fR3Fw5xAbco7SNjU0vFbm2Jbree38Ngx
         3NAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=SrYQt9XAw3qaOEUzWG3cFurd2CYrY9c39EX9R/cNWh4=;
        b=ZDVIVP18QJtqCJ4e9g34/L+xJ0sHkZi12XoGFP7DoIkTGXsD67OHC05NhiP4iHv1v9
         lkfEh6lQOeulX3gYAGfnOGX5r2EEikYl5N8O1JYClLZ2pldA3+v6TzzJkpfcP6VdOhki
         Ij8iTwk48cq3JRcj6z5Eycfg3RqksF3q3DqJKZiTMJMLW1XbixmQV2TliEVswSLc/iRG
         XGuLf9qdxAqiN34qFTqBkld7oP5MuXhE+Pq4ALWpvpdBS791D6sGg5NIvYm4pEItRbzQ
         49V2fZ4dN/ou6+sXABAXF4uw3T80JXBh6E7PG1o6UjGXLn/4grg2qODClMXaLfxIccB0
         wuNQ==
X-Gm-Message-State: APjAAAWl4K8uFXVIrBEC98zyce5cD3Cv6HQjYOiCmQJJnWy+ODyCtuVD
        N73DiBNbBCfKN6D7C160Rlg=
X-Google-Smtp-Source: APXvYqx682tfPumII1B4gK4hjgZXO073JmzjdXio+BtCndQ+fG8Me/uN13zLxcRQ6ymGYFzHrdMfjw==
X-Received: by 2002:a2e:8756:: with SMTP id q22mr1798432ljj.108.1561622295391;
        Thu, 27 Jun 2019 00:58:15 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id n24sm230205ljc.25.2019.06.27.00.58.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 00:58:14 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v2 7/7] serial: imx: get rid of imx_uart_rts_auto()
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
        <1561558293-7683-1-git-send-email-sorganov@gmail.com>
        <1561558293-7683-8-git-send-email-sorganov@gmail.com>
        <20190627060838.ls5ghzngkoiczqex@pengutronix.de>
Date:   Thu, 27 Jun 2019 10:58:13 +0300
In-Reply-To: <20190627060838.ls5ghzngkoiczqex@pengutronix.de> ("Uwe
        \=\?utf-8\?Q\?Kleine-K\=C3\=B6nig\=22's\?\= message of "Thu, 27 Jun 2019 08:08:38
 +0200")
Message-ID: <87v9wrh33e.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:

> On Wed, Jun 26, 2019 at 05:11:33PM +0300, Sergey Organov wrote:
>> Called in only one place, for RS232, it only obscures things, as it
>> doesn't go well with 2 similar named functions,
>> imx_uart_rts_inactive() and imx_uart_rts_active(), that both are
>> RS485-specific.
>> 
>> Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
>> Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> ---
>>  drivers/tty/serial/imx.c | 13 ++++---------
>>  1 file changed, 4 insertions(+), 9 deletions(-)
>> 
>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>> index 171347d..a5e80a0 100644
>> --- a/drivers/tty/serial/imx.c
>> +++ b/drivers/tty/serial/imx.c
>> @@ -402,13 +402,6 @@ static void imx_uart_rts_inactive(struct imx_port *sport, u32 *ucr2)
>>  	mctrl_gpio_set(sport->gpios, sport->port.mctrl);
>>  }
>>  
>> -/* called with port.lock taken and irqs caller dependent */
>> -static void imx_uart_rts_auto(struct imx_port *sport, u32 *ucr2)
>> -{
>> -	if (*ucr2 & UCR2_CTS)
>> -		*ucr2 |= UCR2_CTSC;
>> -}
>> -
>>  /* called with port.lock taken and irqs off */
>>  static void imx_uart_start_rx(struct uart_port *port)
>>  {
>> @@ -1598,8 +1591,10 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
>>  		else
>>  			imx_uart_rts_inactive(sport, &ucr2);
>>  
>> -	} else if (termios->c_cflag & CRTSCTS)
>> -		imx_uart_rts_auto(sport, &ucr2);
>> +	} else if (termios->c_cflag & CRTSCTS) {
>> +		if (ucr2 & UCR2_CTS)
>> +			ucr2 |= UCR2_CTSC;
>> +	}
>
> At least before it was (somewhat) clear that this is about RTS and it
> is about something automatic. So I don't like the patch.

Maybe I just need to put a comment here to clarify?

Let me try to convince you removal is a good thing.

Let's try to mentally revert the patch. If we already have

	} else if (termios->c_cflag & CRTSCTS) {
		if (ucr2 & UCR2_CTS)
			ucr2 |= UCR2_CTSC;
	}

I see no reason to make 2 lines inside if() a function.

First, it's already obvious it's about something automatic, due to if()
condition itself.

Second, the fact that it's about RTS is as [non-]obvious as in any other
place in the driver, taking into account that iMX calls "RTS" "CTS" and
vice versa.

Finally, should we still argue adding a function would be useful, we'd
need to also add, for consistency,

  static void imx_uart_rts_manual(struct imx_port *sport, u32 *ucr2);

(as existing rts_on() and rts_off() do not serve the purpose),

as well as CTS counterparts:

  static void imx_uart_cts_auto(struct imx_port *sport, u32 *ucr2);
  static void imx_uart_cts_manual(struct imx_port *sport, u32 *ucr2);

and patch the code rather heavily, for no obvious gain.

Overall, I believe adding the function would only obscure things.

OTOH, existence of that function forced me to examine the whole source
just to figure that unlike other 2 similar named, it serves entirely
different logical purpose (i.e., it's _not_ 3-d alternative for those
2), and is not used anywhere else.

Look: when we have rts_auto(), rts_off(), and rts_on(), it's logical to
expect it's one of them that will be called when top-level asks for
automatic RTS/CTS, manual RTS off, and manual RTS on, respectively,
isn't it? But it is not the case at all! Still rts_auto() doesn't fit to
the overall picture.

Thanks!

-- Sergey
