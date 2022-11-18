Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606DF62F48A
	for <lists+linux-serial@lfdr.de>; Fri, 18 Nov 2022 13:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241745AbiKRM0I (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 18 Nov 2022 07:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241702AbiKRM0H (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Nov 2022 07:26:07 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A515697096
        for <linux-serial@vger.kernel.org>; Fri, 18 Nov 2022 04:26:06 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id x5so4945170wrt.7
        for <linux-serial@vger.kernel.org>; Fri, 18 Nov 2022 04:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ix98Buqrm8hc4zZgibw2ROra30KJmpCLaRPoOVSax6U=;
        b=fr2y+fgpu7yMtDfL/F6WHS15il9rZPexAjvuSgluGk58Q50xnOVM6u6jOY/KO/1xsY
         z0h4BK4SSg7EJEYSkG0kxrjxd1rgA+X6ACOkAllPjRlzpLsrQq0hvwHKvHKHJuOR5xU2
         cZzLi6EJWcv5J0IkgWUjzxMJMKjT9OYRPIs5OE0izDQEyfjW1RzYl6QriSImMbbaYz+a
         5+TVTTdxVl8vu0gTd84Is720pu7ojdK4DjYoPZxYWz3YB9KwsD0iT8Jt7cPDjEnwXfE1
         /8UwXwEItbZYJxEGYmqU+eTGqdPED/DcOQ5nZ/yf6Zi90pQJuD7R8aumxus6kn1JyLm4
         MnKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ix98Buqrm8hc4zZgibw2ROra30KJmpCLaRPoOVSax6U=;
        b=hYLz28rzoIb+ylCjWpTfpUYfj/AmRguXwRf21/Vp1oLuxRSiDAt78CPuuTSf51HAsl
         ME0yIkmpgaWJqEgkHQBL9SRL/vePwR+EmF7XczoSaQXMnoG+JRNAGIDAjhWKd6KgscfL
         bgn13cMbHtO07XBkOqCjRgRfRwqbSG5u20NeKUsXZ8bdvD8eC1Qp5SCPsOh9aPA8k86P
         2PbFsv4d74jsn1lrS0ZGKF1TcU34rlnWUS43OMF3QYwYY1KidFV2SJDaX5egMyoAeoW4
         ZoHqebO8DCzt72r0mxVfog1u//R3HJ+1jv23vu4j+ftMlLnIVZPOCM7UeRfG+Lp1QObO
         1p5g==
X-Gm-Message-State: ANoB5pl52phq8BShvbeyBuGRkoqF15bgN+ysi/3X2MnfZXG8Vi0rvpaL
        E9Cn/MEEKXrhDi6woOUde8h7EQ==
X-Google-Smtp-Source: AA0mqf4w0Sogr6egE1uHzDv9Nl0SENIbQJhiBOjTBFjUjGbvkSUShCyBnX0yw4Jf9SDeOD3OxkfGuw==
X-Received: by 2002:a05:6000:1d94:b0:238:3d85:8e2c with SMTP id bk20-20020a0560001d9400b002383d858e2cmr4248475wrb.650.1668774365147;
        Fri, 18 Nov 2022 04:26:05 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:b10c:1279:a704:75d4])
        by smtp.gmail.com with ESMTPSA id f19-20020a05600c155300b003c6f3e5ba42sm9873958wmg.46.2022.11.18.04.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 04:26:04 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 03/15] tty: serial: qcom-geni-serial: align #define values
Date:   Fri, 18 Nov 2022 13:25:27 +0100
Message-Id: <20221118122539.384993-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221118122539.384993-1-brgl@bgdev.pl>
References: <20221118122539.384993-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Keep the #define symbols aligned for better readability.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 62 +++++++++++++--------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 7af5df6833c7..97ee7c074b79 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -39,57 +39,57 @@
 #define SE_UART_MANUAL_RFR		0x2ac
 
 /* SE_UART_TRANS_CFG */
-#define UART_TX_PAR_EN		BIT(0)
-#define UART_CTS_MASK		BIT(1)
+#define UART_TX_PAR_EN			BIT(0)
+#define UART_CTS_MASK			BIT(1)
 
 /* SE_UART_TX_STOP_BIT_LEN */
