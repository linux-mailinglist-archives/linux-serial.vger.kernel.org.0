Return-Path: <linux-serial+bounces-2145-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 295B084CF71
	for <lists+linux-serial@lfdr.de>; Wed,  7 Feb 2024 18:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A20DD1F21539
	for <lists+linux-serial@lfdr.de>; Wed,  7 Feb 2024 17:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0039D82899;
	Wed,  7 Feb 2024 17:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b="VazHCZVU"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEFA823C3
	for <linux-serial@vger.kernel.org>; Wed,  7 Feb 2024 17:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707325850; cv=none; b=uL7r/73xavym9+w+VXZZIYbeXDNasPp1Y1S2xNZ4EsZwnsLopMBqP/40nCU0D7oSYaj4skSGyOm73HLTmb+wWjJPJR0x2vEwzCTDFUZb7kdljFULUUC5WJH5e8zwA9DEGRzCDuOCrBXQaEjnBFJ8BSV+KifPPiPGvTZvkqBeO34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707325850; c=relaxed/simple;
	bh=bwc8Yls6eRt/O4jDgK96IDVTeO7vvV4hN9vR3g446yU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YFRxXzEsAkWsRigD0QieK5j8ZL9diApA00zLFx9ER4uEMq5bV+tXukHjJ3t1P8UsV1r2ITD879iyk14E+/T2uGFKPN3T4gULQEmRypRHDMc2r0hk3Vnf/cLR0xxEobw/Lol/K6IveZtv+aQyjacbNsP11sRJH+NU5mkHJMN7Fg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b=VazHCZVU; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4101565d20bso6725405e9.2
        for <linux-serial@vger.kernel.org>; Wed, 07 Feb 2024 09:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20230601.gappssmtp.com; s=20230601; t=1707325846; x=1707930646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jn7k1jazp2MccOFMY/hBnR29Hjiyxg1FLp6nPl1S1t8=;
        b=VazHCZVUpgk3fkWazz9cuVO0dwvkT0e6Z2NBs2ERlZrJcz9ewyjMBBS9tT7sbaQ+gR
         f+Keo364cXxfylsSozFCKseVHZ8GfmGROU2Ymlrk8SgHoO1TATMyeRvFPHkQ7ArGooKE
         OjfKv6qYkSnJTEKDD9MjyWDPMdLcOAEbNQpop0P60Dsfy3cwtp72cJtaZHDWUOv617Gq
         AwxasDHfrBiSMoCo1phjq0h3Tn823k2u76Ab7j6FxgzboMcpb2snuEssCMA00rXjBxJa
         8BrW0UJJV0ZpbkTPAGqCpA/9UFr8RwJhL/RwdHkirMwiDAMcuyDEt5F+D5ffOWNb8agK
         vsRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707325846; x=1707930646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jn7k1jazp2MccOFMY/hBnR29Hjiyxg1FLp6nPl1S1t8=;
        b=jPHedFrnUcSqrH0TUhi8BKFVw5fd90Bqi0QymyJE6NBVuS1lqK5gIrdHFDGnx9Ax7d
         dBz2RRIlho29EDH/YzADvIcV6TPALJIcisHSO2YnRiSg0psl73z9esc0MqwqRdDRYNap
         gh5KdbcjNynU/zT23JaSvfqPPXHdXPuElLamIqOWo/UOdP4QBHWZ5+mC9HMwpSMhUt6i
         RqwlOwg7PiqNNsCmbK/jbfPD0QeHBRiPzZBdgM4ctgrf0WY2y6Lvn3iS4laKgrNvu9m8
         ua//Z6MM2yrSeDA28lDmic2Ov+ltw3wLlKEOxkpuiAUaQB/QqP0FUWp3cQ4G0b6+85ND
         CEaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVC2Kkt2sQYzqUBjbQdsv+lM6uM3zAkWG7bAw8je/y0Ge73xlBAZXTxAdeIzx7FX6XdUri4KDklfQ2zWRJj0x/sOsIGTdU8G/BkT230
X-Gm-Message-State: AOJu0YyX5RdSaEK8YDDdY+Bjms9o6+YDQ6IsznHlZbtxRncn343LyYku
	H/ey35oyzqieDl4cBju3bO1VpujnBNKqbRrdt8pXZhzP5w5fbYaewq6Id1YJ7a4=
