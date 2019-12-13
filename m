Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8F8311DA90
	for <lists+linux-serial@lfdr.de>; Fri, 13 Dec 2019 01:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731707AbfLMAIg (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 12 Dec 2019 19:08:36 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36924 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731702AbfLMAIf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Dec 2019 19:08:35 -0500
Received: by mail-pf1-f194.google.com with SMTP id p14so394526pfn.4
        for <linux-serial@vger.kernel.org>; Thu, 12 Dec 2019 16:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JPHcF1Ac92GQc/SsDP7K+Yij8n5Op4P4c8xwvHBjRY0=;
        b=Fv4cQwiBepW2yfuVGe2bIGqgW8ota1ovR0Oqsbc4sPC1d1OUjKvZ6vQ1b4a/simvRZ
         hkt4QOw7eTenbSMFVj0LK6GV8yxReJromH9baY2pKzNpgT++N5JSrcQVJDe15ur6qMTK
         9aX4+KJQ5J3uFZQPd9WZgF0qk80Oa7uLkWC3MVX1R3A13K01fiCyDuP4hhWHh/TKLc1q
         +KjX4QkipD5ktT3q7JwEvS9TWquf/p9mTa6BPOsC//gM9+Nww7x0Zoo6pDayI7ACHyix
         wenEXpUU+010mB06MpA8ofbbIn25EJifvYxxvyKkWeZSh6sd3IQq2btODsElDw4xyqEq
         iSbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JPHcF1Ac92GQc/SsDP7K+Yij8n5Op4P4c8xwvHBjRY0=;
        b=UDNWEnnGZBzxfjpY5uX/3NKkRXeNo0k7YBsOl8JqocHnXrhL8M+NFP1KswxpCvbKvF
         Ya//X/D4pcdW6LlZ+ZXhpRvpx+x5vCtYJbdAARDJZRke/87EEguME0ACu9nl/291MLpq
         6DvfP3IHOUMjD3Ax1EtFuwSJxjkNTNJZBA957giTsdfZtaLTxmusa5zDoY6E70f/HXTO
         F778MPIgHZ5UXMeiIUIzbH6QDacKmMSEbq8VjrdexSBADWZTajla2JulmQIVoIXDQ1n9
         zkS9q2TKRCIc28KqnrSpgL5Xz/xOZHxzOUXqtDnCOhLCHihFhswSR6dJhqYu/DdjdI/S
         rcGA==
X-Gm-Message-State: APjAAAUuJwomrmDXUVdPXm6DXx67HovY39awPMD5ERZsKzNtrxPP1fC9
        iPbHw1k3IhsvcnMHCCbIyaSn1Q==
X-Google-Smtp-Source: APXvYqyqFKCBWTIp8TYm3kDEts6GcpTPEPycbAbyvkwK3IpCwgEnNSAd2DdwsYCBcerQjSs5m25png==
X-Received: by 2002:a62:b60c:: with SMTP id j12mr13123896pff.8.1576195714876;
        Thu, 12 Dec 2019 16:08:34 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:08:33 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 27/58] tty/serial: Migrate mxs-auart to use has_sysrq
Date:   Fri, 13 Dec 2019 00:06:26 +0000
Message-Id: <20191213000657.931618-28-dima@arista.com>
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

Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/serial/mxs-auart.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index e34525970682..b4f835e7de23 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -12,10 +12,6 @@
  * Copyright 2008 Embedded Alley Solutions, Inc All Rights Reserved.
  */
 
-#if defined(CONFIG_SERIAL_MXS_AUART_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/init.h>
@@ -1693,6 +1689,7 @@ static int mxs_auart_probe(struct platform_device *pdev)
 	s->port.fifosize = MXS_AUART_FIFO_SIZE;
 	s->port.uartclk = clk_get_rate(s->clk);
 	s->port.type = PORT_IMX;
+	s->port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_MXS_AUART_CONSOLE);
 
 	mxs_init_regs(s);
 
-- 
2.24.0

