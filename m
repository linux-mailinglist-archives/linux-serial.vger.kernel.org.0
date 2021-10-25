Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5986D439693
	for <lists+linux-serial@lfdr.de>; Mon, 25 Oct 2021 14:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbhJYMsC (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 25 Oct 2021 08:48:02 -0400
Received: from mga01.intel.com ([192.55.52.88]:31245 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233070AbhJYMsA (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 25 Oct 2021 08:48:00 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10147"; a="253164185"
X-IronPort-AV: E=Sophos;i="5.87,180,1631602800"; 
   d="scan'208";a="253164185"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 05:45:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,180,1631602800"; 
   d="scan'208";a="528743947"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 25 Oct 2021 05:45:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2E970E7; Mon, 25 Oct 2021 15:45:34 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v2 2/2] serial: 8250_pci: Remove empty stub pci_quatech_exit()
Date:   Mon, 25 Oct 2021 15:45:33 +0300
Message-Id: <20211025124533.29977-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211025124533.29977-1-andriy.shevchenko@linux.intel.com>
References: <20211025124533.29977-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The ->exit() callback is checked for presence anyway,
no need to have an empty stub.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: corrected set of the patches, so this become patch 2 in the series
 drivers/tty/serial/8250/8250_pci.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 1d5579143fc8..80ac3235ec35 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1298,10 +1298,6 @@ static int pci_quatech_setup(struct serial_private *priv,
 	return pci_default_setup(priv, board, port, idx);
 }
 
-static void pci_quatech_exit(struct pci_dev *dev)
-{
-}
-
 static int pci_default_setup(struct serial_private *priv,
 		  const struct pciserial_board *board,
 		  struct uart_8250_port *port, int idx)
@@ -2176,7 +2172,6 @@ static struct pci_serial_quirk pci_serial_quirks[] = {
 		.subdevice	= PCI_ANY_ID,
 		.init		= pci_quatech_init,
 		.setup		= pci_quatech_setup,
-		.exit		= pci_quatech_exit,
 	},
 	/*
 	 * Panacom
-- 
2.33.0

