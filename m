Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A56B62F4A4
	for <lists+linux-serial@lfdr.de>; Fri, 18 Nov 2022 13:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235256AbiKRM1P (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 18 Nov 2022 07:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241807AbiKRM03 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Nov 2022 07:26:29 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7124397A84
        for <linux-serial@vger.kernel.org>; Fri, 18 Nov 2022 04:26:11 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id y16so8983297wrt.12
        for <linux-serial@vger.kernel.org>; Fri, 18 Nov 2022 04:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TjRlvG98zfN2Bv4vCWR93fi5oSZzdVfhIH1TmLO20G0=;
        b=36jVyEZd8EBGn2gTFQTK9zvR7p60sA28fQEhTDPQkMGJJHXxRHDUQMpVvb0zR13FV2
         LlhDzZc2eq4elS+3dSlFJhPCsYMO4ysrInRywPesrz74OhM1fKA/UR8xP1zchHCEtmf9
         z7TAkuZMQmwtONuwkRfaNivre/GuU5iAD1wVXTTKHOODkNQ7bUvQtgNR8NEVjwffK2L9
         dCQ71ySN60tAvZdJ64b91DGXG+Nsr1ur9E+5BzZWzJDZrior1vYifXlXv+YGF9IlO0xu
         ZICuIwAgfWie1nj2tZtVG7tTtbDfB7uwNLt8ebWFJITia3CYwIkBYDRPXSvFkEM2hHNY
         HRpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TjRlvG98zfN2Bv4vCWR93fi5oSZzdVfhIH1TmLO20G0=;
        b=XcX8DjjYWouyARcjXvW+4I6nfISc48AYpkfbujalR6qV1MPeHVpPHKgfniKFhY3v0i
         1lzSac6ncflI3xzDicJPe7Mhz/cyhRTiouoOgc0Jr+yD+2ACYGDjvxF5yQ7R8mIyNg1p
         tSk130l3tH2+1FHFXWcx5GKOs1GhFp+eW8czH9BjUQ8Eug3Hko+hHv9JfyhKR2MbsVuA
         DawWQN81osdDq5BDBwaUtvsR9+lO8Pt34M5rS/Jnd3cSUKZPZ3+d8TpcJZUtcLzX7enE
         WHMCuV1ZmXgs913N/Ag7BA0+xTE1TKx4LHtFtAA0fh3JH5lSHn7C6sdb27/Zd5q8v/pu
         1Kmg==
X-Gm-Message-State: ANoB5pm0FoCZ5AH7l8tLRTQq9IFzysFlfPoLfGs/DCY29yjRHcx78jiw
        EcsqvUv3BXCbJ6r+fbOkRb/HwQ==
X-Google-Smtp-Source: AA0mqf57fnDTjxB5aWudsk/YGYhkImBz+5yBS/ycBe5HGZj/d3SfUBQlOu3aU5zXKQbj9Ju5Ob5Pkw==
X-Received: by 2002:adf:f805:0:b0:236:ef0b:68c5 with SMTP id s5-20020adff805000000b00236ef0b68c5mr4316797wrp.373.1668774369979;
        Fri, 18 Nov 2022 04:26:09 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:b10c:1279:a704:75d4])
        by smtp.gmail.com with ESMTPSA id f19-20020a05600c155300b003c6f3e5ba42sm9873958wmg.46.2022.11.18.04.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 04:26:09 -0800 (PST)
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
Subject: [PATCH 08/15] tty: serial: qcom-geni-serial: split out the FIFO tx code
Date:   Fri, 18 Nov 2022 13:25:32 +0100
Message-Id: <20221118122539.384993-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221118122539.384993-1-brgl@bgdev.pl>
References: <20221118122539.384993-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

qcom_geni_serial_handle_tx() is pretty big, let's move the code that
handles the actual writing of data to a separate function which makes
sense in preparation for introducing a dma variant of handle_tx().

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 60 +++++++++++++++------------
 1 file changed, 33 insertions(+), 27 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 39041538e5d2..4b155ca0ac74 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -701,19 +701,48 @@ static void qcom_geni_serial_start_rx(struct uart_port *uport)
 	writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
 }
 
+static int qcom_geni_serial_send_chunk_fifo(struct uart_port *uport,
+					    unsigned int chunk)
+{
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
+	struct circ_buf *xmit = &uport->state->xmit;
+	size_t remaining = chunk;
+	int i, tail = xmit->tail;
+
+	for (i = 0; i < chunk; ) {
+		unsigned int tx_bytes;
+		u8 buf[sizeof(u32)];
+		int c;
+
+		memset(buf, 0, sizeof(buf));
+		tx_bytes = min_t(size_t, remaining, BYTES_PER_FIFO_WORD);
+
+		for (c = 0; c < tx_bytes ; c++) {
+			buf[c] = xmit->buf[tail++];
+			tail &= UART_XMIT_SIZE - 1;
+		}
+
+		iowrite32_rep(uport->membase + SE_GENI_TX_FIFOn, buf, 1);
+
+		i += tx_bytes;
+		uport->icount.tx += tx_bytes;
+		remaining -= tx_bytes;
+		port->tx_remaining -= tx_bytes;
+	}
+
+	return tail;
+}
+
 static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
 		bool active)
 {
 	struct qcom_geni_serial_port *port = to_dev_port(uport);
 	struct circ_buf *xmit = &uport->state->xmit;
 	size_t avail;
-	size_t remaining;
 	size_t pending;
-	int i;
 	u32 status;
 	u32 irq_en;
 	unsigned int chunk;
-	int tail;
 
 	status = readl(uport->membase + SE_GENI_TX_FIFO_STATUS);
 
@@ -732,7 +761,6 @@ static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
 	avail = port->tx_fifo_depth - (status & TX_FIFO_WC);
 	avail *= BYTES_PER_FIFO_WORD;
 
-	tail = xmit->tail;
 	chunk = min(avail, pending);
 	if (!chunk)
 		goto out_write_wakeup;
@@ -747,29 +775,7 @@ static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
 					uport->membase + SE_GENI_M_IRQ_EN);
 	}
 
-	remaining = chunk;
-	for (i = 0; i < chunk; ) {
-		unsigned int tx_bytes;
-		u8 buf[sizeof(u32)];
-		int c;
-
-		memset(buf, 0, sizeof(buf));
-		tx_bytes = min_t(size_t, remaining, BYTES_PER_FIFO_WORD);
-
-		for (c = 0; c < tx_bytes ; c++) {
-			buf[c] = xmit->buf[tail++];
-			tail &= UART_XMIT_SIZE - 1;
-		}
-
-		iowrite32_rep(uport->membase + SE_GENI_TX_FIFOn, buf, 1);
-
-		i += tx_bytes;
-		uport->icount.tx += tx_bytes;
-		remaining -= tx_bytes;
-		port->tx_remaining -= tx_bytes;
-	}
-
-	xmit->tail = tail;
+	xmit->tail = qcom_geni_serial_send_chunk_fifo(uport, chunk);
 
 	/*
 	 * The tx fifo watermark is level triggered and latched. Though we had
-- 
2.37.2

