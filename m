Return-Path: <linux-serial+bounces-660-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E6E809DEB
	for <lists+linux-serial@lfdr.de>; Fri,  8 Dec 2023 09:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4595E1C20972
	for <lists+linux-serial@lfdr.de>; Fri,  8 Dec 2023 08:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE52410781;
	Fri,  8 Dec 2023 08:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lOs0qbtA"
X-Original-To: linux-serial@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9671712
	for <linux-serial@vger.kernel.org>; Fri,  8 Dec 2023 00:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702023059; x=1733559059;
  h=date:from:to:cc:subject:message-id;
  bh=xwPlAflH5mIFIOi4xZ3tVJLvY6XacgDbQCizYrZDZjg=;
  b=lOs0qbtAelMhGX5r3xpcVgLy8ZBymbHq2ZHXOD5JWVEFeKr80kqaynIt
   QDWKcLEvWEVBZIkL3LnRYv6StFOjgbcWH4HAAVhLlLwRS63asyJlBoWAe
   WYnfRIWKuy4ip8qNUQH1bcYhtVbHk+PDw4UU2vCPFu3MyuLK+DPDL+5UJ
   N63aXM8UUYRK3wmYOSrrfYbrTMtXDfLLEjQTa8Fniq/rGYyg3m+HBTwkG
   mMDtrE3xnRH8itokGfa/SNFmmN9uEjBBhlfwBDFtwvLIEI+E9fP5atvEO
   oNLceggSxX0Qoywj0eqdDXiGlYdXHoQ9VLWlw7BIsJU+xGnPrXHDuWvbM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="1456724"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="1456724"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 00:10:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="1103485439"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="1103485439"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 08 Dec 2023 00:09:40 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rBVvW-000DTb-1n;
	Fri, 08 Dec 2023 08:09:38 +0000
Date: Fri, 08 Dec 2023 16:09:16 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 e92fad024929c79460403acf946bc9c09ce5c3a9
Message-ID: <202312081613.oY4Xp0d0-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
branch HEAD: e92fad024929c79460403acf946bc9c09ce5c3a9  serial: 8250_dw: Add ACPI ID for Granite Rapids-D UART

elapsed time: 1477m

