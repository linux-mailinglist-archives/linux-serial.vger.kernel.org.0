Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 087089C468
	for <lists+linux-serial@lfdr.de>; Sun, 25 Aug 2019 16:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbfHYO3c (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sun, 25 Aug 2019 10:29:32 -0400
Received: from mga09.intel.com ([134.134.136.24]:7512 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728433AbfHYO3c (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 25 Aug 2019 10:29:32 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Aug 2019 07:29:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,429,1559545200"; 
   d="scan'208";a="263680161"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 25 Aug 2019 07:29:30 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1i1tWL-0000Bc-NJ; Sun, 25 Aug 2019 22:29:29 +0800
Date:   Sun, 25 Aug 2019 22:28:36 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Cc:     kbuild-all@01.org, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stoica Cosmin-Stefan <cosmin.stoica@nxp.com>,
        "Adrian.Nitu" <adrian.nitu@freescale.com>,
        Larisa Grigore <Larisa.Grigore@nxp.com>,
        Ana Nedelcu <B56683@freescale.com>,
        Mihaela Martinas <Mihaela.Martinas@freescale.com>,
        Matthew Nunez <matthew.nunez@nxp.com>
Subject: [tty:tty-next 84/95] drivers/tty/serial/fsl_linflexuart.c:907:3-8:
 No need to set .owner here. The core will do it.
Message-ID: <201908252233.sNS3lQWH%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
head:   591f4ea2ed6128de397ff8f2dee6ed009db38174
commit: b953815b819b0f327b5538feba3639d52db70172 [84/95] tty: serial: Add linflexuart driver for S32V234

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


coccinelle warnings: (new ones prefixed by >>)

>> drivers/tty/serial/fsl_linflexuart.c:907:3-8: No need to set .owner here. The core will do it.

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
