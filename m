Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC396E2D5
	for <lists+linux-serial@lfdr.de>; Fri, 19 Jul 2019 10:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbfGSIsR (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 19 Jul 2019 04:48:17 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34892 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbfGSIsQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 19 Jul 2019 04:48:16 -0400
Received: by mail-lf1-f65.google.com with SMTP id p197so21166449lfa.2
        for <linux-serial@vger.kernel.org>; Fri, 19 Jul 2019 01:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vPaPaQoPXlJZwdHwp0bhNLbGscClA6YVVkEeKURmVW4=;
        b=smbmTh1A6Yw9XjULzYo/FESKMEByPHQNYky63gTE1YuUnHHbhD9hNK4Ekf/uIWsq01
         3PdPDMS5BLoy7w1hValHSCBbolbM8c0LSZ8eNKyk5scGe7jf7+nQqgIUx1EORHSc1yab
         f+UEFPHgjH3BPfJIT62ueFbe1zYxxfdu639p60AUB/wCs8PUBzVwiEIeBfwOFtW9i28M
         99ZUgOkSOoa6k+ADPR2omVa7HgkQBHJ0Y7lFVM5T2jKVEjwCVIwDaGSnOjMKZHzY3wPk
         5/eNOltdhzZvSlWA8TbA74udGsdr6cy7UKgjSloAqCzAsOmjMaeSO7D+lpg2ZwLYBfrF
         ykZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vPaPaQoPXlJZwdHwp0bhNLbGscClA6YVVkEeKURmVW4=;
        b=ipIHREWs8u/K1nqgYVHjzRkDxVsCPwlY7mu36p5s+AgdcZS/WHSzQ1XUXLwELOm+RD
         LR7EGEKp/8I9Avrv/hTmF9LjdMoEDi6YpvEcEs2uZOL3xun+LXziyxeIM/RVpBEq0Clw
         hCy4MwPONUGjB+j1Uc2jmJQideEHh23Jp+JwOhSoGxOdUSXFcALBrHX7GsbGDf+oNYGS
         NMTdu2XzLfHsJ9YyZ1UauG96vhkNBnZ0Wdfooxgw+p5wqfrLLhd3dSAmlShNpgoBpG2a
         bWEOUc2/eq/7m5QRwTG/S6H+PQROiLFaXeVTpGinpTLR7ZP+eu3VHk+JSdp4A2GUUlNE
         DuFA==
X-Gm-Message-State: APjAAAWogl6vhU3MuuR9q41jZ1vXeEpb7L75zHDmkxAE9rsi1xKq7+l6
        ESj7pMvj0NE1D+uFOLRnjeViCon4
X-Google-Smtp-Source: APXvYqzJc9wKIhSihgDlx/Cxa8rzGW8B2MmBHeLQNzEdeSH3A4tyY90LTregA77XzXRjsX1TLmoyqQ==
X-Received: by 2002:a19:80c4:: with SMTP id b187mr22607365lfd.122.1563526094479;
        Fri, 19 Jul 2019 01:48:14 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id s21sm5588742ljm.28.2019.07.19.01.48.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Jul 2019 01:48:13 -0700 (PDT)
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
Subject: [PATCH v4 3/3] serial: imx: get rid of imx_uart_rts_auto()
Date:   Fri, 19 Jul 2019 11:47:54 +0300
Message-Id: <1563526074-20399-4-git-send-email-sorganov@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1563526074-20399-1-git-send-email-sorganov@gmail.com>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1563526074-20399-1-git-send-email-sorganov@gmail.com>
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
 drivers/tty/serial/imx.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 34d61c4..971055b 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -402,13 +402,6 @@ static void imx_uart_rts_inactive(struct imx_port *sport, u32 *ucr2)
 	mctrl_gpio_set(sport->gpios, sport->port.mctrl);
 }
 
-/* called with port.lock taken and irqs caller dependent */
-static void imx_uart_rts_auto(struct imx_port *sport, u32 *ucr2)
-{
-	if (*ucr2 & UCR2_CTS)
-		*ucr2 |= UCR2_CTSC;
-}
-
 /* called with port.lock taken and irqs off */
 static void imx_uart_start_rx(struct uart_port *port)
 {
@@ -1600,8 +1593,10 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 		else
 			imx_uart_rts_inactive(sport, &ucr2);
 
-	} else if (termios->c_cflag & CRTSCTS)
-		imx_uart_rts_auto(sport, &ucr2);
+	} else if (termios->c_cflag & CRTSCTS) {
+		if (ucr2 & UCR2_CTS)
+			ucr2 |= UCR2_CTSC;
+	}
 
 	if (termios->c_cflag & CRTSCTS)
 		ucr2 &= ~UCR2_IRTS;
-- 
2.10.0.1.g57b01a3