X-Google-Smtp-Source: AGHT+IEWrhvn8EyV1F2rjTjpl9Tcz/fM2cqK29jaBYCn9Y7E5y3hCQ2iSE5tG0/ub95wiRUTBK0FzQ==
X-Received: by 2002:a05:600c:1c0d:b0:40f:fe1a:6ba2 with SMTP id j13-20020a05600c1c0d00b0040ffe1a6ba2mr2812279wms.3.1707325846253;
        Wed, 07 Feb 2024 09:10:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWv0RNvIYsD1i6Osvtq8xDwio8Hvh0N1+H+/FPvd99ndM3oEy+6MWQTVOCT3kVHyD+DM26DoHw67to4ekLY3KUYuQuVnf3AttdSIknS8qS5ngCXzbG8A3VZDb5c2XjZKGW2BuvLWxWBRoZnY/Jdej9UiYzpiVK0/XEs3dIlAme2VhyuHBzK9aRnXJqrlHNFNLbdWiIA5olg5XYHgbMiJS+7n21euKedktCzORR3SDhI5jRc9009kzqyTBDEc6NOD+LGqg3E1seyzR5QDjnQWoYkFoD/GdiOvlvcrLBZNs5bAwOh1H/Xd4c634ZDpVK+dcfSfvvUBHwJbuwz9mXWj2EEOjJAZBloA+bTmzepDlD05waD8Tj7ViWo3b/KY+orOsoFCi6VeFj/WyaHgV93lylYljMhnIEKgOLnp1oOOG6uIhE5o18izY8eKZfLKgelpBrzdXTqEbOWZlNZ1LMz5FNHP+K2GbJBUBmkILGU4t6KEElipUEyQLZXridqF9lfn4knXJzAaiMZI+OnHMe0f9B/2iKTzvfC+XMJtgqLK2XjWRDkqDRh85vdS+9i9HPvCo4mgH17TkSkGBuxYUEfJdi+oXTb02cwe0JjsjKv5y2dz/cXakkRYQzm7edOhIgaDfogKDOpfMWgfKWsbqE/yMhod5w/FSTjUiNgoeCdTeVSwOFN0XfTD45QlgjE3noH9vm22t4HsqqZTRraRRqqaJ7kkyZm+qptCtx7wIsS1NddF/B8W6oU2w6bAgn2b6TcsTXA88WzFnbAk8NvR0gsJ+DuuCetTO4=
Received: from P-ASN-ECS-830T8C3.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id u14-20020a05600c19ce00b0040fdf2832desm2645584wmq.12.2024.02.07.09.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 09:10:45 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: linux-fsdevel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	x86@kernel.org
Cc: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Borislav Petkov <bp@alien8.de>,
	Darren Hart <dvhart@infradead.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Josh Triplett <josh@joshtriplett.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Yoann Congal <yoann.congal@smile.fr>
Subject: [PATCH v5 0/3] printk: CONFIG_BASE_SMALL fix for LOG_CPU_MAX_BUF_SHIFT and removal of CONFIG_BASE_FULL
Date: Wed,  7 Feb 2024 18:10:17 +0100
Message-Id: <20240207171020.41036-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series focuses on CONFIG_BASE_SMALL.
The first patch fixes LOG_CPU_MAX_BUF_SHIFT when CONFIG_BASE_SMALL is
used.
The second patch globally changes the type of CONFIG_BASE_SMALL and
adapts usages.
The third patch removes the now redundant BASE_FULL, puts BASE_SMALL
in its place in the config menus and updates usages in defconfigs.

Thanks everyone for your reviews! :)

Patch history:
v4->v5:
* Applied Petr Mladek's suggestion (Thanks!):
  * Added defconfig update to patch 3/3
* Applied Masahiro Yamada's comments (Thanks!):
  * Shorter form in patch 2/3
  * Dropped the redundant "default n" in patch 3/3

v4 series:
https://lore.kernel.org/all/20240206001333.1710070-1-yoann.congal@smile.fr/
* Patch v4 1/3: (unchanged in v5)
  * Reviewed-by: Petr Mladek <pmladek@suse.com>
  * Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>
