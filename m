Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB49BA83FC
	for <lists+linux-serial@lfdr.de>; Wed,  4 Sep 2019 15:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbfIDMy4 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 4 Sep 2019 08:54:56 -0400
Received: from wp498.webpack.hosteurope.de ([80.237.130.20]:46840 "EHLO
        wp498.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725965AbfIDMy4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 4 Sep 2019 08:54:56 -0400
X-Greylist: delayed 2250 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Sep 2019 08:54:56 EDT
Received: from p50937f79.dip0.t-ipconnect.de ([80.147.127.121] helo=ubuntu-VirtualBox.i.sigma-surface-science.com); authenticated
        by wp498.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        id 1i5UEh-0001JK-N9; Wed, 04 Sep 2019 14:18:07 +0200
From:   =?UTF-8?q?Christoph=20Vogtl=C3=A4nder?= 
        <c.vogtlaender@sigma-surface-science.com>
Cc:     =?UTF-8?q?Christoph=20Vogtl=C3=A4nder?= 
        <c.vogtlaender@sigma-surface-science.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] serial: max310x: turn off transmitter before activating AutoCTS or auto transmitter flow control
Date:   Wed,  4 Sep 2019 14:17:46 +0200
Message-Id: <20190904121746.4641-1-c.vogtlaender@sigma-surface-science.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20190904073022.GB9729@kroah.com>
References: <20190904073022.GB9729@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;c.vogtlaender@sigma-surface-science.com;1567601696;333f7ae9;
X-HE-SMSGID: 1i5UEh-0001JK-N9
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

As documented in the data-sheet, the transmitter must be disabled before
activating AutoCTS or auto transmitter flow control. Accordingly, the
transmitter must be enabled after AutoCTS or auto transmitter flow
control gets deactivated.

Signed-off-by: Christoph Vogtländer <c.vogtlaender@sigma-surface-science.com>
---
 drivers/tty/serial/max310x.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index fb5a7e0e58e9..adfef6dae4a7 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -860,6 +860,15 @@ static void max310x_set_termios(struct uart_port *port,
 	max310x_port_write(port, MAX310X_XON1_REG, termios->c_cc[VSTART]);
 	max310x_port_write(port, MAX310X_XOFF1_REG, termios->c_cc[VSTOP]);
 
+	/* Disable transmitter before enabling AutoCTS or auto transmitter
+	 * flow control
+	 */
+	if (termios->c_cflag & CRTSCTS || termios->c_iflag & IXOFF) {
+		max310x_port_update(port, MAX310X_MODE1_REG,
+				    MAX310X_MODE1_TXDIS_BIT,
+				    MAX310X_MODE1_TXDIS_BIT);
+	}
+
 	port->status &= ~(UPSTAT_AUTOCTS | UPSTAT_AUTORTS | UPSTAT_AUTOXOFF);
 
 	if (termios->c_cflag & CRTSCTS) {
@@ -878,6 +887,15 @@ static void max310x_set_termios(struct uart_port *port,
 	}
 	max310x_port_write(port, MAX310X_FLOWCTRL_REG, flow);
 
+	/* Enable transmitter after disabling AutoCTS and auto transmitter
+	 * flow control
+	 */
+	if (!(termios->c_cflag & CRTSCTS) && !(termios->c_iflag & IXOFF)) {
+		max310x_port_update(port, MAX310X_MODE1_REG,
+				    MAX310X_MODE1_TXDIS_BIT,
+				    0);
+	}
+
 	/* Get baud rate generator configuration */
 	baud = uart_get_baud_rate(port, termios, old,
 				  port->uartclk / 16 / 0xffff,
-- 
2.22.1

