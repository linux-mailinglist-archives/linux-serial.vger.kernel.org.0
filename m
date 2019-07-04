Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6A4B5F8BE
	for <lists+linux-serial@lfdr.de>; Thu,  4 Jul 2019 15:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbfGDNBJ (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 4 Jul 2019 09:01:09 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34995 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbfGDNBJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 4 Jul 2019 09:01:09 -0400
Received: by mail-lj1-f195.google.com with SMTP id x25so6116103ljh.2
        for <linux-serial@vger.kernel.org>; Thu, 04 Jul 2019 06:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SyDWki8L8NcXuBPDzCdM3r3fpSMLCvKmwBmXWEoRaTo=;
        b=JgjQ4YYJtuKFcxmWKZHgny5RPwXpt+nC4RcNKN7GHS/mwiaf7JL4ZM9yhTjk6TrdQK
         2jlHi6886KivLreGvz9b32HD9aCkjZaLaibFhdk8rWXYYLZAv3t072HcN8z9DejLdDab
         kuZVMyH+JwwypPNeoh+TrQZiuxyQQt/EbJf/inlcRbXv1u+3xFl/zS5LvV0VNcnSC3TN
         srRhdLgoComXjILvfwCdtQIPOSaVAaIwU5NoIxjzNC2k4L2gETTfLApcsMA7TCpJ0RFj
         12pmiJ6khJ4biLW9Ui8OMZJYaWyoDNjDMEBIxmiSF4mzaDbgYOWPbU8il1Rc5lHZr9jv
         e/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SyDWki8L8NcXuBPDzCdM3r3fpSMLCvKmwBmXWEoRaTo=;
        b=DIms4vYpmapUpRkuAbakj12CZwHtDpd0q1UoI20Rn7eu2hXBulD+JyNZC49UXuRb43
         zN0p7mmv/Bf4qR9XkIVWimMY2uY7hvAar3vvZck4SQD3PSdesZ92pLR68JAE0MNJGa3o
         KeCsB4LLwQUGac8lIh0oiGtmwDCfq4cSVb72nz7OMumY9/pufZ2lzIrXAvgwqzlhHFns
         WludUTwYoq6TDiqWJ7pJ/zz3V7t/T7fGoZaitqkEEkk2qX5rFR3i8yW7AeMmp0V7KtGi
         YMZhyclIcyEzPD7+2tTnplEZ2tN6Cfb+8F1t7FxQ7raJOgLWc2R7MRC6Y9f+z597LXI0
         Zmvg==
X-Gm-Message-State: APjAAAVwtitPIovdIP5IC+yOetUGYy3e+xgEv2P+Kc52hQ5jSYDH9ZJY
        NDFM2CPO82Ocd7u16/kQDzadVsV/
X-Google-Smtp-Source: APXvYqyqK8GICe53xP/lgQ6CIujxjkUSwEwiwZV5tINqS+mXysxT97isy6FNRj8B4IC9m+Ngqp6cEg==
X-Received: by 2002:a2e:9858:: with SMTP id e24mr24094920ljj.91.1562245266664;
        Thu, 04 Jul 2019 06:01:06 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id h1sm485914lfj.21.2019.07.04.06.01.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Jul 2019 06:01:06 -0700 (PDT)
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
Subject: [PATCH v3 5/7] serial: imx: set_termios(): do not enable autoRTS if RTS is unset
Date:   Thu,  4 Jul 2019 16:00:27 +0300
Message-Id: <1562245229-709-6-git-send-email-sorganov@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1562245229-709-1-git-send-email-sorganov@gmail.com>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1562245229-709-1-git-send-email-sorganov@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

set_termios() shouldn't set UCR2_CTSC bit if UCR2_CTS (=TIOCM_RTS) is
cleared. Added corresponding check in imx_uart_rts_auto() to fix this.

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 drivers/tty/serial/imx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index e0f5365..5532887 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -405,7 +405,8 @@ static void imx_uart_rts_inactive(struct imx_port *sport, u32 *ucr2)
 /* called with port.lock taken and irqs caller dependent */
 static void imx_uart_rts_auto(struct imx_port *sport, u32 *ucr2)
 {
-	*ucr2 |= UCR2_CTSC;
+	if (*ucr2 & UCR2_CTS)
+		*ucr2 |= UCR2_CTSC;
 }
 
 /* called with port.lock taken and irqs off */
@@ -1588,8 +1589,9 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 		else
 			imx_uart_rts_inactive(sport, &ucr2);
 
-	} else if (termios->c_cflag & CRTSCTS)
+	} else if (termios->c_cflag & CRTSCTS) {
 		imx_uart_rts_auto(sport, &ucr2);
+	}
 
 	if (termios->c_cflag & CRTSCTS)
 		ucr2 &= ~UCR2_IRTS;
-- 
2.10.0.1.g57b01a3

