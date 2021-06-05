Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD9939C52D
	for <lists+linux-serial@lfdr.de>; Sat,  5 Jun 2021 04:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbhFEChU (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 4 Jun 2021 22:37:20 -0400
Received: from mga01.intel.com ([192.55.52.88]:30903 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230169AbhFEChU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 4 Jun 2021 22:37:20 -0400
IronPort-SDR: V9qk8lFyvKRG6g6aGxIuYUaQTrb6pU512WNizegiynZLT879Ptvc93ZHcsu8Njx12bjdifE8gl
 iYJhhWDuL4qw==
X-IronPort-AV: E=McAfee;i="6200,9189,10005"; a="225725934"
X-IronPort-AV: E=Sophos;i="5.83,249,1616482800"; 
   d="scan'208";a="225725934"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 19:35:33 -0700
IronPort-SDR: bHvj5StbM04Bzc7+6RIKhYsjQDfPb1xQLkoLqS1CR3zjkQAXAQGgWgTPp5x56Pi0IjnJX+uOtl
 ohRtBQRbR+BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,249,1616482800"; 
   d="scan'208";a="401140619"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 04 Jun 2021 19:35:31 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lpM9r-0007Dt-5D; Sat, 05 Jun 2021 02:35:31 +0000
Date:   Sat, 05 Jun 2021 10:34:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 2877389f59dc455e4283ae23ad494b410c15b3a3
Message-ID: <60bae2bb.uvTCiI/R/IJIplM2%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 2877389f59dc455e4283ae23ad494b410c15b3a3  tty: vcc: use DEVICE_ATTR_*() macro

elapsed time: 731m

configs tested: 194
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                         hackkit_defconfig
h8300                               defconfig
ia64                      gensparse_defconfig
mips                           ci20_defconfig
s390                                defconfig
powerpc                 mpc837x_rdb_defconfig
mips                     cu1830-neo_defconfig
arm                        clps711x_defconfig
arc                         haps_hs_defconfig
mips                          rb532_defconfig
arm                          collie_defconfig
xtensa                generic_kc705_defconfig
powerpc                      mgcoge_defconfig
mips                          rm200_defconfig
powerpc                        fsp2_defconfig
arm                           stm32_defconfig
powerpc                 mpc8540_ads_defconfig
arc                            hsdk_defconfig
riscv             nommu_k210_sdcard_defconfig
arm                  colibri_pxa270_defconfig
powerpc                    adder875_defconfig
powerpc                       ebony_defconfig
sh                        apsh4ad0a_defconfig
arm                        keystone_defconfig
powerpc                    gamecube_defconfig
mips                      maltasmvp_defconfig
powerpc                 mpc836x_rdk_defconfig
mips                           gcw0_defconfig
powerpc                      obs600_defconfig
arm                           sama5_defconfig
mips                    maltaup_xpa_defconfig
powerpc                       eiger_defconfig
nios2                               defconfig
mips                           xway_defconfig
powerpc                          allmodconfig
arm                             pxa_defconfig
arm                         s3c6400_defconfig
arm                     am200epdkit_defconfig
arc                              alldefconfig
riscv                    nommu_virt_defconfig
arm                           tegra_defconfig
um                               alldefconfig
sh                           sh2007_defconfig
mips                         tb0287_defconfig
arm                            mmp2_defconfig
sparc                            alldefconfig
mips                           rs90_defconfig
i386                                defconfig
sh                        edosk7705_defconfig
arm                         shannon_defconfig
arm                       omap2plus_defconfig
mips                        qi_lb60_defconfig
powerpc                        warp_defconfig
mips                 decstation_r4k_defconfig
openrisc                            defconfig
arc                        nsim_700_defconfig
mips                        bcm47xx_defconfig
mips                            gpr_defconfig
ia64                                defconfig
powerpc                     taishan_defconfig
powerpc                 xes_mpc85xx_defconfig
sh                         apsh4a3a_defconfig
powerpc                      ppc40x_defconfig
h8300                    h8300h-sim_defconfig
powerpc                 canyonlands_defconfig
arm                          pxa168_defconfig
arm                         at91_dt_defconfig
mips                           jazz_defconfig
sh                           se7619_defconfig
powerpc                       maple_defconfig
nds32                             allnoconfig
sh                          r7780mp_defconfig
m68k                         apollo_defconfig
mips                           mtx1_defconfig
arm                            xcep_defconfig
sh                         ap325rxa_defconfig
sh                            titan_defconfig
powerpc                     stx_gp3_defconfig
sh                          rsk7201_defconfig
powerpc                    klondike_defconfig
arm                       imx_v6_v7_defconfig
powerpc                     sbc8548_defconfig
arm                   milbeaut_m10v_defconfig
sh                               allmodconfig
powerpc                      tqm8xx_defconfig
mips                           ip28_defconfig
powerpc                       holly_defconfig
xtensa                              defconfig
powerpc                     kmeter1_defconfig
mips                         cobalt_defconfig
powerpc                   motionpro_defconfig
m68k                            q40_defconfig
arm                      integrator_defconfig
powerpc                     ppa8548_defconfig
powerpc                     kilauea_defconfig
mips                           ip22_defconfig
alpha                            alldefconfig
arm                         mv78xx0_defconfig
xtensa                          iss_defconfig
mips                       lemote2f_defconfig
mips                      maltaaprp_defconfig
nios2                         3c120_defconfig
sparc                       sparc32_defconfig
sh                        sh7785lcr_defconfig
arm                        multi_v7_defconfig
m68k                                defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20210604
x86_64               randconfig-a004-20210604
x86_64               randconfig-a003-20210604
x86_64               randconfig-a006-20210604
x86_64               randconfig-a005-20210604
x86_64               randconfig-a001-20210604
i386                 randconfig-a003-20210604
i386                 randconfig-a006-20210604
i386                 randconfig-a004-20210604
i386                 randconfig-a001-20210604
i386                 randconfig-a005-20210604
i386                 randconfig-a002-20210604
i386                 randconfig-a003-20210603
i386                 randconfig-a006-20210603
i386                 randconfig-a004-20210603
i386                 randconfig-a001-20210603
i386                 randconfig-a002-20210603
i386                 randconfig-a005-20210603
x86_64               randconfig-a015-20210603
x86_64               randconfig-a011-20210603
x86_64               randconfig-a012-20210603
x86_64               randconfig-a014-20210603
x86_64               randconfig-a016-20210603
x86_64               randconfig-a013-20210603
i386                 randconfig-a015-20210604
i386                 randconfig-a013-20210604
i386                 randconfig-a016-20210604
i386                 randconfig-a011-20210604
i386                 randconfig-a014-20210604
i386                 randconfig-a012-20210604
i386                 randconfig-a015-20210603
i386                 randconfig-a013-20210603
i386                 randconfig-a011-20210603
i386                 randconfig-a016-20210603
i386                 randconfig-a014-20210603
i386                 randconfig-a012-20210603
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210604
x86_64               randconfig-a015-20210604
x86_64               randconfig-a011-20210604
x86_64               randconfig-a014-20210604
x86_64               randconfig-a012-20210604
x86_64               randconfig-a016-20210604
x86_64               randconfig-a013-20210604

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