-#define TX_STOP_BIT_LEN_1	0
-#define TX_STOP_BIT_LEN_2	2
+#define TX_STOP_BIT_LEN_1		0
+#define TX_STOP_BIT_LEN_2		2
 
 /* SE_UART_RX_TRANS_CFG */
-#define UART_RX_PAR_EN		BIT(3)
+#define UART_RX_PAR_EN			BIT(3)
 
 /* SE_UART_RX_WORD_LEN */
-#define RX_WORD_LEN_MASK	GENMASK(9, 0)
+#define RX_WORD_LEN_MASK		GENMASK(9, 0)
 
 /* SE_UART_RX_STALE_CNT */
-#define RX_STALE_CNT		GENMASK(23, 0)
+#define RX_STALE_CNT			GENMASK(23, 0)
 
 /* SE_UART_TX_PARITY_CFG/RX_PARITY_CFG */
-#define PAR_CALC_EN		BIT(0)
-#define PAR_EVEN		0x00
-#define PAR_ODD			0x01
-#define PAR_SPACE		0x10
+#define PAR_CALC_EN			BIT(0)
+#define PAR_EVEN			0x00
+#define PAR_ODD				0x01
+#define PAR_SPACE			0x10
 
 /* SE_UART_MANUAL_RFR register fields */
-#define UART_MANUAL_RFR_EN	BIT(31)
-#define UART_RFR_NOT_READY	BIT(1)
-#define UART_RFR_READY		BIT(0)
+#define UART_MANUAL_RFR_EN		BIT(31)
+#define UART_RFR_NOT_READY		BIT(1)
+#define UART_RFR_READY			BIT(0)
 
 /* UART M_CMD OP codes */
-#define UART_START_TX		0x1
+#define UART_START_TX			0x1
 /* UART S_CMD OP codes */
-#define UART_START_READ		0x1
-
-#define UART_OVERSAMPLING	32
-#define STALE_TIMEOUT		16
-#define DEFAULT_BITS_PER_CHAR	10
-#define GENI_UART_CONS_PORTS	1
-#define GENI_UART_PORTS		3
-#define DEF_FIFO_DEPTH_WORDS	16
-#define DEF_TX_WM		2
-#define DEF_FIFO_WIDTH_BITS	32
-#define UART_RX_WM		2
+#define UART_START_READ			0x1
+
+#define UART_OVERSAMPLING		32
+#define STALE_TIMEOUT			16
+#define DEFAULT_BITS_PER_CHAR		10
+#define GENI_UART_CONS_PORTS		1
+#define GENI_UART_PORTS			3
+#define DEF_FIFO_DEPTH_WORDS		16
+#define DEF_TX_WM			2
+#define DEF_FIFO_WIDTH_BITS		32
+#define UART_RX_WM			2
 
 /* SE_UART_LOOPBACK_CFG */
-#define RX_TX_SORTED	BIT(0)
-#define CTS_RTS_SORTED	BIT(1)
-#define RX_TX_CTS_RTS_SORTED	(RX_TX_SORTED | CTS_RTS_SORTED)
+#define RX_TX_SORTED			BIT(0)
+#define CTS_RTS_SORTED			BIT(1)
+#define RX_TX_CTS_RTS_SORTED		(RX_TX_SORTED | CTS_RTS_SORTED)
 
 /* UART pin swap value */
-#define DEFAULT_IO_MACRO_IO0_IO1_MASK		GENMASK(3, 0)
+#define DEFAULT_IO_MACRO_IO0_IO1_MASK	GENMASK(3, 0)
 #define IO_MACRO_IO0_SEL		0x3
-#define DEFAULT_IO_MACRO_IO2_IO3_MASK		GENMASK(15, 4)
+#define DEFAULT_IO_MACRO_IO2_IO3_MASK	GENMASK(15, 4)
 #define IO_MACRO_IO2_IO3_SWAP		0x4640
 
 /* We always configure 4 bytes per FIFO word */
-- 
2.37.2

