Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34051258E6F
	for <lists+linux-serial@lfdr.de>; Tue,  1 Sep 2020 14:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgIAMow (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 1 Sep 2020 08:44:52 -0400
Received: from mail.bugwerft.de ([46.23.86.59]:60422 "EHLO mail.bugwerft.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728143AbgIAMND (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 1 Sep 2020 08:13:03 -0400
X-Greylist: delayed 542 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Sep 2020 08:13:02 EDT
Received: from zenbar.fritz.box (p57bc9c6c.dip0.t-ipconnect.de [87.188.156.108])
        by mail.bugwerft.de (Postfix) with ESMTPSA id 506C04553E4;
        Tue,  1 Sep 2020 12:03:36 +0000 (UTC)
From:   Daniel Mack <daniel@zonque.org>
To:     linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        Daniel Mack <daniel@zonque.org>
Subject: [PATCH] sc16is7xx: Set iobase to device index
Date:   Tue,  1 Sep 2020 14:03:29 +0200
Message-Id: <20200901120329.4176302-1-daniel@zonque.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Some derivates of sc16is7xx devices expose more than one tty device to
userspace. If multiple such devices exist in a system, userspace
currently has no clean way to infer which tty maps to which physical
line.

Set the .iobase value to the relative index within the device to allow
infering the order through sysfs.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 drivers/tty/serial/sc16is7xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index d2e5c6c866439..a3085b90e2023 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1272,6 +1272,7 @@ static int sc16is7xx_probe(struct device *dev,
 		s->p[i].port.type	= PORT_SC16IS7XX;
 		s->p[i].port.fifosize	= SC16IS7XX_FIFO_SIZE;
 		s->p[i].port.flags	= UPF_FIXED_TYPE | UPF_LOW_LATENCY;
+		s->p[i].port.iobase	= i;
 		s->p[i].port.iotype	= UPIO_PORT;
 		s->p[i].port.uartclk	= freq;
 		s->p[i].port.rs485_config = sc16is7xx_config_rs485;
-- 
2.26.2

