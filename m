Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E00CE6B5EA
	for <lists+linux-serial@lfdr.de>; Wed, 17 Jul 2019 07:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfGQF25 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 17 Jul 2019 01:28:57 -0400
Received: from inva020.nxp.com ([92.121.34.13]:60288 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbfGQF25 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 17 Jul 2019 01:28:57 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 547981A0319;
        Wed, 17 Jul 2019 07:28:56 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C29821A007D;
        Wed, 17 Jul 2019 07:28:52 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 26A75402E3;
        Wed, 17 Jul 2019 13:28:45 +0800 (SGT)
From:   fugang.duan@nxp.com
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, jslaby@suse.com, fugang.duan@nxp.com,
        u.kleine-koenig@pengutronix.de, festevam@gmail.com
Subject: [PATCH tty/serial 3/5] tty: serial: fsl_lpuart: use kzalloc() instead of kmalloc()
Date:   Wed, 17 Jul 2019 13:19:28 +0800
Message-Id: <20190717051930.15514-4-fugang.duan@nxp.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190717051930.15514-1-fugang.duan@nxp.com>
References: <20190717051930.15514-1-fugang.duan@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Fugang Duan <fugang.duan@nxp.com>

Use kzalloc() instead of kmalloc() to get clean rx buffer
that is useful for DMA mode debug to check the data moving
validity.

Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 7bc3047..746681b 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1097,7 +1097,7 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
 	if (sport->rx_dma_rng_buf_len < 16)
 		sport->rx_dma_rng_buf_len = 16;
 
-	ring->buf = kmalloc(sport->rx_dma_rng_buf_len, GFP_ATOMIC);
+	ring->buf = kzalloc(sport->rx_dma_rng_buf_len, GFP_ATOMIC);
 	if (!ring->buf)
 		return -ENOMEM;
 
-- 
2.7.4

