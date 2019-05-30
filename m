Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 898482FF7F
	for <lists+linux-serial@lfdr.de>; Thu, 30 May 2019 17:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfE3PgF (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 30 May 2019 11:36:05 -0400
Received: from mail.javad.com ([54.86.164.124]:59862 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbfE3PgF (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 30 May 2019 11:36:05 -0400
Received: from localhost6.localdomain6 (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 2306B5453B;
        Thu, 30 May 2019 15:30:08 +0000 (UTC)
Authentication-Results: ip-172-31-2-110;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@gnss.ru smtp.helo=localhost6.localdomain6
Received-SPF: pass (ip-172-31-2-110: connection is authenticated)
Received: from localhost6.localdomain6 (localhost.localdomain [127.0.0.1])
        by localhost6.localdomain6 (8.14.4/8.14.4) with ESMTP id x4UFU6pN025859;
        Thu, 30 May 2019 18:30:06 +0300
Received: (from osv@localhost)
        by localhost6.localdomain6 (8.14.4/8.14.4/Submit) id x4UFU60a025829;
        Thu, 30 May 2019 18:30:06 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Shawn Guo <shawnguo@kernel.org>, linux-serial@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 0/8] Serial: imx: various fixes
Date:   Thu, 30 May 2019 18:29:42 +0300
Message-Id: <20190530152950.25377-1-sorganov@gmail.com>
X-Mailer: git-send-email 2.10.0.1.g57b01a3
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

WARNING: conditionally tested patches, -- see CAVEAT below for
details.

The original problem that caused these changes was broken bytes being
sent/received at random on RTS/CTS handshake switch (i.e., on
setting/clearing termios CRTSCTS bit).

As it went, a few other problems were found and fixed, and then the
fix for original issue has been split into multiple patches that seem
to make sense by themselves. Thus, the "serial: imx: fix data breakage
on termios change", that finally fixes the issue, depends on 2
preceding patches.

The last patch in the series, "serial: imx: use Tx ready rather than
Tx empty irq" is independent of the rest and doesn't fix any serious
issue, but it should get rid of holes in continuous output,
specifically in PIO mode.

CAVEAT:

Originally, patches have been tested (and are still in use) on a board
based on iMX6SX ARM chip, but they are made on top of 4.9.146 Linux
kernel with 'imx_4.9.11_1.0.0_ga' branch of 'linux-imx' (imx vendor)
repo merged in, to be able to run on actual hardware (bare 4.9.x Linux
panics on iMX6SX).

These series is that original set rebased on top of mainstream Linux
v5.1, and the result has only been checked to compile, i.e., no run
tests were performed, as I can't run any mainstream Linux on my board.

I also have similar series on top of mainstream v4.9.146, if that's
more appropriate. However, those series have 1 more patch, that
happenes to match one that's already included in v5.1.

Sergey Organov (8):
  serial: imx: fix DTR inversion
  serial: imx: fix breaking RTS/CTS handshake by mctrl change
  serial: imx: preserve RTS state over termios change
  serial: imx: get rid of unbounded busy-waiting loop
  serial: imx: do not stop Rx/Tx on termios change
  serial: imx: do not disable individual irqs during termios change
  serial: imx: fix data breakage on termios change
  serial: imx: use Tx ready rather than Tx empty irq

 drivers/tty/serial/imx.c | 68 +++++++++++++++++++++++-------------------------
 1 file changed, 32 insertions(+), 36 deletions(-)

-- 
2.10.0.1.g57b01a3

