Return-Path: <linux-serial+bounces-202-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7E57F73BC
	for <lists+linux-serial@lfdr.de>; Fri, 24 Nov 2023 13:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A692B213E4
	for <lists+linux-serial@lfdr.de>; Fri, 24 Nov 2023 12:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469B72031B;
	Fri, 24 Nov 2023 12:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-serial@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2411D43
	for <linux-serial@vger.kernel.org>; Fri, 24 Nov 2023 04:24:55 -0800 (PST)
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 3AOCN5bb035990;
	Fri, 24 Nov 2023 20:23:05 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4ScDWm2myJz2K25CP;
	Fri, 24 Nov 2023 20:17:40 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 24 Nov 2023 20:23:03 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <ilpo.jarvinen@linux.intel.com>, <tony@atomide.com>,
        <john.ogness@linutronix.de>
CC: <tglx@linutronix.de>, <andriy.shevchenko@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <ke.wang@unisoc.com>, <xuewen.yan94@gmail.com>
Subject: [RFC PATCH] serial: core: Use pm_runtime_get_sync() in uart_start()
Date: Fri, 24 Nov 2023 20:22:58 +0800
Message-ID: <20231124122258.1050-1-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 3AOCN5bb035990

The commit 84a9582fd203("serial: core: Start managing serial controllers to enable runtime PM")
use the pm_runtime_get() after uart_port_lock() which would close the irq and disable preement.
At this time,  pm_runtime_get may cause the following two problems:

(1) deadlock in try_to_wake_up:

uart_write()
uart_port_lock() <<< get lock
__uart_start
__pm_runtime_resume
rpm_resume
queue_work_on
try_to_wake_up
_printk
uart_console_write
...
uart_port_lock() <<< wait forever

(2) scheduling while atomic:
uart_write()
uart_port_lock() <<< get lock
__uart_start
__pm_runtime_resume
rpm_resume
chedule() << sleep

So let us use pm_runtime_get_sync() to prevent these.

Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
 drivers/tty/serial/serial_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index f1348a509552..902f7ed35f4d 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -145,7 +145,7 @@ static void __uart_start(struct uart_state *state)
 	port_dev = port->port_dev;
 
 	/* Increment the runtime PM usage count for the active check below */
-	err = pm_runtime_get(&port_dev->dev);
+	err = pm_runtime_get_sync(&port_dev->dev);
 	if (err < 0 && err != -EINPROGRESS) {
 		pm_runtime_put_noidle(&port_dev->dev);
 		return;
@@ -159,7 +159,7 @@ static void __uart_start(struct uart_state *state)
 	if (!pm_runtime_enabled(port->dev) || pm_runtime_active(port->dev))
 		port->ops->start_tx(port);
 	pm_runtime_mark_last_busy(&port_dev->dev);
-	pm_runtime_put_autosuspend(&port_dev->dev);
+	pm_runtime_put_sync_autosuspend(&port_dev->dev);
 }
 
 static void uart_start(struct tty_struct *tty)
-- 
2.25.1


