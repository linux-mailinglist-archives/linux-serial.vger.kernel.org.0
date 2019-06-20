Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40CEC4D0B6
	for <lists+linux-serial@lfdr.de>; Thu, 20 Jun 2019 16:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731791AbfFTOsQ (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 20 Jun 2019 10:48:16 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46833 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfFTOsP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 20 Jun 2019 10:48:15 -0400
Received: by mail-lf1-f68.google.com with SMTP id z15so2602432lfh.13
        for <linux-serial@vger.kernel.org>; Thu, 20 Jun 2019 07:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HSmA2mWGWhBQ0CiBD0AKf9JHGKelcp2PJeQT4mYweVc=;
        b=W0pxNpYBz82c1Zqq7Bv96jba79T4vZ/lo8okYya4azYckR7DCxMvsFFPEcU0don4Jf
         LeQbA/ia7ypibGfGWbZ7GvHwJfOLw2T/A/5u2EbJvD4NI8cwgploJ7X4NkZR9kgnU+RJ
         a2bLohuvhra2oiK8RXG9uojMHaTWMcHgLMlvix4h26Tuq34pgd/Ghvj4nA5B9+R2ULjd
         JmnQvtzhrDX8GaJY/gBT0sjJO0oSu9/j189Ca4DVlO6aprfgRT+KygEg9pmP2aMeQFVr
         XcTaMDGY3mNxQRjazj74jlFsh+ikMy+XbFaDdZdxKjbQnj2JEiQtwS3HJ0NEvqdnTi9D
         5xKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HSmA2mWGWhBQ0CiBD0AKf9JHGKelcp2PJeQT4mYweVc=;
        b=PnG96v0csdJQ22JLqiimuCG2IeO5dVmTBDOPMIpyqzJk349HaDDT0fSUZPQ5RXYHuI
         Pf4UnxBWNUm/I2GzMDvuABM2cLHNfBAcDhaW8sPeV/uk82IWfd0h0V/Lzt/gtUOSrdbM
         qynk9I+jBz/9jzEVgvpQ8I/kUZFeqVDhI0p++CqHNrr3D0E0CUxtr4uNHGLaOatAYSdh
         o1K9F4GzHEia+p0eJ3hOwBI0qdzsfCUV5onsBNv4gYVnqtwh+HkKpgYE8wkms/GUNczd
         N0cJudZS1NC6gsugPMePmJEFQlM4A3wEGbNuaZ/FPNObUvRuE4fbOtEwCtIcbGWRxp2P
         ci6Q==
X-Gm-Message-State: APjAAAUjJBExadtOXOqBsMLh3Shv0/zxSNRyCUrsPWVqER+RgzeIO/wl
        TLN3V9aiI9EGngyTn72XgUw=
X-Google-Smtp-Source: APXvYqzv8uOd/bMglQArMIBQ+KTyM4uiCi+Upep288W03NpjIgQnvzv7cBQnGhuT1n69OPTqA1NXBQ==
X-Received: by 2002:ac2:5922:: with SMTP id v2mr64882966lfi.180.1561042093788;
        Thu, 20 Jun 2019 07:48:13 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id f10sm3577768ljk.95.2019.06.20.07.48.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Jun 2019 07:48:13 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH RFC v1 7/7] serial: imx: get rid of imx_uart_rts_auto()
Date:   Thu, 20 Jun 2019 17:47:53 +0300
Message-Id: <1561042073-617-8-git-send-email-sorganov@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1561042073-617-1-git-send-email-sorganov@gmail.com>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1561042073-617-1-git-send-email-sorganov@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Called in only one place, for RS232, it only obscures things, as it
doesn't go well with 2 similar named functions,
imx_uart_rts_inactive() and imx_uart_rts_active(), that both are
RS485-specific.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 drivers/tty/serial/imx.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 171347d..a5e80a0 100644
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
@@ -1598,8 +1591,10 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 		else
 			imx_uart_rts_inactive(sport, &ucr2);
 
-	} else if (termios->c_cflag & CRTSCTS)
-		imx_uart_rts_auto(sport, &ucr2);
+	} else if (termios->c_cflag & CRTSCTS) {
+		if (ucr2 & UCR2_CTS)
+			ucr2 |= UCR2_CTSC;
+	}
 
 	if (termios->c_cflag & CRTSCTS)
 		ucr2 &= ~UCR2_IRTS;
-- 
2.10.0.1.g57b01a3

