Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3E2D972F9
	for <lists+linux-serial@lfdr.de>; Wed, 21 Aug 2019 09:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbfHUHG5 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 21 Aug 2019 03:06:57 -0400
Received: from mga04.intel.com ([192.55.52.120]:51812 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727206AbfHUHG5 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 21 Aug 2019 03:06:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 00:06:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,411,1559545200"; 
   d="scan'208";a="202931129"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga004.fm.intel.com with ESMTP; 21 Aug 2019 00:06:54 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        gregkh@linuxfoundation.org, mark.rutland@arm.com,
        linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        qi-ming.wu@intel.com, cheol.yong.kim@intel.com,
        rahul.tanwar@intel.com, Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v3 0/2] dt-bindings: serial: lantiq: Convert to YAML & add support for new SoC
Date:   Wed, 21 Aug 2019 15:06:50 +0800
Message-Id: <cover.1566370151.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

There is a new product which reuses Lantiq serial controller IP. Patch 1 in this
series converts existing lantiq dt bindings to YAML schema and Patch 2 updates
it to support newer product.

These patches are baselined upon Linux 5.3-rc4 at below Git tree:
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git

v3:
* Use compatible name for filename.
* Use if/then schema to describe a property which is different for each
  compatibles.
* Address other review concerns about YAML format.

v2:
* Update license to GPL-2.0-only.
* Fix trailing whitespace error.


Rahul Tanwar (2):
  dt-bindings: serial: lantiq: Convert to YAML schema
  dt-bindings: lantiq: Update for new SoC

 .../devicetree/bindings/serial/lantiq,asc.yaml     | 90 ++++++++++++++++++++++
 .../devicetree/bindings/serial/lantiq_asc.txt      | 31 --------
 2 files changed, 90 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/lantiq,asc.yaml
 delete mode 100644 Documentation/devicetree/bindings/serial/lantiq_asc.txt

-- 
2.11.0

