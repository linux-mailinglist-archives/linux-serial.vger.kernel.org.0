Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56CE44D0B5
	for <lists+linux-serial@lfdr.de>; Thu, 20 Jun 2019 16:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731805AbfFTOsP (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 20 Jun 2019 10:48:15 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45736 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731791AbfFTOsO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 20 Jun 2019 10:48:14 -0400
Received: by mail-lf1-f68.google.com with SMTP id u10so2604635lfm.12
        for <linux-serial@vger.kernel.org>; Thu, 20 Jun 2019 07:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/gmvgIGLetUvFcBPF+pJa4U0pLLQ63ecHLMpqfRKqNE=;
        b=EW4Efxi+f4+n9tmUrRsKUWDBDeGfbd8SlIWwqFff40QnougmmpYe9PWBz3PZCpl/Nn
         Su75neDqxDQaHRtw6DQHe33fDum8ZGdp1JnWKQCKoONJFW8zI/g/z1+k5rut8hB32CTM
         vkda5ut3p2Th+ZOXgvI2amW/DS9pUAuAirYj97SfWhi7hvX5OTyHea3Vq1eZcnHepvUf
         6JX9p4GsaXXop3nKoGHxZhzf0ECgcmSXGLGeZLEcq5r9Fa8CoyDexCECLu2PYNff9y0c
         JvIthpVuWEpeNyVyEoEQUb0O2p6sa9a8cqW4HAw2GXKvTelKnXlmfGkU+NV/3KxhpB0l
         FlNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/gmvgIGLetUvFcBPF+pJa4U0pLLQ63ecHLMpqfRKqNE=;
        b=QrQCw7cjY/CA8zDAk1K8gwGBuYTbatH6kgqrDIqq6F2Ga54UzXLtXNw1BI60bgIxO4
         VTncqHJ/CMNY2oGxeQlEahacnXn+7dBxGA7eoN9ZA9B1wD7bZWQ2TlRy4nEPduWZCqK9
         8TngfVubWGKQnEXg1vdxxEKyyipDPvyzgkrvKwDpkPvX3W1MEAcug4KVNyHDShXgH8VO
         qlYelrMI9wM/v5ozViPS0h0+Q14p9bxykB170kDHXfGmXi8r2yLT6qNA6Vwl326jSx70
         M+5xuaZBreNGT5Gf8AAQjjdaiGoTiecGmYoN9zrnB1dLPRfp/6onztISsj4ZWhIkMcUF
         q91g==
X-Gm-Message-State: APjAAAXOLkYH9ChuFYqwf4lOhT/L3VUVZ4Ex6WEzyZaVCR9J4STsBV5g
        DbMMdAxbSexi09t7VyEOL3E=
X-Google-Smtp-Source: APXvYqwDmpSWVNY+4QgAKqUYLQ+RxNZ4gmwBGU7Au5lGe/bodTp2ffmy2FO8HU1Hkk13agrWqpSGCw==
X-Received: by 2002:ac2:5b0c:: with SMTP id v12mr53351238lfn.184.1561042092841;
        Thu, 20 Jun 2019 07:48:12 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id f10sm3577768ljk.95.2019.06.20.07.48.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Jun 2019 07:48:12 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH RFC v1 6/7] serial: imx: set_mctrl(): correctly restore autoRTS state
Date:   Thu, 20 Jun 2019 17:47:52 +0300
Message-Id: <1561042073-617-7-git-send-email-sorganov@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1561042073-617-1-git-send-email-sorganov@gmail.com>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1561042073-617-1-git-send-email-sorganov@gmail.com>
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

