Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 418FE6FC09
	for <lists+linux-serial@lfdr.de>; Mon, 22 Jul 2019 11:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbfGVJWY (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 22 Jul 2019 05:22:24 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37566 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727744AbfGVJWY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Jul 2019 05:22:24 -0400
Received: by mail-lj1-f193.google.com with SMTP id z28so36955233ljn.4
        for <linux-serial@vger.kernel.org>; Mon, 22 Jul 2019 02:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HA2f/ifCDrGNgMEk+3HGOD0y69BKIfJxvyiY4pBfCgE=;
        b=rkiUfHF7VO9LHPZzsQsdyww5l9RzJLCGBPEXFixUlamFHpcZviC1GyG+PGFCV1kfV5
         2pw/X06gPcEtd2xBNg4sYqs6Galcx91JalyNsJXvnA0cyf2tmcWAy+OaHTEnTrHKAp81
         UQmhlLZ03gKxTuSeE0Sg7s3/Wd9ugLfkJfc+MXWEo+d9e7s+h5872OBuSF57/+BjrXVt
         QYdVjb67iC0uqfvACfS/8hHNPJou1yuRG3SoM6UOSqqyG3EKll/rUuGa2YOEKyGoUAyv
         XVE+cTY7SdA2AkRVY+1O22dRjkAcB21FJ8OfqjiR1bQ1ofYDvag8nYU3hy5gRLYOgKKg
         yZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HA2f/ifCDrGNgMEk+3HGOD0y69BKIfJxvyiY4pBfCgE=;
        b=gsHKb7eES3IjSwwCDixLdFLuaVnRLgwLs5CTVetzHYzt82jPUUB4Qdep7S0DASYZm6
         +lY+oaBjdD0OtW3wCBVPx9IeQ8bo2jA5019jYH41hMRAFaNFHahc18Lf/xgZZmrM2ZBg
         DYykEnRRq7lDIzzuPgGTqRUxSpPxUjIkkU7udJpTrfLvaC1XpcI1IFjk7AMBezABO2HU
         K6jTDSggUxG46OdnLoPwXtm8jSC3unFPRNFnO+CMHRHKp8DDvBXvNUeK3Uf/OAkr3VG4
         fB4zStW+6jOQjKr9orGSIycwfE4shbfdzm/5I/NFXuUMsJBFxj0PBVhTuFEO72YCLOs8
         YEFA==
X-Gm-Message-State: APjAAAUySeqYd5f6nGovaG3MEzAHTpmkwO12Aoqo3EAt8gfXuJEYEku2
        oZcrzq73/KAapXzeY299g1QsNb1J
X-Google-Smtp-Source: APXvYqwHAC3dvb2De+mxHlgp8DFhqzN74V36dBGcVrQ3LpNHmBSOnGLfnvFLH5JXbGLQHaiAKsyRTQ==
X-Received: by 2002:a2e:8007:: with SMTP id j7mr35899636ljg.191.1563787341958;
        Mon, 22 Jul 2019 02:22:21 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id b68sm8425088ljb.0.2019.07.22.02.22.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Jul 2019 02:22:21 -0700 (PDT)
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
Subject: [PATCH v5 2/3] serial: imx: set_mctrl(): correctly restore autoRTS state
Date:   Mon, 22 Jul 2019 12:22:09 +0300
Message-Id: <1563787330-1394-3-git-send-email-sorganov@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1563787330-1394-1-git-send-email-sorganov@gmail.com>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1563787330-1394-1-git-send-email-sorganov@gmail.com>
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

Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
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

