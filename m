Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1FCB1D6DB0
	for <lists+linux-serial@lfdr.de>; Sun, 17 May 2020 23:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgEQV4e (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sun, 17 May 2020 17:56:34 -0400
Received: from gloria.sntech.de ([185.11.138.130]:45124 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbgEQV4e (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 17 May 2020 17:56:34 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.sntech)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jaRGf-0002am-Os; Sun, 17 May 2020 23:56:21 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     gregkh@linuxfoundation.org
Cc:     jslaby@suse.com, andriy.shevchenko@linux.intel.com,
        matwey.kornilov@gmail.com, giulio.benetti@micronovasrl.com,
        lukas@wunner.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com, heiko@sntech.de,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: [PATCH v3 5/5] serial: 8250_dw: add em485 support
Date:   Sun, 17 May 2020 23:56:10 +0200
Message-Id: <20200517215610.2131618-6-heiko@sntech.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200517215610.2131618-1-heiko@sntech.de>
References: <20200517215610.2131618-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Giulio Benetti <giulio.benetti@micronovasrl.com>

Need to use rs485 transceiver so let's use existing em485 485 emulation
layer on top of 8250.

Add rs485_config callback to port and uses the standard em485 start and
stop helpers.

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
[moved to use newly added start/stop helpers]
Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
---
 drivers/tty/serial/8250/8250_dw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 51a7d3b19b39..36d364268a45 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -415,6 +415,9 @@ static int dw8250_probe(struct platform_device *pdev)
 	p->serial_out	= dw8250_serial_out;
 	p->set_ldisc	= dw8250_set_ldisc;
 	p->set_termios	= dw8250_set_termios;
+	p->rs485_config = serial8250_em485_config;
+	up->rs485_start_tx = serial8250_em485_start_tx;
+	up->rs485_stop_tx = serial8250_em485_stop_tx;
 
 	p->membase = devm_ioremap(dev, regs->start, resource_size(regs));
 	if (!p->membase)
-- 
2.25.1

