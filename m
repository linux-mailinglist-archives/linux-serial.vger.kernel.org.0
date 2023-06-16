Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207ED732409
	for <lists+linux-serial@lfdr.de>; Fri, 16 Jun 2023 02:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbjFPAFB (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 15 Jun 2023 20:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjFPAFA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 15 Jun 2023 20:05:00 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD7A2719
        for <linux-serial@vger.kernel.org>; Thu, 15 Jun 2023 17:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686873898; x=1718409898;
  h=date:from:to:cc:subject:message-id;
  bh=Z2A+OqRzDrIdeWndxV8CKE4JWP8xRdBVhethK4a32K8=;
  b=lGRxghBw5njbEIrlZsFYLYaLViL1qtPf8DoD5UiZV4hJouwiDgAUjQ8C
   2uT/k8uS7CxpXftOSbqcZKcruVYrBDKVXFWTCyY0RoToSDPe3lZhuM6xt
   Br6+zWyjr1BeOElp2CNJdmOfcr6gE9HGBiQybYCbDoyyJcJcpKi709Dwg
   i59toRLeBoqYfsWQBvyxPaUBGTMJJDtf3QYqX/tg9UESlc9QMLkpoZ8TN
   hlP8/mOLRYEyai6DmUIqrXW/wvvWwja8DKAQJRxOYxJama172XGJpIJdn
   VQrzhttjF5k7KzkGvdKAj0MMQD1egpO86RZyOXarG00U5v4p+XgzbCKkk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="425002438"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="425002438"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 17:04:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="689997226"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="689997226"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 15 Jun 2023 17:04:57 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q9wxU-0000XV-2T;
        Fri, 16 Jun 2023 00:04:56 +0000
Date:   Fri, 16 Jun 2023 08:04:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 e8cc334847dbd204ed4f500b3e3fa899b3766b62
Message-ID: <202306160835.mvs3bOUV-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: e8cc334847dbd204ed4f500b3e3fa899b3766b62  selftests: tty: add selftest for tty timestamp updates

elapsed time: 720m

configs tested: 145
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r004-20230614   gcc  
alpha        buildonly-randconfig-r004-20230615   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r023-20230615   gcc  
alpha                randconfig-r025-20230615   gcc  
alpha                randconfig-r026-20230615   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230615   gcc  
arc                           tb10x_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                         axm55xx_defconfig   gcc  
arm                                 defconfig   gcc  
arm                          gemini_defconfig   gcc  
arm                         nhk8815_defconfig   gcc  
arm                  randconfig-r046-20230615   gcc  
arm                         s5pv210_defconfig   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r005-20230614   clang
arm64                               defconfig   gcc  
arm64                randconfig-r034-20230615   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r014-20230615   gcc  
hexagon              randconfig-r003-20230615   clang
hexagon              randconfig-r015-20230615   clang
hexagon              randconfig-r041-20230615   clang
hexagon              randconfig-r045-20230615   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230614   clang
i386                 randconfig-i002-20230614   clang
i386                 randconfig-i003-20230614   clang
i386                 randconfig-i004-20230614   clang
i386                 randconfig-i005-20230614   clang
i386                 randconfig-i006-20230614   clang
i386                 randconfig-i011-20230614   gcc  
i386                 randconfig-i011-20230615   clang
i386                 randconfig-i012-20230614   gcc  
i386                 randconfig-i012-20230615   clang
i386                 randconfig-i013-20230614   gcc  
i386                 randconfig-i013-20230615   clang
i386                 randconfig-i014-20230614   gcc  
i386                 randconfig-i014-20230615   clang
i386                 randconfig-i015-20230614   gcc  
i386                 randconfig-i015-20230615   clang
i386                 randconfig-i016-20230614   gcc  
i386                 randconfig-i016-20230615   clang
i386                 randconfig-r024-20230615   clang
i386                 randconfig-r036-20230615   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r012-20230615   gcc  
m68k                 randconfig-r013-20230614   gcc  
m68k                 randconfig-r033-20230615   gcc  
m68k                           virt_defconfig   gcc  
microblaze           randconfig-r001-20230615   gcc  
microblaze           randconfig-r011-20230615   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r002-20230614   gcc  
mips                 randconfig-r006-20230615   clang
mips                 randconfig-r022-20230615   gcc  
mips                 randconfig-r024-20230615   gcc  
nios2                               defconfig   gcc  
openrisc             randconfig-r012-20230614   gcc  
openrisc             randconfig-r013-20230615   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r025-20230615   gcc  
parisc               randconfig-r036-20230615   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r003-20230614   gcc  
powerpc                      makalu_defconfig   gcc  
powerpc              randconfig-r011-20230614   gcc  
powerpc              randconfig-r035-20230615   gcc  
powerpc                      walnut_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r033-20230615   gcc  
riscv                randconfig-r042-20230615   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r001-20230614   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r014-20230614   gcc  
s390                 randconfig-r021-20230615   clang
s390                 randconfig-r026-20230615   clang
s390                 randconfig-r044-20230615   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r001-20230615   gcc  
sh                         ecovec24_defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                   randconfig-r016-20230614   gcc  
sh                   randconfig-r031-20230615   gcc  
sh                   randconfig-r032-20230615   gcc  
sparc                            allyesconfig   gcc  
sparc        buildonly-randconfig-r003-20230615   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r005-20230615   gcc  
sparc64      buildonly-randconfig-r005-20230615   gcc  
sparc64              randconfig-r016-20230615   gcc  
sparc64              randconfig-r021-20230615   gcc  
sparc64              randconfig-r032-20230615   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230614   clang
x86_64               randconfig-a001-20230615   gcc  
x86_64               randconfig-a002-20230614   clang
x86_64               randconfig-a002-20230615   gcc  
x86_64               randconfig-a003-20230614   clang
x86_64               randconfig-a003-20230615   gcc  
x86_64               randconfig-a004-20230614   clang
x86_64               randconfig-a004-20230615   gcc  
x86_64               randconfig-a005-20230614   clang
x86_64               randconfig-a005-20230615   gcc  
x86_64               randconfig-a006-20230614   clang
x86_64               randconfig-a006-20230615   gcc  
x86_64               randconfig-a011-20230615   clang
x86_64               randconfig-a012-20230615   clang
x86_64               randconfig-a013-20230615   clang
x86_64               randconfig-a014-20230615   clang
x86_64               randconfig-a015-20230615   clang
x86_64               randconfig-a016-20230615   clang
x86_64               randconfig-r022-20230615   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r006-20230614   gcc  
xtensa               randconfig-r002-20230615   gcc  
xtensa               randconfig-r015-20230614   gcc  
xtensa               randconfig-r031-20230615   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
