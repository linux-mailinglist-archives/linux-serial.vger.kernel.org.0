Return-Path: <linux-serial+bounces-156-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 630CB7F5925
	for <lists+linux-serial@lfdr.de>; Thu, 23 Nov 2023 08:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F5871C20B65
	for <lists+linux-serial@lfdr.de>; Thu, 23 Nov 2023 07:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C0A16412;
	Thu, 23 Nov 2023 07:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VotlnwEU"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C74D42
	for <linux-serial@vger.kernel.org>; Wed, 22 Nov 2023 23:24:29 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-32dff08bbdbso344406f8f.2
        for <linux-serial@vger.kernel.org>; Wed, 22 Nov 2023 23:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700724268; x=1701329068; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=glDIJBHGxZ+W4YAgV26CnXbvxUmxQYnGxfvLbwvG8mM=;
        b=VotlnwEUPAPSNrVce9L9AVGLf5SFJvWaMvTA2E2JCOUHeckgiC3XFRljojkbyVGVip
         TkVTJolTvWm20eZG2/88munaQ11lJDRVUhpjbEupzc6MlsO6sIhKGriEdHEjv9IR81JW
         V+8zOiM1+gDr0XvI3DSZLPuxKljpyOBsGJOn89YqpNd8hlFkeIpKmhDKxEiIrRVoTCQ3
         OuhdeH27Jrgm6v03216SCWCI/wOPSXKdc7nOxYyl8ZO0SP34S3yrpHju10EK7u+xVqRu
         LFEWRAQSQYEgwQ+Zt2JfSWy6uUf30p5Sp9U5O8tdQAmKndMUCMjsgRArNvLqdop8mdIU
         zMyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700724268; x=1701329068;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=glDIJBHGxZ+W4YAgV26CnXbvxUmxQYnGxfvLbwvG8mM=;
        b=M2VR4lscQCjXMkvfU+pUZoEpw0unlo9orgChEhRva2Y2Sf6jdrkNh+7FrVcSGxrTgG
         Dv0ry+qepgPD7QuPpw7HHGk7Rbugt4i1QoRdi5oJa35957MuIbnEGh5poNtR2lOKT2Q6
         0XAJ11VNhb/CqFComi/mdGrMXOBLhiE9olgINOkR6Usp62kn34dIvKKcIQDbz5hx+OEC
         hM3xvl08AIYIa7fJmBf1bSuTRkbqTEkQrqeKFd5f47bHiznYI1y+iLL0j06i7XvpDRSv
         Yr5J2rl7fjY0cqMPvbVmgWbXbfNUNTFoqk+nvtBVd62SLtuEEoV52TQB37PEzHVEbpKG
         rG4A==
X-Gm-Message-State: AOJu0YwfqkfGO1lXNBZUvGFQIDoMoUbvy1TCV6XpMkbrYqGTM1xCkEWi
	Jv/pxyhiovdjLhl49lYLBZxXzA==
X-Google-Smtp-Source: AGHT+IEKgSAvwU+quZwntLL8CoIH9KhcpaTa8/JJZaDNw1Vw3y6oWRpa7BZZ0Za9QkIuhpqBWf+L6Q==
X-Received: by 2002:a5d:5885:0:b0:332:d504:c138 with SMTP id n5-20020a5d5885000000b00332d504c138mr2189978wrf.1.1700724268131;
        Wed, 22 Nov 2023 23:24:28 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id e11-20020a5d500b000000b0032d2489a399sm778289wrt.49.2023.11.22.23.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 23:24:27 -0800 (PST)
From: Dan Carpenter <dan.carpenter@linaro.org>
X-Google-Original-From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Thu, 23 Nov 2023 10:24:24 +0300
To: oe-kbuild@lists.linux.dev, Tony Lindgren <tony@atomide.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	"David S . Miller" <davem@davemloft.net>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Dhruva Gole <d-gole@ti.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Johan Hovold <johan@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 3/3] serial: core: Move console character device
 handling from printk
Message-ID: <6933c98f-7f76-4955-ba0f-89ea340b672d@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121113203.61341-4-tony@atomide.com>

