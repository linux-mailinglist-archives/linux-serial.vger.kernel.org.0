Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED9B5666D
	for <lists+linux-serial@lfdr.de>; Wed, 26 Jun 2019 12:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbfFZKQW (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 26 Jun 2019 06:16:22 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52631 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfFZKQV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 26 Jun 2019 06:16:21 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1hg4yC-00076d-5r; Wed, 26 Jun 2019 12:16:04 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1hg4y7-0006s2-BF; Wed, 26 Jun 2019 12:15:59 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-serial@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sergey Organov <sorganov@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 0/2] serial: imx: use UPF_AUTO_CTS
Date:   Wed, 26 Jun 2019 12:15:55 +0200
Message-Id: <20190626101557.26299-1-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This series eliminates a duplicate call to uart_handle_cts_change() and
sets the UPF_AUTO_CTS flag for the i.MX UART driver.

Normally setting the UPF_AUTO_CTS flag should only be a little
optimization as the transmitter is no longer enabled/disabled with every
CTS change, here it fixes an issue which initially brought me to
implement this patch. I am working on uploading a firmware to a Marvell
bluetooth chip. During download it often happened that a CTS interrupt
was lost and the upload stalled forever. This patch fixes the issue
(without knowing why we lost CTS interrupts in the first place)

This series is based on Sergei Shtylyovs series "serial: imx: fix RTS
and RTS/CTS handling" and should be applied ontop of it.

Sascha Hauer (2):
  serial: imx: remove duplicate handling of CTS change
  serial: imx: use UPF_AUTO_CTS

 drivers/tty/serial/imx.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

-- 
2.20.1

