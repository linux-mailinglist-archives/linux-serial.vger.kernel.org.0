Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E113E2ADD9
	for <lists+linux-serial@lfdr.de>; Mon, 27 May 2019 07:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbfE0FC3 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 27 May 2019 01:02:29 -0400
Received: from mx.socionext.com ([202.248.49.38]:48343 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbfE0FC2 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 May 2019 01:02:28 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 27 May 2019 14:02:26 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id C848818010A;
        Mon, 27 May 2019 14:02:26 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 27 May 2019 14:02:26 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 4956E1A04FC;
        Mon, 27 May 2019 14:02:26 +0900 (JST)
Received: from M20VSDK.e01.socionext.com (unknown [10.213.118.34])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 0A229120ABF;
        Mon, 27 May 2019 14:02:26 +0900 (JST)
From:   Sugaya Taichi <sugaya.taichi@socionext.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Sugaya Taichi <sugaya.taichi@socionext.com>
Subject: [PATCH] serial: Fix an invalid comparing statement
Date:   Mon, 27 May 2019 14:01:27 +0900
Message-Id: <1558933288-30023-1-git-send-email-sugaya.taichi@socionext.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Drop the if-statement which refers to 8th bit field of u8 variable.
The bit field is no longer used.

Fixes: ba44dc043004 ("serial: Add Milbeaut serial control")
Reported-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
---
 drivers/tty/serial/milbeaut_usio.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/milbeaut_usio.c b/drivers/tty/serial/milbeaut_usio.c
index 949ab7e..d7207ab 100644
--- a/drivers/tty/serial/milbeaut_usio.c
+++ b/drivers/tty/serial/milbeaut_usio.c
@@ -56,7 +56,6 @@
 #define MLB_USIO_SSR_FRE		BIT(4)
 #define MLB_USIO_SSR_PE			BIT(5)
 #define MLB_USIO_SSR_REC		BIT(7)
-#define MLB_USIO_SSR_BRK		BIT(8)
 #define MLB_USIO_FCR_FE1		BIT(0)
 #define MLB_USIO_FCR_FE2		BIT(1)
 #define MLB_USIO_FCR_FCL1		BIT(2)
@@ -180,18 +179,14 @@ static void mlb_usio_rx_chars(struct uart_port *port)
 		if (status & MLB_USIO_SSR_ORE)
 			port->icount.overrun++;
 		status &= port->read_status_mask;
-		if (status & MLB_USIO_SSR_BRK) {
-			flag = TTY_BREAK;
+		if (status & MLB_USIO_SSR_PE) {
+			flag = TTY_PARITY;
 			ch = 0;
 		} else
-			if (status & MLB_USIO_SSR_PE) {
-				flag = TTY_PARITY;
+			if (status & MLB_USIO_SSR_FRE) {
+				flag = TTY_FRAME;
 				ch = 0;
-			} else
-				if (status & MLB_USIO_SSR_FRE) {
-					flag = TTY_FRAME;
-					ch = 0;
-				}
+			}
 		if (flag)
 			uart_insert_char(port, status, MLB_USIO_SSR_ORE,
 					 ch, flag);
-- 
1.9.1

