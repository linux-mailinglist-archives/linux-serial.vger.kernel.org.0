Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7355658E70
	for <lists+linux-serial@lfdr.de>; Thu, 29 Dec 2022 16:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbiL2Pui (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 29 Dec 2022 10:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbiL2Pui (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 29 Dec 2022 10:50:38 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C69B13F4F
        for <linux-serial@vger.kernel.org>; Thu, 29 Dec 2022 07:50:35 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id o15so13397621wmr.4
        for <linux-serial@vger.kernel.org>; Thu, 29 Dec 2022 07:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mxBRWEKdxDoxUmsf4m1Rf+wCWTOWa4yctJPkk6Ti6eA=;
        b=mAWTeny0sqvADkOky+spceEmg9syZ8nm2BawGZXoEyTRWH6pr2xqeTmQP6z3nF7ga4
         vJTk2fXB0ynr/dpSkhgIGH/AYtGa7mMVG+z0M/JjcThAmVF0p0wUVjpVmPj3lOfhTAU/
         1Dh/x3SgVJpZYdoD2JxwQb4be7nzV0WLkdsPScKFuwHreV9O5FsSUmYEHeonc8ncGQBL
         if+w7MFVFw/znWnPebEOCHBeErX1HH/SZZa+fqeAEu+TrfHwwvximtCfQSB0ZKsycRTx
         OjveQ4o2aMYzc0HaY5yF5E0kXS30j6QPurPra3G9a3fVSClCvTlbDvp8i1f+mElmsU84
         v3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mxBRWEKdxDoxUmsf4m1Rf+wCWTOWa4yctJPkk6Ti6eA=;
        b=CGBdldFIGJ2ouq1SLUtw3DAZA6uLKbaa+bsloeO1BgACygjgDHA1fcvKGlkP+yjlGP
         tvIsnkAllfhaLwTLO+rEwH24nNWVoXGzadOPSyMCDJXcwPSXEtQdwfo4z1lRkvU7fGWv
         BsEYde7hi1UCP/WmfVaZjXDvTJ82RyJ8UDgdm7Riw8s0YEMpaMkLp1SU90e18+08982T
         vm3XWJMXakf582sXofb1it/ST/txQ+26NdRgemgwVSJukaLfCEKmN6D1rmvmwKMj/FEH
         y8g3faJkeojzsHz1DEkRU9sy8K2AjeqaciiRo9BBUhCd+ev3QGeEUJKIxaI1M3z0clib
         1tPA==
X-Gm-Message-State: AFqh2kpMUUPSRm6ESVTNqgsUSHdAzAGt3LQCUzHLERgbzUlkRseFeI4J
        8K85yIoQc0uqtEb/i8HPFLyiug==
X-Google-Smtp-Source: AMrXdXt180PN5Ceh/nenWRord0+ZdJloEExn/Z1fAmgzdQZ3Flv/bOvzy0bNwEZKtBazgUjhZSX2hg==
X-Received: by 2002:a05:600c:1603:b0:3d1:c895:930c with SMTP id m3-20020a05600c160300b003d1c895930cmr20392802wmn.35.1672329033991;
        Thu, 29 Dec 2022 07:50:33 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:8f7a:98d8:9d8d:ced8])
        by smtp.gmail.com with ESMTPSA id bh12-20020a05600c3d0c00b003cfa81e2eb4sm25251647wmb.38.2022.12.29.07.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 07:50:33 -0800 (PST)
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
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v6 00/14] serial: qcom-geni-serial: implement support for SE DMA
Date:   Thu, 29 Dec 2022 16:50:16 +0100
Message-Id: <20221229155030.418800-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
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

The goal of this series is to update the qcom-geni-serial driver to use
the DMA mode of the QUPv3 serial engine. This is accomplished by the last
patch in the series. The previous ones contain either various tweaks,
reworks and refactoring or prepare the driver for adding DMA support.

More work will follow on the serial engine in order to reduce code
redundancy among its users and add support for SE DMA to the qcom GENI
SPI driver.

v5 -> v6:
- move patch 12/14 to the front of the series and mark it as a fix
- rebase on top of v6.2-rc1 (there were some updates to the driver)

v4 -> v5:
- split patch 8/13 into two: one for splitting out the chunk sending code
  and one for refactoring it (for easier review)
- when stopping uart: disable the irq first before stopping transfers in
  progress, otherwise we rist rescheduling additional transfers after
  interrupt
- make types even nore consistent in qcom_geni_serial_send_chunk_fifo()

v3 -> v4:
- don't assign NULL (even cast) to variables of type dma_addr_t
- refactor checking the SE_GENI_STATUS into two inline functions
- drop min_t() in favor of regular min() after adding some consistency to types
- check if the abort command was successful and emit a message if not when
  stopping TX in DMA mode

v2 -> v3:
- drop devres patches from the series

v1 -> v2:
- turn to_dev_uport() macro into a static inline function
- use CIRC_CNT_TO_END() and uart_xmit_advance() where applicable and don't
  handle xmit->tail directly
- drop sizeof() where BYTES_PER_FIFO_WORD can be used
- further refactor qcom_geni_serial_handle_tx_fifo()
- collect review tags

Bartosz Golaszewski (14):
  tty: serial: qcom-geni-serial: stop operations in progress at shutdown
  tty: serial: qcom-geni-serial: drop unneeded forward definitions
  tty: serial: qcom-geni-serial: remove unused symbols
  tty: serial: qcom-geni-serial: align #define values
  tty: serial: qcom-geni-serial: improve the to_dev_port() macro
  tty: serial: qcom-geni-serial: remove stray newlines
  tty: serial: qcom-geni-serial: refactor qcom_geni_serial_isr()
  tty: serial: qcom-geni-serial: remove unneeded tabs
  tty: serial: qcom-geni-serial: split out the FIFO tx code
  tty: serial: qcom-geni-serial: refactor
    qcom_geni_serial_send_chunk_fifo()
  tty: serial: qcom-geni-serial: drop the return value from handle_rx
  tty: serial: qcom-geni-serial: use of_device_id data
  soc: qcom-geni-se: add more symbol definitions
  tty: serial: qcom-geni-serial: add support for serial engine DMA

 drivers/tty/serial/qcom_geni_serial.c | 626 +++++++++++++++++---------
 include/linux/qcom-geni-se.h          |   3 +
 2 files changed, 413 insertions(+), 216 deletions(-)

-- 
2.37.2

