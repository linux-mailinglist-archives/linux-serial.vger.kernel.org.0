Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C285549F19
	for <lists+linux-serial@lfdr.de>; Tue, 18 Jun 2019 13:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729528AbfFRLYF (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 18 Jun 2019 07:24:05 -0400
Received: from mga02.intel.com ([134.134.136.20]:32112 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729690AbfFRLYE (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 Jun 2019 07:24:04 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2019 04:24:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,389,1557212400"; 
   d="scan'208";a="164671057"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 18 Jun 2019 04:24:01 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hdCDY-000ApD-MO; Tue, 18 Jun 2019 19:24:00 +0800
Date:   Tue, 18 Jun 2019 19:23:51 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Jay Dolan <jay.dolan@accesio.com>
Cc:     kbuild-all@01.org, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH tty] serial: 8250: pericom_do_set_divisor can be static
Message-ID: <20190618112351.GA31802@lkp-kbuild18>
References: <201906181948.HzE13NAX%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201906181948.HzE13NAX%lkp@intel.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


Fixes: 6bf4e42f1d19 ("serial: 8250: Add support for higher baud rates to Pericom chips")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 8250_pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 7ba1c3b..7f740b3 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1326,7 +1326,7 @@ static int pci_default_setup(struct serial_private *priv,
 
 	return setup_port(priv, port, bar, offset, board->reg_shift);
 }
-void
+static void
 pericom_do_set_divisor(struct uart_port *port, unsigned int baud,
 			       unsigned int quot, unsigned int quot_frac)
 {
