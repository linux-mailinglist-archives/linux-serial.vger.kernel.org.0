Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD7715F8C0
	for <lists+linux-serial@lfdr.de>; Thu,  4 Jul 2019 15:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfGDNBM (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 4 Jul 2019 09:01:12 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44327 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbfGDNBM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 4 Jul 2019 09:01:12 -0400
Received: by mail-lj1-f193.google.com with SMTP id k18so6072888ljc.11
        for <linux-serial@vger.kernel.org>; Thu, 04 Jul 2019 06:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iFkawdZ5Qbd64aBfLB7G/2IByrJZ52xv8EKcLUHUKyg=;
        b=gZwrSvC6Ql2DUkwL/tYLzFq7GY821LeLxgRRNN082KZr7oErJNkbsU5t2Yqo9mCTBW
         X6tX/94+bNZHkEwZawbARckZhMteoiYs8DfsqNOt6OG5ITHEW7Jft5T2rNtYrlVX6ih0
         pLhDzflHHAWeItnEsYZqEJrWR9olupRNXzUEbme8n2ry5CBpxFwV26USLYQS183kyuJG
         dRLI2RGDNTOjl7kX0+ovRbjmo7GyAev8h2RESl939EyHe7cJXO2o4aysrekgw/HvlMSK
         54rtLrnjUdGKSquoeWinuVDVtgK108jXTT5kLEZ/1zPpIZ68SRXIEZoGU1J/sOkBq+lt
         TVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iFkawdZ5Qbd64aBfLB7G/2IByrJZ52xv8EKcLUHUKyg=;
        b=rYZRXkGknmNcIwlefpF7ep6nBt4a3DHfqwhLdn/lu2qx6uPtEuXNPElxZEDg4doPcT
         XMJGpGWKk1IxY7f216A+qG9drgKzqpreWCNHjQwVjTddDRThv6Hs5mDpgNU/FDBOOr4U
         3Qp7ZLf9Sh+HXnG2M6Y41/zsicMmmXn+cRfVlISMnpurxLQ3j+B+cAKB08kLIxUmI+H9
         ealYzqzSzONmZNHhdv1b4e4mHedFuOCNc9yy0W8CQrYd6E/uTLvhG4iJQEc25esrRk15
         /gAoZPIlHLTVnYCpuBp6Kc3s0Un/kDOR+2VbuY1BIzewt5luSBZ31Irnf6lGIJhjNSDV
         zZlQ==
X-Gm-Message-State: APjAAAVOad3QHJEN+4b9zrX+ut5CPA/QWns74mLHZELbNuXYx7N6pAK7
        Aibr4p/brtLdALix7tCTWNSlxblt
X-Google-Smtp-Source: APXvYqzi+zB+DMQHWPOrhTYHDsuybi9IxDE3XFE0vNOu//S6piBaknj6RbeenK5U7P/fYa9NUJABLw==
X-Received: by 2002:a2e:8846:: with SMTP id z6mr23896366ljj.20.1562245269472;
        Thu, 04 Jul 2019 06:01:09 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id h1sm485914lfj.21.2019.07.04.06.01.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Jul 2019 06:01:08 -0700 (PDT)
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
Subject: [PATCH v3 7/7] serial: imx: get rid of imx_uart_rts_auto()
Date:   Thu,  4 Jul 2019 16:00:29 +0300
Message-Id: <1562245229-709-8-git-send-email-sorganov@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1562245229-709-1-git-send-email-sorganov@gmail.com>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1562245229-709-1-git-send-email-sorganov@gmail.com>
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
 drivers/tty/serial/imx.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 582a3fd..f4e9d1a 100644
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
@@ -1602,7 +1595,8 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 			imx_uart_rts_inactive(sport, &ucr2);
 
 	} else if (termios->c_cflag & CRTSCTS) {
-		imx_uart_rts_auto(sport, &ucr2);
+		if (ucr2 & UCR2_CTS)
+			ucr2 |= UCR2_CTSC;
 	}
 
 	if (termios->c_cflag & CRTSCTS)
-- 
2.10.0.1.g57b01a3

