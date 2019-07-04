Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5180F5F654
	for <lists+linux-serial@lfdr.de>; Thu,  4 Jul 2019 12:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfGDKJ1 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 4 Jul 2019 06:09:27 -0400
Received: from inva021.nxp.com ([92.121.34.21]:47144 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727249AbfGDKJ1 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 4 Jul 2019 06:09:27 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 17F652005A0;
        Thu,  4 Jul 2019 12:09:26 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9C8E820059E;
        Thu,  4 Jul 2019 12:09:22 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 07392402C0;
        Thu,  4 Jul 2019 18:09:17 +0800 (SGT)
From:   fugang.duan@nxp.com
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, jslaby@suse.com, fugang.duan@nxp.com,
        u.kleine-koenig@pengutronix.de, daniel.baluta@nxp.com
Subject: [PATCH tty/serial 0/2] tty: serial: fsl_lpuart: add imx8qxp support
Date:   Thu,  4 Jul 2019 18:00:19 +0800
Message-Id: <20190704100021.10859-1-fugang.duan@nxp.com>
X-Mailer: git-send-email 2.14.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Fugang Duan <fugang.duan@nxp.com>

The two patches are to add imx8qxp lpuart support and add required clocks for
binding documentation.

Fugang Duan (2):
  tty: serial: fsl_lpuart: add imx8qxp support
  dt-bindings: serial: lpuart: add the clock requirement for imx8qxp

 .../devicetree/bindings/serial/fsl-lpuart.txt      |   5 +-
 drivers/tty/serial/fsl_lpuart.c                    | 106 +++++++++++++++++----
 2 files changed, 90 insertions(+), 21 deletions(-)

-- 
2.7.4

