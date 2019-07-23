Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09D5D714F2
	for <lists+linux-serial@lfdr.de>; Tue, 23 Jul 2019 11:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbfGWJUm (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 23 Jul 2019 05:20:42 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33606 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728569AbfGWJUl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Jul 2019 05:20:41 -0400
Received: by mail-lf1-f65.google.com with SMTP id x3so28910306lfc.0
        for <linux-serial@vger.kernel.org>; Tue, 23 Jul 2019 02:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=GRGRANQcmKxQudgDYzhBenNZAQ5yhd2GJzBykTOiWlc=;
        b=JCWzpfkH01b78Yh0JrjweiSOPh+bIsEiO6HewQLqBDHtB7noDKKLCgShoD3sACjN9l
         kwK3EgmdqL2wG+/Ote7IJKbYWb64D+Cqw8x/WB7/raxpoOhVPaTMyni+VIYABj6bPlvq
         AtAhTSjskNsZD8ahRyiB45q9jew3TZvIvwR2w+GN9DIfDLREgOuiWS1S2OadvLdznD9x
         a8NAqJRGqZTacnHKxrf6vdBehyzftQ3O66OluiqqmCd9r8dH+zdHu8R7x35V2wJL8uPi
         iIZQHzZ0/W85VJ+rrHpsI6ri1VzoyRxP2CjDO24UOUJPW1tCAeMkop8EP9hcwqJJoth+
         y9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=GRGRANQcmKxQudgDYzhBenNZAQ5yhd2GJzBykTOiWlc=;
        b=UdwnCOh/K2xIISL0EBdyhAaV/JpvDw8PTrYIvGXuHCQU3OVwVSrQu27O0BHXSbg+tt
         RtYCzOaMzyU6SVJ/oqxwmnEfy07OgOBwRx0+VJ26LWpVYOm64gWM1cMasYTU9yx3zwvt
         TsAvjiGJhzJ9gKshuo0NrL46X9jrimR8VRqzp/LNUBAKKz7jJzGyKLKoLTqygXQsraqv
         nR6ippF6rON6S6+PsXHpkZwVt/85mh5bqdR6/ouS8P5IUvhW7tGMxCczV1MhfTkNCuhj
         Ij2Qq2Ww5xb54SFrd6syQZX8hm6mJqDLldG/2/K1PEJuVguw7eSxNsOVy8EqyKHhPG1F
         Go9g==
X-Gm-Message-State: APjAAAWSGUut3PcSCAM5IlafAEJNTzIgm/nOT91VttTY9OCaNQGavGTp
        3QUfU9K9UXTJxfAosOBc6yA=
X-Google-Smtp-Source: APXvYqyyF6Gz9sQ6FmT6/DerWqAbxGfTSrr5WAQHrO/0w2uzSbvk8fyzH2NJbiX3x23WwqcZh1tXhA==
X-Received: by 2002:a19:78e:: with SMTP id 136mr35480608lfh.48.1563873639783;
        Tue, 23 Jul 2019 02:20:39 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id k4sm7920231ljj.41.2019.07.23.02.20.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 02:20:39 -0700 (PDT)
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
Date:   Tue, 23 Jul 2019 12:20:38 +0300
In-Reply-To: <20190722202406.hr74mg64sxoovah7@pengutronix.de> ("Uwe
        \=\?utf-8\?Q\?Kleine-K\=C3\=B6nig\=22's\?\= message of "Mon, 22 Jul 2019 22:24:06
 +0200")
Message-ID: <87h87d1509.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:

> On Mon, Jul 22, 2019 at 10:22:10PM +0300, Sergey Organov wrote:
>> imx_uart_set_mctrl() happened to set UCR2_CTSC bit whenever TIOCM_RTS
>> was set, no matter if RTS/CTS handshake is enabled or not. Now fixed by
>> turning handshake on only when CRTSCTS bit for the port is set.
>>
>> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>> Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
>> Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> ---
>>  drivers/tty/serial/imx.c | 16 ++++++++++++++--
>>  1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>> index 32f36d8..059ba35 100644
>> --- a/drivers/tty/serial/imx.c
>> +++ b/drivers/tty/serial/imx.c
>> @@ -974,10 +974,22 @@ static void imx_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
>>  	if (!(port->rs485.flags & SER_RS485_ENABLED)) {
>>  		u32 ucr2;
>>
>> +		/*
>> +		 * Turn off autoRTS if RTS is lowered and restore autoRTS
>> +		 * setting if RTS is raised.
>
> "lower" and "raising" are misleading here. I recommend sticking to
> "active" and "inactive".

This is copy-pasted from the 8250 driver. I'd prefer to leave it as is.

>
>> +		 */
>>  		ucr2 = imx_uart_readl(sport, UCR2);
>>  		ucr2 &= ~(UCR2_CTS | UCR2_CTSC);
>> -		if (mctrl & TIOCM_RTS)
>> -			ucr2 |= UCR2_CTS | UCR2_CTSC;
>> +		if (mctrl & TIOCM_RTS) {
>> +			ucr2 |= UCR2_CTS;
>> +			/*
>> +			 * UCR2_IRTS is unset if and only if the port is
>> +			 * configured for CRTSCTS, so we use inverted UCR2_IRTS
>> +			 * to get the state to restore to.
>> +			 */
>> +			if (!(ucr2 & UCR2_IRTS))
>> +				ucr2 |= UCR2_CTSC;
>> +		}
>
> If you teach imx_uart_rts_auto about IRTS this function could be reused
> here I think.

Yeah, but imx_uart_rts_auto_if_crtscts_and_rts_is_active() ? I feel
somewhat uncomfortable about that mixing of different purposes.

Besides, one of the purposes of these patch series was to get rid of
imx_uart_rts_auto() as its name is confusing in the context of existing
imx_uart_rts_active() and imx_uart_rts_inactive(), as I already
explained before.

We can rename the function to avoid confusion, add yet another check to
it, and call it from 2 places, but it's still questionable if it's an
improvement, and could be done as a follow-up step anyway. It will look
something like this then:

 -- >8 --

    serial: imx: factor out common code into new imx_uart_set_auto_rts()

	Modified   drivers/tty/serial/imx.c
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index d9a73c7..c8b847e 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -954,6 +954,20 @@ static unsigned int imx_uart_get_mctrl(struct uart_port *port)
 	return ret;
 }

+/*
+ * Compute and set auto RTS in 'ucr2' according to the current state of RTS
+ * signal and CRTSCTS state of port configuration.
+ *
+ * Use inverted UCR2_IRTS to get the state of CRTSCTS, and don't let receiver
+ * control RTS output if RTS is inactive.
+ *
+ */
+static void imx_uart_set_auto_rts(u32 *ucr2)
+{
+	if ((*ucr2 & UCR2_CTS) && !(*ucr2 & UCR2_IRTS))
+		*ucr2 |= UCR2_CTSC;
+}
+
 /* called with port.lock taken and irqs off */
 static void imx_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
@@ -971,13 +985,7 @@ static void imx_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 		ucr2 &= ~(UCR2_CTS | UCR2_CTSC);
 		if (mctrl & TIOCM_RTS) {
 			ucr2 |= UCR2_CTS;
-			/*
-			 * UCR2_IRTS is unset if and only if the port is
-			 * configured for CRTSCTS, so we use inverted UCR2_IRTS
-			 * to get the state to restore to.
-			 */
-			if (!(ucr2 & UCR2_IRTS))
-				ucr2 |= UCR2_CTSC;
+			imx_uart_set_auto_rts(&ucr2);
 		}
 		imx_uart_writel(sport, ucr2, UCR2);
 	}
@@ -1594,12 +1602,7 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 			imx_uart_rts_inactive(sport, &ucr2);

 	} else if (termios->c_cflag & CRTSCTS) {
-		/*
-		 * Only let receiver control RTS output if we were not requested
-		 * to have RTS inactive (which then should take precedence).
-		 */
-		if (ucr2 & UCR2_CTS)
-			ucr2 |= UCR2_CTSC;
+		imx_uart_set_auto_rts(&ucr2);
 	}

 	if (termios->c_cflag & CRTSCTS)



-- Sergey
