Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 681A311DA8D
	for <lists+linux-serial@lfdr.de>; Fri, 13 Dec 2019 01:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731690AbfLMAI3 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 12 Dec 2019 19:08:29 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:42630 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731674AbfLMAI2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Dec 2019 19:08:28 -0500
Received: by mail-pj1-f67.google.com with SMTP id o11so335807pjp.9
        for <linux-serial@vger.kernel.org>; Thu, 12 Dec 2019 16:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wjRZfevODYHzxZeJEerM++U5kPyQ2TNReizqo4rhZwM=;
        b=M5sgU6/NwIb3XirwHpgQRnTGudiEyVael2ZmtUe5vDyrezJvnbQSGG4mZHYIJHR+n/
         o/+FzqVlrxnbt3QZTfGiPRqKKBcjW0AqsLrG1DfJqeLtmbUibc3P0Dd9cFoeXDBfcFF+
         tnVw0Qi4W0uwzqWJaWIO1MZxFijKHqj+fKXp3Gz2AuA6VMbb6ivIJTBHKy5bYGmCz3fB
         DMI9sb/Z6cdv8RQbi1OJZylZQtcs89lEU7ZQ0lbVDaDb+CQK4ZAWWxXMzPlex7pF8XlT
         DHXrHpfPAmwn9gSCBeccQ0VCzpiVwmM2A6enAGxBC+s/AUeslkiHEfQ3X5i6xxm10xqQ
         Jyeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wjRZfevODYHzxZeJEerM++U5kPyQ2TNReizqo4rhZwM=;
        b=Gbok2jXce0NR/JdgSw8kA3kGTF7DgA9FX4qFaCdCQGmmJn2paqDZuhYVCgGrziFmAv
         2Do8hlq6m0z/rEeN5D3vzWuHPiwsVKAo7bweIEu1kctcGQxa0/xHCeCDfTImLm+RlbBn
         76HQc2qMh8cGDfdZCbS8wBKdgg0gHSa8ZcVs3zBfvnvPGpKEG1uewsNcYY5aZoC15ibg
         1hHSCcobHLGb9dMuQisOkqm8FOIq0ICYyoNeJ/1OoLcyEgw+dKbxWcv4KGUk0D1Sutwb
         /CCknzv6eeijllRwZbd/kgn5gZMJ49h3nZ6wVv7CvXUsCxCipdowH0u+TiYix/TF3W3e
         JjJg==
X-Gm-Message-State: APjAAAW0wD++6tb65BM0YEDmxf08RolmlBitrh7jl3CFmiqIuKZZMtKB
        2Qdt19xIg10kZOYlIppGy66rHQ==
X-Google-Smtp-Source: APXvYqwOOwyv/lff+up03radtTwnn5tvkqRamJd4DuZq9Zp4UmzvPyH30ddOnKD+EpAGQZ0jV22pZA==
X-Received: by 2002:a17:902:8e84:: with SMTP id bg4mr12742595plb.138.1576195708252;
        Thu, 12 Dec 2019 16:08:28 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:08:27 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 25/58] tty/serial: Migrate msm_serial to use has_sysrq
Date:   Fri, 13 Dec 2019 00:06:24 +0000
Message-Id: <20191213000657.931618-26-dima@arista.com>
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

Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/serial/msm_serial.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index 1cbae0768b1f..375d6d3f17b2 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -7,10 +7,6 @@
  * Copyright (c) 2011, Code Aurora Forum. All rights reserved.
  */
 
-#if defined(CONFIG_SERIAL_MSM_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-# define SUPPORT_SYSRQ
-#endif
-
 #include <linux/kernel.h>
 #include <linux/atomic.h>
 #include <linux/dma-mapping.h>
@@ -1801,6 +1797,7 @@ static int msm_serial_probe(struct platform_device *pdev)
 	if (unlikely(irq < 0))
 		return -ENXIO;
 	port->irq = irq;
+	port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_MSM_CONSOLE);
 
 	platform_set_drvdata(pdev, port);
 
-- 
2.24.0

