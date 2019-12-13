Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54B0711DAA7
	for <lists+linux-serial@lfdr.de>; Fri, 13 Dec 2019 01:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731815AbfLMAJP (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 12 Dec 2019 19:09:15 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32822 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731533AbfLMAJP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Dec 2019 19:09:15 -0500
Received: by mail-pg1-f193.google.com with SMTP id 6so591992pgk.0
        for <linux-serial@vger.kernel.org>; Thu, 12 Dec 2019 16:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t1uh3W06H9NP6XRp/n5KbLShieglkDi9487fZao2G2I=;
        b=H3/YmJffs8b3odMUqGlaEHM/jpcFGNzkEIhF7RKU302EkPXx0fPYpHuucOhQ/ibExP
         2vKkbtYutHWFVm2bXcm4x+sVdR2t5/sMnamGFN80o2OOYTyyyMV53Xz0naldgP5B1h5I
         I87xgSECVlUeX0ddvHAysUD0NXjEZmVbE+9wS+wjhKD9171c4UoenqIesRzThyvNHMbA
         ELPgTHntR/qxU4qmeJmrmJy/ZvyW4xgMyPtuFMoQKd34cfDioXFTllJh/9VZo/bDIvbK
         +OJQ/FHrr/0DMz1KHMmRvOWaHoKpJvIaxXgV/pRiU7NudRHITAivFx5c46dsH1qyaVtN
         jHvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t1uh3W06H9NP6XRp/n5KbLShieglkDi9487fZao2G2I=;
        b=A82gDNB2PGslGUG1dH4VGrGAZWjCy+WqsWzhYUKSN+wSaScuCUV55WlH3MPvusaUg5
         7b7mdaWVuU63plpr5lQKIWveFR9xpZ4J5xargWtRdYyEKqv2m97DRjtZ5GCUvNcMU2nt
         A8jOy7VX5W9S2BhL4tEjof6nH0NOa2ueTz0WQCIJkO4/2A9E1zFzr0PuRB7jrBVqfpWA
         jlqoZGoAkmcr5IUFnEwATmr9yDNKqeeVVx5kK6JaG0f3qSSEM4lqqIJZbzchH3Q2WwN9
         rPJUAhlBjAJWMuyM0H/hP+lqFkCmTaJhCZe2ON9nn3GyYKx8LNDSnZNv9z/Ugdi7H1r1
         lpMA==
X-Gm-Message-State: APjAAAVvzyvNx6rQP0g7ON0GkGZqYDKJ8FalWx7M0D7Jai20k74yNeAQ
        Rn54WyHc0W0WFaeKJnLcbm+7iA==
X-Google-Smtp-Source: APXvYqwEf0zBe1s8PsjO3BBPeIQoHuwqLNAJvF3Y8o6KuSfl69SR2eKVcYqSPHKxGzLz1fZix5rWvA==
X-Received: by 2002:a63:696:: with SMTP id 144mr14278642pgg.260.1576195754663;
        Thu, 12 Dec 2019 16:09:14 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:09:13 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: [PATCH 41/58] tty/serial: Migrate sh-sci to use has_sysrq
Date:   Fri, 13 Dec 2019 00:06:40 +0000
Message-Id: <20191213000657.931618-42-dima@arista.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191213000657.931618-1-dima@arista.com>
References: <20191213000657.931618-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The SUPPORT_SYSRQ ifdeffery is not nice as:
- May create misunderstanding about sizeof(struct uart_port) between
  different objects
- Prevents moving functions from serial_core.h
- Reduces readability (well, it's ifdeffery - it's hard to follow)

In order to remove SUPPORT_SYSRQ, has_sysrq variable has been added.
Initialise it in driver's probe and remove ifdeffery.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/serial/sh-sci.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 58bf9d496ba5..9b4ff872e297 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -15,10 +15,6 @@
  *   Modified to support SH7300 SCIF. Takashi Kusuda (Jun 2003).
  *   Removed SH7300 support (Jul 2007).
  */
-#if defined(CONFIG_SERIAL_SH_SCI_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
 #undef DEBUG
 
 #include <linux/clk.h>
@@ -2887,6 +2883,7 @@ static int sci_init_single(struct platform_device *dev,
 	port->ops	= &sci_uart_ops;
 	port->iotype	= UPIO_MEM;
 	port->line	= index;
+	port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_SH_SCI_CONSOLE);
 
 	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
 	if (res == NULL)
@@ -3015,12 +3012,9 @@ static void serial_console_write(struct console *co, const char *s,
 	unsigned long flags;
 	int locked = 1;
 
-#if defined(SUPPORT_SYSRQ)
 	if (port->sysrq)
 		locked = 0;
-	else
-#endif
-	if (oops_in_progress)
+	else if (oops_in_progress)
 		locked = spin_trylock_irqsave(&port->lock, flags);
 	else
 		spin_lock_irqsave(&port->lock, flags);
-- 
2.24.0

