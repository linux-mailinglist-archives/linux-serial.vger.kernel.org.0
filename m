Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1AAE6B5E7
	for <lists+linux-serial@lfdr.de>; Wed, 17 Jul 2019 07:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfGQF2x (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 17 Jul 2019 01:28:53 -0400
Received: from inva020.nxp.com ([92.121.34.13]:60160 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbfGQF2x (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 17 Jul 2019 01:28:53 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D04351A0319;
        Wed, 17 Jul 2019 07:28:51 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4A3BD1A031D;
        Wed, 17 Jul 2019 07:28:48 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 8D864402C3;
        Wed, 17 Jul 2019 13:28:43 +0800 (SGT)
From:   fugang.duan@nxp.com
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, jslaby@suse.com, fugang.duan@nxp.com,
        u.kleine-koenig@pengutronix.de, festevam@gmail.com
Subject: [PATCH tty/serial 1/5] tty: serial: fsl_lpuart: remove the dev.coherent_dma_mask zero setting
Date:   Wed, 17 Jul 2019 13:19:26 +0800
Message-Id: <20190717051930.15514-2-fugang.duan@nxp.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190717051930.15514-1-fugang.duan@nxp.com>
References: <20190717051930.15514-1-fugang.duan@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Fugang Duan <fugang.duan@nxp.com>

By default, .of_dma_configure() init dev.coherent_dma_mask to BIT(32) that
match the eDMA address range. If re-init dev.coherent_dma_mask to zero, then
streaming dma mapping will go swiotlb dma_map, if swiotlb is not initalized
then it causes mapping failed.

Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 92dad2b..b856d1d 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2320,8 +2320,6 @@ static int lpuart_probe(struct platform_device *pdev)
 	if (!sport)
 		return -ENOMEM;
 
-	pdev->dev.coherent_dma_mask = 0;
-
 	ret = of_alias_get_id(np, "serial");
 	if (ret < 0) {
 		ret = ida_simple_get(&fsl_lpuart_ida, 0, UART_NR, GFP_KERNEL);
-- 
2.7.4

