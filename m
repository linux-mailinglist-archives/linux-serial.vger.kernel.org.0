Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 756A4EC2FD
	for <lists+linux-serial@lfdr.de>; Fri,  1 Nov 2019 13:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730880AbfKAMnR (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 1 Nov 2019 08:43:17 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34708 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730814AbfKAMm5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 1 Nov 2019 08:42:57 -0400
Received: by mail-lj1-f196.google.com with SMTP id 139so10156970ljf.1
        for <linux-serial@vger.kernel.org>; Fri, 01 Nov 2019 05:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D4oV4L5jtcWTxjf1oA8VyXP7dsMMZPn/dF9MUNC7L/c=;
        b=ChWgoM+RZleyCLooBGG2A1JvdWWg6KMP8RrMTmsVo3TAQDAVvhTW+C5mRqEot+jHi/
         SpxZ2ZUc39mTWbzjkLRZGYunWjGAYS6JuGkoqFkg0FqFDlarhRUUYfgczq8HLtQp+2NR
         tk0eB+HTSnnLKRnKAxtdhZqDz3PFucHnDy6rI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D4oV4L5jtcWTxjf1oA8VyXP7dsMMZPn/dF9MUNC7L/c=;
        b=Wnp4TEMcy8yRKY6KydfDnK/R9IDWaoSiZenMyJn/wvL3Nz26ntgOafdv65wK/uC0Zw
         biAP9VpYqtS/+nIejGlCmQrVPhqFLTbx6EEm8cyZv2fy7dqr1CLnWUP/SsKunH6QD05W
         HpoFIAI2tDcpfc5WBVva+7U0toJ4na2RCe98bWZ2tZT7g2zxv3+RdxUDE+AnlROTz25A
         jHS+PJoyB/UPpBmpZ9ZXscfBJ9NvZ4WISmi+a+vaJANY6ngWOF0lfUB8gtYEytwbGeic
         nFyXtA1YES1bkZBqGX49TFdyX3Ll/Gk8s8iOy+UK8/CLqNeUrYAmHgwQlJzRkmJIdfrI
         qcuA==
X-Gm-Message-State: APjAAAWxD1dayx+vEO5BoAFN4cjpu6fIahU5kf2uIeeJsQe+fUYEwoYO
        CLcp5h0m09GWaMRAx67X9ZZqGvb5YLZul8Mt
X-Google-Smtp-Source: APXvYqxVbSqp5kPPNVKutOzvam5gITHLA7sjIHP3EZEUUIO07QhZSO60B4aKNJx9iWIs4WaLlt4NVw==
X-Received: by 2002:a2e:96cb:: with SMTP id d11mr1392868ljj.82.1572612174201;
        Fri, 01 Nov 2019 05:42:54 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id o26sm2458540lfi.57.2019.11.01.05.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 05:42:53 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-serial@vger.kernel.org
Subject: [PATCH v3 32/36] serial: ucc_uart: use of_property_read_u32() in ucc_uart_probe()
Date:   Fri,  1 Nov 2019 13:42:06 +0100
Message-Id: <20191101124210.14510-33-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191101124210.14510-1-linux@rasmusvillemoes.dk>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <20191101124210.14510-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

For this to work correctly on little-endian hosts, don't access the
device-tree properties directly in native endianness, but use the
of_property_read_u32() helper.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/tty/serial/ucc_uart.c | 41 +++++++++++++++--------------------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index 313697842e24..f5ea84928a3b 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -1256,10 +1256,10 @@ static int soft_uart_init(struct platform_device *ofdev)
 static int ucc_uart_probe(struct platform_device *ofdev)
 {
 	struct device_node *np = ofdev->dev.of_node;
-	const unsigned int *iprop;      /* Integer OF properties */
 	const char *sprop;      /* String OF properties */
 	struct uart_qe_port *qe_port = NULL;
 	struct resource res;
+	u32 val;
 	int ret;
 
 	/*
@@ -1290,23 +1290,19 @@ static int ucc_uart_probe(struct platform_device *ofdev)
 
 	/* Get the UCC number (device ID) */
 	/* UCCs are numbered 1-7 */
-	iprop = of_get_property(np, "cell-index", NULL);
-	if (!iprop) {
-		iprop = of_get_property(np, "device-id", NULL);
-		if (!iprop) {
-			dev_err(&ofdev->dev, "UCC is unspecified in "
-				"device tree\n");
-			ret = -EINVAL;
-			goto out_free;
-		}
+	if (of_property_read_u32(np, "cell-index", &val) &&
+	    of_property_read_u32(np, "device-id", &val)) {
+		dev_err(&ofdev->dev, "UCC is unspecified in device tree\n");
+		ret = -EINVAL;
+		goto out_free;
 	}
 
-	if ((*iprop < 1) || (*iprop > UCC_MAX_NUM)) {
-		dev_err(&ofdev->dev, "no support for UCC%u\n", *iprop);
+	if (val < 1 || val > UCC_MAX_NUM) {
+		dev_err(&ofdev->dev, "no support for UCC%u\n", val);
 		ret = -ENODEV;
 		goto out_free;
 	}
-	qe_port->ucc_num = *iprop - 1;
+	qe_port->ucc_num = val - 1;
 
 	/*
 	 * In the future, we should not require the BRG to be specified in the
@@ -1350,13 +1346,12 @@ static int ucc_uart_probe(struct platform_device *ofdev)
 	}
 
 	/* Get the port number, numbered 0-3 */
-	iprop = of_get_property(np, "port-number", NULL);
-	if (!iprop) {
+	if (of_property_read_u32(np, "port-number", &val)) {
 		dev_err(&ofdev->dev, "missing port-number in device tree\n");
 		ret = -EINVAL;
 		goto out_free;
 	}
-	qe_port->port.line = *iprop;
+	qe_port->port.line = val;
 	if (qe_port->port.line >= UCC_MAX_UART) {
 		dev_err(&ofdev->dev, "port-number must be 0-%u\n",
 			UCC_MAX_UART - 1);
@@ -1386,31 +1381,29 @@ static int ucc_uart_probe(struct platform_device *ofdev)
 		}
 	}
 
-	iprop = of_get_property(np, "brg-frequency", NULL);
-	if (!iprop) {
+	if (of_property_read_u32(np, "brg-frequency", &val)) {
 		dev_err(&ofdev->dev,
 		       "missing brg-frequency in device tree\n");
 		ret = -EINVAL;
 		goto out_np;
 	}
 
-	if (*iprop)
-		qe_port->port.uartclk = *iprop;
+	if (val)
+		qe_port->port.uartclk = val;
 	else {
 		/*
 		 * Older versions of U-Boot do not initialize the brg-frequency
 		 * property, so in this case we assume the BRG frequency is
 		 * half the QE bus frequency.
 		 */
-		iprop = of_get_property(np, "bus-frequency", NULL);
-		if (!iprop) {
+		if (of_property_read_u32(np, "bus-frequency", &val)) {
 			dev_err(&ofdev->dev,
 				"missing QE bus-frequency in device tree\n");
 			ret = -EINVAL;
 			goto out_np;
 		}
-		if (*iprop)
-			qe_port->port.uartclk = *iprop / 2;
+		if (val)
+			qe_port->port.uartclk = val / 2;
 		else {
 			dev_err(&ofdev->dev,
 				"invalid QE bus-frequency in device tree\n");
-- 
2.23.0

