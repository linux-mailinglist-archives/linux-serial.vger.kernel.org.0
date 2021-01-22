Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 015BA2FF909
	for <lists+linux-serial@lfdr.de>; Fri, 22 Jan 2021 00:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbhAUXof (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 21 Jan 2021 18:44:35 -0500
Received: from mga11.intel.com ([192.55.52.93]:29200 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725271AbhAUXod (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 Jan 2021 18:44:33 -0500
IronPort-SDR: yZ5eu2+GTugZTLhg1nO0aBw6kQkvcCXqkS+UugiVdhkvAZcpPduNi2AwLa5abz5HXLTxZT2Leu
 z71CyZWhZXoQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="175853326"
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="175853326"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 15:43:50 -0800
IronPort-SDR: tdFXccUlkXJlcvusMosf0SrBUZKqOpjC0GU8hIwfZkrjG5DIm6YMGe2fmqb5LzgNq/BFiSmlHs
 gk5hW/Ki6hCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="427571433"
Received: from lkp-server01.sh.intel.com (HELO 260eafd5ecd0) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 21 Jan 2021 15:43:49 -0800
Received: from kbuild by 260eafd5ecd0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l2jcC-0006mD-HO; Thu, 21 Jan 2021 23:43:48 +0000
Date:   Fri, 22 Jan 2021 07:43:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 3cfade53c77315d018c50ea1ee3420cef1c50fe7
Message-ID: <600a119e.TTEKWNz2C5QyfQm2%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 3cfade53c77315d018c50ea1ee3420cef1c50fe7  Merge branch 'tty-splice' of git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux into tty-next

elapsed time: 727m

configs tested: 123
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
openrisc                         alldefconfig
arm                            lart_defconfig
arm                            pleb_defconfig
arm                         assabet_defconfig
sh                           se7619_defconfig
arm                        trizeps4_defconfig
h8300                     edosk2674_defconfig
arc                        vdk_hs38_defconfig
powerpc                 mpc832x_mds_defconfig
arm                        keystone_defconfig
ia64                         bigsur_defconfig
arc                          axs101_defconfig
x86_64                           alldefconfig
mips                          ath79_defconfig
sh                          lboxre2_defconfig
powerpc                      pcm030_defconfig
arm                           h3600_defconfig
arm                            xcep_defconfig
mips                      loongson3_defconfig
mips                           ci20_defconfig
h8300                       h8s-sim_defconfig
mips                        jmr3927_defconfig
mips                    maltaup_xpa_defconfig
sparc64                          alldefconfig
arm                        cerfcube_defconfig
m68k                        stmark2_defconfig
mips                            ar7_defconfig
m68k                           sun3_defconfig
h8300                               defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                     ppa8548_defconfig
arm                         cm_x300_defconfig
mips                           ip27_defconfig
m68k                         amcore_defconfig
powerpc                     sequoia_defconfig
mips                          ath25_defconfig
arm                         orion5x_defconfig
c6x                         dsk6455_defconfig
powerpc                     pseries_defconfig
mips                           rs90_defconfig
mips                       bmips_be_defconfig
sh                        edosk7705_defconfig
arm                        spear6xx_defconfig
sh                          r7785rp_defconfig
powerpc                       holly_defconfig
s390                             alldefconfig
sh                  sh7785lcr_32bit_defconfig
mips                       lemote2f_defconfig
arm                         socfpga_defconfig
powerpc                    socrates_defconfig
m68k                       m5208evb_defconfig
parisc                generic-32bit_defconfig
arm                          pxa910_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nios2                               defconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                             allyesconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20210121
x86_64               randconfig-a003-20210121
x86_64               randconfig-a001-20210121
x86_64               randconfig-a005-20210121
x86_64               randconfig-a006-20210121
x86_64               randconfig-a004-20210121
i386                 randconfig-a001-20210121
i386                 randconfig-a002-20210121
i386                 randconfig-a003-20210121
i386                 randconfig-a004-20210121
i386                 randconfig-a006-20210121
i386                 randconfig-a005-20210121
i386                 randconfig-a011-20210121
i386                 randconfig-a012-20210121
i386                 randconfig-a015-20210121
i386                 randconfig-a013-20210121
i386                 randconfig-a014-20210121
i386                 randconfig-a016-20210121
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
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
