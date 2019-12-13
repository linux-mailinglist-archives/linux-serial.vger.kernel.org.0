Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0352A11DAE8
	for <lists+linux-serial@lfdr.de>; Fri, 13 Dec 2019 01:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731670AbfLMAK7 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 12 Dec 2019 19:10:59 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46268 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731648AbfLMAIU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Dec 2019 19:08:20 -0500
Received: by mail-pg1-f195.google.com with SMTP id z124so508854pgb.13
        for <linux-serial@vger.kernel.org>; Thu, 12 Dec 2019 16:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eIG2+4JbwVOuLRSDX8JZZBINCAprxXq9FQQrJM6v5lY=;
        b=i7uxmhA2rgEx5xz5lwkNok1PJSSUXiIGLw2LYAurwbY25ER+4Kn2iIb8xZJpupl8eS
         GMFaqOnsR9Xk0kkTXTORWl3OApnz1zkV1b/5Mri63yr4/t8LAS1GyUvkfTEE6tefzRCj
         rX4xYsqGGQSy4VgL1nBXyIQBhvqGppe6wqJHq3vHjYNphpNhgVFXvCh6XQ1dNo5+qVfu
         OB00i/RNOVpg8mpuej5sR0lEhGxiZNujzNOZKOoPlfNGQtBeD+//SlBunakQJ4wnMZfw
         s8vtkYZgemCVG5uJwv8zCQqzgKCtPJMxAtXm8aaPngpieBNmwV9Fz3WlZ9yiuy5P33SE
         e+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eIG2+4JbwVOuLRSDX8JZZBINCAprxXq9FQQrJM6v5lY=;
        b=jLceYrSF8fdvNFaT7jKb7JksCdjwlj09QMGuPByYb8q+wNpzlNrLZMfqrfQpkw7D7G
         Ns8SnROkaN/itmeR791bHF+f/ugv6OUcjysVD7FzuBJhbXcd1xFDoFuGdMtd33ZdKHeO
         2axlThHcVFNVVzD6fjRh2NjJu+IIOxsB6sfYv41Q74DKNDjVw32eWoqGQtwxZ6Gd0/2K
         g2Cjzkuqw9n2wWJli2z7s62fuIYMeh2lgaOrYP0/Xu5uIuNo6eTc7xjDXZgEz4nrVjVu
         IPbdFLwXv9FINDdnPDz1NFPq/V6jAW7kgbt7Ptu+yQvHd360LzfnCiZw8LfMNfCrM3+2
         aJgw==
X-Gm-Message-State: APjAAAX9pID2qwi51KAiWlKNNzT5IwFJ9LsHzX2xfSiJGeLmH0JA3w23
        DWIgu5tv6WBfGQK0ecefdz+jQA==
X-Google-Smtp-Source: APXvYqw5ht+uJN4C/OeK2k0lFtlvIG3dJAym/DzMXBsu1g2/2ovtqrVHmV9EmTuPxecmvGJGcMfDqA==
X-Received: by 2002:a62:53c3:: with SMTP id h186mr5433700pfb.118.1576195699313;
        Thu, 12 Dec 2019 16:08:19 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:08:18 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: [PATCH 22/58] tty/serial: Migrate milbeaut_usio to use has_sysrq
Date:   Fri, 13 Dec 2019 00:06:21 +0000
Message-Id: <20191213000657.931618-23-dima@arista.com>
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
 drivers/tty/serial/milbeaut_usio.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/milbeaut_usio.c b/drivers/tty/serial/milbeaut_usio.c
index 949ab7efc4fc..8f2cab7f66ad 100644
--- a/drivers/tty/serial/milbeaut_usio.c
+++ b/drivers/tty/serial/milbeaut_usio.c
@@ -3,10 +3,6 @@
  * Copyright (C) 2018 Socionext Inc.
  */
 
-#if defined(CONFIG_SERIAL_MILBEAUT_USIO_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
 #include <linux/clk.h>
 #include <linux/console.h>
 #include <linux/module.h>
@@ -537,6 +533,7 @@ static int mlb_usio_probe(struct platform_device *pdev)
 	port->irq = mlb_usio_irq[index][RX];
 	port->uartclk = clk_get_rate(clk);
 	port->fifosize = 128;
+	port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_MILBEAUT_USIO_CONSOLE);
 	port->iotype = UPIO_MEM32;
 	port->flags = UPF_BOOT_AUTOCONF | UPF_SPD_VHI;
 	port->line = index;
-- 
2.24.0

