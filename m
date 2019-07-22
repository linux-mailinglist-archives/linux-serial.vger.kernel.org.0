Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDC9E7099C
	for <lists+linux-serial@lfdr.de>; Mon, 22 Jul 2019 21:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfGVTWX (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 22 Jul 2019 15:22:23 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34951 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbfGVTWX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Jul 2019 15:22:23 -0400
Received: by mail-lf1-f66.google.com with SMTP id p197so27461951lfa.2
        for <linux-serial@vger.kernel.org>; Mon, 22 Jul 2019 12:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hlO4j1hJuCOJd1h1Hw9Dr7/Fw6jxqbEeyEo5OnuF750=;
        b=OBZ5VenYegly2ZmgB5apxAfAcbm+r7LzHEHc5zO9xF3ZIT2Nt/9Drpvjh6u0DKhL4X
         pgioTplB7ujqb0Sh+fw20i11enadUzceNFnS2VbQqnfBKZR0jyba/W7o/dXFSCrD4IXl
         ZSBK9kkwfBd8DYxsSQvOa8OGd70F+Afe+uPCwHniJDr7Nrqxc72SuJ1E6yZ6da0W807V
         VuXWRFqzgl6qQZI7iOVtLeHgxdsKSeWU2EhmF3VsYjqS2T3PT5RDVLGUFsKjkcQ/83I9
         oEMaYD+ZYZZcUB1bXJy1O4q/9i7UCZhZlvwCS4P6P+O9mivIu3ffWTgbCnSsE7x6/YM0
         N7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hlO4j1hJuCOJd1h1Hw9Dr7/Fw6jxqbEeyEo5OnuF750=;
        b=Y2NlL2buStOkQFo0b3nzdW3VcoNZt806rm2d+1pjufkU/yH+FRMzOY1zd37CxFdkYT
         SJBJQeccK530jBNrAaXVFTM3jGFDcDnB4uDn9s4T81Qx6KC/SLrM5C6/bsJJBR7oqAiY
         MpMIjaofTO1OBtsub9lJPjSSJl3elSOhmV95yK3UbrCiLegJWt5u0az56b2/FbMJKN9+
         acUkHu3cj6x+cPBtXebKTt6+BnxsOxl+DqQdIZr2q8x/6q5fGXFoGTDKVyTXz4AW5ajF
         NOMttOtlR6h3z4EHr2zt8sb0SqSK4GeDZqxLGNgPr1lOlcnW6qb6k1HleGn3R0VpOGoN
         6ERg==
X-Gm-Message-State: APjAAAX52cQnMI+jYw+fH4JCAK5hhI1fnPx4c0Fh/IeAVKVzrNdr07ni
        3CWSEeUkZyktseGC940wnK2d3Ygy
X-Google-Smtp-Source: APXvYqwboXpIQejpdye+ead8X3EBEYoeyGI8KGKUyL2A6myeizX0W9lQ5Z68gTdkgvQR+MzbQJ3AiA==
X-Received: by 2002:ac2:4644:: with SMTP id s4mr32318959lfo.158.1563823341083;
        Mon, 22 Jul 2019 12:22:21 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id n124sm6129307lfd.46.2019.07.22.12.22.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Jul 2019 12:22:20 -0700 (PDT)
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
Subject: [PATCH v6 1/3] serial: imx: set_termios(): do not enable autoRTS if RTS is unset
Date:   Mon, 22 Jul 2019 22:22:09 +0300
Message-Id: <1563823331-5629-2-git-send-email-sorganov@gmail.com>
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

Don't let receiver hardware automatically control RTS output if it
was requested to be inactive.

To ensure this, set_termios() shouldn't set UCR2_CTSC bit if UCR2_CTS
(=TIOCM_RTS) is cleared. Added corresponding check in imx_uart_rts_auto()
to fix this.

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
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

