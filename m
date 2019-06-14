Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5534045C49
	for <lists+linux-serial@lfdr.de>; Fri, 14 Jun 2019 14:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbfFNML5 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 14 Jun 2019 08:11:57 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39398 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbfFNML5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Jun 2019 08:11:57 -0400
Received: by mail-lf1-f66.google.com with SMTP id p24so1576649lfo.6
        for <linux-serial@vger.kernel.org>; Fri, 14 Jun 2019 05:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UYjsmUBIL6tntgGWQMmUG0zM7PGoxZJvICmLpEKuiKM=;
        b=il7i9G1w3SX0Zw4vIbZTsQplXBvEBNZ+eNvDmLzsAFQexzjH9BwvOMZhALmT9Y5DA7
         RVg6hUfJwzJoRyUpD2JtLUJevdCgwMplMPfNfdiiwzyY3BvMOqYmUj+NCQFP2zBQ9YFq
         yJkcaArmW5G6cXeBfEObNJpRV29I+BC8bjnO0tNtniXG+fjo0rsHMPxy8NkFfaXMPaFX
         AlUsdxlbXNi+wd6yNy7OtljKJzeUK+mfQESTfTJ2QXA+xtC1qnE8n1dLXXnqU02x5yna
         ZlNnxlR0rpet7esPf7bPaEgP0kxMpnv+E+oYXmR/FmhlQmM8u2BG54xhpe8Ue2qv9Fsd
         9rqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UYjsmUBIL6tntgGWQMmUG0zM7PGoxZJvICmLpEKuiKM=;
        b=IautsfMwqWICOBWoMf15enviEn6je4o3pP6vX7qx2jghVHwQ06viRLaHVrlaUa7US2
         mp1A6ddwrFnjdfPKMCNTEOnCFWT+WmaCfFvxyHj9Dk79IXa7lcpCIGGArR5ru2qPa3bw
         jzI439IcrZ9gCYGfpaEcR+zFNfRq4cPldAhWM6anM+WIJN3ZlZVN7rcdyDdTSGaTLbXp
         pLe6tGB1fQtbUt3MZD7fYlk6Z5w2mDBC0GwNskd657HLMJpGBG1wPlW1r3bIScfXrSS3
         85pN54LiGbxnJCxwA/4VBrVI463A4gEQ2Fv5nwWqSdVw9gM02KkGI4mtwLdfQG7iaS+4
         JmSw==
X-Gm-Message-State: APjAAAUrhXAn/oPx8ZT/AgwfvMjZJAfXsP0FQ1f+I9PSZx/D7eOSdRll
        LWQC5UQRk1/bkwxL0l2c+AY=
X-Google-Smtp-Source: APXvYqwE0kQ3/SOZHOsiq+i5HI5BQIQVPxzNpqWa+XM9yTu3PSUfyxB/zEsW9U1o4rVYPTAAidt/xw==
X-Received: by 2002:ac2:5382:: with SMTP id g2mr46735673lfh.92.1560514315029;
        Fri, 14 Jun 2019 05:11:55 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id p27sm459683lfh.8.2019.06.14.05.11.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Jun 2019 05:11:54 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH RFC 4/7] serial: imx: set_termios(): do not enable autoRTS if RTS is unset
Date:   Fri, 14 Jun 2019 15:11:31 +0300
Message-Id: <1560514294-29111-5-git-send-email-sorganov@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1560514294-29111-1-git-send-email-sorganov@gmail.com>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1560514294-29111-1-git-send-email-sorganov@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

set_termios() shouldn't set UCR2_CTSC bit if UCR2_CTS (=TIOCM_RTS) is
cleared. Added corresponding check in imx_uart_rts_auto() to fix this.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 drivers/tty/serial/imx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 17e2322..8ee910f 100644
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
-- 
2.10.0.1.g57b01a3

