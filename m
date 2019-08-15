Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 805C28F061
	for <lists+linux-serial@lfdr.de>; Thu, 15 Aug 2019 18:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbfHOQVw (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 15 Aug 2019 12:21:52 -0400
Received: from mga12.intel.com ([192.55.52.136]:53107 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729895AbfHOQVw (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 15 Aug 2019 12:21:52 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2019 09:21:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,389,1559545200"; 
   d="scan'208";a="260861724"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 15 Aug 2019 09:21:50 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hyIVa-0007PW-8A; Fri, 16 Aug 2019 00:21:50 +0800
Date:   Fri, 16 Aug 2019 00:21:48 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@01.org, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [tty:tty-testing 84/90] drivers/tty/serial/lpc32xx_hs.c:447:14:
 sparse: sparse: incompatible types for 'case' statement
Message-ID: <201908160045.ql5LACNr%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Arnd,

First bad commit (maybe != root cause):

tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
head:   92770c07234fb9e097ceb512e4bb29aca750075c
commit: 5dce8eccb54355ea42918b651f1085e54b2c5f2f [84/90] serial: lpc32xx_hs: allow compile-testing
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-rc1-7-g2b96cd8-dirty
        git checkout 5dce8eccb54355ea42918b651f1085e54b2c5f2f
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   include/linux/sched.h:609:43: sparse: sparse: bad integer constant expression
   include/linux/sched.h:609:73: sparse: sparse: invalid named zero-width bitfield `value'
   include/linux/sched.h:610:43: sparse: sparse: bad integer constant expression
   include/linux/sched.h:610:67: sparse: sparse: invalid named zero-width bitfield `bucket_id'
   drivers/tty/serial/lpc32xx_hs.c:447:14: sparse: sparse: undefined identifier 'LPC32XX_HS_UART1_BASE'
   drivers/tty/serial/lpc32xx_hs.c:450:14: sparse: sparse: undefined identifier 'LPC32XX_HS_UART2_BASE'
   drivers/tty/serial/lpc32xx_hs.c:453:14: sparse: sparse: undefined identifier 'LPC32XX_HS_UART7_BASE'
>> drivers/tty/serial/lpc32xx_hs.c:447:14: sparse: sparse: incompatible types for 'case' statement
   drivers/tty/serial/lpc32xx_hs.c:450:14: sparse: sparse: incompatible types for 'case' statement
   drivers/tty/serial/lpc32xx_hs.c:453:14: sparse: sparse: incompatible types for 'case' statement
   drivers/tty/serial/lpc32xx_hs.c:461:21: sparse: sparse: undefined identifier 'LPC32XX_UARTCTL_CLOOP'
   drivers/tty/serial/lpc32xx_hs.c:466:21: sparse: sparse: undefined identifier 'LPC32XX_UARTCTL_CLOOP'
   drivers/tty/serial/lpc32xx_hs.c:580:17: sparse: sparse: undefined identifier 'SZ_4K'
   drivers/tty/serial/lpc32xx_hs.c:591:22: sparse: sparse: undefined identifier 'SZ_4K'
   drivers/tty/serial/lpc32xx_hs.c:594:64: sparse: sparse: undefined identifier 'SZ_4K'
   drivers/tty/serial/lpc32xx_hs.c:596:33: sparse: sparse: undefined identifier 'SZ_4K'
   drivers/tty/serial/lpc32xx_hs.c:693:27: sparse: sparse: undefined identifier 'LPC32XX_MAIN_OSC_FREQ'
   drivers/tty/serial/lpc32xx_hs.c:447:14: sparse: sparse: Expected constant expression in case statement
   drivers/tty/serial/lpc32xx_hs.c:450:14: sparse: sparse: Expected constant expression in case statement
   drivers/tty/serial/lpc32xx_hs.c:453:14: sparse: sparse: Expected constant expression in case statement

vim +/case +447 drivers/tty/serial/lpc32xx_hs.c

596f93f50e2d1a Roland Stigge 2012-06-11  439  
596f93f50e2d1a Roland Stigge 2012-06-11  440  /* LPC3250 Errata HSUART.1: Hang workaround via loopback mode on inactivity */
596f93f50e2d1a Roland Stigge 2012-06-11  441  static void lpc32xx_loopback_set(resource_size_t mapbase, int state)
596f93f50e2d1a Roland Stigge 2012-06-11  442  {
596f93f50e2d1a Roland Stigge 2012-06-11  443  	int bit;
596f93f50e2d1a Roland Stigge 2012-06-11  444  	u32 tmp;
596f93f50e2d1a Roland Stigge 2012-06-11  445  
596f93f50e2d1a Roland Stigge 2012-06-11  446  	switch (mapbase) {
596f93f50e2d1a Roland Stigge 2012-06-11 @447  	case LPC32XX_HS_UART1_BASE:
596f93f50e2d1a Roland Stigge 2012-06-11  448  		bit = 0;
596f93f50e2d1a Roland Stigge 2012-06-11  449  		break;
596f93f50e2d1a Roland Stigge 2012-06-11  450  	case LPC32XX_HS_UART2_BASE:
596f93f50e2d1a Roland Stigge 2012-06-11  451  		bit = 1;
596f93f50e2d1a Roland Stigge 2012-06-11  452  		break;
596f93f50e2d1a Roland Stigge 2012-06-11  453  	case LPC32XX_HS_UART7_BASE:
596f93f50e2d1a Roland Stigge 2012-06-11  454  		bit = 6;
596f93f50e2d1a Roland Stigge 2012-06-11  455  		break;
596f93f50e2d1a Roland Stigge 2012-06-11  456  	default:
596f93f50e2d1a Roland Stigge 2012-06-11  457  		WARN(1, "lpc32xx_hs: Warning: Unknown port at %08x\n", mapbase);
596f93f50e2d1a Roland Stigge 2012-06-11  458  		return;
596f93f50e2d1a Roland Stigge 2012-06-11  459  	}
596f93f50e2d1a Roland Stigge 2012-06-11  460  
596f93f50e2d1a Roland Stigge 2012-06-11  461  	tmp = readl(LPC32XX_UARTCTL_CLOOP);
596f93f50e2d1a Roland Stigge 2012-06-11  462  	if (state)
596f93f50e2d1a Roland Stigge 2012-06-11  463  		tmp |= (1 << bit);
596f93f50e2d1a Roland Stigge 2012-06-11  464  	else
596f93f50e2d1a Roland Stigge 2012-06-11  465  		tmp &= ~(1 << bit);
596f93f50e2d1a Roland Stigge 2012-06-11  466  	writel(tmp, LPC32XX_UARTCTL_CLOOP);
596f93f50e2d1a Roland Stigge 2012-06-11  467  }
596f93f50e2d1a Roland Stigge 2012-06-11  468  

:::::: The code at line 447 was first introduced by commit
:::::: 596f93f50e2d1a926bbb6c73aa7ee7fd862b7062 serial: Add driver for LPC32xx High Speed UARTs

:::::: TO: Roland Stigge <stigge@antcom.de>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
