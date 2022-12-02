Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F05E6402A2
	for <lists+linux-serial@lfdr.de>; Fri,  2 Dec 2022 09:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbiLBI5D (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 2 Dec 2022 03:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbiLBI41 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 2 Dec 2022 03:56:27 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E257CC0548
        for <linux-serial@vger.kernel.org>; Fri,  2 Dec 2022 00:56:05 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id f18so6780706wrj.5
        for <linux-serial@vger.kernel.org>; Fri, 02 Dec 2022 00:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbfRkHz4/aW9Ej0X8Fhaj4Le2T1GhSly/B7XfhIOtq0=;
        b=JktLJu4rVvE9sWZWbk7w7Rz8IZyV0rFZh+goJTP/i2KKdtHMA4S8T1vUcxSTh/5ywY
         sXpRLYx/VPIcPs14Tz98iyvtpyZC+uV/e8WmlIZe5YkBzcvgCuwzGYh2P6fw4WcfV074
         vX4GWxX++bFE5BBxm44+CPuqtXpQGSAg4nrco7uhdkSfUX/yLy0uumrtiZJ6So0E0AWQ
         bgCMWEQ23qOm1apcuaTjanWDftzLAz827SbpcZ+daBynmQ5P2iXU1EZ7jNkdpjVlT3tX
         I4sKvXnQiW7/q3SnuUGjfwsuKOlqZkw4yl3O0pBJR3yAcRCWd0spk7xBIx2NGQ2IwjVt
         OcKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zbfRkHz4/aW9Ej0X8Fhaj4Le2T1GhSly/B7XfhIOtq0=;
        b=r+bI0orDZhNcKH4LKd+lL9R9xIamCVM1wYgjcDX1gg1Fj3isFHX1FimVkPCPgdclN6
         iG6V6LLs2iU1PODDePVMp18SfPszRNPDvpPWiG9xSdxLoLhBEIRoLkd3xnIPlKaEq9lR
         1pfeP5jV77pz4eGbWYQIhWH/MfAarzMl0HV2wWtcGHd2Yhlr99QAxpJ/3ibIDHZLxOsu
         WAl+mLa79stVzdXi0oB0X4eUnaw5XNzkVsWapbKsb0OfyY1EUi62eV5nGKsbcVIw+nOt
         8uonnBsKRFj/rAjj6dGNeSHsZeCG6YDuGe7UXKT2iNPneXP9wDiGCnb6Vxa49TH1fpJd
         /TZw==
X-Gm-Message-State: ANoB5pk7fcaQDMMMpBdvxllX2vUtl/1BLHjf9Koait63hZCedooKZAU1
        vh8rbbVgPzD+Kr5n7CvDLuekPw==
X-Google-Smtp-Source: AA0mqf6W5dJs+6xkkg/KNDhThIeAo4VOfAUHRRveInmom0lnH/BHM1cBfTRQY1FlCMakbSRwzwpicg==
X-Received: by 2002:adf:f2d0:0:b0:242:7c:eb9c with SMTP id d16-20020adff2d0000000b00242007ceb9cmr24328148wrp.178.1669971364317;
        Fri, 02 Dec 2022 00:56:04 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:29a4:6f04:ddb1:1ed7])
        by smtp.gmail.com with ESMTPSA id a13-20020adfed0d000000b0024219b1cb1bsm6527517wro.60.2022.12.02.00.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 00:56:03 -0800 (PST)
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
Subject: [PATCH v5 07/14] tty: serial: qcom-geni-serial: remove unneeded tabs
Date:   Fri,  2 Dec 2022 09:55:47 +0100
Message-Id: <20221202085554.59637-8-brgl@bgdev.pl>
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

Remove redundant indentation in struct member assignment.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index fba02f71a874..68a1402fbe58 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -141,26 +141,26 @@ static inline struct qcom_geni_serial_port *to_dev_port(struct uart_port *uport)
 static struct qcom_geni_serial_port qcom_geni_uart_ports[GENI_UART_PORTS] = {
 	[0] = {
 		.uport = {
-				.iotype = UPIO_MEM,
-				.ops = &qcom_geni_uart_pops,
-				.flags = UPF_BOOT_AUTOCONF,
-				.line = 0,
+			.iotype = UPIO_MEM,
+			.ops = &qcom_geni_uart_pops,
+			.flags = UPF_BOOT_AUTOCONF,
+			.line = 0,
 		},
 	},
 	[1] = {
 		.uport = {
-				.iotype = UPIO_MEM,
-				.ops = &qcom_geni_uart_pops,
-				.flags = UPF_BOOT_AUTOCONF,
-				.line = 1,
+			.iotype = UPIO_MEM,
+			.ops = &qcom_geni_uart_pops,
+			.flags = UPF_BOOT_AUTOCONF,
+			.line = 1,
 		},
 	},
 	[2] = {
 		.uport = {
-				.iotype = UPIO_MEM,
-				.ops = &qcom_geni_uart_pops,
-				.flags = UPF_BOOT_AUTOCONF,
-				.line = 2,
+			.iotype = UPIO_MEM,
+			.ops = &qcom_geni_uart_pops,
+			.flags = UPF_BOOT_AUTOCONF,
+			.line = 2,
 		},
 	},
 };
-- 
2.37.2

