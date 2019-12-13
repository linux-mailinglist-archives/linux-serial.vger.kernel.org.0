Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE6911DA9D
	for <lists+linux-serial@lfdr.de>; Fri, 13 Dec 2019 01:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731381AbfLMAI4 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 12 Dec 2019 19:08:56 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45583 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731752AbfLMAIz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Dec 2019 19:08:55 -0500
Received: by mail-pl1-f193.google.com with SMTP id bc8so373933plb.12
        for <linux-serial@vger.kernel.org>; Thu, 12 Dec 2019 16:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YJ/K67n2T5JKCf35S1BcGc2M+5ycQJ72kMRDMo/lBe4=;
        b=NX0gv+nVHqjcOgV/2F+Ya/vhafp0KyetvAVn6TzCw7SMvq0/u4RLiLESz4QUOmHh3A
         EVmV2RNWYSowwhMlisVrMGgBp28oC5Z/xp1GfeA3KD3PrL10tmSk0PYSsYbVSYtc8+Hq
         TIZ8mCLritKRQOgi35ODpufNBlOjZcPiCBmn2z1juJZdlrO/hTM9rXpJapf7KTLz6kJq
         KlLi36WcjYreAqRWg3RKp1geiDE2EvIWuif8gb64BEjWQEICvNfRYhvQYTHpkokEj3Kw
         4z6H0GJey83qOqMeRLbOpy2/zfgVzinlaLJnHbm29q9lfr6ZAfk2uUC+h1EFABhzwt4O
         gNQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YJ/K67n2T5JKCf35S1BcGc2M+5ycQJ72kMRDMo/lBe4=;
        b=UcPxU3E4uu8cMu+W4Sq+vIq2K6ETutllzMtxayzb73/Z0ubosDYjieZIGbf5iD540D
         N/JLA6iUjPgWLrhTdoyLz0TioGrbP8GqMMaFMR9ACOLHO/u1NOFqxjYIV7MFPbIW0Tnn
         0NYvRuCbIaDhb+qPndTqMG3ACLL59NrqrTCLp2x7jLfN5Ciif8l86aLMjYIGhQfSg0TC
         0pae0nsPB8fIoZ8S5rK/e4Fd7DSRIdM/KUIb9+LicFIwbugjnNC9evo2fgocaMtn9T6w
         vS8kLvcbxf9CqPzt0ZE69Cr2wbReMcJNtsGXFtzvycckS7UO297zvpu+b5wXqhKxSh2l
         7ZRw==
X-Gm-Message-State: APjAAAUeLESw0c9bP4+dSHYgRHQNe4LYwZ53eQKgenwRsGL0Q3XdzQ7r
        omSKumTd6LiiT0v0RsgMfC4dRQ==
X-Google-Smtp-Source: APXvYqxBiIWzDGmJW2EGWJGBn1iFjkHGX2XegbsBDBpEz+UVnAGvV4Tdgr4/zKm03jglZxdYW08fOg==
X-Received: by 2002:a17:902:bd0a:: with SMTP id p10mr5081948pls.65.1576195734438;
        Thu, 12 Dec 2019 16:08:54 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:08:53 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: [PATCH 34/58] tty/serial: Migrate pxa to use has_sysrq
Date:   Fri, 13 Dec 2019 00:06:33 +0000
Message-Id: <20191213000657.931618-35-dima@arista.com>
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
 drivers/tty/serial/pxa.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index 4932b674f7ef..41319ef96fa6 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -19,10 +19,6 @@
  */
 
 
-#if defined(CONFIG_SERIAL_PXA_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
 #include <linux/ioport.h>
 #include <linux/init.h>
 #include <linux/console.h>
@@ -879,6 +875,7 @@ static int serial_pxa_probe(struct platform_device *dev)
 	sport->port.dev = &dev->dev;
 	sport->port.flags = UPF_IOREMAP | UPF_BOOT_AUTOCONF;
 	sport->port.uartclk = clk_get_rate(sport->clk);
+	sport->port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_PXA_CONSOLE);
 
 	ret = serial_pxa_probe_dt(dev, sport);
 	if (ret > 0)
-- 
2.24.0

