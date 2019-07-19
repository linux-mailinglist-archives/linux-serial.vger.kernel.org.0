Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA3D16E687
	for <lists+linux-serial@lfdr.de>; Fri, 19 Jul 2019 15:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfGSNfl (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 19 Jul 2019 09:35:41 -0400
Received: from foss.arm.com ([217.140.110.172]:43478 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728542AbfGSNfl (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 19 Jul 2019 09:35:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD6E0337;
        Fri, 19 Jul 2019 06:35:40 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A61FC3F71A;
        Fri, 19 Jul 2019 06:35:39 -0700 (PDT)
From:   Dave Martin <Dave.Martin@arm.com>
To:     linux-serial@vger.kernel.org
Cc:     Russell King <linux@arm.linux.org.uk>,
        Phil Elwell <phil@raspberrypi.org>,
        Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        linux-rpi-kernel@lists.infradead.org
Subject: [RFC PATCH 0/2] serial: pl011: Fix TX dropping race
Date:   Fri, 19 Jul 2019 14:35:23 +0100
Message-Id: <1563543325-12463-1-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

When serial_core pushes some new TX chars via a call to
pl011_start_tx(), it can race with irqs triggered by ongoing
transmission, overfilling the FIFO and causing characters to be silently
dropped.

This was originally reported by Phil Elwell [1], who proposed an initial
fix.

This series aims for a simpler and more robust solution to the problem.

Any testing much appreciated!  If all looks good, I can repost this on
v5.3-rc1 when that arrives.


As noted in the patches, I'm not sure that the second patch is necessary
(or even desirable).  Please test both with and without the second
patch, and please comment if you have any thoughts on it :)


[1] [PATCH] tty: amba-pl011: Make TX optimisation conditional
http://lists.infradead.org/pipermail/linux-rpi-kernel/2019-July/008832.html


Dave Martin (2):
  serial: pl011: Fix dropping of TX chars due to irq race
  serial: pl011: Don't bother pushing more TX data while TX irq is
    active

 drivers/tty/serial/amba-pl011.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

-- 
2.1.4

