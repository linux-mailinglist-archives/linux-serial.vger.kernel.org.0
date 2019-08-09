Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E41087E2D
	for <lists+linux-serial@lfdr.de>; Fri,  9 Aug 2019 17:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436665AbfHIPh4 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 9 Aug 2019 11:37:56 -0400
Received: from mga17.intel.com ([192.55.52.151]:41123 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436647AbfHIPh4 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 9 Aug 2019 11:37:56 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2019 08:37:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,364,1559545200"; 
   d="gz'50?scan'50,208,50";a="350523484"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 09 Aug 2019 08:37:52 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hw6xj-0004vq-GF; Fri, 09 Aug 2019 23:37:51 +0800
Date:   Fri, 9 Aug 2019 23:37:00 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     kbuild-all@01.org, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [tty:tty-testing 68/80] drivers/tty/serial/8250/8250_pci.c:1823:12:
 note: in expansion of macro 'do_div'
Message-ID: <201908092358.3oQm8kOO%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="brd36ilttoxmqqml"
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--brd36ilttoxmqqml
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
head:   7e9e6c1f446cf98e5e59d065f43428a9e1046fed
commit: ad7d1f21825e7513f2fcfe6b8d21f8c365050c34 [68/80] serial: 8250_pci: Add support for Sunix serial boards
config: parisc-c3000_defconfig (attached as .config)
compiler: hppa-linux-gcc (GCC) 7.4.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout ad7d1f21825e7513f2fcfe6b8d21f8c365050c34
        # save the attached .config to linux build tree
        GCC_VERSION=7.4.0 make.cross ARCH=parisc 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from ./arch/parisc/include/generated/asm/div64.h:1:0,
                    from include/linux/kernel.h:18,
                    from include/linux/list.h:9,
                    from include/linux/module.h:9,
                    from drivers/tty/serial/8250/8250_pci.c:10:
   drivers/tty/serial/8250/8250_pci.c: In function 'pci_sunix_setup':
   include/asm-generic/div64.h:222:28: warning: comparison of distinct pointer types lacks a cast
     (void)(((typeof((n)) *)0) == ((uint64_t *)0)); \
                               ^
>> drivers/tty/serial/8250/8250_pci.c:1823:12: note: in expansion of macro 'do_div'
      offset = do_div(idx, 4);
               ^~~~~~
   In file included from include/linux/kernel.h:11:0,
                    from include/linux/list.h:9,
                    from include/linux/module.h:9,
                    from drivers/tty/serial/8250/8250_pci.c:10:
   include/asm-generic/div64.h:235:25: warning: right shift count >= width of type [-Wshift-count-overflow]
     } else if (likely(((n) >> 32) == 0)) {  \
                            ^
   include/linux/compiler.h:77:40: note: in definition of macro 'likely'
    # define likely(x) __builtin_expect(!!(x), 1)
                                           ^
>> drivers/tty/serial/8250/8250_pci.c:1823:12: note: in expansion of macro 'do_div'
      offset = do_div(idx, 4);
               ^~~~~~
   In file included from ./arch/parisc/include/generated/asm/div64.h:1:0,
                    from include/linux/kernel.h:18,
                    from include/linux/list.h:9,
                    from include/linux/module.h:9,
                    from drivers/tty/serial/8250/8250_pci.c:10:
   include/asm-generic/div64.h:239:22: error: passing argument 1 of '__div64_32' from incompatible pointer type [-Werror=incompatible-pointer-types]
      __rem = __div64_32(&(n), __base); \
                         ^
>> drivers/tty/serial/8250/8250_pci.c:1823:12: note: in expansion of macro 'do_div'
      offset = do_div(idx, 4);
               ^~~~~~
   include/asm-generic/div64.h:213:17: note: expected 'uint64_t * {aka long long unsigned int *}' but argument is of type 'int *'
    extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor);
                    ^~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/do_div +1823 drivers/tty/serial/8250/8250_pci.c

  1805	
  1806	static int
  1807	pci_sunix_setup(struct serial_private *priv,
  1808			const struct pciserial_board *board,
  1809			struct uart_8250_port *port, int idx)
  1810	{
  1811		int bar;
  1812		int offset;
  1813	
  1814		port->port.flags |= UPF_FIXED_TYPE;
  1815		port->port.type = PORT_SUNIX;
  1816	
  1817		if (idx < 4) {
  1818			bar = 0;
  1819			offset = idx * board->uart_offset;
  1820		} else {
  1821			bar = 1;
  1822			idx -= 4;
> 1823			offset = do_div(idx, 4);
  1824			offset = idx * 64 + offset * board->uart_offset;
  1825		}
  1826	
  1827		return setup_port(priv, port, bar, offset, 0);
  1828	}
  1829	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--brd36ilttoxmqqml
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
e1KyjfwAAA==

--brd36ilttoxmqqml--
