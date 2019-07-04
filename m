Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF1655F8BC
	for <lists+linux-serial@lfdr.de>; Thu,  4 Jul 2019 15:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfGDNBG (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 4 Jul 2019 09:01:06 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45695 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbfGDNBG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 4 Jul 2019 09:01:06 -0400
Received: by mail-lj1-f193.google.com with SMTP id m23so6061505lje.12
        for <linux-serial@vger.kernel.org>; Thu, 04 Jul 2019 06:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mRhyyilptEVPd04WdgykTEukksr9XwSZnIYd4NBzYsQ=;
        b=J7KeLt9OoRCHRueMSXq55bYbYpg435r4HjpO3mod8gVs264oODuzbDV2uOxjOUjZrX
         vq+AYm1ZD1zH8BGE/uslpHdEclofsB+OkC6tEFNZUOdPrJ4kNElarw2AJdQLgRAeczH2
         bdxKW4XG6LwXaluA2MB+kzUfBvP24rWAqPO9ztViv88Pjq+URYQhQFnbEt3YZ3pJbSlr
         SPZki8PWWeU6Oyt7SR30UXsZF/A4CKPi85oij/tpM0M0Qf27ajXUGzc1cCozt9sBo5Yz
         0X3Vz7IryZllZj6wzhLW3GbltoEWlYTMb81J+gE42XbMuUwQopDEx5nhmLcUH0PNMPVS
         Tgaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mRhyyilptEVPd04WdgykTEukksr9XwSZnIYd4NBzYsQ=;
        b=R37a7H5ugrzw3pKnUgWPaIryKKL++aledQHAk0jtu+jMLHdjjjyOs98SLZP96ODBwy
         qN4tTpduwuNhx8XGE0tDzP2spFxAAJujS0zLFxCjilyLZ+0JtB+DYr5n9wrsAfgZd6HI
         aiSZ3EJYaqLnkaMqr/Q9m3wKzoxWmeYcAqbjV96a88IADcJYSRiq72p81/ymfsRAzSNV
         XrugY16zUpvTxQ5JJxAXI5bwKRZj/B0MvJugYC4pWm0Y5hY5SjDzV4sFBAkOiMKooFAT
         OmfoOjkFstBpyVr5G9eIc8A+5X49EB97hS1fceksKk888d1WfdXBI5pPYS2HrMPMo0HX
         HeOA==
X-Gm-Message-State: APjAAAVd+iGPC75nbVKSqk8b1zICQFYmnO5ivdihkL/mjk5xXG6f6BQ3
        tnKSeJd4sKO7rzQpBzunzQbYkVnY
X-Google-Smtp-Source: APXvYqwn0RtHcAtS1iKLqSBCZklPg4z5nGhe97iJgNmJX3SuE/EIAWq8RKtGJIfGjyD1ED/O6ptXsQ==
X-Received: by 2002:a2e:864d:: with SMTP id i13mr23876453ljj.92.1562245264059;
        Thu, 04 Jul 2019 06:01:04 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id h1sm485914lfj.21.2019.07.04.06.01.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Jul 2019 06:01:03 -0700 (PDT)
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
Subject: [PATCH v3 3/7] serial: imx: set_termios(): clarify RTS/CTS bits calculation
Date:   Thu,  4 Jul 2019 16:00:25 +0300
Message-Id: <1562245229-709-4-git-send-email-sorganov@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1562245229-709-1-git-send-email-sorganov@gmail.com>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1562245229-709-1-git-send-email-sorganov@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Avoid repeating the same code for rs485 twice.

Make it obvious we clear CRTSCTS bit in termios->c_cflag whenever
sport->have_rtscts is false.

Make it obvious we clear UCR2_IRTS whenever CRTSCTS is set.

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 drivers/tty/serial/imx.c | 36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 87802fd..17e2322 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1567,35 +1567,25 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 	if ((termios->c_cflag & CSIZE) == CS8)
 		ucr2 |= UCR2_WS;
 
-	if (termios->c_cflag & CRTSCTS) {
-		if (sport->have_rtscts) {
-			ucr2 &= ~UCR2_IRTS;
+	if (!sport->have_rtscts)
+		termios->c_cflag &= ~CRTSCTS;
 
-			if (port->rs485.flags & SER_RS485_ENABLED) {
-				/*
-				 * RTS is mandatory for rs485 operation, so keep
-				 * it under manual control and keep transmitter
-				 * disabled.
-				 */
-				if (port->rs485.flags &
-				    SER_RS485_RTS_AFTER_SEND)
-					imx_uart_rts_active(sport, &ucr2);
-				else
-					imx_uart_rts_inactive(sport, &ucr2);
-			} else {
-				imx_uart_rts_auto(sport, &ucr2);
-			}
-		} else {
-			termios->c_cflag &= ~CRTSCTS;
-		}
-	} else if (port->rs485.flags & SER_RS485_ENABLED) {
-		/* disable transmitter */
+	if (port->rs485.flags & SER_RS485_ENABLED) {
+		/*
+		 * RTS is mandatory for rs485 operation, so keep
+		 * it under manual control and keep transmitter
+		 * disabled.
+		 */
 		if (port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
 			imx_uart_rts_active(sport, &ucr2);
 		else
 			imx_uart_rts_inactive(sport, &ucr2);
-	}
 
+	} else if (termios->c_cflag & CRTSCTS)
+		imx_uart_rts_auto(sport, &ucr2);
+
+	if (termios->c_cflag & CRTSCTS)
+		ucr2 &= ~UCR2_IRTS;
 
 	if (termios->c_cflag & CSTOPB)
 		ucr2 |= UCR2_STPB;
-- 
2.10.0.1.g57b01a3

