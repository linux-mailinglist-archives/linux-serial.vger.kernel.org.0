Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88DE756B96
	for <lists+linux-serial@lfdr.de>; Wed, 26 Jun 2019 16:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfFZOOW (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 26 Jun 2019 10:14:22 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35057 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfFZOOV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 26 Jun 2019 10:14:21 -0400
Received: by mail-lj1-f195.google.com with SMTP id x25so2398867ljh.2
        for <linux-serial@vger.kernel.org>; Wed, 26 Jun 2019 07:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PSCP97EAMw9kJ5xr2biP47mIP/F/75GsSBuiL+rMzdw=;
        b=mqUioiLReGnEQt+HM3TnWMKitnMv4iEElkv3Gxq/nhULQPVKwjqcrzDEiooO2YoSVo
         iM1wtpbL3kCH2M2N6HPi3q7Dhtr0Bxo9RY6kiySEIPyxEmbhw+FUIh5vmMV95XuR3USl
         3EwQR+oSAGzlbo9eXaCP4cgS+DqXhTSHrsbt0TrpUSBBs5cRhywaFhUs4GKeOKcRiJ/x
         lCZVoj2RwhLu0G6nKLjevdfPaLJFpeJ/d4ID0VICG1G/csP2GrXd59yDmfUH+5hxkTxn
         TJhxWbOsYSHXtjqreBzsCLFGM7p0nxGCY3xLAsCbGmW5TIzMQCEpgITjWW6S3sguJKeA
         oC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PSCP97EAMw9kJ5xr2biP47mIP/F/75GsSBuiL+rMzdw=;
        b=P9LCIM4MDudxJzw6tgpHpBERoFyKeucnoAo/rmIRt2mMQ8HliVqS3XteDYxkPHq1Qf
         M402HSIqudGz073jf0IOYLo7mtSmh9IqDvtz5A5Bi9iUfsJasoTMqr8akgqh8+GA+vZh
         aUQ1EfG5gZ9Ex0i2NYRcZ9X7eYEzkL7ne/e4W/CAz070oP9soq5vds5DocVlofwZIqub
         QCtLSLiC9G/W7Ef6hfrHmMzc0CsSfsvaWj+iw67rCErEP3I/t1NDBE1izxH8LqiI3Q1Y
         xlnWljCIt46rUgZeepL/h57cP2PnJ6li/02/RFWE2jnHAgZuNx6gKtdT4reM3FeH7cY4
         +2XA==
X-Gm-Message-State: APjAAAWDCNIgDPSxgD8tmeY9zEcdo+lM8MaV8uq7GUBK59BUfjEGUz65
        I/uviWJJCaGkIL0zZFOAZ04=
X-Google-Smtp-Source: APXvYqyuTVynFjGEcA3fo0upN/VPg2m8WVsm9Rnt8JOCdPSLblri7wBfunfXN82sWRjbNSecicxmbA==
X-Received: by 2002:a2e:9b03:: with SMTP id u3mr3086619lji.15.1561558459745;
        Wed, 26 Jun 2019 07:14:19 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 25sm2863825ljn.62.2019.06.26.07.14.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Jun 2019 07:14:19 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v2 5/7] serial: imx: set_termios(): do not enable autoRTS if RTS is unset
Date:   Wed, 26 Jun 2019 17:11:31 +0300
Message-Id: <1561558293-7683-6-git-send-email-sorganov@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1561558293-7683-1-git-send-email-sorganov@gmail.com>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1561558293-7683-1-git-send-email-sorganov@gmail.com>
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
 drivers/tty/serial/imx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index e0f5365..4867f80 100644
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

