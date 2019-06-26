Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 753F956B98
	for <lists+linux-serial@lfdr.de>; Wed, 26 Jun 2019 16:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfFZOOX (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 26 Jun 2019 10:14:23 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39657 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfFZOOX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 26 Jun 2019 10:14:23 -0400
Received: by mail-lj1-f196.google.com with SMTP id v18so2377829ljh.6
        for <linux-serial@vger.kernel.org>; Wed, 26 Jun 2019 07:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=disSROzqfUTYpKBNgu+W39ygIWnnZb5HbJrhGeUkuwI=;
        b=BZj8H7g+wSJU3LS7Okj/+Un4KL2iGuLBDqcdcEdVq5R5tg43lDh8RHDvP8Sjk1tgAg
         EGPnu5JOWBCXeBM4+Fa6IUVYWxIowJrKn+Y1CXKRDUpeDChs/B1CkGmVDXZakNdU3NIG
         igwQWHWYjAOErhpFJF7lMMWIDcPk11H10UoxW7atwM3x2CyXcqzaCpndkP1qQZiOcke+
         uUtA5tj/61A5V/YvQ12mM2yVqkYxtSN5JST2LKGOf+HX7KnWw5ycCmFylwdhAuLPEpQ8
         WrlIQTH3X3fJ924sImugV+iwxzEoqwZ7m82jaLI9XAQd/ZXS7I+8A/0zCvFAhXHSelQ9
         ncdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=disSROzqfUTYpKBNgu+W39ygIWnnZb5HbJrhGeUkuwI=;
        b=CYNU3we+I6YB818RujUEL5KYjFyJjH0hA9cw7QKOG+lC1otmB0Hbz2kxBXEqkJsaOl
         aBg7mlHd5rSUPaq778Va2RqYqa6iiGILkepo4tjxEWa1qYZOatTS6gDTnA8f3zukZiHO
         bp0sUgnNQYGsjAwlg6B1RN5LkD8Ff2h1FaZ9TRiZLApSMhZJYkq3ir5GukfZUpslyOyM
         MZ51Qm6GmmQrWSmiUpovACzNO0oiwykz5zbYZZV7RYnoyOuWS5ugDvsyLwUbIdieAq/6
         QNzF0kYDWUz13K+poiH70gJXEkknQ6zV8kjJNK3MoYAS/jj3YY2DK+wsQTyMva9csT5v
         SuVg==
X-Gm-Message-State: APjAAAVJcnRmOAGaCf+RadBcIRzXI0b/IAMyJgOWoWSxKkhaQYHUfGcW
        exSWPwgDPYuDuHE1xMKRi18=
X-Google-Smtp-Source: APXvYqzQ3GQSF/ngOsv3mi41ox5k13SoEkk3vZAxzYGrp0VMn7mMceHw0FTkyiuSkMxqLHYFdZ3q9Q==
X-Received: by 2002:a2e:988b:: with SMTP id b11mr3080348ljj.110.1561558461628;
        Wed, 26 Jun 2019 07:14:21 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 25sm2863825ljn.62.2019.06.26.07.14.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Jun 2019 07:14:21 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v2 7/7] serial: imx: get rid of imx_uart_rts_auto()
Date:   Wed, 26 Jun 2019 17:11:33 +0300
Message-Id: <1561558293-7683-8-git-send-email-sorganov@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1561558293-7683-1-git-send-email-sorganov@gmail.com>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1561558293-7683-1-git-send-email-sorganov@gmail.com>
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
index 171347d..a5e80a0 100644
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
@@ -1598,8 +1591,10 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
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

