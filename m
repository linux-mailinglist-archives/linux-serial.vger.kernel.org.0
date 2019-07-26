Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDAA0771A8
	for <lists+linux-serial@lfdr.de>; Fri, 26 Jul 2019 20:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388000AbfGZSxX (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 26 Jul 2019 14:53:23 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38155 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387854AbfGZSxX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Jul 2019 14:53:23 -0400
Received: by mail-lj1-f194.google.com with SMTP id r9so52435577ljg.5
        for <linux-serial@vger.kernel.org>; Fri, 26 Jul 2019 11:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sj8RVBs1fk0i3q8Mv8Hvbl0QmOyE222Bssz9akDFVOY=;
        b=sCGwZuU9pvjnkWWzIrVaU5Tt6VgiIQEXIJaeUOSYMNehQmShord01NCMJnfCC5ncrs
         9CVWh72fv1sEcVNnZErHW9QUdHnUCH4b2ntzI3ZfB6SNqyAzJevcMb9OGgdkS5Rw/bfS
         AVWN8uIV3+u29U/zFqux27d/tRGdG7R5Wuj8qhshwZoV2Bha7AnWxUiDBSzlN/lhdk0z
         EtXtsAVq89cVegXtRVCXTwuHTlea8WRG2kj+eqRESGujdyeUSv6yDAf1Duyk4as31gFk
         31JVUGPmqy/mjXVKjO4EpmoHCsR4tjQkdlpOA0X0xB2zihc7UwNLEQCDnNoyISaAe6eE
         EFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sj8RVBs1fk0i3q8Mv8Hvbl0QmOyE222Bssz9akDFVOY=;
        b=l+kTwyzomD4vjlfUIL2TMlX877s9y39HvxX/YzaAmL8L9ybAMcoeadaoIZ6s85IeA7
         PS0ZCUJFOqs0KxIaMkXFOwOHxWf5NCwrdm+GrnrUBdBEwJn1H7w7xa+ZqaCtYWSzIYk3
         HLroqsWbRXz9I/6gCN/Ya1YEGg5c0g3fiJV7ws0GwyjZmr4EFaVn7rwh12soKucaZB0g
         7lFa3nZD8BzMWk7t1K6fJCHtx4ezfhSILitbz9W6MlU1qfkK2uzr1xmkp9m17qMVF7lO
         1T81Joe8QajkytkTqOhvI76eVkxthKu/sMmbSiR1pPf1ekhGmILqWcS0LmiVigRloTJa
         L4bg==
X-Gm-Message-State: APjAAAVVjWkYUtyXQFvRo8dcRc8a6BHDw/06sENXhJC77N+44sVTqXC9
        7J+gXVrT5W0nJwWrjsbQ2Cv6hC3k
X-Google-Smtp-Source: APXvYqzmB6/vZkocyFQqX9FSF/5ZmmXo9D8WgIVwA5Pw/VEahaXGRoJMOu09/LuIPHzg5UJ8hsucaw==
X-Received: by 2002:a2e:8007:: with SMTP id j7mr50708763ljg.191.1564167201088;
        Fri, 26 Jul 2019 11:53:21 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id u15sm10254810lji.61.2019.07.26.11.53.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jul 2019 11:53:20 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v7 3/3] serial: imx: get rid of imx_uart_rts_auto()
Date:   Fri, 26 Jul 2019 21:52:41 +0300
Message-Id: <1564167161-3972-4-git-send-email-sorganov@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1564167161-3972-1-git-send-email-sorganov@gmail.com>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1564167161-3972-1-git-send-email-sorganov@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Called in only one place, for RS232, it only obscures things, as it
doesn't go well with 2 similar named functions,
imx_uart_rts_inactive() and imx_uart_rts_active(), that both are
RS485-specific.

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 drivers/tty/serial/imx.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 059ba35..d9a73c7 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -402,17 +402,6 @@ static void imx_uart_rts_inactive(struct imx_port *sport, u32 *ucr2)
 	mctrl_gpio_set(sport->gpios, sport->port.mctrl);
 }
 
-/* called with port.lock taken and irqs caller dependent */
-static void imx_uart_rts_auto(struct imx_port *sport, u32 *ucr2)
-{
-	/*
-	 * Only let receiver control RTS output if we were not requested to have
-	 * RTS inactive (which then should take precedence).
-	 */
-	if (*ucr2 & UCR2_CTS)
-		*ucr2 |= UCR2_CTSC;
-}
-
 /* called with port.lock taken and irqs off */
 static void imx_uart_start_rx(struct uart_port *port)
 {
@@ -1604,8 +1593,14 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 		else
 			imx_uart_rts_inactive(sport, &ucr2);
 
-	} else if (termios->c_cflag & CRTSCTS)
-		imx_uart_rts_auto(sport, &ucr2);
+	} else if (termios->c_cflag & CRTSCTS) {
+		/*
+		 * Only let receiver control RTS output if we were not requested
+		 * to have RTS inactive (which then should take precedence).
+		 */
+		if (ucr2 & UCR2_CTS)
+			ucr2 |= UCR2_CTSC;
+	}
 
 	if (termios->c_cflag & CRTSCTS)
 		ucr2 &= ~UCR2_IRTS;
-- 
2.10.0.1.g57b01a3

