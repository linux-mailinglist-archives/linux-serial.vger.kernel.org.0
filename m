Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA1F3A83FE
	for <lists+linux-serial@lfdr.de>; Wed,  4 Sep 2019 15:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730185AbfIDMy7 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 4 Sep 2019 08:54:59 -0400
Received: from wp498.webpack.hosteurope.de ([80.237.130.20]:46938 "EHLO
        wp498.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725965AbfIDMy7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 4 Sep 2019 08:54:59 -0400
Received: from p50937f79.dip0.t-ipconnect.de ([80.147.127.121] helo=ubuntu-VirtualBox.i.sigma-surface-science.com); authenticated
        by wp498.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        id 1i5UDv-00012K-Ss; Wed, 04 Sep 2019 14:17:19 +0200
From:   =?UTF-8?q?Christoph=20Vogtl=C3=A4nder?= 
        <c.vogtlaender@sigma-surface-science.com>
Cc:     c.vogtlaender@sigma-surface-science.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] serial: max310x: Properly set flags in AutoCTS mode
Date:   Wed,  4 Sep 2019 14:11:41 +0200
Message-Id: <20190904121141.4570-1-c.vogtlaender@sigma-surface-science.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20190904073009.GA9729@kroah.com>
References: <20190904073009.GA9729@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;c.vogtlaender@sigma-surface-science.com;1567601698;785e2d79;
X-HE-SMSGID: 1i5UDv-00012K-Ss
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Commit 391f93f2ec9f ("serial: core: Rework hw-assisted flow control
support") has changed the way the AutoCTS mode is handled.

According to that change, serial drivers which enable H/W AutoCTS mode must
set UPSTAT_AUTORTS, UPSTAT_AUTOCTS and UPSTAT_AUTOXOFF to prevent the
serial core from inadvertently disabling RX or TX. This patch adds proper
handling of UPSTAT_AUTORTS, UPSTAT_AUTOCTS and UPSTAT_AUTOXOFF flags.

Signed-off-by: Christoph Vogtländer <c.vogtlaender@sigma-surface-science.com>
---
 drivers/tty/serial/max310x.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 0e24235..fb5a7e0 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -859,15 +859,23 @@ static void max310x_set_termios(struct uart_port *port,
 	/* Configure flow control */
 	max310x_port_write(port, MAX310X_XON1_REG, termios->c_cc[VSTART]);
 	max310x_port_write(port, MAX310X_XOFF1_REG, termios->c_cc[VSTOP]);
-	if (termios->c_cflag & CRTSCTS)
+
+	port->status &= ~(UPSTAT_AUTOCTS | UPSTAT_AUTORTS | UPSTAT_AUTOXOFF);
+
+	if (termios->c_cflag & CRTSCTS) {
+		/* Enable AUTORTS and AUTOCTS */
+		port->status |= UPSTAT_AUTOCTS | UPSTAT_AUTORTS;
 		flow |= MAX310X_FLOWCTRL_AUTOCTS_BIT |
 			MAX310X_FLOWCTRL_AUTORTS_BIT;
+	}
 	if (termios->c_iflag & IXON)
 		flow |= MAX310X_FLOWCTRL_SWFLOW3_BIT |
 			MAX310X_FLOWCTRL_SWFLOWEN_BIT;
-	if (termios->c_iflag & IXOFF)
+	if (termios->c_iflag & IXOFF) {
+		port->status |= UPSTAT_AUTOXOFF;
 		flow |= MAX310X_FLOWCTRL_SWFLOW1_BIT |
 			MAX310X_FLOWCTRL_SWFLOWEN_BIT;
+	}
 	max310x_port_write(port, MAX310X_FLOWCTRL_REG, flow);
 
 	/* Get baud rate generator configuration */
-- 
2.7.4