* Patch v4 2/3:
  * Reviewed-by: Petr Mladek <pmladek@suse.com>
  * Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
  * Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>

v3->v4: Applied Petr Mladek's suggestion (Thanks!):
* Keep BASE_SMALL instead of BASE_FULL
* A patch changing the type of BASE_SMALL was added.

v3 series was named "printk: CONFIG_BASE_SMALL fix for
LOG_CPU_MAX_BUF_SHIFT and removal"
https://lore.kernel.org/all/20240204232945.1576403-1-yoann.congal@smile.fr/
* Patch v3 1/2:
  * Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>
  * Reviewed-by: John Ogness <john.ogness@linutronix.de>
  * Reviewed-by: Petr Mladek <pmladek@suse.com>
* Patch v3 2/2:
  * Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>

v2 -> v3: Applied Luis Chamberlain's comments (Thanks!):
* Split the single commit in two : one functional fix, one global
  removal.

v2 patch was named "printk: Remove redundant CONFIG_BASE_SMALL"
https://lore.kernel.org/all/20240127220026.1722399-1-yoann.congal@smile.fr/
* Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>
* Reviewed-by: John Ogness <john.ogness@linutronix.de>

v1 -> v2: Applied Masahiro Yamada's comments (Thanks!):
* Changed from "Change CONFIG_BASE_SMALL to type bool" to
  "Remove it and switch usage to !CONFIG_BASE_FULL"
* Fixed "Fixes:" tag and reference to the mailing list thread.
* Added a note about CONFIG_LOG_CPU_MAX_BUF_SHIFT changing.

v1 patch was named "treewide: Change CONFIG_BASE_SMALL to bool type"
https://lore.kernel.org/all/20240126163032.1613731-1-yoann.congal@smile.fr/

Yoann Congal (3):
  printk: Fix LOG_CPU_MAX_BUF_SHIFT when BASE_SMALL is enabled
  printk: Change type of CONFIG_BASE_SMALL to bool
  printk: Remove redundant CONFIG_BASE_FULL

 arch/arm/configs/collie_defconfig                  |  2 +-
 arch/arm/configs/keystone_defconfig                |  2 +-
 arch/arm/configs/lpc18xx_defconfig                 |  2 +-
 arch/arm/configs/moxart_defconfig                  |  2 +-
 arch/arm/configs/mps2_defconfig                    |  2 +-
 arch/arm/configs/omap1_defconfig                   |  2 +-
 arch/arm/configs/stm32_defconfig                   |  2 +-
 arch/microblaze/configs/mmu_defconfig              |  2 +-
 arch/mips/configs/rs90_defconfig                   |  2 +-
 arch/powerpc/configs/adder875_defconfig            |  2 +-
 arch/powerpc/configs/ep88xc_defconfig              |  2 +-
 arch/powerpc/configs/mpc866_ads_defconfig          |  2 +-
 arch/powerpc/configs/mpc885_ads_defconfig          |  2 +-
 arch/powerpc/configs/tqm8xx_defconfig              |  2 +-
 arch/riscv/configs/nommu_k210_defconfig            |  2 +-
 arch/riscv/configs/nommu_k210_sdcard_defconfig     |  2 +-
 arch/riscv/configs/nommu_virt_defconfig            |  2 +-
 arch/sh/configs/edosk7705_defconfig                |  2 +-
 arch/sh/configs/se7619_defconfig                   |  2 +-
 arch/sh/configs/se7712_defconfig                   |  2 +-
 arch/sh/configs/se7721_defconfig                   |  2 +-
 arch/sh/configs/shmin_defconfig                    |  2 +-
 arch/x86/include/asm/mpspec.h                      |  6 +++---
 drivers/tty/vt/vc_screen.c                         |  2 +-
 include/linux/threads.h                            |  4 ++--
 include/linux/udp.h                                |  2 +-
 include/linux/xarray.h                             |  2 +-
 init/Kconfig                                       | 14 ++++----------
 kernel/futex/core.c                                |  2 +-
 kernel/user.c                                      |  2 +-
 .../testing/selftests/wireguard/qemu/kernel.config |  1 -
 31 files changed, 36 insertions(+), 43 deletions(-)

-- 
2.39.2