Hi Tony,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tony-Lindgren/printk-Save-console-options-for-add_preferred_console_match/20231121-193809
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20231121113203.61341-4-tony%40atomide.com
patch subject: [PATCH v3 3/3] serial: core: Move console character device handling from printk
config: parisc-randconfig-r081-20231122 (https://download.01.org/0day-ci/archive/20231122/202311221437.5Gil0Pml-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231122/202311221437.5Gil0Pml-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Closes: https://lore.kernel.org/r/202311221437.5Gil0Pml-lkp@intel.com/

smatch warnings:
drivers/tty/serial/serial_base_bus.c:266 serial_base_add_preferred_console() error: uninitialized symbol 'nmbr_match'.
drivers/tty/serial/serial_base_bus.c:265 serial_base_add_preferred_console() error: uninitialized symbol 'char_match'.

vim +/nmbr_match +266 drivers/tty/serial/serial_base_bus.c

e4ebdcd790e0f3 Tony Lindgren 2023-11-21  261  int serial_base_add_preferred_console(struct uart_driver *drv,
e4ebdcd790e0f3 Tony Lindgren 2023-11-21  262  				      struct uart_port *port)
e4ebdcd790e0f3 Tony Lindgren 2023-11-21  263  {
e4ebdcd790e0f3 Tony Lindgren 2023-11-21  264  	const char *port_match __free(kfree);
b1b8726ec3f40b Tony Lindgren 2023-11-21 @265  	const char *char_match __free(kfree);
b1b8726ec3f40b Tony Lindgren 2023-11-21 @266  	const char *nmbr_match __free(kfree);

These need to be initialized to NULL.

	const char *char_match __free(kfree) = NULL;

e4ebdcd790e0f3 Tony Lindgren 2023-11-21  267  	int ret;
e4ebdcd790e0f3 Tony Lindgren 2023-11-21  268  
e4ebdcd790e0f3 Tony Lindgren 2023-11-21  269  	port_match = kasprintf(GFP_KERNEL, "%s:%i.%i", dev_name(port->dev),
e4ebdcd790e0f3 Tony Lindgren 2023-11-21  270  			       port->ctrl_id, port->port_id);
e4ebdcd790e0f3 Tony Lindgren 2023-11-21  271  	if (!port_match)
e4ebdcd790e0f3 Tony Lindgren 2023-11-21  272  		return -ENOMEM;

Otherwise in this error path we'll call kfree(char_match) and
kfree(nmbr_match) when the haven't been initialized.

e4ebdcd790e0f3 Tony Lindgren 2023-11-21  273  
b1b8726ec3f40b Tony Lindgren 2023-11-21  274  	char_match = kasprintf(GFP_KERNEL, "%s%i", drv->dev_name, port->line);
b1b8726ec3f40b Tony Lindgren 2023-11-21  275  	if (!char_match)
b1b8726ec3f40b Tony Lindgren 2023-11-21  276  		return -ENOMEM;
b1b8726ec3f40b Tony Lindgren 2023-11-21  277  
b1b8726ec3f40b Tony Lindgren 2023-11-21  278  	/* Handle ttyS specific options */
b1b8726ec3f40b Tony Lindgren 2023-11-21  279  	if (!strncmp(drv->dev_name, "ttyS", 4)) {
b1b8726ec3f40b Tony Lindgren 2023-11-21  280  		/* No name, just a number */
b1b8726ec3f40b Tony Lindgren 2023-11-21  281  		nmbr_match = kasprintf(GFP_KERNEL, "%i", port->line);
b1b8726ec3f40b Tony Lindgren 2023-11-21  282  		if (!nmbr_match)
b1b8726ec3f40b Tony Lindgren 2023-11-21  283  			return -ENODEV;
b1b8726ec3f40b Tony Lindgren 2023-11-21  284  
b1b8726ec3f40b Tony Lindgren 2023-11-21  285  		ret = add_preferred_console_match(nmbr_match, drv->dev_name,
b1b8726ec3f40b Tony Lindgren 2023-11-21  286  						  port->line);
b1b8726ec3f40b Tony Lindgren 2023-11-21  287  		if (ret && ret != -ENOENT)
b1b8726ec3f40b Tony Lindgren 2023-11-21  288  			return ret;
b1b8726ec3f40b Tony Lindgren 2023-11-21  289  
b1b8726ec3f40b Tony Lindgren 2023-11-21  290  		/* Sparc ttya and ttyb */
b1b8726ec3f40b Tony Lindgren 2023-11-21  291  		ret = serial_base_add_sparc_console(drv, port);
b1b8726ec3f40b Tony Lindgren 2023-11-21  292  		if (ret)
b1b8726ec3f40b Tony Lindgren 2023-11-21  293  			return ret;
b1b8726ec3f40b Tony Lindgren 2023-11-21  294  	}
b1b8726ec3f40b Tony Lindgren 2023-11-21  295  
b1b8726ec3f40b Tony Lindgren 2023-11-21  296  	/* Handle the traditional character device name style console=ttyS0 */
b1b8726ec3f40b Tony Lindgren 2023-11-21  297  	ret = add_preferred_console_match(char_match, drv->dev_name, port->line);
b1b8726ec3f40b Tony Lindgren 2023-11-21  298  	if (ret && ret != -ENOENT)
b1b8726ec3f40b Tony Lindgren 2023-11-21  299  		return ret;
b1b8726ec3f40b Tony Lindgren 2023-11-21  300  
e4ebdcd790e0f3 Tony Lindgren 2023-11-21  301  	/* Translate a hardware addressing style console=DEVNAME:0.0 */
e4ebdcd790e0f3 Tony Lindgren 2023-11-21  302  	ret = add_preferred_console_match(port_match, drv->dev_name, port->line);
e4ebdcd790e0f3 Tony Lindgren 2023-11-21  303  	if (ret && ret != -ENOENT)
e4ebdcd790e0f3 Tony Lindgren 2023-11-21  304  		return ret;
e4ebdcd790e0f3 Tony Lindgren 2023-11-21  305  
e4ebdcd790e0f3 Tony Lindgren 2023-11-21  306  	return 0;
e4ebdcd790e0f3 Tony Lindgren 2023-11-21  307  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


