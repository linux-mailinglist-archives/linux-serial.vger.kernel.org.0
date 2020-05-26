Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F69F1CB224
	for <lists+linux-serial@lfdr.de>; Fri,  8 May 2020 16:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgEHOni (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 8 May 2020 10:43:38 -0400
Received: from mail.bugwerft.de ([46.23.86.59]:53196 "EHLO mail.bugwerft.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727893AbgEHOnh (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 8 May 2020 10:43:37 -0400
Received: from zenbar.fritz.box (pD95EF03D.dip0.t-ipconnect.de [217.94.240.61])
        by mail.bugwerft.de (Postfix) with ESMTPSA id 90B8440646E;
        Fri,  8 May 2020 14:35:21 +0000 (UTC)
From:   Daniel Mack <daniel@zonque.org>
To:     devicetree@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org, jslaby@suse.com,
        pascal.huerst@gmail.com, Daniel Mack <daniel@zonque.org>
Subject: [PATCH 0/4] sc16is7xx: Add IrDA mode and threaded IRQ
Date:   Fri,  8 May 2020 16:37:53 +0200
Message-Id: <20200508143757.2609740-1-daniel@zonque.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Here are some simple patches to add an IrDA mode to the sc16is7xx
spi/i2c serial UART bridge driver, and to switch to a threaded
IRQ handler. The 4th patch enables falling edge IRQ triggers for
DT enabled setups as well.

Daniel Mack (2):
  sc16is7xx: Always use falling edge IRQ
  sc16is7xx: Use threaded IRQ

Pascal Huerst (2):
  dt-bindings: sc16is7xx: Add flag to activate IrDA mode
  sc16is7xx: Add flag to activate IrDA mode

 .../bindings/serial/nxp,sc16is7xx.txt         |  4 ++
 drivers/tty/serial/sc16is7xx.c                | 42 ++++++++++---------
 2 files changed, 26 insertions(+), 20 deletions(-)

-- 
2.26.2

