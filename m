Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD99635B20
	for <lists+linux-serial@lfdr.de>; Wed, 23 Nov 2022 12:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236405AbiKWLJS (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 23 Nov 2022 06:09:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237559AbiKWLIc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 23 Nov 2022 06:08:32 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E649824F
        for <linux-serial@vger.kernel.org>; Wed, 23 Nov 2022 03:08:11 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id l39-20020a05600c1d2700b003cf93c8156dso1034239wms.4
        for <linux-serial@vger.kernel.org>; Wed, 23 Nov 2022 03:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrodxjE3++JzSf9Q5uxlAVuutjj+cagca/Bct4wXLdY=;
        b=pP4gS/HNxUf1PC9+KBEniYc8ud5tGr4nZdY/Y/d3YrZGdYbaKwpiuJPxcotoxvGsmB
         RW0AwYy+5Txh5eg+YnvFht6fnHY6izGJSWKIDIyyeOwwuzYP7BUz1WUyrHGi64iHXyRm
         2gJLPmtG+clhzI/2typ0Agb/uwJcqiKZy55mF9EHCXUqbWM9BHO82PPflDunZq6i3awq
         K/8hAdBIkHzKRgHu/FpZgffAAGjMMI1nhBk7mGp73lMB4b/mi971o084WtQG2XIR+6/P
         OWM5cjManBcY5IipW6K+j75ZCz6qhlC82oO0eJ7rAHQ8dsWjtWf8xqghMcvfs/7KXR8/
         8odg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hrodxjE3++JzSf9Q5uxlAVuutjj+cagca/Bct4wXLdY=;
        b=3yVHQxkzN2Qi7GBwmNGOe7EstPNX9Qke4OFempksbwyxpJqzPtsLcN+rzRdyuRjRUX
         3QMT7tHJLv1RmyoZIdPvScfsLwM2jLxzgjHbDyGdIJ1DAM+FHkeIzhBUTQSxb4MsQdAc
         p2PXeWkCGf3xQmwCSRNEM3rNJgVR1sClJM46i44WYSYzFj5vNeWoqNqCiCcq2mL8XGOS
         jMtqxHbeQUf2Qcm3mMx0VC+KnmmLnqSgHLczDwW2MAjCD0ctFcArkuxkS/PvdVo1TFLo
         Ox8XJB8juCJjLW8g8dl+a2RPg3cv5iFNxQD+xgtbc+j3r35RB38A9cUBPcfbdtHRE+Ce
         5ITA==
X-Gm-Message-State: ANoB5pkowr6A+XSgao4FYHTyVqiC/g/1+B0cpDgS86G3cduelhDNXsyN
        W/I5zuW3c0bDTqQJy8gExaQXbQ==
X-Google-Smtp-Source: AA0mqf5k/RsNdXvc/unIDAoAnaPsXITgStGNfkr7yd2ElmRgsqyZdNwUhsMEd++G8IAdUqUQs0BxDw==
X-Received: by 2002:a1c:7501:0:b0:3cf:61a3:464e with SMTP id o1-20020a1c7501000000b003cf61a3464emr12946239wmc.111.1669201690423;
        Wed, 23 Nov 2022 03:08:10 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:ae74:d94f:4677:3378])
        by smtp.gmail.com with ESMTPSA id f13-20020a05600c4e8d00b003c6c182bef9sm2560406wmq.36.2022.11.23.03.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 03:08:10 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v3 06/13] tty: serial: qcom-geni-serial: refactor qcom_geni_serial_isr()
Date:   Wed, 23 Nov 2022 12:07:52 +0100
Message-Id: <20221123110759.1836666-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221123110759.1836666-1-brgl@bgdev.pl>
References: <20221123110759.1836666-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Simplify the conditions in qcom_geni_serial_isr() and fix indentation.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index ec2523736e99..fba02f71a874 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -827,20 +827,18 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
 
 	if (m_irq_status & m_irq_en & (M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN))
 		qcom_geni_serial_handle_tx(uport, m_irq_status & M_CMD_DONE_EN,
-					geni_status & M_GENI_CMD_ACTIVE);
+					   geni_status & M_GENI_CMD_ACTIVE);
 
-	if (s_irq_status & S_GP_IRQ_0_EN || s_irq_status & S_GP_IRQ_1_EN) {
+	if (s_irq_status & (S_GP_IRQ_0_EN | S_GP_IRQ_1_EN)) {
 		if (s_irq_status & S_GP_IRQ_0_EN)
 			uport->icount.parity++;
 		drop_rx = true;
-	} else if (s_irq_status & S_GP_IRQ_2_EN ||
-					s_irq_status & S_GP_IRQ_3_EN) {
+	} else if (s_irq_status & (S_GP_IRQ_2_EN | S_GP_IRQ_3_EN)) {
 		uport->icount.brk++;
 		port->brk = true;
 	}
 
-	if (s_irq_status & S_RX_FIFO_WATERMARK_EN ||
-					s_irq_status & S_RX_FIFO_LAST_EN)
+	if (s_irq_status & (S_RX_FIFO_WATERMARK_EN | S_RX_FIFO_LAST_EN))
 		qcom_geni_serial_handle_rx(uport, drop_rx);
 
 out_unlock:
-- 
2.37.2

