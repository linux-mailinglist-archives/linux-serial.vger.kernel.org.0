Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2351DC980
	for <lists+linux-serial@lfdr.de>; Thu, 21 May 2020 11:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbgEUJMB (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 21 May 2020 05:12:01 -0400
Received: from mail.bugwerft.de ([46.23.86.59]:59118 "EHLO mail.bugwerft.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728761AbgEUJMA (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 May 2020 05:12:00 -0400
Received: from zenbar.fritz.box (pd95ef28a.dip0.t-ipconnect.de [217.94.242.138])
        by mail.bugwerft.de (Postfix) with ESMTPSA id 1DF19407CBA;
        Thu, 21 May 2020 09:09:00 +0000 (UTC)
From:   Daniel Mack <daniel@zonque.org>
To:     devicetree@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org, jslaby@suse.com,
        jringle@gridpoint.com, m.brock@vanmierlo.com,
        pascal.huerst@gmail.com, Daniel Mack <daniel@zonque.org>
Subject: [PATCH v3 0/6] sc16is7xx: IrDA mode and threaded IRQs
Date:   Thu, 21 May 2020 11:11:46 +0200
Message-Id: <20200521091152.404404-1-daniel@zonque.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This is v3 of the series.

v3:

 * Add my s-o-b to the first two patches

v2:

 * Change single bool properties into an array
   (suggested by Rob Herring)
 * Add a patch first try TRIGGER_LOW and SHARED interrupts, and then
   fall back to FALLING edge if the IRQ controller fails to provide the
   former (suggested by Maarten Brock)
 * Add a patch to check for the device presence

Daniel Mack (4):
  sc16is7xx: Always use falling edge IRQ
  sc16is7xx: Use threaded IRQ
  sc16is7xx: Allow sharing the IRQ line
  sc16is7xx: Read the LSR register for basic device presence check

Pascal Huerst (2):
  dt-bindings: sc16is7xx: Add flag to activate IrDA mode
  sc16is7xx: Add flag to activate IrDA mode

 .../bindings/serial/nxp,sc16is7xx.txt         |  4 +
 drivers/tty/serial/sc16is7xx.c                | 73 +++++++++++++------
 2 files changed, 56 insertions(+), 21 deletions(-)

-- 
2.26.2

