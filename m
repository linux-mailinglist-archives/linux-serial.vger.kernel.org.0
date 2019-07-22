Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB2D56FC0A
	for <lists+linux-serial@lfdr.de>; Mon, 22 Jul 2019 11:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbfGVJWZ (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 22 Jul 2019 05:22:25 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40671 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbfGVJWZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Jul 2019 05:22:25 -0400
Received: by mail-lj1-f195.google.com with SMTP id m8so3283097lji.7
        for <linux-serial@vger.kernel.org>; Mon, 22 Jul 2019 02:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AB9Uhy9tvuGFyl7GXO1etpCNViYG1ibv00O/NXtQ8qI=;
        b=sfVmdXLMToo060hTaOQKGSekZo/nQgI+rUVXwxbsl1zWdeT8Ou8wZ2DSd0Toat2wvE
         OY1ig9BZzEetVuVQGSORIFmmHnPUwFm7cQFl1YXb3YIvN3sfr25StiCPz4e0OpVN4UhN
         AIPqCCFbyocLbejYqn4Dmhxpd8r9m+llxm+qMTYzq++NXuTisw6SfkSNDajoA1gsKMK9
         vkU9B5j3VTR04W7+JApSihLVrQc4YUwovUGv7R5RlXmhR3qsaxEVGlp7kCQu1vJ6KyR7
         /dBYolSHWgX619+nxe0XGcpy6BOilJ54y/PPKBuB1LSWcJQQOPB0vmnEQbemPsAIihf4
         LIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AB9Uhy9tvuGFyl7GXO1etpCNViYG1ibv00O/NXtQ8qI=;
        b=MwL4z8AEuenGFpvgm3glh3+YG2VzmNtfdN7QvRhh4UNVrrRTqlaYmG2dtGrb4gDM4J
         ak4a92GjU5qwS+HcxGyoJRi+hHcDfG9att2Gymq63PcfSw5OlxG94azBuh2MWKRhvcaH
         SMbmHMl5ErAvL5xjyA6jBIC6n2NB5sf3Lkk6GxCmAuo//G4IqpHf8TEmmNISejWpq598
         0JuPeeMQVIPTHpyog/3x9oUDAW+WEZCa98DZJ/Rc4yEN/hiuasN6DB0LzHOuM7RZ/w9Y
         XspM16JNOrpAGV41npgCQCYH3f0e1AoVB3PKIj442y7LuECd6tZgijZmmpmXHRM7FVj6
         +WqA==
X-Gm-Message-State: APjAAAWzmG0HyxMRp6d7yt3Ht689ngzX6GTglsUdbQY0mvXZ/80qaYGK
        h+ErayL0G0NB/nHYdFHwTyUEPfGV
X-Google-Smtp-Source: APXvYqxWQrMDT2vKFWjVmiipEuXJG5cCZHpd/xcTl4RwYawjhu07ztS2G7AVcrSV4iEL+yeypBPnlQ==
X-Received: by 2002:a2e:9a19:: with SMTP id o25mr35933375lji.63.1563787342756;
        Mon, 22 Jul 2019 02:22:22 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id b68sm8425088ljb.0.2019.07.22.02.22.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Jul 2019 02:22:22 -0700 (PDT)
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
Subject: [PATCH v5 3/3] serial: imx: get rid of imx_uart_rts_auto()
Date:   Mon, 22 Jul 2019 12:22:10 +0300
Message-Id: <1563787330-1394-4-git-send-email-sorganov@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1563787330-1394-1-git-send-email-sorganov@gmail.com>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1563787330-1394-1-git-send-email-sorganov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Called in only one place, for RS232, it only obscures things, as it
doesn't go well with 2 similar named functions,
imx_uart_rts_inactive() and imx_uart_rts_active(), that both are
RS485-specific.

Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
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

