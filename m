Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A407F11DAE9
	for <lists+linux-serial@lfdr.de>; Fri, 13 Dec 2019 01:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731710AbfLMALB (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 12 Dec 2019 19:11:01 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:37241 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731508AbfLMAIO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Dec 2019 19:08:14 -0500
Received: by mail-pj1-f66.google.com with SMTP id ep17so345854pjb.4
        for <linux-serial@vger.kernel.org>; Thu, 12 Dec 2019 16:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yRzUJUqTBi61FgnBxTRYOYQVNLiXFzlJgvmZ3LoxYGs=;
        b=Dpn+ZOU0VJ1jnmCCWPCi/cpydH77Rk9jQpBS8bdiYXyA5X8coGnaEAioo4sksukaBG
         x3+tHKUQWEPfpsMcgNlBLHRWhuHw7g7z0SSxRGnhoLbk9GPARFz+H2ZbepQmj+4ZimP/
         NhyovAMvEy7PzZl/Qzm0efHVhOC35advDRpTaZ5CUjqKREUHqJirfD4KXp6ebs6XhWgV
         8OcaI2qrGksloZnHn8U7csI4UJpm1d9gdKzQt0TRSeXe8HQVQlE/ca25zim1jE8Wacde
         lk8TBHWWYExjp6C1yV3slGlbf2fPUkoEb/jvWW+1nzroffysMOC5uYu/R7d1aASB3378
         Shrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yRzUJUqTBi61FgnBxTRYOYQVNLiXFzlJgvmZ3LoxYGs=;
        b=M/X9EDkU2wyEcaEg/pbvO+ME7o3C9y4DNgIsibGlMAjy/epeRCL+++aV4a3dxO8/o2
         m84WaiSZfQWUjN2ec9WRgXpBO6wbDIP0g027iwXi67AcWk549VmYpmlAttenozSj8D7s
         ucZ/xb/754LoyHzvMn8NN1uLmyWPQErppkbCFv+Squ+RMzW6YFWuZCx3cWHioEog/+Oo
         uHukiQUbJiomrb9Wbj9oX/9C+aJ7gH8PBBw58QB5LGY3F60XHqqNGnBgCoHArFTHM6Jx
         K3lCN8Uaj8oiXi7TRyZGbOimuYu/GQ88zi3YBOC9SIDNQ2BjDPw5MML9ea919hqsbM6w
         wmjw==
X-Gm-Message-State: APjAAAWSHNZ1K6tbkNXfZju+t3ljE9xBM40LGrOCIhXGjwEBd3M0KYsF
        U4za11fNVkPfmUAtISnQ1KNBYw==
X-Google-Smtp-Source: APXvYqydrnGvxnCreiqWq4Cu8QG9hWPQ0YlL+rT7Psz+HwhqPQ+hAc6pPfFavOQ/L+0ndjseZAjUBQ==
X-Received: by 2002:a17:902:bd0a:: with SMTP id p10mr5078883pls.65.1576195693231;
        Thu, 12 Dec 2019 16:08:13 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:08:12 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: [PATCH 20/58] tty/serial: Migrate ip22zilog to use has_sysrq
Date:   Fri, 13 Dec 2019 00:06:19 +0000
Message-Id: <20191213000657.931618-21-dima@arista.com>
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
 drivers/tty/serial/ip22zilog.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/ip22zilog.c b/drivers/tty/serial/ip22zilog.c
index 8c810733df3d..86fff69d7e7c 100644
--- a/drivers/tty/serial/ip22zilog.c
+++ b/drivers/tty/serial/ip22zilog.c
@@ -38,10 +38,6 @@
 #include <asm/sgi/hpc3.h>
 #include <asm/sgi/ip22.h>
 
-#if defined(CONFIG_SERIAL_IP22_ZILOG_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
 #include <linux/serial_core.h>
 
 #include "ip22zilog.h"
@@ -1080,6 +1076,7 @@ static struct uart_driver ip22zilog_reg = {
 
 static void __init ip22zilog_prepare(void)
 {
+	unsigned char sysrq_on = IS_ENABLED(CONFIG_SERIAL_IP22_ZILOG_CONSOLE);
 	struct uart_ip22zilog_port *up;
 	struct zilog_layout *rp;
 	int channel, chip;
@@ -1115,6 +1112,7 @@ static void __init ip22zilog_prepare(void)
 		up[(chip * 2) + 0].port.irq = zilog_irq;
 		up[(chip * 2) + 0].port.uartclk = ZS_CLOCK;
 		up[(chip * 2) + 0].port.fifosize = 1;
+		up[(chip * 2) + 0].port.has_sysrq = sysrq_on;
 		up[(chip * 2) + 0].port.ops = &ip22zilog_pops;
 		up[(chip * 2) + 0].port.type = PORT_IP22ZILOG;
 		up[(chip * 2) + 0].port.flags = 0;
@@ -1126,6 +1124,7 @@ static void __init ip22zilog_prepare(void)
 		up[(chip * 2) + 1].port.irq = zilog_irq;
 		up[(chip * 2) + 1].port.uartclk = ZS_CLOCK;
 		up[(chip * 2) + 1].port.fifosize = 1;
+		up[(chip * 2) + 1].port.has_sysrq = sysrq_on;
 		up[(chip * 2) + 1].port.ops = &ip22zilog_pops;
 		up[(chip * 2) + 1].port.type = PORT_IP22ZILOG;
 		up[(chip * 2) + 1].port.line = (chip * 2) + 1;
-- 
2.24.0

