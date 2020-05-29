Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C09F41E759B
	for <lists+linux-serial@lfdr.de>; Fri, 29 May 2020 07:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgE2FvG (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 29 May 2020 01:51:06 -0400
Received: from mail.bugwerft.de ([46.23.86.59]:56498 "EHLO mail.bugwerft.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbgE2FvG (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 29 May 2020 01:51:06 -0400
Received: from zenbar.fritz.box (p57bc97c6.dip0.t-ipconnect.de [87.188.151.198])
        by mail.bugwerft.de (Postfix) with ESMTPSA id D3BF24230C3;
        Fri, 29 May 2020 05:51:04 +0000 (UTC)
From:   Daniel Mack <daniel@zonque.org>
To:     devicetree@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org, jslaby@suse.com,
        jringle@gridpoint.com, m.brock@vanmierlo.com,
        pascal.huerst@gmail.com, Daniel Mack <daniel@zonque.org>
Subject: [PATCH v4 0/2] sc16is7xx: IrDA mode and threaded IRQs
Date:   Fri, 29 May 2020 07:50:56 +0200
Message-Id: <20200529055058.1606910-1-daniel@zonque.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This is a resend of the first two patches of the series to bring IrDA
support to the sc16is7xx driver.

The "linux," prefix is now dropped from the DT property.

The patches are rebased on top of the other 4 that have already been
merged.

Pascal Huerst (2):
  dt-bindings: sc16is7xx: Add flag to activate IrDA mode
  sc16is7xx: Add flag to activate IrDA mode

 .../bindings/serial/nxp,sc16is7xx.txt         |  4 ++++
 drivers/tty/serial/sc16is7xx.c                | 20 +++++++++++++++++++
 2 files changed, 24 insertions(+)

-- 
2.26.2

