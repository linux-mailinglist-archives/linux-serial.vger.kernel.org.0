Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F38997099E
	for <lists+linux-serial@lfdr.de>; Mon, 22 Jul 2019 21:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbfGVTWZ (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 22 Jul 2019 15:22:25 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33564 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbfGVTWZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Jul 2019 15:22:25 -0400
Received: by mail-lj1-f194.google.com with SMTP id h10so38717107ljg.0
        for <linux-serial@vger.kernel.org>; Mon, 22 Jul 2019 12:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dMFpXLyuKl/ARSHo20Q9Hq9vNpRSPEtnIGWgcelt85w=;
        b=in21JgjdGrZF9LtT8nCi8uhPjZ0unyb6VwBZ3uDKYSva7WjusxgOq7TA6502tKUufi
         3I42F0w//h3VKKzlNRU8t+ewOCpb+f1Y+PONiycPofWqJP4XK+QLRsFTe2NRY6h6sTe9
         /TK22wxi6RF9r1mFRezHTjbxUGxUXGyVjo5FAS3Qibu71WQ9EGl92qjrCIXoPodtfTRB
         l1dyzM+/iqCEYB/zGo96vv8JXxqxthAFmCApqbKSa16X9JAzOH/ZPz8mkBbarAJZ66+H
         bbw9bMCuQJjtuOgmTqygOrraskmfqZ7kuWuxxzb6PzjaoVnlhLbM1Mpkfy3Yfx0kuzZt
         rdiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dMFpXLyuKl/ARSHo20Q9Hq9vNpRSPEtnIGWgcelt85w=;
        b=uRTKzI/QUSoNwQ3Vzzpo+mug9SyQNsNoxCJ4hYiILPnYd6XWQgRz08P7as4HNMRXFv
         c1lIv0UhVI79Im4tA4pk3clJb+YRZh5uB2I/EchYW1UyDr6Yc3VqzIYW5kJePznZHZZ2
         a2PAelAOcbwcUJ8e2JZ9X25MGTlnxpisWYjEwTkb2bcnxUweX68eUbjSveSRFlHB7fj3
         vKUMF5DpbZ9xbDcpCdRgST1+aqufsJ+Y0zMG6eHFxIemYtKUhPwu9lxEJqnOx5znAt3D
         TUjTELYb/+D/4EC6rG5uZgua0/hMQ1Qq9Akldy40bWSxjBzF2dp6IQZm/TKd9SqjBhR1
         qHlw==
X-Gm-Message-State: APjAAAWrRL2kTiOhzMCgSzLu08uyny0JVjMKJwzYgO5GFlTsfSP+Gc0v
        yDQkOlpJGGfCyRmUzCIjH1oZ2WPR
X-Google-Smtp-Source: APXvYqwZG9xAwevycV1eqLHdjNT7UInKyPe6n8YOGoJQBBJFUwfNpUWf3hvH8YyXA1xFOeQeDX4TBw==
X-Received: by 2002:a2e:894a:: with SMTP id b10mr32119358ljk.99.1563823343029;
        Mon, 22 Jul 2019 12:22:23 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id n124sm6129307lfd.46.2019.07.22.12.22.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Jul 2019 12:22:22 -0700 (PDT)
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
Subject: [PATCH v6 3/3] serial: imx: get rid of imx_uart_rts_auto()
Date:   Mon, 22 Jul 2019 22:22:11 +0300
Message-Id: <1563823331-5629-4-git-send-email-sorganov@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1563823331-5629-1-git-send-email-sorganov@gmail.com>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1563823331-5629-1-git-send-email-sorganov@gmail.com>
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

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
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

