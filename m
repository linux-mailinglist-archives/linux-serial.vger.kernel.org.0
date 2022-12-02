Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC27A6402B9
	for <lists+linux-serial@lfdr.de>; Fri,  2 Dec 2022 09:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbiLBI54 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 2 Dec 2022 03:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbiLBI5B (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 2 Dec 2022 03:57:01 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8904DC35A6
        for <linux-serial@vger.kernel.org>; Fri,  2 Dec 2022 00:56:11 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id p13-20020a05600c468d00b003cf8859ed1bso3727390wmo.1
        for <linux-serial@vger.kernel.org>; Fri, 02 Dec 2022 00:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LuwEN90AtgG+bvIlYhOJ4Y3TdxahsORXGOntfwKDvGM=;
        b=W2JObHAU3OlA/ReHV0mZlqT9VGsOJBAzjZTf75NChTiLnLAqJJKbKA2+YHv6O3awEJ
         ypizr5p6eY0pqq5ceMKOm8Xq7oawzZ9tkjXMREbGux7beijwpJC5f/tFavRJDNnoaGbJ
         TTXPGw9HyLWDTSQeVS+U2tyvnP5iMQ73QTkeN2/kn8xB9KFmqBnKvLoj7umm+wC7gRz8
         bYFIvsuLy2+VPgVDzsZM1jPp9AaSRHmc9ENTOE8kIfWJBRaUtBsYej9Skh8jwpVqzmgi
         iLzwSWMeckbRr3wud6bsYH/iwhFDxJ5X/LLq+UnGcTHGZtJHhYwy6Cpy6/sd0qi1Yhi5
         Imtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LuwEN90AtgG+bvIlYhOJ4Y3TdxahsORXGOntfwKDvGM=;
        b=dGHx3QPb5NDNr7onl6u5kskM6ltYpkdafzKJHaAjDeLgL6NT2FXPWamr3Aw8qw6UFC
         xVcIpWfJZe9ZChRXQdlIyp2LaLScWmLazyzyeNPrzJk2s1om+ABOUxdqIym3oEg2lECq
         n4prl6trJnhSnZUmsYg5JmcFeUDlnVQZ9pIGTE1nzWB5XXY1kIbae5gTGIhjJTR6mUdX
         QGigMcb/XcH3ANC3LmDd1pdERpFki0fBkNn5XrKQBvSPe57dlHkqJ31R3U7q/UAZ2hrv
         o1lFS5YZLzj6bQ68IhQz1uNy5k0L7zFqROHwW6hs26HJwAZPd0GDl6DIwic7CWQ9eQF6
         UXzQ==
X-Gm-Message-State: ANoB5pmV2chQjPgJounlm38A8mISclMtxWzmD56J3pmLvj6hYjL3ecpB
        ZwTymqUulAZSZnY3EFvjcqGfEw==
X-Google-Smtp-Source: AA0mqf4qOE8TfJOJSb6Zj6OMKm3aw3+RKHTTawqwv60hwYhonB8hQr5PXPSqp7HaccbeVor2+uX1Eg==
X-Received: by 2002:a05:600c:21c6:b0:3c7:19a6:8146 with SMTP id x6-20020a05600c21c600b003c719a68146mr52634302wmj.158.1669971370022;
        Fri, 02 Dec 2022 00:56:10 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:29a4:6f04:ddb1:1ed7])
        by smtp.gmail.com with ESMTPSA id a13-20020adfed0d000000b0024219b1cb1bsm6527517wro.60.2022.12.02.00.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 00:56:09 -0800 (PST)
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
Subject: [PATCH v5 13/14] soc: qcom-geni-se: add more symbol definitions
Date:   Fri,  2 Dec 2022 09:55:53 +0100
Message-Id: <20221202085554.59637-14-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221202085554.59637-1-brgl@bgdev.pl>
References: <20221202085554.59637-1-brgl@bgdev.pl>
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

The following symbols will be used when adding support for SE DMA in
the qcom geni serial driver.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 include/linux/qcom-geni-se.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/qcom-geni-se.h b/include/linux/qcom-geni-se.h
index f5672785c0c4..400213daa461 100644
--- a/include/linux/qcom-geni-se.h
+++ b/include/linux/qcom-geni-se.h
@@ -103,6 +103,7 @@ struct geni_se {
 #define SE_DMA_TX_FSM_RST		0xc58
 #define SE_DMA_RX_IRQ_STAT		0xd40
 #define SE_DMA_RX_IRQ_CLR		0xd44
+#define SE_DMA_RX_LEN_IN		0xd54
 #define SE_DMA_RX_FSM_RST		0xd58
 #define SE_HW_PARAM_0			0xe24
 #define SE_HW_PARAM_1			0xe28
@@ -235,6 +236,8 @@ struct geni_se {
 #define RX_SBE				BIT(2)
 #define RX_RESET_DONE			BIT(3)
 #define RX_FLUSH_DONE			BIT(4)
+#define RX_DMA_PARITY_ERR		BIT(5)
+#define RX_DMA_BREAK			GENMASK(8, 7)
 #define RX_GENI_GP_IRQ			GENMASK(10, 5)
 #define RX_GENI_CANCEL_IRQ		BIT(11)
 #define RX_GENI_GP_IRQ_EXT		GENMASK(13, 12)
-- 
2.37.2

