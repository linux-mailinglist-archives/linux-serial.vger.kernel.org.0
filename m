Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 328DE1E1D7E
	for <lists+linux-serial@lfdr.de>; Tue, 26 May 2020 10:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgEZIkM (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 26 May 2020 04:40:12 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:52519 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbgEZIkM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 26 May 2020 04:40:12 -0400
Received: from localhost (50-39-163-217.bvtn.or.frontiernet.net [50.39.163.217])
        (Authenticated sender: josh@joshtriplett.org)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id B48AF200007;
        Tue, 26 May 2020 08:40:08 +0000 (UTC)
Date:   Tue, 26 May 2020 01:40:06 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] serial: 8250: Enable 16550A variants by default on non-x86
Message-ID: <d32bdbf9fed2719c1180228464ba84dfcdeb5aa5.1590482037.git.josh@joshtriplett.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Some embedded devices still use these serial ports; make sure they're
still enabled by default on architectures more likely to have them, to
avoid rendering someone's console unavailable.

Fixes: dc56ecb81a0a ("serial: 8250: Support disabling mdelay-filled probes of 16550A variants")
Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---

Based on user reports from embedded devices that need these variants.

 drivers/tty/serial/8250/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index af0688156dd0..8195a31519ea 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -63,6 +63,7 @@ config SERIAL_8250_PNP
 config SERIAL_8250_16550A_VARIANTS
 	bool "Support for variants of the 16550A serial port"
 	depends on SERIAL_8250
+	default !X86
 	help
 	  The 8250 driver can probe for many variants of the venerable 16550A
 	  serial port. Doing so takes additional time at boot.
-- 
2.27.0.rc0

