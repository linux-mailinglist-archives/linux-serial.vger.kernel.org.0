Return-Path: <linux-serial+bounces-51-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B43AD7F2AFA
	for <lists+linux-serial@lfdr.de>; Tue, 21 Nov 2023 11:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5496DB21806
	for <lists+linux-serial@lfdr.de>; Tue, 21 Nov 2023 10:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD25482C1;
	Tue, 21 Nov 2023 10:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="maJE4LgW"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C3FED
	for <linux-serial@vger.kernel.org>; Tue, 21 Nov 2023 02:49:14 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40b2b3da41eso2168405e9.3
        for <linux-serial@vger.kernel.org>; Tue, 21 Nov 2023 02:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700563753; x=1701168553; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vm1mzb+/0cWoJA6/opr6AD2njrHp+x6yQgd44ScRa7Q=;
        b=maJE4LgWjFL+KeiRZ6vg9pOgRWKwPxl/xNcpc2iCEg7vc67AdD6ybldaBDT5xnQp/N
         K3USUQo4VRlk/EzUAERX95T+61PPls9WF7+RVkwPG77lFcAhJ6xvHibwn174KVsuQsDw
         0lezjF1uTaSzfy2ZsAuyDHogFrYWRN+rrm7JueF7R5vIIYmLuYmCETFZKFTdWo3VtlsB
         rKC7dDwGwc7HuaOJ+It+GL395fqn87R/7MniyHu2ww5EoBnXpUTsquLUkDtjScUS9I59
         7exr+S49aEDUFYPJblbnJJMePEW7RR7rXNexnng4X3fGsLbQjRjhhzuGDUfPJJlHY9VK
         bCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700563753; x=1701168553;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:date:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vm1mzb+/0cWoJA6/opr6AD2njrHp+x6yQgd44ScRa7Q=;
        b=Gr+IUG0PtXWBgdJHnQ8JCAOd3dmTDeQ79LTQUXlOtqotapC0VHcjmiAOR3zwS+FJcz
         sHRwTD4enwq6/q/FCOBNewIFOC+Ckl26xKqQ1b42rYgUJIS1aB7V1nDbCmCTWazWSbeJ
         Tj1fKbaLPMMRMWnVn0g2g7LqNc2aH4DrCu3jrQey79zAtC7GBrV2ro8EMLl+WaTbQsht
         qiBfweuVrpuXDjZLrdn8hokT1IWCBpEuuV4Ej1aJ/dCXzqvN45wa85VasqJM7nV6Jlxw
         F/ihU1GCAnfGigF8LGbQTaemLVhoGCDm32k1k/cn0IJn4CwKYI/Z8kXGHwb8hX2Iwikb
         mYAQ==
X-Gm-Message-State: AOJu0YyTa0xGqGWbGQaca9jKsf3o0x9QwejI+tQQ9/u61DWJhpaCUrcD
	fBv1DvVyx+3+0NvY6gPR1hjtwg==
X-Google-Smtp-Source: AGHT+IGdWxrYI1CbBcjMK9wdr9tOMsAMG0nGdMH6J9FvpnI0ugEyHONwgzuV9omZo0HEuwXox11j/A==
X-Received: by 2002:a05:600c:3588:b0:40b:29f3:af02 with SMTP id p8-20020a05600c358800b0040b29f3af02mr1059939wmq.27.1700563752661;
        Tue, 21 Nov 2023 02:49:12 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id je12-20020a05600c1f8c00b0040839fcb217sm16689767wmb.8.2023.11.21.02.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 02:49:12 -0800 (PST)
From: Dan Carpenter <dan.carpenter@linaro.org>
X-Google-Original-From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 21 Nov 2023 05:49:09 -0500
To: oe-kbuild@lists.linux.dev, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	devicetree@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 2/2] serial: core: implement support for rs485-mux-gpios
Message-ID: <ecdc16e5-18f8-4675-91a3-36a0371e1e8d@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231120151056.148450-3-linux@rasmusvillemoes.dk>

