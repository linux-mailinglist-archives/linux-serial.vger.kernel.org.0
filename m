Return-Path: <linux-serial+bounces-5265-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D55AB948122
	for <lists+linux-serial@lfdr.de>; Mon,  5 Aug 2024 20:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5442B1F21609
	for <lists+linux-serial@lfdr.de>; Mon,  5 Aug 2024 18:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1515D17A59A;
	Mon,  5 Aug 2024 17:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GIX0pchw"
X-Original-To: linux-serial@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5FA16BE29;
	Mon,  5 Aug 2024 17:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722880720; cv=none; b=av3WsXybg4AiMwe1bOaFwqTsioAJ0RaB89vXMGm/1m7EGlMureTEMpOV9MM5+KsUKR7ICze2WxfnrIAjDaSrxsXM4T3d8iohEsQvctaAoJwE5uFF7UaLFstQSbrTwL+pghieDgZN9PCjKgH2HQmTChPDtcR8hR/4lOn9SpmIewM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722880720; c=relaxed/simple;
	bh=Aj6RPQXpz5kHvCamcRZP05HjigIF7x5EsV+xnuSlKUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eMLfzq+oX42iYpLQ4WYurD9Q5H+PNxH1Phee3loXIhhVQG5NsnfE+vw16jfj9S1rFVgivib1xNz9ekJdeWF5EQuVI+n1cHVzYWiFspUv29gEphH6GHvkLX+LeoWQ76OfBjBzoTHuOyt0BiF59ViowEOXEOwzebSN7mz5y+fZQi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GIX0pchw; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722880718; x=1754416718;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Aj6RPQXpz5kHvCamcRZP05HjigIF7x5EsV+xnuSlKUg=;
  b=GIX0pchwW8sbtAty4pOEWgmQsHr5qHoBgByBf6dMZx0texgLUI7z99LI
   zz7C808VMLcRzUr0mE4CDDjokrE468WUyomV+hkErle7hLS/gAr0BeuvK
   GVuVwDKMxsUQeJiCaxv+ADiG2u4Y8wD8hgSsG/AB5v3rVDZrFjQwYvyNt
   Q30sfqCw9tgjv6KNy1G6lEGccQ7Bd2iYtoZ8sPttMw1BmvXq72YART8vj
   ePh5oe8bNwah/aDL77f2gJVFZy+PoCIIG9YshqmJnojBCD1+M3dqdt8qu
   xOZl8ipUtVqYPwuy3sV7IEAM9ScQ/r97+eXmcIDrxtKQNtkKmeI/wnp5l
   g==;
X-CSE-ConnectionGUID: znWnWrGPQS2XKPTAcjlAHg==
X-CSE-MsgGUID: JrsT/XWcQfeYhfK1DIq97A==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="43385624"
X-IronPort-AV: E=Sophos;i="6.09,265,1716274800"; 
   d="scan'208";a="43385624"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 10:58:37 -0700
X-CSE-ConnectionGUID: L/kbVEL2ROiE7R0MGQi7tg==
X-CSE-MsgGUID: eugIK1zJR5ic1rjceYDJ4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,265,1716274800"; 
   d="scan'208";a="87176211"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 05 Aug 2024 10:58:35 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sb1yb-0003Nw-0O;
	Mon, 05 Aug 2024 17:58:33 +0000
Date: Tue, 6 Aug 2024 01:57:40 +0800
From: kernel test robot <lkp@intel.com>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, gregkh@linuxfoundation.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: Re: [PATCH 05/13] serial: use guards for simple mutex locks
Message-ID: <202408060106.20nUZZ2i-lkp@intel.com>
References: <20240805102046.307511-6-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240805102046.307511-6-jirislaby@kernel.org>

Hi Jiri,

kernel test robot noticed the following build errors:

