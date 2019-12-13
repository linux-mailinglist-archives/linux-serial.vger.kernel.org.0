Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5CE11DA6A
	for <lists+linux-serial@lfdr.de>; Fri, 13 Dec 2019 01:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731275AbfLMAH1 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 12 Dec 2019 19:07:27 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:37168 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731160AbfLMAH1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Dec 2019 19:07:27 -0500
Received: by mail-pj1-f66.google.com with SMTP id ep17so344186pjb.4
        for <linux-serial@vger.kernel.org>; Thu, 12 Dec 2019 16:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6mNnjO8v1tpl9yqVUOmaWfH9cLoEm7aFdIH5BtFh2r4=;
        b=dgyveXe++pvbZzQRfBmAF/BV57WQgKW8tFS6uvjxmvo976OQWCi2hyt+Xte32scieT
         fDYObp4UGB+chOn+KLJ0V3caJWWZMV+4OUuk9iELuQHxkso4dEwadxwKIK27SZOY7JEv
         rOIDZhb3i4lGeATobG9gOF0HbRsMf67n1t0XAnXWUyKmK9dni9LrbMJUrTfBe/Pa8HAT
         qr9EeeafSMpWp11LvOPlgnBKi5xlBn19dQ/Y8qRyf6rxUZfQzjrPeKf5g13cbNqB6Y57
         5VxBUNfl4MMdR/wZwE7VQLsab5VacSajatAHncx5Cx9LWx+yROBw3gs8rN8bUc1xMmwz
         Zuqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6mNnjO8v1tpl9yqVUOmaWfH9cLoEm7aFdIH5BtFh2r4=;
        b=sUgG6sCOLoQGJ9h94hhji+6GIOEuXU1VIjMf6BFxk4AmKWUiGhL965onwyOEyZ51Rd
         uCD/XqWPQy4gDxiNOTIqBsagrwXF85CV3d4rAcUluJYjwikb3dKJWmXWyUBHojIa23Rd
         FhO1RRzCT4Zv0etTGzbx4VosMEYo0NWz5qHdrfb/UqMtOa8XGIs2u0IK4repJ7yC3inW
         MvUkUbQMVIChquZqHmQ2WN0W5aXwEF3MUGYnVtmWUnNOajZFtAauRTdRs/q9Ox1piAPg
         jrt2lBLE1q8idrxJgTtyXCk8yz74uUZwn6DYO1SND6w67zXfe2gxBu711qiVY/Nm6l0F
         S/uA==
X-Gm-Message-State: APjAAAXSaJR7jwEkANZzyTbNLM/iwpmOfZiA/VgpRSD6dTvlfkyoxda6
        ktxpz42YTjObSGwWiosbt1Zr1g==
X-Google-Smtp-Source: APXvYqy/yq33aCSkTVokTTb3YtsIWtq/9olFkGeixr9RtIQxE27PiPzHCSj/k0+5f3lTD5yC44fofw==
X-Received: by 2002:a17:90a:b010:: with SMTP id x16mr13564458pjq.130.1576195646097;
        Thu, 12 Dec 2019 16:07:26 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:07:25 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org, Andrew Jeffery <andrew@aj.id.au>,
        Joel Stanley <joel@jms.id.au>,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Subject: [PATCH 04/58] tty/serial: Migrate aspeed_vuart to use has_sysrq
Date:   Fri, 13 Dec 2019 00:06:03 +0000
Message-Id: <20191213000657.931618-5-dima@arista.com>
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

Cc: Andrew Jeffery <andrew@aj.id.au>
Cc: Joel Stanley <joel@jms.id.au>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-aspeed@lists.ozlabs.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/serial/8250/8250_aspeed_vuart.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
index 6e67fd89445a..d657aa14c3e4 100644
--- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
+++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
@@ -5,10 +5,6 @@
  *    Copyright (C) 2016 Jeremy Kerr <jk@ozlabs.org>, IBM Corp.
  *    Copyright (C) 2006 Arnd Bergmann <arnd@arndb.de>, IBM Corp.
  */
-#if defined(CONFIG_SERIAL_8250_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
@@ -406,6 +402,7 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
 	port.port.unthrottle = aspeed_vuart_unthrottle;
 	port.port.status = UPSTAT_SYNC_FIFO;
 	port.port.dev = &pdev->dev;
+	port.port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE);
 
 	rc = sysfs_create_group(&vuart->dev->kobj, &aspeed_vuart_attr_group);
 	if (rc < 0)
-- 
2.24.0

