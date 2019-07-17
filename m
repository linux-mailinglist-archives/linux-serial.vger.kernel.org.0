Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71EC56B5E9
	for <lists+linux-serial@lfdr.de>; Wed, 17 Jul 2019 07:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfGQF25 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 17 Jul 2019 01:28:57 -0400
Received: from inva020.nxp.com ([92.121.34.13]:60312 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbfGQF25 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 17 Jul 2019 01:28:57 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8EAFE1A007D;
        Wed, 17 Jul 2019 07:28:56 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 098681A0317;
        Wed, 17 Jul 2019 07:28:53 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id E6633402E7;
        Wed, 17 Jul 2019 13:28:45 +0800 (SGT)
From:   fugang.duan@nxp.com
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, jslaby@suse.com, fugang.duan@nxp.com,
        u.kleine-koenig@pengutronix.de, festevam@gmail.com
Subject: [PATCH tty/serial 4/5] tty: serial: fsl_lpuart: remove sg_set_buf() for sport->rx_sgl
Date:   Wed, 17 Jul 2019 13:19:29 +0800
Message-Id: <20190717051930.15514-5-fugang.duan@nxp.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190717051930.15514-1-fugang.duan@nxp.com>
References: <20190717051930.15514-1-fugang.duan@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Fugang Duan <fugang.duan@nxp.com>

Since .sg_init_one() already set sg entry page like below code.
	sg_init_one()
		sg_init_table(sg, 1);
		sg_set_buf(sg, buf, buflen);

So it should not set sg entry page again, remove the redundant code.

Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 746681b..ba87b58 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1102,7 +1102,6 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
 		return -ENOMEM;
 
 	sg_init_one(&sport->rx_sgl, ring->buf, sport->rx_dma_rng_buf_len);
-	sg_set_buf(&sport->rx_sgl, ring->buf, sport->rx_dma_rng_buf_len);
 	nent = dma_map_sg(sport->port.dev, &sport->rx_sgl, 1, DMA_FROM_DEVICE);
 
 	if (!nent) {
-- 
2.7.4

