Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32C1E45C4B
	for <lists+linux-serial@lfdr.de>; Fri, 14 Jun 2019 14:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbfFNML7 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 14 Jun 2019 08:11:59 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38541 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbfFNML7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Jun 2019 08:11:59 -0400
Received: by mail-lf1-f67.google.com with SMTP id b11so1579996lfa.5
        for <linux-serial@vger.kernel.org>; Fri, 14 Jun 2019 05:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MDH+SHphi2du8HQmnp7WkqZowZkrn1A0IGK01w7XZi4=;
        b=tjFyKsoOmlqoDIYNiaw0kw6MN9s1Upm314ctD6PUnNY3UjlUOhmS2tPXI+dvHPVLCS
         TmH9Wg8+j+AL6lAeQx10dXaWiGlnpIYAYzUw7eDTJbC0hV6zyAvCN39tAPWEbpixyf77
         N6vK+d48EAdtUBSFzbgr7k2hAJ9hk2YIFEVCzxo8/fSEVxcyJVQ+HMKiDfrLuf/DGsEb
         mqFfqHhVZZXkoBNJfHEjaoXHL8T6P/thlKSELLZOO82Ny5/0b5g+IzuhM5+DXfZ6cXOt
         a8sRWPeOlQr2pf0k5sVXJLsD8nHS+6NYWmLcgH2C1E9/OMca6uOYmmrFDcxPen9Ok9/s
         QIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MDH+SHphi2du8HQmnp7WkqZowZkrn1A0IGK01w7XZi4=;
        b=p3dwOSY2QrhyRYJBZ5I3LkfIPcgcrM21mAOYC9IQpjRK6/B016lYFgewZF/EHs0DL+
         o1J7c8xzopoznwm6LPLrqekgV5/2tTN5UyDIYCt4xapzFEqV+vUuspR2kZjU5/knnNkP
         IwhbGKuUGABSL9vI5xYcUT5nQLbD2u2OB+6Hmb6CfU3ZXzv4MKU2PLzM/caJidmGnw3U
         yaufnUff6q67Rvonk+Cqyxs1Hmxjnjyu4iwY4fgr9HR4FZPn5eHeLoeLiDtGjZZjRzRS
         3ojpbiFNWyi5ytczt437wYqRzXuaXaSvLhIZtznNwWewLhxRDhRETKHuFsZrCc0HlQV4
         9OSA==
X-Gm-Message-State: APjAAAWCgKeQBRxy7McgP8Uc5nkK+gN71UDaNgC1l0pAWbIVya+VAjYR
        r2m1x/vh6VsAKkWmkYEd6UE=
X-Google-Smtp-Source: APXvYqzUW0zaN2dztJMASk7r2O0ps7VxazW/j1SIteqZxnYzGbKqLOxtxLTGrUwrCTBm6XYDQeaLbQ==
X-Received: by 2002:a19:230f:: with SMTP id j15mr9538698lfj.122.1560514317209;
        Fri, 14 Jun 2019 05:11:57 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id p27sm459683lfh.8.2019.06.14.05.11.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Jun 2019 05:11:56 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH RFC 6/7] serial: imx: set_mctrl(): correctly restore autoRTS state
Date:   Fri, 14 Jun 2019 15:11:33 +0300
Message-Id: <1560514294-29111-7-git-send-email-sorganov@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1560514294-29111-1-git-send-email-sorganov@gmail.com>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1560514294-29111-1-git-send-email-sorganov@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

imx_uart_set_mctrl() happened to set UCR2_CTSC bit whenever TIOCM_RTS
was set, no matter if RTS/CTS handshake is enabled or not. Now fixed by
turning handshake on only when CRTSCTS bit for the port is set.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 drivers/tty/serial/imx.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index de23068..bdb8b6a 100644
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

