Return-Path: <linux-serial+bounces-10469-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEEFB2609F
	for <lists+linux-serial@lfdr.de>; Thu, 14 Aug 2025 11:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34C76A269A5
	for <lists+linux-serial@lfdr.de>; Thu, 14 Aug 2025 09:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D26E2E7183;
	Thu, 14 Aug 2025 09:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aVOXsldm"
X-Original-To: linux-serial@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD6525F7A9
	for <linux-serial@vger.kernel.org>; Thu, 14 Aug 2025 09:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755162635; cv=none; b=KCbhk9h8milDY3xsTFRJAEy7rahUY5J49IVUqJVuRFT3J6sAq3JU/pJdkldgO32/lJDd3xUqwLIZ9+uD6DHT14pxkhImMAhes07Cx9XtfSGEhkUNrYfFdbLGJGq4Wrz8+XglFNpi92hKC1gXL/wvy/1JCJv8bmlLyBA2v90QpWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755162635; c=relaxed/simple;
	bh=ciGUjwYNOBWbSCce5NB1U0UGOXBIDrWamKl2aLvxBKE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=pICh/Z3AZjp3umSKXOhQVJBfrdVj27oX5+pKS/LlvWzPxz1n6GiPc3p5Z0kTJd+Lzv3ZYyUyf/riZHPGNldrq9hQzvUR9vbw5DDn6Viw79WvZDD0Xbg0tbYm4PwnhbiIR7ZYTAGa2UE2rCUr/a2nvMaHw1P8LRvE38QrfXSkrJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aVOXsldm; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755162633; x=1786698633;
  h=date:from:to:cc:subject:message-id;
  bh=ciGUjwYNOBWbSCce5NB1U0UGOXBIDrWamKl2aLvxBKE=;
  b=aVOXsldmqazTGGb2x/OI+2xw5J1FNsi7P46oFJjULXAAT6YSFoWapzaY
   WUenNvwboKTyRFesvoIcT59cbeakImpxRBk2TWAjUi1b+IpbOadDH2eOk
   oYf/XPqno48qpGIpyZwfN/MI+XwvUx57mMnJHhOQt0s/He9mPBCV8WpWR
   yOWWCph5rNTmIeeEN2BoWEEKUeJHMkH/gwU1uQ8NrO5depDsgfj5B5/Uh
   ojUpzmFhvTmcJ9xwXNW9ELpmSP0ShswY3yARh32RprBFN8fi+cxK9kpmZ
   d5hIuiGnOVU74F9GLM9gyNU/lYghJAGgQemzAHfABJwPB/31RoGumH5zw
   g==;
X-CSE-ConnectionGUID: 2IKjHa2fRRK8OXcmkHormg==
X-CSE-MsgGUID: d8BUHKpIRCKxwJDJavXTYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="68848959"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="68848959"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 02:10:32 -0700
X-CSE-ConnectionGUID: ebZc8m4ZSAK/nvk6ChfRQg==
X-CSE-MsgGUID: PpiU4aO3SdqTP5LeNK0xwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="166624469"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 14 Aug 2025 02:10:32 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1umTyH-000Amw-0C;
	Thu, 14 Aug 2025 09:10:16 +0000
Date: Thu, 14 Aug 2025 17:08:44 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 96c08ff80b8fce45e49fee5eba4b40b1654eb5aa
Message-ID: <202508141731.ENYdHzC6-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 96c08ff80b8fce45e49fee5eba4b40b1654eb5aa  tty: sysrq: delete unnecessary check

elapsed time: 968m

