Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7811845C47
	for <lists+linux-serial@lfdr.de>; Fri, 14 Jun 2019 14:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfFNMLy (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 14 Jun 2019 08:11:54 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35115 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbfFNMLy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Jun 2019 08:11:54 -0400
Received: by mail-lj1-f193.google.com with SMTP id x25so2186242ljh.2
        for <linux-serial@vger.kernel.org>; Fri, 14 Jun 2019 05:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D4v0SFR2nHGdYcEZZKZiUTxqoD86zDefhBuvLG6SwpU=;
        b=AhAtzRZR1iNbZtwwefyYQrhCxFjjjj3jcAtizT8hokoo5h70+FSnAE5y+zYDk1LWi4
         NIgeJuyCHNbZ3Yt2eG0yOW3R6bUBLTGn3h7qfGUP27zs6pEW/8A4aMnI/Wi68hjjYCU0
         HCWaq/sL2tY9m9vkgWU13HhB3shFp0FG6wmP91kkFY7W1y+kHkDU1+hbgRyBbNwFxztk
         GbVCABEY/OuCjip8EbMCR5xMi8BRHM2MeL6SqY9tEdxuAmXdw122za1xBMdNAacvx1DI
         jyh6DeZ/9VvOqVFBVa/q7K22U4KXBIDa7TIICQz0P2B3ZDXOE+7Dk2ZnXvhSNlw2l3Fu
         hIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D4v0SFR2nHGdYcEZZKZiUTxqoD86zDefhBuvLG6SwpU=;
        b=h1g9olU9oelyhTTBFsXyVxmQIqRPfnbtfNOSpU+IXs5kCZn6aSCmupeL7gBIyoQO7z
         kAN88OmVQs20V0WD9h2FxIx9Dc5l5odetrBvgOgPnLm0u5dpUQDDkl2SNKPMOqO9rVsz
         ta2upVPZJXTYcb5aHTiMlzXAqhFynqRPYY8RRBg7wht8D9tL3pcKlZXswUVvVhG9KKdr
         K1uxXRk2AhNAqIBPS0XFbdB5c9LSU4l24RuZ2HATqwDyTy0hwFTN5oUe76fhqJnA10iQ
         dIDAgNa36JNTS9mrjTl6RdfNuCeD1ww5hKuVfWdsZmJb0UqRVdFOP/Nz9AUBQ1Ugxx/U
         XVww==
X-Gm-Message-State: APjAAAVg9qtyIVu320rfn0t6BssMqESfrFy9UxNtEbqwPsYIebhKX263
        6sHCRBELVfgb/8/Xy0rvfGI=
X-Google-Smtp-Source: APXvYqwwguL28sV6oiZAQwrOvk7Z9RiemYNUnbx+FhUEesYHx8o0fOJn3igjqb2ZoreP6P9ZiZmGHA==
X-Received: by 2002:a2e:824c:: with SMTP id j12mr42933549ljh.53.1560514312926;
        Fri, 14 Jun 2019 05:11:52 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id p27sm459683lfh.8.2019.06.14.05.11.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Jun 2019 05:11:52 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH RFC 2/7] serial: imx: set_termios(): factor-out 'ucr2' initial value
Date:   Fri, 14 Jun 2019 15:11:29 +0300
Message-Id: <1560514294-29111-3-git-send-email-sorganov@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1560514294-29111-1-git-send-email-sorganov@gmail.com>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1560514294-29111-1-git-send-email-sorganov@gmail.com>
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

