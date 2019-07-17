Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 819036B5E6
	for <lists+linux-serial@lfdr.de>; Wed, 17 Jul 2019 07:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfGQF2w (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 17 Jul 2019 01:28:52 -0400
Received: from inva021.nxp.com ([92.121.34.21]:34606 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbfGQF2w (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 17 Jul 2019 01:28:52 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0E85420034B;
        Wed, 17 Jul 2019 07:28:51 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7D5C820023F;
        Wed, 17 Jul 2019 07:28:47 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id C16F3402B5;
        Wed, 17 Jul 2019 13:28:42 +0800 (SGT)
From:   fugang.duan@nxp.com
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, jslaby@suse.com, fugang.duan@nxp.com,
        u.kleine-koenig@pengutronix.de, festevam@gmail.com
Subject: [PATCH tty/serial 0/5] tty: serial: fsl_lpuart: code clean up and bugfix
Date:   Wed, 17 Jul 2019 13:19:25 +0800
Message-Id: <20190717051930.15514-1-fugang.duan@nxp.com>
X-Mailer: git-send-email 2.9.5
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Fugang Duan <fugang.duan@nxp.com>

The patch set is to clean up the code and fix some minor issues.
There have no function change except the patch "tty: serial: fsl_lpuart:
add earlycon for imx8qxp platform" add earlycon support for imx8qxp platform.

Fugang Duan (5):
  tty: serial: fsl_lpuart: remove the dev.coherent_dma_mask zero setting
  tty: serial: fsl_lpuart: add earlycon for imx8qxp platform
  tty: serial: fsl_lpuart: use kzalloc() instead of kmalloc()
  tty: serial: fsl_lpuart: remove sg_set_buf() for sport->rx_sgl
  tty: serial: fsl_lpuart: correct the FIFO depth size

 drivers/tty/serial/fsl_lpuart.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

-- 
2.7.4

