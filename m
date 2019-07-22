Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B94B6FC08
	for <lists+linux-serial@lfdr.de>; Mon, 22 Jul 2019 11:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbfGVJWX (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 22 Jul 2019 05:22:23 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36511 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbfGVJWX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Jul 2019 05:22:23 -0400
Received: by mail-lf1-f67.google.com with SMTP id q26so26119557lfc.3
        for <linux-serial@vger.kernel.org>; Mon, 22 Jul 2019 02:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3RZDKKssLiiM+ZqD6fvBMB3Dv9xagAFFHDgU43w8ol0=;
        b=aGw/F/VEZpVAJBDXyA75DL9/4pmrXg1U0JBqRqa3ALjH/myv8cOn4ugMqpL7e/ZPXs
         ZiY1/gZeGfa9UsTNPTKIzZ3yaTKiz3r9eDMJeT6GHtiKdFQ7AkUleGJvItnxkUlEMuD0
         PfbV4HfStoCpoIo1U860aONjccYvVTdwpKMuzOpuELuzlK3Xh7rgJwDUWEALsPdzw2CO
         6czjWGE8ZaoYOoVrOIJASFfsE0BSnzQUbfS6LeIFIp2CEFMH22b5sq0zI9NCCrqCoueL
         Rwz9rJbLnpBuFdxmGjw6V+NOq6qNV0UIjG0IK1dwcmZLbaZ9qrHmM2ZcUV6PaRrG5Hoz
         WkzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3RZDKKssLiiM+ZqD6fvBMB3Dv9xagAFFHDgU43w8ol0=;
        b=gRowScLFFQLDHNsgAuDF6hkTBG4dZ+wP1+4Qz96badv6IsuZpn3as6UssquWbKZ18i
         TfBKrrU9hG16VC++rRaKHFzNA1Tli8LNDr6YXKHGyY+nIG1YzLS1AI6ubVz1AmMvc+gz
         aDB3XflEupa3JJnT0bTONqHWugT10BiQhmFugkZVRc7hzfimdcgBa86yN+mYF7OHwO/0
         HVK42FbIUnzk8pRsuG6vWKQJU/OyCIXXqr4c6uOlppn60cLF/eIxHF5WHNuQnKPJ2iw0
         xsgGYb6B4N2Y8m8moHtHvKYoJDqyk7Dvi3UVRUiQBFdqAiW6NIWPM/1ngY4TtPzy1af8
         i3ww==
X-Gm-Message-State: APjAAAWIHCtrAX8kihxxEEOAV4Y0LgQJGMpgFW5qgdw1g8wdo9Bxld6N
        hfiAxsSMI4zejr4lFIU0k5TJMFFF
X-Google-Smtp-Source: APXvYqzmUDHMeFgXh0O8Zqk1fIKHJ+x0b+A0DiTtGNBtTJNdwDOGg12otmwhbua1bXOTSDzyum6ZbQ==
X-Received: by 2002:ac2:514f:: with SMTP id q15mr31871139lfd.145.1563787341071;
        Mon, 22 Jul 2019 02:22:21 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id b68sm8425088ljb.0.2019.07.22.02.22.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Jul 2019 02:22:20 -0700 (PDT)
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
Subject: [PATCH v5 1/3] serial: imx: set_termios(): do not enable autoRTS if RTS is unset
Date:   Mon, 22 Jul 2019 12:22:08 +0300
Message-Id: <1563787330-1394-2-git-send-email-sorganov@gmail.com>
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

Don't let receiver hardware automatically control RTS output if it
was requested to be inactive.

To ensure this, set_termios() shouldn't set UCR2_CTSC bit if UCR2_CTS
(=TIOCM_RTS) is cleared. Added corresponding check in imx_uart_rts_auto()
to fix this.

Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 drivers/tty/serial/imx.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 57d6e6b..32f36d8 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -405,7 +405,12 @@ static void imx_uart_rts_inactive(struct imx_port *sport, u32 *ucr2)
 /* called with port.lock taken and irqs caller dependent */
 static void imx_uart_rts_auto(struct imx_port *sport, u32 *ucr2)
 {
-	*ucr2 |= UCR2_CTSC;
+	/*
+	 * Only let receiver control RTS output if we were not requested to have
+	 * RTS inactive (which then should take precedence).
+	 */
+	if (*ucr2 & UCR2_CTS)
+		*ucr2 |= UCR2_CTSC;
 }
 
 /* called with port.lock taken and irqs off */
-- 
2.10.0.1.g57b01a3

