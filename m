Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B29EA09BC
	for <lists+linux-serial@lfdr.de>; Wed, 28 Aug 2019 20:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfH1SiI (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 28 Aug 2019 14:38:08 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44615 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfH1SiH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 28 Aug 2019 14:38:07 -0400
Received: by mail-lf1-f67.google.com with SMTP id v16so358262lfg.11
        for <linux-serial@vger.kernel.org>; Wed, 28 Aug 2019 11:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GgBnhbAyK5YL0Icz4CgluyDZjeVZCXJztYJPnsKKGn4=;
        b=peXiicX+gbp0gfJEQW0rAdumG70hYVWtX2sB3zUaizeySHSrbSjCh9cuBpkSgfBE+8
         32AQ3ZwoCfMmUfH85tVdO7Nf5ezMoMrfsM33x337+fetRAJKuyl/otI6Yta6uRTyhOUB
         oVFsYYQcHwFu/ZSAfuZdlZQFxMO908wZy3SK3yn610nTz74sBDKcfz4WBYn0VFG6cxuA
         MVJhz2MGBUfULr2IO7m79d4SgelXxATIUuBdtwRjm1YORc6WcuUojU7LOB2NszwiMOrQ
         NpyVOgaxH8aWKkJwBcMJkE/OGU6XQuJtVMsMOtDlAYc+mmx5JUXM8V2VRACqd6+N1+je
         dx5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GgBnhbAyK5YL0Icz4CgluyDZjeVZCXJztYJPnsKKGn4=;
        b=g6nFyUAqlt2hUIDfyQbRwIM/DaGSJN+zCeKhYQdUBSV1cCztuI7+3gulAAU5IdYeGp
         sxmIJJFKsiaYvP+t8HUgDkiL4Yo0oTG8EVtTghyu5Hy2k6+yFoGI9pj+E263K1LXqGH0
         n2CK2ZaGwrrCJV422ivkrzTHvLgKb71Ks46YnZx3+96Wi+4zJhGpoTH+OinB24LnDahQ
         rmL6lgsxD2h9LrJFjSHTSPY9FAmyspyEvQRf7VY+//0B4Sd9zs5Wv6bjPHYrUrjPEevp
         iLDFB73eDeRuYTAa0b0mKuOUFUvStjlXMa3vHWSEIp42urN01n0Bd6SHFvo5f1ntMldl
         U28A==
X-Gm-Message-State: APjAAAVNUuWEl2nPKsHmMvuwdXQPwwRSjPeGXoBCBljz+9+Beu5UDds4
        skw+RSTEW2TOFFXqUBQyf9vvAPrh
X-Google-Smtp-Source: APXvYqygR2+YIzVn2R25wf1NRFFId1aPu8cFdWI6PPLfj8Qr4trmPS0fkLaTqtfpJzj/8OF5T6+xGA==
X-Received: by 2002:a19:c6d5:: with SMTP id w204mr3369494lff.53.1567017485322;
        Wed, 28 Aug 2019 11:38:05 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id f6sm9226lja.16.2019.08.28.11.38.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Aug 2019 11:38:04 -0700 (PDT)
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
Subject: [PATCH v2 1/5] serial: imx: get rid of unbounded busy-waiting loop
Date:   Wed, 28 Aug 2019 21:37:51 +0300
Message-Id: <1567017475-11919-2-git-send-email-sorganov@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1567017475-11919-1-git-send-email-sorganov@gmail.com>
References: <20190530152950.25377-1-sorganov@gmail.com>
 <1567017475-11919-1-git-send-email-sorganov@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

imx_set_termios(): remove busy-waiting "drain Tx FIFO" loop. Worse
yet, it was potentially unbounded wait due to RTS/CTS (hardware)
handshake.

Let user space ensure draining is done before termios change, if
draining is needed in the first place.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 drivers/tty/serial/imx.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index d9a73c7..47b6156 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1644,7 +1644,7 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 	uart_update_timeout(port, termios->c_cflag, baud);
 
 	/*
-	 * disable interrupts and drain transmitter
+	 * disable interrupts
 	 */
 	old_ucr1 = imx_uart_readl(sport, UCR1);
 	imx_uart_writel(sport,
@@ -1652,9 +1652,6 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 			UCR1);
 	imx_uart_writel(sport, old_ucr2 & ~UCR2_ATEN, UCR2);
 
-	while (!(imx_uart_readl(sport, USR2) & USR2_TXDC))
-		barrier();
-
 	/* then, disable everything */
 	imx_uart_writel(sport, old_ucr2 & ~(UCR2_TXEN | UCR2_RXEN | UCR2_ATEN), UCR2);
 
-- 
2.10.0.1.g57b01a3

