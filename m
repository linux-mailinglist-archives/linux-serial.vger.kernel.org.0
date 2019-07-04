Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 085525F8BF
	for <lists+linux-serial@lfdr.de>; Thu,  4 Jul 2019 15:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfGDNBK (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 4 Jul 2019 09:01:10 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41239 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbfGDNBK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 4 Jul 2019 09:01:10 -0400
Received: by mail-lj1-f193.google.com with SMTP id 205so6091038ljj.8
        for <linux-serial@vger.kernel.org>; Thu, 04 Jul 2019 06:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Vjqg27zo8GSuJgU6iVxhR1yNRE/ZU22ne3V7jvRsp28=;
        b=QS9k6FW9w4E7lJVl91rKZEbJwQCPFf4dXHEnx92561O9pq8FV57Bu8VQzOZ+tF3acv
         HDzFIeV2nfNItPM1raEZQIs/7jmltHT3/csXL89AmcdXvreOTEUFHhhQnnqiP/bVv15N
         22h/KyIhu8lHKV8Cf0Qq9A/G3avCLY1DOKN7tDHVmuVTAZdUcpemBdo6hJqt5T8oHiPX
         tOBCkYMYXDYXW3Kz5NR4VuRhTR7BkcupkchrFvRKaMcKH31jlQGdchMyyhN9e3NzlzrT
         810EPE02SA7TXnkVI0WJGJ/93KkoCgVyyuP8dppfZ1DkD8cEQfSXpBT3QT20GrAs8tH8
         cQ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Vjqg27zo8GSuJgU6iVxhR1yNRE/ZU22ne3V7jvRsp28=;
        b=UAUYZmrr2FhniYgCSW2ZOSOjPTrpQPSzIpU1kn/dYHO56LYHbZFuzkeOV2jDqavMBX
         pvENmrYtHvDBHrtBu62/DvAVqBfivb1Yk2+D/JH3czAw6ayT597+FLHos5xK7wXZkLtc
         UQIt2xqOIG2+VxzMM4hskNLUOncxnqi7rCoFOcdNQsN6PCKxoN84FTYkz5IMv9Jat0Ex
         JiGiXTiDnXKAL0xfD+SovCjvevblmYQ9xeirwVmGOVZTqr7emKtTLI9grbwrbSML7C4s
         uaC2L+2NtSbYbNzHBoCods65cveQYhUPQvtR0BdqO0nSZ3fw2Fau80i8ehb0ekQ+y5no
         fT1A==
X-Gm-Message-State: APjAAAWdfYMKnXT/uJyEljgj5jDiBMYjha8vbD9WJQDxKuetB3BBZ34A
        KC7pjf68P+2pRwW5UYxjJFnfr7Vs
X-Google-Smtp-Source: APXvYqy0O6Yaej+AxploccL21axdxsQ4p5RQt1Xg5aioHDDia+DQANIaVf69pxKtMsc+zBt44esfiw==
X-Received: by 2002:a05:651c:150:: with SMTP id c16mr8505844ljd.193.1562245268095;
        Thu, 04 Jul 2019 06:01:08 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id h1sm485914lfj.21.2019.07.04.06.01.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Jul 2019 06:01:07 -0700 (PDT)
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
Subject: [PATCH v3 6/7] serial: imx: set_mctrl(): correctly restore autoRTS state
Date:   Thu,  4 Jul 2019 16:00:28 +0300
Message-Id: <1562245229-709-7-git-send-email-sorganov@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1562245229-709-1-git-send-email-sorganov@gmail.com>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1562245229-709-1-git-send-email-sorganov@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

imx_uart_set_mctrl() happened to set UCR2_CTSC bit whenever TIOCM_RTS
was set, no matter if RTS/CTS handshake is enabled or not. Now fixed by
turning handshake on only when CRTSCTS bit for the port is set.

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 drivers/tty/serial/imx.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 5532887..582a3fd 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -970,10 +970,22 @@ static void imx_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	if (!(port->rs485.flags & SER_RS485_ENABLED)) {
 		u32 ucr2;
 
+		/*
+		 * Turn off autoRTS if RTS is lowered and restore autoRTS
+		 * setting if RTS is raised.
+		 */
 		ucr2 = imx_uart_readl(sport, UCR2);
 		ucr2 &= ~(UCR2_CTS | UCR2_CTSC);
-		if (mctrl & TIOCM_RTS)
-			ucr2 |= UCR2_CTS | UCR2_CTSC;
+		if (mctrl & TIOCM_RTS) {
+			ucr2 |= UCR2_CTS;
+			/*
+			 * UCR2_IRTS is unset if and only if the port is
+			 * configured for CRTSCTS, so we use inverted UCR2_IRTS
+			 * to get the state to restore to.
+			 */
+			if (!(ucr2 & UCR2_IRTS))
+				ucr2 |= UCR2_CTSC;
+		}
 		imx_uart_writel(sport, ucr2, UCR2);
 	}
 
-- 
2.10.0.1.g57b01a3

