Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 905132FF7C
	for <lists+linux-serial@lfdr.de>; Thu, 30 May 2019 17:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfE3PgF (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 30 May 2019 11:36:05 -0400
Received: from mail.javad.com ([54.86.164.124]:59866 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbfE3PgF (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 30 May 2019 11:36:05 -0400
X-Greylist: delayed 354 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 May 2019 11:36:04 EDT
Received: from localhost6.localdomain6 (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 29C005453C;
        Thu, 30 May 2019 15:30:08 +0000 (UTC)
Authentication-Results: ip-172-31-2-110;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@gnss.ru smtp.helo=localhost6.localdomain6
Received-SPF: pass (ip-172-31-2-110: connection is authenticated)
Received: from localhost6.localdomain6 (localhost.localdomain [127.0.0.1])
        by localhost6.localdomain6 (8.14.4/8.14.4) with ESMTP id x4UFU6q6025921;
        Thu, 30 May 2019 18:30:06 +0300
Received: (from osv@localhost)
        by localhost6.localdomain6 (8.14.4/8.14.4/Submit) id x4UFU6N9025917;
        Thu, 30 May 2019 18:30:06 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Shawn Guo <shawnguo@kernel.org>, linux-serial@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 1/8] serial: imx: fix DTR inversion
Date:   Thu, 30 May 2019 18:29:43 +0300
Message-Id: <20190530152950.25377-2-sorganov@gmail.com>
X-Mailer: git-send-email 2.10.0.1.g57b01a3
In-Reply-To: <20190530152950.25377-1-sorganov@gmail.com>
References: <20190530152950.25377-1-sorganov@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

imx_set_mctrl() had TIOCM_DTR meaning inverted

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 drivers/tty/serial/imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index dff75dc..e9e812a 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -974,7 +974,7 @@ static void imx_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	}
 
 	ucr3 = imx_uart_readl(sport, UCR3) & ~UCR3_DSR;
-	if (!(mctrl & TIOCM_DTR))
+	if (mctrl & TIOCM_DTR)
 		ucr3 |= UCR3_DSR;
 	imx_uart_writel(sport, ucr3, UCR3);
 
-- 
2.10.0.1.g57b01a3

