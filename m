Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25815475AB
	for <lists+linux-serial@lfdr.de>; Sat, 11 Jun 2022 16:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbiFKOiU (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sat, 11 Jun 2022 10:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235441AbiFKOiT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 11 Jun 2022 10:38:19 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C072763B5
        for <linux-serial@vger.kernel.org>; Sat, 11 Jun 2022 07:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654958298; x=1686494298;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=z78fEKbs/bMlPlpDjXeyWThmgX4eS4IK2jPlprOlNXE=;
  b=NINCZ/9u4m8qM9yFuNC0aunhrheOJP0zR0MEvqwtQc0aRfsNXN2eqSs/
   S9Cpn/2qrAeGJ01HVj0S2duJ8IeaNlFavySxFh1Jb3+uNLlUaF2EBlJdb
   9Cgq7jo4kCSLvotMqpOwcX+hmZP398wpzDPpfyyPOO+HUwEAltL8ndQV6
   Cu/aIHlkTkyY3cBWmsRwklHinsYGF1WALSBxFPcuNaCqmGn31FFxU3J9w
   c0d1ekPaSAqqEiv2xlYzb3Wrz8kKJm0crP49Wa2SNB3qLaj2TKF1CNGi8
   MrvUb07EEi8HfMtEumDzM/rC78ggdmhWl1py3+zfLC1pdzQlGJyXt3rrd
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10375"; a="266638943"
X-IronPort-AV: E=Sophos;i="5.91,293,1647327600"; 
   d="scan'208";a="266638943"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2022 07:38:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,293,1647327600"; 
   d="scan'208";a="650424210"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 11 Jun 2022 07:38:16 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o02Fk-000IyL-5V;
        Sat, 11 Jun 2022 14:38:16 +0000
Date:   Sat, 11 Jun 2022 22:37:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 be03b0651ffd8bab69dfd574c6818b446c0753ce
Message-ID: <62a4a8c6.7CBf75Keo5LFf0Zj%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
branch HEAD: be03b0651ffd8bab69dfd574c6818b446c0753ce  serial: 8250: Store to lsr_save_flags after lsr read

elapsed time: 1590m

configs tested: 112
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
ia64                         bigsur_defconfig
m68k                        m5272c3_defconfig
sh                            titan_defconfig
powerpc                 mpc837x_mds_defconfig
mips                         tb0226_defconfig
powerpc64                           defconfig
sh                          rsk7201_defconfig
powerpc                 canyonlands_defconfig
sh                          lboxre2_defconfig
powerpc                      makalu_defconfig
powerpc                        cell_defconfig
s390                          debug_defconfig
powerpc                      tqm8xx_defconfig
h8300                            allyesconfig
arm                           h5000_defconfig
mips                       capcella_defconfig
riscv             nommu_k210_sdcard_defconfig
sh                   secureedge5410_defconfig
powerpc                      ep88xc_defconfig
powerpc                       maple_defconfig
sh                     magicpanelr2_defconfig
arm                          badge4_defconfig
powerpc                     ep8248e_defconfig
powerpc                      mgcoge_defconfig
nios2                               defconfig
m68k                          amiga_defconfig
arm                            pleb_defconfig
sh                ecovec24-romimage_defconfig
powerpc                     taishan_defconfig
powerpc                     sequoia_defconfig
um                           x86_64_defconfig
sh                   sh7770_generic_defconfig
arc                    vdk_hs38_smp_defconfig
arm                             pxa_defconfig
powerpc                      ppc40x_defconfig
xtensa                           alldefconfig
mips                          rb532_defconfig
ia64                                defconfig
riscv                             allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
arc                              allyesconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a006
x86_64                        randconfig-a002
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220611
arc                  randconfig-r043-20220611
s390                 randconfig-r044-20220611
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
powerpc                    socrates_defconfig
powerpc                     ppa8548_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                             mxs_defconfig
arm                        magician_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
