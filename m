Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 211BD2D6EAD
	for <lists+linux-serial@lfdr.de>; Fri, 11 Dec 2020 04:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733054AbgLKDd2 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 10 Dec 2020 22:33:28 -0500
Received: from mga02.intel.com ([134.134.136.20]:50895 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390777AbgLKDcq (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 10 Dec 2020 22:32:46 -0500
IronPort-SDR: MT/Z4NrWACZxYMLs9xhjM/nRdgnqufECIFOOAND66XLNWsiUBJgXeg7jyVnL70ANJv8NcS9G9s
 uEufdT4MSI9Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9831"; a="161424792"
X-IronPort-AV: E=Sophos;i="5.78,410,1599548400"; 
   d="scan'208";a="161424792"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2020 19:32:05 -0800
IronPort-SDR: 4D9xR04mMGL6v21OWTGsoBMJxtodrUAzP6s7DvAaHSiWs7/cl6fh6Qy1ixr5ECrKAqBi06eFnF
 FaQ9xpXWkyhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,410,1599548400"; 
   d="scan'208";a="408926134"
Received: from lkp-server01.sh.intel.com (HELO ecc0cebe68d1) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 10 Dec 2020 19:32:04 -0800
Received: from kbuild by ecc0cebe68d1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1knZA4-0000j9-04; Fri, 11 Dec 2020 03:32:04 +0000
Date:   Fri, 11 Dec 2020 11:31:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 d96f04d347e4011977abdbb4da5d8f303ebd26f8
Message-ID: <5fd2e7fa.Fo1vxLdyKTvAFZyK%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git  tty-testing
branch HEAD: d96f04d347e4011977abdbb4da5d8f303ebd26f8  serial: 8250_omap: Avoid FIFO corruption caused by MDR1 access

elapsed time: 720m

configs tested: 157
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arc                         haps_hs_defconfig
arm                          ixp4xx_defconfig
arm                          simpad_defconfig
sh                 kfr2r09-romimage_defconfig
um                             i386_defconfig
arc                            hsdk_defconfig
mips                    maltaup_xpa_defconfig
arm                          ep93xx_defconfig
arm                            zeus_defconfig
sh                           se7343_defconfig
sh                            migor_defconfig
mips                        vocore2_defconfig
arm                         orion5x_defconfig
powerpc                 mpc836x_mds_defconfig
arm                     eseries_pxa_defconfig
arm                      tct_hammer_defconfig
powerpc                    mvme5100_defconfig
powerpc                      acadia_defconfig
sh                             shx3_defconfig
arm                          imote2_defconfig
mips                malta_kvm_guest_defconfig
sh                          sdk7780_defconfig
powerpc                 mpc8560_ads_defconfig
arm                         lubbock_defconfig
arm                          tango4_defconfig
mips                           gcw0_defconfig
powerpc                     asp8347_defconfig
powerpc                         ps3_defconfig
sh                           se7705_defconfig
sh                        sh7763rdp_defconfig
sparc64                          alldefconfig
h8300                               defconfig
sh                          rsk7201_defconfig
mips                           rs90_defconfig
arm                          collie_defconfig
openrisc                    or1ksim_defconfig
mips                        bcm63xx_defconfig
alpha                            alldefconfig
sh                         microdev_defconfig
arm                           u8500_defconfig
powerpc                        icon_defconfig
m68k                             alldefconfig
sh                          r7785rp_defconfig
sh                   secureedge5410_defconfig
ia64                          tiger_defconfig
arm                        mini2440_defconfig
sh                              ul2_defconfig
c6x                                 defconfig
mips                             allyesconfig
mips                          rb532_defconfig
mips                        bcm47xx_defconfig
sh                          urquell_defconfig
sh                          sdk7786_defconfig
powerpc                      ppc64e_defconfig
arm                         palmz72_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                         shannon_defconfig
sh                               j2_defconfig
m68k                       m5249evb_defconfig
arm                       versatile_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                 mpc834x_itx_defconfig
sh                               alldefconfig
powerpc                      cm5200_defconfig
powerpc                      ppc40x_defconfig
mips                          rm200_defconfig
arm                             mxs_defconfig
riscv                            alldefconfig
powerpc                      arches_defconfig
m68k                        m5272c3_defconfig
powerpc                 mpc837x_rdb_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
sparc                            allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20201209
i386                 randconfig-a005-20201209
i386                 randconfig-a001-20201209
i386                 randconfig-a002-20201209
i386                 randconfig-a006-20201209
i386                 randconfig-a003-20201209
i386                 randconfig-a001-20201210
i386                 randconfig-a004-20201210
i386                 randconfig-a003-20201210
i386                 randconfig-a002-20201210
i386                 randconfig-a005-20201210
i386                 randconfig-a006-20201210
x86_64               randconfig-a016-20201209
x86_64               randconfig-a012-20201209
x86_64               randconfig-a013-20201209
x86_64               randconfig-a014-20201209
x86_64               randconfig-a015-20201209
x86_64               randconfig-a011-20201209
i386                 randconfig-a013-20201209
i386                 randconfig-a014-20201209
i386                 randconfig-a011-20201209
i386                 randconfig-a015-20201209
i386                 randconfig-a012-20201209
i386                 randconfig-a016-20201209
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20201209
x86_64               randconfig-a006-20201209
x86_64               randconfig-a005-20201209
x86_64               randconfig-a001-20201209
x86_64               randconfig-a002-20201209
x86_64               randconfig-a003-20201209
x86_64               randconfig-a003-20201210
x86_64               randconfig-a006-20201210
x86_64               randconfig-a002-20201210
x86_64               randconfig-a005-20201210
x86_64               randconfig-a004-20201210
x86_64               randconfig-a001-20201210

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
