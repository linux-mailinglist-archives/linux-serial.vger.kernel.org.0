Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF3B87E6D
	for <lists+linux-serial@lfdr.de>; Fri,  9 Aug 2019 17:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436622AbfHIPsA (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 9 Aug 2019 11:48:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:59868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436666AbfHIPr6 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 9 Aug 2019 11:47:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EEE0214C6;
        Fri,  9 Aug 2019 15:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565365677;
        bh=RGq2p7/oJouSD+cYnchdKapTnvqszKPCF5rALE3m3Q8=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=vTZNu+dLAEyDcUKUZD+mkTWA0FmO1104ho8WTQRWs6js7CHCMtqL+pbuxpftxxVS/
         jYad310jdMpEWAo0IAem4unsvXAXJs3JIwIP5dUeVTb2dd5v6ofsYUxALsRE5LLMfK
         DiegKOXi63YM+LRgSEpAXN4yBL/Pz1gCMh5GS5E4=
Date:   Fri, 9 Aug 2019 17:47:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     kbuild test robot <lkp@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>, kbuild-all@01.org,
        linux-serial@vger.kernel.org
Subject: Re: [tty:tty-testing 68/80]
 drivers/tty/serial/8250/8250_pci.c:1823:12: note: in expansion of macro
 'do_div'
Message-ID: <20190809154754.GA22879@kroah.com>
References: <201908092358.3oQm8kOO%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201908092358.3oQm8kOO%lkp@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Aug 09, 2019 at 11:37:00PM +0800, kbuild test robot wrote:
> tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
> head:   7e9e6c1f446cf98e5e59d065f43428a9e1046fed
> commit: ad7d1f21825e7513f2fcfe6b8d21f8c365050c34 [68/80] serial: 8250_pci: Add support for Sunix serial boards
> config: parisc-c3000_defconfig (attached as .config)
> compiler: hppa-linux-gcc (GCC) 7.4.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout ad7d1f21825e7513f2fcfe6b8d21f8c365050c34
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.4.0 make.cross ARCH=parisc 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from ./arch/parisc/include/generated/asm/div64.h:1:0,
>                     from include/linux/kernel.h:18,
>                     from include/linux/list.h:9,
>                     from include/linux/module.h:9,
>                     from drivers/tty/serial/8250/8250_pci.c:10:
>    drivers/tty/serial/8250/8250_pci.c: In function 'pci_sunix_setup':
>    include/asm-generic/div64.h:222:28: warning: comparison of distinct pointer types lacks a cast
>      (void)(((typeof((n)) *)0) == ((uint64_t *)0)); \
>                                ^
> >> drivers/tty/serial/8250/8250_pci.c:1823:12: note: in expansion of macro 'do_div'
>       offset = do_div(idx, 4);
>                ^~~~~~
>    In file included from include/linux/kernel.h:11:0,
>                     from include/linux/list.h:9,
>                     from include/linux/module.h:9,
>                     from drivers/tty/serial/8250/8250_pci.c:10:
>    include/asm-generic/div64.h:235:25: warning: right shift count >= width of type [-Wshift-count-overflow]
>      } else if (likely(((n) >> 32) == 0)) {  \
>                             ^
>    include/linux/compiler.h:77:40: note: in definition of macro 'likely'
>     # define likely(x) __builtin_expect(!!(x), 1)
>                                            ^
> >> drivers/tty/serial/8250/8250_pci.c:1823:12: note: in expansion of macro 'do_div'
>       offset = do_div(idx, 4);
>                ^~~~~~
>    In file included from ./arch/parisc/include/generated/asm/div64.h:1:0,
>                     from include/linux/kernel.h:18,
>                     from include/linux/list.h:9,
>                     from include/linux/module.h:9,
>                     from drivers/tty/serial/8250/8250_pci.c:10:
>    include/asm-generic/div64.h:239:22: error: passing argument 1 of '__div64_32' from incompatible pointer type [-Werror=incompatible-pointer-types]
>       __rem = __div64_32(&(n), __base); \
>                          ^
> >> drivers/tty/serial/8250/8250_pci.c:1823:12: note: in expansion of macro 'do_div'
>       offset = do_div(idx, 4);
>                ^~~~~~
>    include/asm-generic/div64.h:213:17: note: expected 'uint64_t * {aka long long unsigned int *}' but argument is of type 'int *'
>     extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor);
>                     ^~~~~~~~~~
>    cc1: some warnings being treated as errors
> 
> vim +/do_div +1823 drivers/tty/serial/8250/8250_pci.c
> 
>   1805	
>   1806	static int
>   1807	pci_sunix_setup(struct serial_private *priv,
>   1808			const struct pciserial_board *board,
>   1809			struct uart_8250_port *port, int idx)
>   1810	{
>   1811		int bar;
>   1812		int offset;
>   1813	
>   1814		port->port.flags |= UPF_FIXED_TYPE;
>   1815		port->port.type = PORT_SUNIX;
>   1816	
>   1817		if (idx < 4) {
>   1818			bar = 0;
>   1819			offset = idx * board->uart_offset;
>   1820		} else {
>   1821			bar = 1;
>   1822			idx -= 4;
> > 1823			offset = do_div(idx, 4);

idx needs to be a u64 here.  Please fix up.  I'll go drop your two
patches and wait for new ones.

thanks,

greg k-h
