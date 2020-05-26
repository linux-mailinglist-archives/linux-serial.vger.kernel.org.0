Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB421CD174
	for <lists+linux-serial@lfdr.de>; Mon, 11 May 2020 07:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgEKF5c (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 11 May 2020 01:57:32 -0400
Received: from mga09.intel.com ([134.134.136.24]:42737 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbgEKF5c (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 11 May 2020 01:57:32 -0400
IronPort-SDR: ZuxvH/aDKSkMtlPEUUYLI7kTyhbdbjgQiJyM7TbUCC6WFcfpF6NhMoI4H3vgLn8kH2VEHJ2K+M
 MFpGkLI5oJcw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2020 22:57:31 -0700
IronPort-SDR: ZGSIcjZ7iMwxegO+BG1o4LQOwGGIzSmhrSP+OHvWaBIXy5M7BRgy37mhavehqnRvTUCywROdj+
 Uhur0t8iQGLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,378,1583222400"; 
   d="scan'208";a="371117369"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga001.fm.intel.com with ESMTP; 10 May 2020 22:57:29 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v3 0/2] serial: lantiq: Make driver modular & console configurable
Date:   Mon, 11 May 2020 13:57:25 +0800
Message-Id: <cover.1589176044.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Patch 1 is to make lantiq UART driver's use as console selectable/configurable.
Patch 2 adds changes so the driver can be compiled as module.

v3:
- Fix a section mismatch warning. Reported-by: kbuild test robot <lkp@intel.com>.

v2:
- Split into two patches. One for console configuration and two for
  modular driver. (Greg KH) 

v1:
- Initial version.


Rahul Tanwar (2):
  serial: lantiq: Make UART's use as console selectable
  serial: lantiq: Make driver modular

 drivers/tty/serial/Kconfig  | 13 +++++++++++--
 drivers/tty/serial/lantiq.c | 40 +++++++++++++++++++++++++++++++++++-----
 2 files changed, 46 insertions(+), 7 deletions(-)

-- 
2.11.0

