Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2A3536DFD
	for <lists+linux-serial@lfdr.de>; Thu,  6 Jun 2019 10:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbfFFIAc (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 6 Jun 2019 04:00:32 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33136 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbfFFIAb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 6 Jun 2019 04:00:31 -0400
Received: by mail-lf1-f66.google.com with SMTP id y17so860158lfe.0
        for <linux-serial@vger.kernel.org>; Thu, 06 Jun 2019 01:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/AhlJdTkiW7Y8IhZ3G0HH2q33/F14E5FLuC6qe7v9gs=;
        b=dhjg2ZG89cRNOKeTBeqxz+dRXhHwwu+VfLg/BUtSN4NtshFBZ21tx4grUQu1RkOoz9
         QTVvORFuSg33zNHK8lt3SwxP+3qjaIKGCJHx/1nKZchCSyMLbknfvC1G9Hz+t2QKrSHg
         v1awE6U3g+Ck87AmTkjqAcc+45YWh/LHbdb7gD/ZGb7ZVm918FbaGPDE0k8tzpNtq8k1
         a1z+1m96zyh5TioEtYSGmKORxPex1gyHvWUDUbWj2ZsyS2Wxy4klHcbiMkxKw4Yc44ig
         cMWfb2YFwcjAaGOhpNabxC6Q8I85dt5ojENu/J3eBf8uQepZ6WNEkVb7Cv9PH9SH+r7D
         AJ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/AhlJdTkiW7Y8IhZ3G0HH2q33/F14E5FLuC6qe7v9gs=;
        b=WvTO/YHL6DNmwzkoI9QsFRtgP79F7WT4iGCplZQHVClN37rdqovVhxmZRHwyILRMWR
         U1xsDotn8wf9vFmbiYzw5QosqkWDOqmGKZREUdqOuIiK1X/K7+SNAWww/BkgpZyosS6Y
         kDDcnwM9QibMRfdnAMYLE6EsMNudX9xZROyFSFEPRu1m4ftE0pN/3h/y8WsJkNjg8dEm
         FWjSmoi9LIbvgFFH+0YhXJY5GtSianlx4O4Ai5X70dwI6lpFYNvRjEuZUnMrRi8UFhBd
         0cuEHc0PtTKgFXRn65B7JWsznFIs4R77AqLoB92Qh6u0GcTKQMq4m0SIjzgPlt+s1cur
         UlRQ==
X-Gm-Message-State: APjAAAUuEmah6bvvctajAE+RCJYa6GKr/mH7gDKr1iuERJzDNGPxQZO5
        OluoELzTLSvO42cSydFJp7ZAqOLxdmk=
X-Google-Smtp-Source: APXvYqwRSI5VTq9Zuq6CBIpqaQm0Uo9VqYxlekAvrEj7YG3iQ7vIysCQQ4+ykt5AQhzT49+Huo8sCA==
X-Received: by 2002:ac2:53a5:: with SMTP id j5mr22793633lfh.172.1559808029437;
        Thu, 06 Jun 2019 01:00:29 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id o8sm212176ljh.42.2019.06.06.01.00.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Jun 2019 01:00:28 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH RFC] serial: imx: fix locking in set_termios()
Date:   Thu,  6 Jun 2019 10:59:37 +0300
Message-Id: <1559807977-4598-1-git-send-email-sorganov@gmail.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

imx_uart_set_termios() called imx_uart_rts_active(), or
imx_uart_rts_inactive() before taking port->port.lock.

As a consequence, sport->port.mctrl that these functions modify
could have been changed without holding port->port.lock.

Moved locking of port->port.lock above the calls to fix the issue.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 drivers/tty/serial/imx.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index dff75dc..cb95ff71 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1550,6 +1550,20 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 		old_csize = CS8;
 	}
 
+	del_timer_sync(&sport->timer);
+
+	/*
+	 * Ask the core to calculate the divisor for us.
+	 */
+	baud = uart_get_baud_rate(port, termios, old, 50, port->uartclk / 16);
+	quot = uart_get_divisor(port, baud);
+
+	/*
+	 * Take port lock before imx_uart_rts_*() calls, as they change
+	 * sport->port.mctrl
+	 */
+	spin_lock_irqsave(&sport->port.lock, flags);
+
 	if ((termios->c_cflag & CSIZE) == CS8)
 		ucr2 = UCR2_WS | UCR2_SRST | UCR2_IRTS;
 	else
@@ -1593,16 +1607,6 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 			ucr2 |= UCR2_PROE;
 	}
 
-	del_timer_sync(&sport->timer);
-
-	/*
-	 * Ask the core to calculate the divisor for us.
-	 */
-	baud = uart_get_baud_rate(port, termios, old, 50, port->uartclk / 16);
-	quot = uart_get_divisor(port, baud);
-
-	spin_lock_irqsave(&sport->port.lock, flags);
-
 	sport->port.read_status_mask = 0;
 	if (termios->c_iflag & INPCK)
 		sport->port.read_status_mask |= (URXD_FRMERR | URXD_PRERR);
-- 
2.10.0.1.g57b01a3