configs tested: 211
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                               allnoconfig    clang-22
arc                              allyesconfig    clang-19
arc                                 defconfig    clang-19
arc                        nsimosci_defconfig    clang-22
arc                   randconfig-001-20250814    gcc-10.5.0
arc                   randconfig-001-20250814    gcc-12.5.0
arc                   randconfig-002-20250814    gcc-10.5.0
arc                   randconfig-002-20250814    gcc-13.4.0
arc                    vdk_hs38_smp_defconfig    clang-22
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                                 defconfig    clang-19
arm                            mps2_defconfig    clang-22
arm                   randconfig-001-20250814    clang-22
arm                   randconfig-001-20250814    gcc-10.5.0
arm                   randconfig-002-20250814    clang-22
arm                   randconfig-002-20250814    gcc-10.5.0
arm                   randconfig-003-20250814    gcc-10.5.0
arm                   randconfig-004-20250814    gcc-10.5.0
arm                   randconfig-004-20250814    gcc-8.5.0
arm                           sunxi_defconfig    clang-22
arm                         vf610m4_defconfig    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250814    clang-17
arm64                 randconfig-001-20250814    gcc-10.5.0
arm64                 randconfig-002-20250814    gcc-10.5.0
arm64                 randconfig-002-20250814    gcc-8.5.0
arm64                 randconfig-003-20250814    gcc-10.5.0
arm64                 randconfig-004-20250814    gcc-10.5.0
arm64                 randconfig-004-20250814    gcc-13.4.0
csky                              allnoconfig    clang-22
csky                                defconfig    clang-19
csky                  randconfig-001-20250814    gcc-10.5.0
csky                  randconfig-001-20250814    gcc-15.1.0
csky                  randconfig-002-20250814    gcc-10.5.0
csky                  randconfig-002-20250814    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250814    clang-20
hexagon               randconfig-001-20250814    gcc-10.5.0
hexagon               randconfig-002-20250814    clang-22
hexagon               randconfig-002-20250814    gcc-10.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250814    clang-20
i386        buildonly-randconfig-002-20250814    clang-20
i386        buildonly-randconfig-002-20250814    gcc-12
i386        buildonly-randconfig-003-20250814    clang-20
i386        buildonly-randconfig-003-20250814    gcc-12
i386        buildonly-randconfig-004-20250814    clang-20
i386        buildonly-randconfig-005-20250814    clang-20
i386        buildonly-randconfig-005-20250814    gcc-12
i386        buildonly-randconfig-006-20250814    clang-20
i386        buildonly-randconfig-006-20250814    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250814    clang-20
i386                  randconfig-002-20250814    clang-20
i386                  randconfig-003-20250814    clang-20
i386                  randconfig-004-20250814    clang-20
i386                  randconfig-005-20250814    clang-20
i386                  randconfig-006-20250814    clang-20
i386                  randconfig-007-20250814    clang-20
i386                  randconfig-011-20250814    gcc-12
i386                  randconfig-012-20250814    gcc-12
i386                  randconfig-013-20250814    gcc-12
i386                  randconfig-014-20250814    gcc-12
i386                  randconfig-015-20250814    gcc-12
i386                  randconfig-016-20250814    gcc-12
i386                  randconfig-017-20250814    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250814    clang-22
loongarch             randconfig-001-20250814    gcc-10.5.0
loongarch             randconfig-002-20250814    gcc-10.5.0
loongarch             randconfig-002-20250814    gcc-15.1.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250814    gcc-10.5.0
nios2                 randconfig-002-20250814    gcc-10.5.0
nios2                 randconfig-002-20250814    gcc-9.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250814    gcc-10.5.0
parisc                randconfig-002-20250814    gcc-10.5.0
parisc                randconfig-002-20250814    gcc-13.4.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc               randconfig-001-20250814    gcc-10.5.0
powerpc               randconfig-001-20250814    gcc-8.5.0
powerpc               randconfig-002-20250814    gcc-10.5.0
powerpc               randconfig-002-20250814    gcc-8.5.0
powerpc               randconfig-003-20250814    gcc-10.5.0
powerpc                     stx_gp3_defconfig    clang-22
powerpc64             randconfig-001-20250814    clang-22
powerpc64             randconfig-001-20250814    gcc-10.5.0
powerpc64             randconfig-002-20250814    clang-22
powerpc64             randconfig-002-20250814    gcc-10.5.0
powerpc64             randconfig-003-20250814    clang-22
powerpc64             randconfig-003-20250814    gcc-10.5.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250814    clang-22
riscv                 randconfig-002-20250814    clang-22
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250814    clang-22
s390                  randconfig-002-20250814    clang-22
s390                  randconfig-002-20250814    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250814    clang-22
sh                    randconfig-001-20250814    gcc-9.5.0
sh                    randconfig-002-20250814    clang-22
sh                    randconfig-002-20250814    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250814    clang-22
sparc                 randconfig-001-20250814    gcc-14.3.0
sparc                 randconfig-002-20250814    clang-22
sparc                 randconfig-002-20250814    gcc-12.5.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250814    clang-22
sparc64               randconfig-002-20250814    clang-22
sparc64               randconfig-002-20250814    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250814    clang-22
um                    randconfig-002-20250814    clang-22
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250814    clang-20
x86_64      buildonly-randconfig-002-20250814    clang-20
x86_64      buildonly-randconfig-003-20250814    clang-20
x86_64      buildonly-randconfig-003-20250814    gcc-12
x86_64      buildonly-randconfig-004-20250814    clang-20
x86_64      buildonly-randconfig-005-20250814    clang-20
x86_64      buildonly-randconfig-005-20250814    gcc-12
x86_64      buildonly-randconfig-006-20250814    clang-20
x86_64      buildonly-randconfig-006-20250814    gcc-12
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-071-20250814    gcc-12
x86_64                randconfig-072-20250814    gcc-12
x86_64                randconfig-073-20250814    gcc-12
x86_64                randconfig-074-20250814    gcc-12
x86_64                randconfig-075-20250814    gcc-12
x86_64                randconfig-076-20250814    gcc-12
x86_64                randconfig-077-20250814    gcc-12
x86_64                randconfig-078-20250814    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                       common_defconfig    clang-22
xtensa                randconfig-001-20250814    clang-22
xtensa                randconfig-001-20250814    gcc-8.5.0
xtensa                randconfig-002-20250814    clang-22
xtensa                randconfig-002-20250814    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

