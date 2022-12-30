Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312B6658E87
	for <lists+linux-serial@lfdr.de>; Thu, 29 Dec 2022 16:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbiL2Pv2 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 29 Dec 2022 10:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbiL2Pup (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 29 Dec 2022 10:50:45 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DB01BD
        for <linux-serial@vger.kernel.org>; Thu, 29 Dec 2022 07:50:42 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id h16so17706016wrz.12
        for <linux-serial@vger.kernel.org>; Thu, 29 Dec 2022 07:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lb0vU9ZSHO5r+oQcoBj4FnTeT47p74OitaDWVpDY66s=;
        b=gn0PqKEDVwLS6qBr3pmBW87z/OJoS2PNkLt64lbjK6Nxa/8tXhL1R9OyzI9Zbz6Oq2
         A0tfCA/nXyS2iNmM2u1F5MAYvIe3VJArlgMbRamIjnCwHDb4uyqULqYh13vWDDnodTZ2
         9xamHppbjlLKf7kA8i6j+rad3yluIUnu2qJaJKnBceUiixmZtZLVEuzjeaHlolllmRgr
         IZC1IKUzW1hGmOZTUdzR38vNxNN0REML789/w3e+20XkAjEJW8U9xHaeKGAfc/iBb4Ci
         baaarDRd6Jv1ugxZ2BqtXvf6dmrDJ1ugoon4HRdxKYQfOqzWB6OT/5nzTnKNOIeyY5Th
         zxUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lb0vU9ZSHO5r+oQcoBj4FnTeT47p74OitaDWVpDY66s=;
        b=S72d0EyMxhctruex5ictdCwoIZS6h/SS2EBHwmy9QgcUy8FiVlYjsN7ch7LOuCJTls
         6wjqqNMQ/W83BRVeX8vLqsTUNisEKdJHQPtcnen1kvsTpLTjcgd1MEXRUtzQ9m+i+idi
         qSqMjFUBGU6AdzMwHuGeKMiVH555i68dSMGf5WXdFe2jeekGLT5MW4bmVi3gwyZKD37q
         RMp7qddOj4PgXEqcUvm+ufDYv7+OZkZWqyzPoeD6vX1pDJG/gYsVTZJ77ibTX4E1C+5W
         mjI8a7Janj1aOkvaEPDLtBBrEPO53fCpqg5nJLNe8ef4KC/ck5DKQRNGI2gFRXlBUQ+z
         eogA==
X-Gm-Message-State: AFqh2kpt6vv0wLgTOEyhwYAryaMk1gJBjVuXDvIRGjdlwIUD/FEi/ULv
        sZWh2DNbrPLtZJmViLXdmVHL+w==
X-Google-Smtp-Source: AMrXdXuMwy3U4WcaXrx/yBwFi2f8h1TvwwsB8sikW66om9SJvxMkB7+tLhTlNPL3H0MO7rlqfGTNPA==
X-Received: by 2002:a5d:65c4:0:b0:281:24c5:a533 with SMTP id e4-20020a5d65c4000000b0028124c5a533mr7550899wrw.23.1672329040793;
        Thu, 29 Dec 2022 07:50:40 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:8f7a:98d8:9d8d:ced8])
        by smtp.gmail.com with ESMTPSA id bh12-20020a05600c3d0c00b003cfa81e2eb4sm25251647wmb.38.2022.12.29.07.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 07:50:40 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v6 07/14] tty: serial: qcom-geni-serial: refactor qcom_geni_serial_isr()
Date:   Thu, 29 Dec 2022 16:50:23 +0100
Message-Id: <20221229155030.418800-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221229155030.418800-1-brgl@bgdev.pl>
References: <20221229155030.418800-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
index f4e2486b2115..92aefd4f8527 100644
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