[auto build test ERROR on tty/tty-testing]
[also build test ERROR on tty/tty-next tty/tty-linus usb/usb-testing usb/usb-next usb/usb-linus linus/master v6.11-rc2 next-20240805]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiri-Slaby-SUSE/tty-simplify-tty_dev_name_to_number-using-guard-mutex/20240805-184227
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20240805102046.307511-6-jirislaby%40kernel.org
patch subject: [PATCH 05/13] serial: use guards for simple mutex locks
config: i386-buildonly-randconfig-002-20240805 (https://download.01.org/0day-ci/archive/20240806/202408060106.20nUZZ2i-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240806/202408060106.20nUZZ2i-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408060106.20nUZZ2i-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/tty/serial/serial_core.c:2400:8: error: use of undeclared label 'unlock'
    2400 |                 goto unlock;
         |                      ^
   1 error generated.


vim +/unlock +2400 drivers/tty/serial/serial_core.c

b3b708fa2780cd2 drivers/serial/serial_core.c     Guennadi Liakhovetski   2007-10-16  2369  
ccce6debb62d949 drivers/serial/serial_core.c     Alan Cox                2009-09-19  2370  int uart_suspend_port(struct uart_driver *drv, struct uart_port *uport)
^1da177e4c3f415 drivers/serial/serial_core.c     Linus Torvalds          2005-04-16  2371  {
ccce6debb62d949 drivers/serial/serial_core.c     Alan Cox                2009-09-19  2372  	struct uart_state *state = drv->state + uport->line;
ccce6debb62d949 drivers/serial/serial_core.c     Alan Cox                2009-09-19  2373  	struct tty_port *port = &state->port;
b3b708fa2780cd2 drivers/serial/serial_core.c     Guennadi Liakhovetski   2007-10-16  2374  	struct device *tty_dev;
ccce6debb62d949 drivers/serial/serial_core.c     Alan Cox                2009-09-19  2375  	struct uart_match match = {uport, drv};
^1da177e4c3f415 drivers/serial/serial_core.c     Linus Torvalds          2005-04-16  2376  
d2d8bbc5cc74b7e drivers/tty/serial/serial_core.c Jiri Slaby (SUSE        2024-08-05  2377) 	guard(mutex)(&port->mutex);
^1da177e4c3f415 drivers/serial/serial_core.c     Linus Torvalds          2005-04-16  2378  
b286f4e87e325b7 drivers/tty/serial/serial_core.c Tony Lindgren           2023-11-13  2379  	tty_dev = device_find_child(&uport->port_dev->dev, &match, serial_match_port);
88e2582e90bb89f drivers/tty/serial/serial_core.c Lucas Stach             2017-05-11  2380  	if (tty_dev && device_may_wakeup(tty_dev)) {
aef3ad103a686f2 drivers/tty/serial/serial_core.c Andy Shevchenko         2017-08-13  2381  		enable_irq_wake(uport->irq);
b3b708fa2780cd2 drivers/serial/serial_core.c     Guennadi Liakhovetski   2007-10-16  2382  		put_device(tty_dev);
b3b708fa2780cd2 drivers/serial/serial_core.c     Guennadi Liakhovetski   2007-10-16  2383  		return 0;
b3b708fa2780cd2 drivers/serial/serial_core.c     Guennadi Liakhovetski   2007-10-16  2384  	}
5a65dcc04cda41f drivers/tty/serial/serial_core.c Federico Vaga           2013-04-15  2385  	put_device(tty_dev);
5a65dcc04cda41f drivers/tty/serial/serial_core.c Federico Vaga           2013-04-15  2386  
c9d2325cdb92fd4 drivers/tty/serial/serial_core.c Vijaya Krishna Nivarthi 2022-05-16  2387  	/*
c9d2325cdb92fd4 drivers/tty/serial/serial_core.c Vijaya Krishna Nivarthi 2022-05-16  2388  	 * Nothing to do if the console is not suspending
c9d2325cdb92fd4 drivers/tty/serial/serial_core.c Vijaya Krishna Nivarthi 2022-05-16  2389  	 * except stop_rx to prevent any asynchronous data
cfab87c2c271576 drivers/tty/serial/serial_core.c Vijaya Krishna Nivarthi 2022-06-08  2390  	 * over RX line. However ensure that we will be
cfab87c2c271576 drivers/tty/serial/serial_core.c Vijaya Krishna Nivarthi 2022-06-08  2391  	 * able to Re-start_rx later.
c9d2325cdb92fd4 drivers/tty/serial/serial_core.c Vijaya Krishna Nivarthi 2022-05-16  2392  	 */
c9d2325cdb92fd4 drivers/tty/serial/serial_core.c Vijaya Krishna Nivarthi 2022-05-16  2393  	if (!console_suspend_enabled && uart_console(uport)) {
abcb0cf1f5b2d99 drivers/tty/serial/serial_core.c John Ogness             2023-05-25  2394  		if (uport->ops->start_rx) {
559c7ff4e324558 drivers/tty/serial/serial_core.c Thomas Gleixner         2023-09-14  2395  			uart_port_lock_irq(uport);
c9d2325cdb92fd4 drivers/tty/serial/serial_core.c Vijaya Krishna Nivarthi 2022-05-16  2396  			uport->ops->stop_rx(uport);
559c7ff4e324558 drivers/tty/serial/serial_core.c Thomas Gleixner         2023-09-14  2397  			uart_port_unlock_irq(uport);
abcb0cf1f5b2d99 drivers/tty/serial/serial_core.c John Ogness             2023-05-25  2398  		}
a47cf07f60dcb02 drivers/tty/serial/serial_core.c Claudiu Beznea          2024-04-30  2399  		device_set_awake_path(uport->dev);
b164c9721e3ea4c drivers/tty/serial/serial_core.c Peter Hurley            2015-01-22 @2400  		goto unlock;
c9d2325cdb92fd4 drivers/tty/serial/serial_core.c Vijaya Krishna Nivarthi 2022-05-16  2401  	}
b164c9721e3ea4c drivers/tty/serial/serial_core.c Peter Hurley            2015-01-22  2402  
ccce6debb62d949 drivers/serial/serial_core.c     Alan Cox                2009-09-19  2403  	uport->suspended = 1;
b3b708fa2780cd2 drivers/serial/serial_core.c     Guennadi Liakhovetski   2007-10-16  2404  
d41861ca19c9e96 drivers/tty/serial/serial_core.c Peter Hurley            2016-04-09  2405  	if (tty_port_initialized(port)) {
ccce6debb62d949 drivers/serial/serial_core.c     Alan Cox                2009-09-19  2406  		const struct uart_ops *ops = uport->ops;
c8c6bfa39d6bd73 drivers/serial/serial_core.c     Russell King            2008-02-04  2407  		int tries;
18c9d4a3c249e9d drivers/tty/serial/serial_core.c Al Cooper               2022-03-24  2408  		unsigned int mctrl;
^1da177e4c3f415 drivers/serial/serial_core.c     Linus Torvalds          2005-04-16  2409  
75b20a2ac425b94 drivers/tty/serial/serial_core.c Ilpo J�rvinen           2023-01-17  2410  		tty_port_set_suspended(port, true);
515be7baeddb04d drivers/tty/serial/serial_core.c Ilpo J�rvinen           2023-01-17  2411  		tty_port_set_initialized(port, false);
a6b93a908508810 drivers/serial/serial_core.c     Russell King            2006-10-01  2412  
559c7ff4e324558 drivers/tty/serial/serial_core.c Thomas Gleixner         2023-09-14  2413  		uart_port_lock_irq(uport);
ccce6debb62d949 drivers/serial/serial_core.c     Alan Cox                2009-09-19  2414  		ops->stop_tx(uport);
7c7f9bc986e6988 drivers/tty/serial/serial_core.c Lukas Wunner            2022-09-22  2415  		if (!(uport->rs485.flags & SER_RS485_ENABLED))
ccce6debb62d949 drivers/serial/serial_core.c     Alan Cox                2009-09-19  2416  			ops->set_mctrl(uport, 0);
18c9d4a3c249e9d drivers/tty/serial/serial_core.c Al Cooper               2022-03-24  2417  		/* save mctrl so it can be restored on resume */
18c9d4a3c249e9d drivers/tty/serial/serial_core.c Al Cooper               2022-03-24  2418  		mctrl = uport->mctrl;
18c9d4a3c249e9d drivers/tty/serial/serial_core.c Al Cooper               2022-03-24  2419  		uport->mctrl = 0;
ccce6debb62d949 drivers/serial/serial_core.c     Alan Cox                2009-09-19  2420  		ops->stop_rx(uport);
559c7ff4e324558 drivers/tty/serial/serial_core.c Thomas Gleixner         2023-09-14  2421  		uart_port_unlock_irq(uport);
^1da177e4c3f415 drivers/serial/serial_core.c     Linus Torvalds          2005-04-16  2422  
^1da177e4c3f415 drivers/serial/serial_core.c     Linus Torvalds          2005-04-16  2423  		/*
^1da177e4c3f415 drivers/serial/serial_core.c     Linus Torvalds          2005-04-16  2424  		 * Wait for the transmitter to empty.
^1da177e4c3f415 drivers/serial/serial_core.c     Linus Torvalds          2005-04-16  2425  		 */
ccce6debb62d949 drivers/serial/serial_core.c     Alan Cox                2009-09-19  2426  		for (tries = 3; !ops->tx_empty(uport) && tries; tries--)
^1da177e4c3f415 drivers/serial/serial_core.c     Linus Torvalds          2005-04-16  2427  			msleep(10);
c8c6bfa39d6bd73 drivers/serial/serial_core.c     Russell King            2008-02-04  2428  		if (!tries)
cade3580f79aeba drivers/tty/serial/serial_core.c Andy Shevchenko         2017-03-31  2429  			dev_err(uport->dev, "%s: Unable to drain transmitter\n",
cade3580f79aeba drivers/tty/serial/serial_core.c Andy Shevchenko         2017-03-31  2430  				uport->name);
^1da177e4c3f415 drivers/serial/serial_core.c     Linus Torvalds          2005-04-16  2431  
ccce6debb62d949 drivers/serial/serial_core.c     Alan Cox                2009-09-19  2432  		ops->shutdown(uport);
18c9d4a3c249e9d drivers/tty/serial/serial_core.c Al Cooper               2022-03-24  2433  		uport->mctrl = mctrl;
^1da177e4c3f415 drivers/serial/serial_core.c     Linus Torvalds          2005-04-16  2434  	}
^1da177e4c3f415 drivers/serial/serial_core.c     Linus Torvalds          2005-04-16  2435  
^1da177e4c3f415 drivers/serial/serial_core.c     Linus Torvalds          2005-04-16  2436  	/*
^1da177e4c3f415 drivers/serial/serial_core.c     Linus Torvalds          2005-04-16  2437  	 * Disable the console device before suspending.
^1da177e4c3f415 drivers/serial/serial_core.c     Linus Torvalds          2005-04-16  2438  	 */
b164c9721e3ea4c drivers/tty/serial/serial_core.c Peter Hurley            2015-01-22  2439  	if (uart_console(uport))
ccce6debb62d949 drivers/serial/serial_core.c     Alan Cox                2009-09-19  2440  		console_stop(uport->cons);
^1da177e4c3f415 drivers/serial/serial_core.c     Linus Torvalds          2005-04-16  2441  
6f538fe31c1d453 drivers/tty/serial/serial_core.c Linus Walleij           2012-12-07  2442  	uart_change_pm(state, UART_PM_STATE_OFF);
^1da177e4c3f415 drivers/serial/serial_core.c     Linus Torvalds          2005-04-16  2443  
^1da177e4c3f415 drivers/serial/serial_core.c     Linus Torvalds          2005-04-16  2444  	return 0;
^1da177e4c3f415 drivers/serial/serial_core.c     Linus Torvalds          2005-04-16  2445  }
15dc475bcc1739c drivers/tty/serial/serial_core.c Jiri Slaby              2022-01-24  2446  EXPORT_SYMBOL(uart_suspend_port);
^1da177e4c3f415 drivers/serial/serial_core.c     Linus Torvalds          2005-04-16  2447  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

