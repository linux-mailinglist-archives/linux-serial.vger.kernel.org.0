Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F65D63BE71
	for <lists+linux-serial@lfdr.de>; Tue, 29 Nov 2022 12:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbiK2LAg (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 29 Nov 2022 06:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbiK2LAZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 29 Nov 2022 06:00:25 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABF460E92
        for <linux-serial@vger.kernel.org>; Tue, 29 Nov 2022 03:00:24 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id v7so10590909wmn.0
        for <linux-serial@vger.kernel.org>; Tue, 29 Nov 2022 03:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrodxjE3++JzSf9Q5uxlAVuutjj+cagca/Bct4wXLdY=;
        b=f7KBupZKEv89MmEWL+Hpyk0X7yqUvKsNA2eKPe9MGoi6DP+Somr/3YKb7OsvtwSTL9
         dPbAkNnxRy0WuXm+8OTJi49+lVB/BFdQFnW0kid+DoKNTybSKi9VXWQvUqGZj8cTeVqJ
         U3A9iRZYdjXEUHs1vpcHYhC/3SFrN1TxtEFI3B05Oj2ouJLmIfaKx0xPiuanMkmC1Y4d
         Ku5p0cblw0KdaQqG10TkMNTfF8OGlrKSV/aOaJgapXRU5bpNOQlIerlLZLjUafiIVfuL
         2aLOSD7Ryz7lLNdwhBm7oEkTYu5/Mq0Unj1OomvGr35zP0BUpCwf4SULcOaNEwKpv8xI
         N2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hrodxjE3++JzSf9Q5uxlAVuutjj+cagca/Bct4wXLdY=;
        b=tyxs3iskvCg40Hp4kEwsibrHm1wxL2PwCZm8aFnnTn/MSTxMvy/+ZQZLG1vmCH1AiD
         euAj+FRmj1D9mL/pvqZb4isf0OIbjRn1t/fBL0xk3+GRKASAZIdavtUmFEAF9WmlWH0f
         WCPgBknld6BfvrdANhgmhlDIf0DoIQFinjp3kx2phNXMFbffW8TSataodo7BfaB5fYF1
         8we+meE5JFgx8VoETfhTG6+CFBIvsbcEPX/BYVwZ1UDRWMRXXhoyR3qK3wwx2n8Biobu
         yuWI4+AAcKjNSXElh5vFDNA/GUc+dsFttLuDWMRYvl5B9Kk2wud1e0SLsFatc5zE1uFG
         lluw==
X-Gm-Message-State: ANoB5plD5Y2ojSvHw2ngZSz9ouAu/eLwiS1gY11KF9oBTXURbiyW2CgI
        Eao2skC5zApphHNYZXsB5igz1Q==
X-Google-Smtp-Source: AA0mqf6gli/Ra65Hvjq28nqIOpLdHCy1N4wirFtX/8WUw2yTjbme1+wrXY7fIaldOceukMuhPYseaQ==
X-Received: by 2002:a05:600c:6549:b0:3d0:5aa:b315 with SMTP id dn9-20020a05600c654900b003d005aab315mr38550158wmb.101.1669719623419;
        Tue, 29 Nov 2022 03:00:23 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:6b19:1d8e:fbca:fd02])
        by smtp.gmail.com with ESMTPSA id q19-20020a1cf313000000b003a3170a7af9sm1617658wmq.4.2022.11.29.03.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 03:00:23 -0800 (PST)
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
Subject: [PATCH v4 06/13] tty: serial: qcom-geni-serial: refactor qcom_geni_serial_isr()
Date:   Tue, 29 Nov 2022 12:00:05 +0100
Message-Id: <20221129110012.224685-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221129110012.224685-1-brgl@bgdev.pl>
References: <20221129110012.224685-1-brgl@bgdev.pl>
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

