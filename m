Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50B5F4D0B1
	for <lists+linux-serial@lfdr.de>; Thu, 20 Jun 2019 16:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfFTOsL (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 20 Jun 2019 10:48:11 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34934 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfFTOsK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 20 Jun 2019 10:48:10 -0400
Received: by mail-lj1-f194.google.com with SMTP id x25so2991794ljh.2
        for <linux-serial@vger.kernel.org>; Thu, 20 Jun 2019 07:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D4v0SFR2nHGdYcEZZKZiUTxqoD86zDefhBuvLG6SwpU=;
        b=DUoQH5nzAMQkwMgDK92LnSpcbYkdUejrkX56/rNFbK//1UyTzgqlZZFF4DshEJOCmv
         GBGf+9R9bZmt7SuPgQoCuh4epT0TSA267X+Y8C3Xz3P7Xt6PjtqesEBydf2QHv55oxna
         824UwQN/3woBSubU7mBH4Z24yCD9/EFcycJBTUFj+wrbtfKauxbmqgY4TU6U2zTVoKsa
         V5Yc+3dDUclTIkoTGudTdZTU9OqIU+svFs6JEIWZnY6f4zvu4ze092StynGqssiILxqJ
         TbqjLLEvT5CgmFkn1oWwMXOkK90nKDWPDUw/XCUuIQO7xGQC2gi6Ae9sVpVD/v9NglzA
         UchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D4v0SFR2nHGdYcEZZKZiUTxqoD86zDefhBuvLG6SwpU=;
        b=lwwoQZkPT3jNREH5iWLxv/QYQNHELFDSh4HNvGZjDcCu7xXS+q48v4L3yQhDVoo3o+
         rM2b32oWgDwkRQQyZrVfoGCazZ8qRkGnDKWdOEJPk+vzSGuuhs7zAqCXAM12Mw7pdywl
         UBAZVS3LvLualZO/kCKfOXbZlnyT02/cLvTu9d8Q6lJTYC9AIRALvaJxoiitObBG4HGq
         1BPp+JnWJ5g/NODrfedpnb/5D5Qsax2eQoxS337G2axS6aWdp9ikaxRUo/PdmR4L7dX4
         dXI4fgPTZSS0tk6RTQJ8AZ2D4QjX82DqFazsCH3Ei6B/lJRY3cNVWE7hY9jTl3k7ga8s
         nhFA==
X-Gm-Message-State: APjAAAW9EwqFlKomgXeWtYqjs78Ueo3cDCQv5/o2dVgoCTovLJHlHy2h
        157OxwU9T4hZMEeRBgvE7N8=
X-Google-Smtp-Source: APXvYqx3FATvUJqLsAjONbNQN8PduHBc6uhH3sMNqzf2nFuoCLFoZo2UvsSlmbNL+Io14cpICWaaZA==
X-Received: by 2002:a2e:5548:: with SMTP id j69mr23778346ljb.48.1561042088818;
        Thu, 20 Jun 2019 07:48:08 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id f10sm3577768ljk.95.2019.06.20.07.48.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Jun 2019 07:48:08 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH RFC v1 2/7] serial: imx: set_termios(): factor-out 'ucr2' initial value
Date:   Thu, 20 Jun 2019 17:47:48 +0300
Message-Id: <1561042073-617-3-git-send-email-sorganov@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1561042073-617-1-git-send-email-sorganov@gmail.com>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1561042073-617-1-git-send-email-sorganov@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Set common bits in a separate statement to make initialization
explicit and not repeat the common part.

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

