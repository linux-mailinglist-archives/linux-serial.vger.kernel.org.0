Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC28F35C9A
	for <lists+linux-serial@lfdr.de>; Wed,  5 Jun 2019 14:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbfFEMWr (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 5 Jun 2019 08:22:47 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38585 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbfFEMWr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 Jun 2019 08:22:47 -0400
Received: by mail-pf1-f193.google.com with SMTP id a186so14034971pfa.5;
        Wed, 05 Jun 2019 05:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3GAMKG2bkSkOspilJvNkC+5w7eNdhVRmLQMCFlqm2lc=;
        b=au49flYFDpWpe1BM6oyUDx/hlReF8ml02Eius+8cHz1UMaWs9aOlK52QXKER3c/ivX
         WDfu4ZjGLO1XaCnfgbn0l6n73icde4Os53KV4ZT4cCOo4BxYua2F5MRWjJApvQqBI7Vy
         tT1byoFOU41Z82RzHu+pSnA0gQKM8IAvGG+mU+4IuVgcfDyGfrrUOSV0ieY59jywqVKi
         rZk5z/u4gxOw6ev5ph26Ev85n5fdBYhW649e+wtwYxBZ6VVYcuIzLdKYC/P1xOn6AFa3
         zPIUM2lj51kO3wQDg6cCfNwoZRmBiCLIS1ofYPaVhZP/lbJ7I12RDY4dOkSlyV8mLYgr
         OFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3GAMKG2bkSkOspilJvNkC+5w7eNdhVRmLQMCFlqm2lc=;
        b=XTL1R2mapUXctd1D6mCmyRJ3eLMpz0hruIWR+nwrXwaKletIPsRvNEpQp1nZ8PUHOS
         5irHcniVUoZ+klBiNYwDw1isaK7NSlv6pUci19dKwebMQuSyL6ABi2MsQRsiDEdMCpjl
         WDwl2kCLWJbJDj/8H0H5troW0D34BDpmlR8tJm/Po9oh9N0EFdnd4It8ywa1PnD37KqN
         LHqlO6eLCVNVuMtxdBditcKLQ+lsqt4PHM4p+B2fS6sasR2QxxeBIsvQqPNXHkPN80j6
         QVHoIF7OTRiML6t2g6dWH3A3Kmyk6lHzep0p6Pb1715/uW6q1E51D3oVxTfauVxwxHdt
         2P4A==
X-Gm-Message-State: APjAAAXjFwZTYj51WdHq4u9CkHFKoibtdZMj1qHuB3P+1KzLZc+SbXaS
        gUKv9msQ1tJ8ey50cmAENdo=
X-Google-Smtp-Source: APXvYqxppjG9m8JUHMI008hu8C6MlDpFXdE6HrHO3yMyYnkRlIDngOMKrYTo8DJhUuRFY87+dC/x1w==
X-Received: by 2002:a62:ed0a:: with SMTP id u10mr14088279pfh.243.1559737366426;
        Wed, 05 Jun 2019 05:22:46 -0700 (PDT)
Received: from Pilot130.192.168.0.22 (211-20-114-70.HINET-IP.hinet.net. [211.20.114.70])
        by smtp.googlemail.com with ESMTPSA id q22sm3322094pff.63.2019.06.05.05.22.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Jun 2019 05:22:46 -0700 (PDT)
From:   "sudheer.v" <open.sudheer@gmail.com>
To:     gregkh@linuxfoundation.org, mchehab+samsung@kernel.org,
        jslaby@suse.com, joel@jms.id.au, andrew@aj.id.au,
        benh@kernel.crashing.org, robh+dt@kernel.org, mark.rutland@arm.com,
        shivahshankar.shankarnarayanrao@aspeedtech.com,
        sudheer.veliseti@aspeedtech.com
Cc:     sudheer Kumar veliseti <sudheer.open@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org
Subject: [patch 4/5] defconfig and MAINTAINERS updated for AST2500 DMA UART driver
Date:   Wed,  5 Jun 2019 17:53:14 +0530
Message-Id: <1559737395-28542-5-git-send-email-open.sudheer@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1559737395-28542-1-git-send-email-open.sudheer@gmail.com>
References: <1559737395-28542-1-git-send-email-open.sudheer@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: sudheer Kumar veliseti <sudheer.open@gmail.com>

Signed-off-by: sudheer veliseti <sudheer.open@gmail.com>
---
 MAINTAINERS                          | 13 +++++++++++++
 arch/arm/configs/aspeed_g5_defconfig |  1 +
 2 files changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 997e27ab492f..c9a9790b97f6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1347,6 +1347,19 @@ F:	drivers/crypto/axis
 F:	drivers/pinctrl/pinctrl-artpec*
 F:	Documentation/devicetree/bindings/pinctrl/axis,artpec6-pinctrl.txt
 
+ARM/ASPEED DMA UART DRIVER
+M:	sudheer v <sudheer.open@gmail.com>
+M:	ShivahShankar <shivahshankar.shankarnarayanrao@aspeedtech.com>
+R:	Joel Stanley <joel@jms.id.au>
+R:	Andrew Jeffery <andrew@aj.id.au>
+R:	Vinod Koul <vkoul@kernel.org>
+L:	dmaengine@vger.kernel.org
+L:	openbmc@lists.ozlabs.org
+L:	linux-aspeed@lists.ozlabs.org
+S:	Maintained
+F:	drivers/tty/serial/8250/8250_aspeed_uart_dma.c
+F:	Documentation/devicetree/bindings/serial/ast-sdma-uart.txt
+
 ARM/ASPEED I2C DRIVER
 M:	Brendan Higgins <brendanhiggins@google.com>
 R:	Benjamin Herrenschmidt <benh@kernel.crashing.org>
diff --git a/arch/arm/configs/aspeed_g5_defconfig b/arch/arm/configs/aspeed_g5_defconfig
index 1849cbc161b4..25bf26630939 100644
--- a/arch/arm/configs/aspeed_g5_defconfig
+++ b/arch/arm/configs/aspeed_g5_defconfig
@@ -144,6 +144,7 @@ CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_NR_UARTS=6
 CONFIG_SERIAL_8250_RUNTIME_UARTS=6
+CONFIG_AST_SERIAL_DMA_UART=y
 CONFIG_SERIAL_8250_EXTENDED=y
 CONFIG_SERIAL_8250_ASPEED_VUART=y
 CONFIG_SERIAL_8250_SHARE_IRQ=y
-- 
2.17.1

