Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDF2E5F8BB
	for <lists+linux-serial@lfdr.de>; Thu,  4 Jul 2019 15:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfGDNBF (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 4 Jul 2019 09:01:05 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39705 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbfGDNBF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 4 Jul 2019 09:01:05 -0400
Received: by mail-lj1-f196.google.com with SMTP id v18so6078069ljh.6
        for <linux-serial@vger.kernel.org>; Thu, 04 Jul 2019 06:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GovB0KsV809AJW6tOWDxmHhyRG51oTvazg+HECC24X8=;
        b=vEPEzke0valyfsuQGRkaINfMgvEaL34LSMeazDtcXBSYIsCUjHGDkIqdV4AqVexD0i
         F/fHwh6MgjNiSgtDccaDE+5JLSt9ln98xz4GiS83kd3KE0njPccfsRa7fEUM2jJLkvFt
         p96cFAXbhspaBGyfBp8mKKOLQHx4uyo5AdFw3WwheZGg3LFIeXfH2zdactpZ0v6r4WNN
         8CsLtStxKemadRcE4jf8tBU4pnVXBb8VYSXRWtvtCYMB8RpnyQ4WpN28rNZqn8Bsd+AS
         Q+KWDdp6uiKbsmPTnEBBcvlkhi6bJKtLyVJ7GYMtsLTSwObZefpsnCsUsIpXUqHJxJdT
         GvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GovB0KsV809AJW6tOWDxmHhyRG51oTvazg+HECC24X8=;
        b=JY3H/Ia+x9xe8A8RINNbfCtKodoIaG2VgpKPsJxh5SEzcuW5DTCD4ZVX4OYgRWL8x+
         7+VQ/2c51iNkkkvuVEMoHJwbbkXgpzIKXuOXOUTMKIBbTZgZIGP+lLZfLiGet60d1Hys
         CKNZlkPvzl7kAvK8ObAKzgpecCSn5DVmWuBrLjDG+nyFcUeXQVnKY9CK9DrDt25++bEo
         GpO5RdkLGp7Wy5sFo3pXdww77LicNWG8KLx4RHMrq9c9wtodnHl/C/j40u6wy2QccxlW
         y8rPs9FQdOePEXKyGNXD7aPTLwVpKxb7fvJW4wJhiwvdyvbhMaUS51NB8u8vv4Fgt+T1
         3s/A==
X-Gm-Message-State: APjAAAX5DOOYuVCVPZoNoGsdy1m16M4lsRAU/vElIb9dlFrpdqc1kzE0
        nkReogaur8Q5WaPjBA4TXCvxM/zy
X-Google-Smtp-Source: APXvYqwJ2WjaNtVJPAJY+EIZRKqqbDSgCqxD35lCya0AJ5Yf6vXOpOTzZ3tP361M9YOHNH7dyQnfgQ==
X-Received: by 2002:a2e:5d46:: with SMTP id r67mr23597540ljb.187.1562245262585;
        Thu, 04 Jul 2019 06:01:02 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id h1sm485914lfj.21.2019.07.04.06.01.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Jul 2019 06:01:01 -0700 (PDT)
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
Subject: [PATCH v3 2/7] serial: imx: set_termios(): factor-out 'ucr2' initial value
Date:   Thu,  4 Jul 2019 16:00:24 +0300
Message-Id: <1562245229-709-3-git-send-email-sorganov@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1562245229-709-1-git-send-email-sorganov@gmail.com>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1562245229-709-1-git-send-email-sorganov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Set common bits in a separate statement to make initialization
explicit and not repeat the common part.

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 drivers/tty/serial/imx.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 1055124..87802fd 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1563,10 +1563,9 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	spin_lock_irqsave(&sport->port.lock, flags);
 
+	ucr2 = UCR2_SRST | UCR2_IRTS;
 	if ((termios->c_cflag & CSIZE) == CS8)
-		ucr2 = UCR2_WS | UCR2_SRST | UCR2_IRTS;
-	else
-		ucr2 = UCR2_SRST | UCR2_IRTS;
+		ucr2 |= UCR2_WS;
 
 	if (termios->c_cflag & CRTSCTS) {
 		if (sport->have_rtscts) {
-- 
2.10.0.1.g57b01a3

