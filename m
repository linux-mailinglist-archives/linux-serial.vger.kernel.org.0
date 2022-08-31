Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2696C5A733D
	for <lists+linux-serial@lfdr.de>; Wed, 31 Aug 2022 03:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbiHaBPq (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 30 Aug 2022 21:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiHaBPp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 30 Aug 2022 21:15:45 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080ED6C757
        for <linux-serial@vger.kernel.org>; Tue, 30 Aug 2022 18:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661908545; x=1693444545;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ej2sS08Bkp1mOUAQC80kWeoejOTp1goYbLmP3/7rLBk=;
  b=XGtZewr7ot+sGG/6j4tFjHG+xQ10c8WVBJJrkyYaDuHiF5ckvSW0KCdP
   SkY4QAgUhw7/3J2/HJSDTbxaHEmGXEyTBmExEnCLxG01n03ZOVnVQOOR9
   gXUsGdKensLfB3PjYFRs/YnMZ40oEGLeGG6eRlnV1/o3ajSqcHD7KMbvq
   vcv0syoh9+sEo2GOTcXf25eIw/wO9YRAPUmFDigTxZiLM2daYPzS6zyLh
   XxrkT4hK66ZGkYd3Dlp273Y/dhkr1LzpCPm/tJDIMhpA/qQgu7/SBgxNF
   xByTnGwPh5Oo1sowuEBIKKwKpZsHo5Cddmhss2hvf8p21yf/CuDFUlITU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="295348479"
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="295348479"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 18:15:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="611933755"
Received: from lkp-server02.sh.intel.com (HELO 77b6d4e16fc5) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 30 Aug 2022 18:15:43 -0700
Received: from kbuild by 77b6d4e16fc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTCKU-0000pa-2T;
        Wed, 31 Aug 2022 01:15:42 +0000
Date:   Wed, 31 Aug 2022 09:15:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 902e02ea9385373ce4b142576eef41c642703955
Message-ID: <630eb62f.raXWpIGMKG5Sah6p%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
branch HEAD: 902e02ea9385373ce4b142576eef41c642703955  tty: n_gsm: avoid call of sleeping functions from atomic context

elapsed time: 726m

configs tested: 53
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                  randconfig-r043-20220830
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                                defconfig
x86_64                        randconfig-a006
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
sh                               allmodconfig
i386                          randconfig-a001
x86_64                        randconfig-a013
i386                          randconfig-a003
i386                             allyesconfig
x86_64                        randconfig-a011
i386                          randconfig-a005
i386                          randconfig-a014
x86_64                        randconfig-a015
x86_64                          rhel-8.3-func
i386                          randconfig-a012
m68k                             allmodconfig
x86_64                         rhel-8.3-kunit
i386                          randconfig-a016
arc                              allyesconfig
x86_64                    rhel-8.3-kselftests
alpha                            allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
ia64                             allmodconfig
arm                                 defconfig
m68k                             allyesconfig
arm                              allyesconfig
arm64                            allyesconfig

clang tested configs:
hexagon              randconfig-r045-20220830
riscv                randconfig-r042-20220830
hexagon              randconfig-r041-20220830
s390                 randconfig-r044-20220830
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a013
i386                          randconfig-a002
i386                          randconfig-a015
x86_64                        randconfig-a016
i386                          randconfig-a004
x86_64                        randconfig-a012
i386                          randconfig-a006
i386                          randconfig-a011
x86_64                        randconfig-a014

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
