Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89BD37099D
	for <lists+linux-serial@lfdr.de>; Mon, 22 Jul 2019 21:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfGVTWY (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 22 Jul 2019 15:22:24 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43099 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbfGVTWY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Jul 2019 15:22:24 -0400
Received: by mail-lf1-f65.google.com with SMTP id c19so27480176lfm.10
        for <linux-serial@vger.kernel.org>; Mon, 22 Jul 2019 12:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wnit4p85ORmgfnZn4hAkBjNauy9f4K7ibUxB6LLunYI=;
        b=OUXCvoenllByUjPJujE3BRthxEaq55rjTdMdDKZp1dI1QYrJTD2K8yttKXVEoegkQL
         S5TEfmkT0MGc9WDr6KJrdjXGkCsrYMQDp9Z4/n8X7I4PNIdtNP0IW1v1q5HLSytSq/ME
         c7+Hz9PGlgCvXv/XMZyoXv5XTIx0Z99iD9yGwJIQvDQ+Rh6DAf/9Kgn+jo/c0rLjhOFC
         3ifUNZTT9BKarFYuliptX8RhH1F3Oz2hSge3fxjwKJIyANBBy2z1VHE/NRJ9d/td9H7w
         +CdL0YySrgG8y3EXrz4n8d9JArm9kQ5VizLJXDawq1AbcZYduiTn0+avPqmNuhh/ZSZU
         XmZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wnit4p85ORmgfnZn4hAkBjNauy9f4K7ibUxB6LLunYI=;
        b=JNxpIm0VJSE9UX/yrIk7wL8xRZHtV1sjC4NwZ8fIIMr91Ckww6dk34qxpYmxCRd9Rz
         okOT7z3OQtPKfZFyuz0A5ewCsN9Z/pk91P+XX9qgwsxMIxyuRJYvbMSxtzqDvZcbJ5go
         HOe9+7xyQl8wOJvxq4qU3/KNc7gpStmyVnvhSclMAuOYacUfCuCBFe5/BC8W5y2V8SFf
         X3VGHgUpcDg0Ur6u2YWqlpzpB0XFl0bUf0+NqnuAou6MRxaCnnj5ezt8zb353VpvPQSq
         doTm/8eIPhPEaTvxgJTGz1yDoodhC/mH8m1OEvkWmaF5dtE/DYIhNv3xW6svN4F0ccoJ
         Nv2w==
X-Gm-Message-State: APjAAAUQO+MJOc0khKP6KQ3Q3TgWKvmIXe20VfmASYgp9+3bgKYkxiqU
        6pNawc1eC3/e1UAAy5SFkqAlokHZ
X-Google-Smtp-Source: APXvYqzMcAxtvEzeZaLbMfwbcBn9qKi7e4zuAuT1RxXDnSo2B3PtPcOpAQp3OSoAIKssKwyHOq2Ljg==
X-Received: by 2002:ac2:563c:: with SMTP id b28mr20156125lff.93.1563823342006;
        Mon, 22 Jul 2019 12:22:22 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id n124sm6129307lfd.46.2019.07.22.12.22.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Jul 2019 12:22:21 -0700 (PDT)
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
Subject: [PATCH v6 2/3] serial: imx: set_mctrl(): correctly restore autoRTS state
Date:   Mon, 22 Jul 2019 22:22:10 +0300
Message-Id: <1563823331-5629-3-git-send-email-sorganov@gmail.com>
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

imx_uart_set_mctrl() happened to set UCR2_CTSC bit whenever TIOCM_RTS
was set, no matter if RTS/CTS handshake is enabled or not. Now fixed by
turning handshake on only when CRTSCTS bit for the port is set.

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 drivers/tty/serial/imx.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 32f36d8..059ba35 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -974,10 +974,22 @@ static void imx_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
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

