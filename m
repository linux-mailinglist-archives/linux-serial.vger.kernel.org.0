Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C58D56B97
	for <lists+linux-serial@lfdr.de>; Wed, 26 Jun 2019 16:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbfFZOOX (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 26 Jun 2019 10:14:23 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39243 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfFZOOW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 26 Jun 2019 10:14:22 -0400
Received: by mail-lf1-f66.google.com with SMTP id p24so1688635lfo.6
        for <linux-serial@vger.kernel.org>; Wed, 26 Jun 2019 07:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Cru3DQ0cf7AVa+7W6ow471nhNIp8xE7O+QraDjrOeNI=;
        b=oGSohR+AMbgw3RJe6dElbWB7kM/ng20QeMXi7srOmz1ae9AIpYC42091JUF7gRtRQI
         U6InvOg08QosR9ixVkmIIv8uBJ3Imd8Dhnj18XNyUgxhAsZRC1VDRY3xqlqT5RABwSrh
         J0nugtNshxwM97+dZSJs+IUkSIfEBMa8rqRMW/sYT/3vcUhXdb9kWi479vMmhCxpf24S
         f0Ocy1I+stdB19JV2iX4tFEtWt+b5bM29PWgVMpz4iqdgVMsRoVC1ftKK2JWKJDa3TaG
         9mJ1r0Q9UbR0g/MCDrSa5X9SfOCKfKnp33T6i3zUQLNZ8GCyb7wUNyXfU08SFRW1+4qw
         0g7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Cru3DQ0cf7AVa+7W6ow471nhNIp8xE7O+QraDjrOeNI=;
        b=qA2oL23zChdktq4IhRnFiMgSCsMS3sbTjSIu32hSO1S8iT8FVhpD5T0V2RF5Cva7X7
         vZvUOGZHf/wCHhFUaiNQIBkR4thwt3FAGxYf9Ps7yxENKDaeK2JsGlT3YIb07GMC2jpw
         2M+/vUdU21QYzSLBgtphnXLyziOAG44gPsTvh2p0nVjRin61H/cpvxORGWoLzRARO0ZH
         uDzkovMUwrHPUmvUH2QeV2KdrSXTMQFUdmmYgEIVpa/2d1NRgJHUiS8Qdw2viAWnVElP
         Uv5k7AIiNXH/ujYIQVl//t+rpHQs5f6hbS3H/6EqKk00frv0WBh9+nKYpsNC9JRAHR5U
         dm7w==
X-Gm-Message-State: APjAAAXDn7Z4DAbAGvVY0FWbvfzI65NYy+eL8tkfLYAY5kDTXrfdvT5s
        5cfVEx04/HtMFeno3NIvzaE=
X-Google-Smtp-Source: APXvYqyL1RGOMBYqi/6sv3nKZIVcrOLXsrmGA0M5Cj0IiQP51tp7X8MAQLS00+1fgkBYgDv6grPSfw==
X-Received: by 2002:a19:490d:: with SMTP id w13mr2761425lfa.58.1561558460721;
        Wed, 26 Jun 2019 07:14:20 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 25sm2863825ljn.62.2019.06.26.07.14.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Jun 2019 07:14:20 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v2 6/7] serial: imx: set_mctrl(): correctly restore autoRTS state
Date:   Wed, 26 Jun 2019 17:11:32 +0300
Message-Id: <1561558293-7683-7-git-send-email-sorganov@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1561558293-7683-1-git-send-email-sorganov@gmail.com>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1561558293-7683-1-git-send-email-sorganov@gmail.com>
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
 drivers/tty/serial/imx.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 4867f80..171347d 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -970,10 +970,19 @@ static void imx_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	if (!(port->rs485.flags & SER_RS485_ENABLED)) {
 		u32 ucr2;
 
+		/*
+		 * Turn off autoRTS (UCR2_CTSC) if RTS is lowered and restore
+		 * autoRTS setting if RTS is raised. Inverted UCR2_IRTS is set
+		 * if and only if CRTSCTS bit is set for the port, so we use it
+		 * to get the state to restore to.
+		 */
 		ucr2 = imx_uart_readl(sport, UCR2);
 		ucr2 &= ~(UCR2_CTS | UCR2_CTSC);
-		if (mctrl & TIOCM_RTS)
-			ucr2 |= UCR2_CTS | UCR2_CTSC;
+		if (mctrl & TIOCM_RTS) {
+			ucr2 |= UCR2_CTS;
+			if (!(ucr2 & UCR2_IRTS))
+				ucr2 |= UCR2_CTSC;
+		}
 		imx_uart_writel(sport, ucr2, UCR2);
 	}
 
-- 
2.10.0.1.g57b01a3