configs tested: 214
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231207   gcc  
arc                   randconfig-001-20231208   gcc  
arc                   randconfig-002-20231207   gcc  
arc                   randconfig-002-20231208   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                               allnoconfig   gcc  
arm                         assabet_defconfig   gcc  
arm                           h3600_defconfig   gcc  
arm                      integrator_defconfig   gcc  
arm                      jornada720_defconfig   gcc  
arm                       multi_v4t_defconfig   gcc  
arm                        multi_v7_defconfig   gcc  
arm                   randconfig-001-20231207   gcc  
arm                   randconfig-002-20231207   gcc  
arm                   randconfig-003-20231207   gcc  
arm                   randconfig-004-20231207   gcc  
arm                         s3c6400_defconfig   gcc  
arm                           sunxi_defconfig   gcc  
arm                           tegra_defconfig   gcc  
arm                         wpcm450_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231207   gcc  
arm64                 randconfig-002-20231207   gcc  
arm64                 randconfig-003-20231207   gcc  
arm64                 randconfig-004-20231207   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231207   gcc  
csky                  randconfig-001-20231208   gcc  
csky                  randconfig-002-20231207   gcc  
csky                  randconfig-002-20231208   gcc  
hexagon                          allmodconfig   clang
hexagon                          allyesconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386                                defconfig   gcc  
i386                  randconfig-011-20231207   clang
i386                  randconfig-011-20231208   gcc  
i386                  randconfig-012-20231207   clang
i386                  randconfig-012-20231208   gcc  
i386                  randconfig-013-20231207   clang
i386                  randconfig-013-20231208   gcc  
i386                  randconfig-014-20231207   clang
i386                  randconfig-014-20231208   gcc  
i386                  randconfig-015-20231207   clang
i386                  randconfig-015-20231208   gcc  
i386                  randconfig-016-20231207   clang
i386                  randconfig-016-20231208   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch                 loongson3_defconfig   gcc  
loongarch             randconfig-001-20231207   gcc  
loongarch             randconfig-001-20231208   gcc  
loongarch             randconfig-002-20231207   gcc  
loongarch             randconfig-002-20231208   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                            mac_defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
m68k                        stmark2_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ci20_defconfig   gcc  
mips                      loongson3_defconfig   gcc  
mips                         rt305x_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231207   gcc  
nios2                 randconfig-001-20231208   gcc  
nios2                 randconfig-002-20231207   gcc  
nios2                 randconfig-002-20231208   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231207   gcc  
parisc                randconfig-001-20231208   gcc  
parisc                randconfig-002-20231207   gcc  
parisc                randconfig-002-20231208   gcc  
parisc64                         alldefconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      ep88xc_defconfig   gcc  
powerpc                  iss476-smp_defconfig   gcc  
powerpc                      makalu_defconfig   gcc  
powerpc                       ppc64_defconfig   gcc  
powerpc               randconfig-001-20231207   gcc  
powerpc               randconfig-002-20231207   gcc  
powerpc               randconfig-003-20231207   gcc  
powerpc                     stx_gp3_defconfig   gcc  
powerpc64             randconfig-001-20231207   gcc  
powerpc64             randconfig-002-20231207   gcc  
powerpc64             randconfig-003-20231207   gcc  
riscv                            allmodconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_k210_defconfig   gcc  
riscv                 randconfig-001-20231207   gcc  
riscv                 randconfig-002-20231207   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231208   gcc  
s390                  randconfig-002-20231208   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh                                  defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                    randconfig-001-20231207   gcc  
sh                    randconfig-001-20231208   gcc  
sh                    randconfig-002-20231207   gcc  
sh                    randconfig-002-20231208   gcc  
sh                          sdk7780_defconfig   gcc  
sh                           se7206_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231207   gcc  
sparc64               randconfig-001-20231208   gcc  
sparc64               randconfig-002-20231207   gcc  
sparc64               randconfig-002-20231208   gcc  
um                               allmodconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231207   gcc  
um                    randconfig-002-20231207   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231207   gcc  
x86_64       buildonly-randconfig-001-20231208   clang
x86_64       buildonly-randconfig-002-20231207   gcc  
x86_64       buildonly-randconfig-002-20231208   clang
x86_64       buildonly-randconfig-003-20231207   gcc  
x86_64       buildonly-randconfig-003-20231208   clang
x86_64       buildonly-randconfig-004-20231207   gcc  
x86_64       buildonly-randconfig-004-20231208   clang
x86_64       buildonly-randconfig-005-20231207   gcc  
x86_64       buildonly-randconfig-005-20231208   clang
x86_64       buildonly-randconfig-006-20231207   gcc  
x86_64       buildonly-randconfig-006-20231208   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20231207   gcc  
x86_64                randconfig-011-20231208   clang
x86_64                randconfig-012-20231207   gcc  
x86_64                randconfig-012-20231208   clang
x86_64                randconfig-013-20231207   gcc  
x86_64                randconfig-013-20231208   clang
x86_64                randconfig-014-20231207   gcc  
x86_64                randconfig-014-20231208   clang
x86_64                randconfig-015-20231207   gcc  
x86_64                randconfig-015-20231208   clang
x86_64                randconfig-016-20231207   gcc  
x86_64                randconfig-016-20231208   clang
x86_64                randconfig-071-20231207   gcc  
x86_64                randconfig-071-20231208   clang
x86_64                randconfig-072-20231207   gcc  
x86_64                randconfig-072-20231208   clang
x86_64                randconfig-073-20231207   gcc  
x86_64                randconfig-073-20231208   clang
x86_64                randconfig-074-20231207   gcc  
x86_64                randconfig-074-20231208   clang
x86_64                randconfig-075-20231207   gcc  
x86_64                randconfig-075-20231208   clang
x86_64                randconfig-076-20231207   gcc  
x86_64                randconfig-076-20231208   clang
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa                randconfig-001-20231207   gcc  
xtensa                randconfig-001-20231208   gcc  
xtensa                randconfig-002-20231207   gcc  
xtensa                randconfig-002-20231208   gcc  
xtensa                         virt_defconfig   gcc  
xtensa                    xip_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

