Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69ED23CC6C
	for <lists+linux-serial@lfdr.de>; Tue, 11 Jun 2019 15:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389992AbfFKNDp (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 11 Jun 2019 09:03:45 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34947 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389960AbfFKNDn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 11 Jun 2019 09:03:43 -0400
Received: by mail-qt1-f193.google.com with SMTP id d23so14379632qto.2
        for <linux-serial@vger.kernel.org>; Tue, 11 Jun 2019 06:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=faQE88ujE/76yz0sq08P7FI2LyFdXUQaK/KufiaD+SU=;
        b=cawsFIlCK7ZP/gb1qhdOLy+VvbLAUirZ5VY0AxSfLFdwJWC25HYG4ZeZ+ylKgc1Ct3
         Z9dkKldGWJfejH+leIR7r0CvMRMA8V43uv8sej3mFk/ZTmBrgmh0nPTJOq3Z77XMN2mx
         ST32IcKCXz1/7K3UENEOCLtCGmhHGSYwYEKFU/UNSkWzImBNp2/4mQGz5OikxIeGKp90
         3mCJpdlVMpbzRjJMCgYTNp5WuqStq6rqWeNKljfxM1XTNFs/EPNckVRMHI8lh5ZD+gC0
         p92eX1GKwzJyyoDzvvFedcSRDJSDPr+mnoiXNuWT7OvH5e73BSlfA7NfghLBQZQK/cGU
         DNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=faQE88ujE/76yz0sq08P7FI2LyFdXUQaK/KufiaD+SU=;
        b=NL1xUFpWO5NwjmCx2/L59LP1JGWPDX9e/SEJZHGJK+9umN6xsCmkrF2AlM7VzHP7FY
         xvsLtuDmRIFRNHrv+FUFGI+0CAeVuTF/eBFBONYt+ql3A+0kWXiaqpa9RvQCYzEQCYGe
         bhbULQJlaY/v8/Ise/pidwic3L0fOQMuRMTSxna1fAWbexpBWxguU9fAdaYVkzfl759X
         h9fNDChJk5w5OY+T6hnUIszi5nb9SAgMaKHMQtsA5i663hl6acK6nWTfMNIm+CnlpxJ0
         3SwG+vijjisYB/T/VuA2po5Jqfl8aenKiiYbK8pR7ceTjV/1huDdIjK8AC3WTPPuacpz
         IP1w==
X-Gm-Message-State: APjAAAXE5WVJdncQvSG6cNIBFcCvkSjd4TbIu7yFCJ2MX7ZkVdfhDTQq
        8Pa+uy7BIjNSVfWfwk0e5Zc=
X-Google-Smtp-Source: APXvYqzBC7R4iU1Iv8Xeno4VxpNMTweJASTkrFN+VLgJ6hQRxAggVHTeLOeErpIxqRpiAEdkjKokzA==
X-Received: by 2002:a0c:ee49:: with SMTP id m9mr2933207qvs.217.1560258222141;
        Tue, 11 Jun 2019 06:03:42 -0700 (PDT)
Received: from fabio-Latitude-E5450.nxp.com ([177.221.114.206])
        by smtp.gmail.com with ESMTPSA id l94sm6414920qte.48.2019.06.11.06.03.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 06:03:41 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] serial: fsl_lpuart: Remove unneeded OOM error message
Date:   Tue, 11 Jun 2019 10:03:39 -0300
Message-Id: <20190611130339.11674-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

There is no need to add an out-of-memory error message inside
the driver because the core MM code will take care of it.

Remove the unneeded OOM error message.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/tty/serial/fsl_lpuart.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index da6e918df4e7..28a365c7c373 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1040,10 +1040,8 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
 		sport->rx_dma_rng_buf_len = 16;
 
 	ring->buf = kmalloc(sport->rx_dma_rng_buf_len, GFP_ATOMIC);
-	if (!ring->buf) {
-		dev_err(sport->port.dev, "Ring buf alloc failed\n");
+	if (!ring->buf)
 		return -ENOMEM;
-	}
 
 	sg_init_one(&sport->rx_sgl, ring->buf, sport->rx_dma_rng_buf_len);
 	sg_set_buf(&sport->rx_sgl, ring->buf, sport->rx_dma_rng_buf_len);
-- 
2.17.1