Hi Rasmus,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rasmus-Villemoes/dt-bindings-serial-rs485-add-rs485-mux-gpios-binding/20231120-231551
base:   v6.7-rc2
patch link:    https://lore.kernel.org/r/20231120151056.148450-3-linux%40rasmusvillemoes.dk
patch subject: [PATCH 2/2] serial: core: implement support for rs485-mux-gpios
config: hexagon-randconfig-r071-20231121 (https://download.01.org/0day-ci/archive/20231121/202311211751.MgZLovko-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20231121/202311211751.MgZLovko-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Closes: https://lore.kernel.org/r/202311211751.MgZLovko-lkp@intel.com/

New smatch warnings:
drivers/tty/serial/serial_core.c:3651 uart_get_rs485_mode() warn: passing zero to 'PTR_ERR'

Old smatch warnings:
drivers/tty/serial/serial_core.c:2996 iomem_base_show() warn: argument 3 to %lX specifier is cast from pointer

vim +/PTR_ERR +3651 drivers/tty/serial/serial_core.c

d58a2df3d8877b Lukas Wunner          2020-05-18  3629  	/*
d58a2df3d8877b Lukas Wunner          2020-05-18  3630  	 * Disabling termination by default is the safe choice:  Else if many
d58a2df3d8877b Lukas Wunner          2020-05-18  3631  	 * bus participants enable it, no communication is possible at all.
d58a2df3d8877b Lukas Wunner          2020-05-18  3632  	 * Works fine for short cables and users may enable for longer cables.
d58a2df3d8877b Lukas Wunner          2020-05-18  3633  	 */
7cda0b9eb6eb9e Andy Shevchenko       2023-10-03  3634  	desc = devm_gpiod_get_optional(dev, "rs485-term", GPIOD_OUT_LOW);
7cda0b9eb6eb9e Andy Shevchenko       2023-10-03  3635  	if (IS_ERR(desc))
7cda0b9eb6eb9e Andy Shevchenko       2023-10-03  3636  		return dev_err_probe(dev, PTR_ERR(desc), "Cannot get rs485-term-gpios\n");
7cda0b9eb6eb9e Andy Shevchenko       2023-10-03  3637  	port->rs485_term_gpio = desc;
8bec874f84d826 Ilpo J�rvinen         2022-07-04  3638  	if (port->rs485_term_gpio)
8bec874f84d826 Ilpo J�rvinen         2022-07-04  3639  		port->rs485_supported.flags |= SER_RS485_TERMINATE_BUS;
d58a2df3d8877b Lukas Wunner          2020-05-18  3640  
7cda0b9eb6eb9e Andy Shevchenko       2023-10-03  3641  	dflags = (rs485conf->flags & SER_RS485_RX_DURING_TX) ?
163f080eb717d2 Christoph Niedermaier 2022-12-02  3642  		 GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
7cda0b9eb6eb9e Andy Shevchenko       2023-10-03  3643  	desc = devm_gpiod_get_optional(dev, "rs485-rx-during-tx", dflags);
7cda0b9eb6eb9e Andy Shevchenko       2023-10-03  3644  	if (IS_ERR(desc))
7cda0b9eb6eb9e Andy Shevchenko       2023-10-03  3645  		return dev_err_probe(dev, PTR_ERR(desc), "Cannot get rs485-rx-during-tx-gpios\n");
7cda0b9eb6eb9e Andy Shevchenko       2023-10-03  3646  	port->rs485_rx_during_tx_gpio = desc;
163f080eb717d2 Christoph Niedermaier 2022-12-02  3647  
da0ccd117da1e4 Rasmus Villemoes      2023-11-20  3648  	dflags = (rs485conf->flags & SER_RS485_ENABLED) ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
da0ccd117da1e4 Rasmus Villemoes      2023-11-20  3649  	desc = devm_gpiod_get_optional(dev, "rs485-mux", dflags);
da0ccd117da1e4 Rasmus Villemoes      2023-11-20  3650  	if (IS_ERR(desc))
da0ccd117da1e4 Rasmus Villemoes      2023-11-20 @3651  		return dev_err_probe(dev, PTR_ERR(port->rs485_mux_gpio),
                                                                                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Should be PTR_ERR(desc).

da0ccd117da1e4 Rasmus Villemoes      2023-11-20  3652  				     "Cannot get rs485-mux-gpios\n");
da0ccd117da1e4 Rasmus Villemoes      2023-11-20  3653  	port->rs485_mux_gpio = desc;
da0ccd117da1e4 Rasmus Villemoes      2023-11-20  3654  
c150c0f362c1e5 Lukas Wunner          2020-05-12  3655  	return 0;
ef838a81dd4de1 Uwe Kleine-K�nig      2017-09-13  3656  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


