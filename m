Return-Path: <linux-serial+bounces-12498-lists+linux-serial=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-serial@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDWgMcH+cWmvZwAAu9opvQ
	(envelope-from <linux-serial+bounces-12498-lists+linux-serial=lfdr.de@vger.kernel.org>)
	for <lists+linux-serial@lfdr.de>; Thu, 22 Jan 2026 11:41:05 +0100
X-Original-To: lists+linux-serial@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C45965622
	for <lists+linux-serial@lfdr.de>; Thu, 22 Jan 2026 11:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B688944B3F9
	for <lists+linux-serial@lfdr.de>; Thu, 22 Jan 2026 10:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B4F40FDA4;
	Thu, 22 Jan 2026 10:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GrjO1EE8"
X-Original-To: linux-serial@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520163D34A6;
	Thu, 22 Jan 2026 10:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769077444; cv=none; b=eMVTGK3M6SJEnmGnCe7c9D939soxbygIjEPfzB+lkVMJyyFXANF8O+46/mAJH+G+RDyZ+sSX1J823zF7bGY6a2vdj7u821bCtsx8d8zG9yZFxTTXK5m+EmaP3gxsFoSwR5IIr33Phm9bxIw2KN0VcxEPLBOX9Ih+T0irX6jQ0iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769077444; c=relaxed/simple;
	bh=uTiTQ01g0GllJB8U43pVQU4kXZOWEcw7b3TRyEuxnPg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E82URWHRPTuiy/DXjLXl+Opo97C02Q7Lso5AdH7YDTe4h6hYKcr+HewdBhHmdZuXWUi4kh/hZir+9LrQxTSqOk1D1RMGBpG3vGD8qEAAufV9sWFklRgZK8+gAM2PsceV1dG+leTumNTNxHn8HFPkiMyn9ZaakKvJO1wfY6gOOaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GrjO1EE8; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769077442; x=1800613442;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uTiTQ01g0GllJB8U43pVQU4kXZOWEcw7b3TRyEuxnPg=;
  b=GrjO1EE8zCA7AB27jP2c6n3rnC1lYLpVz/EgsGnEox44IvPBVdeJmymn
   42ELfkH+ixewzSKuXfHrvK867fI574EUfRCxONz7C0JfLXJO+k8Oj+B5c
   mTp6FXFNAPx/sKL+Xuf7jHUX7RNcKRDQ4yT2IFFUGEURpDnh0T3wggN3p
   u24o8lqFt2gAAXCa6BIkax7kLjtTcVp2Ae2SOZ/2/UhQvQlxJaBMFA99a
   ZBF+rkF/HmhVnkFx4OZZF+smeZfGbWyNTe5M5GfObVoi2NIXtlhWEJ+iY
   +yDdCI5EE1GZ+UIegE3oAXLI2yAX51fdnkslKOxR1puqdGeVjSTZZMMQe
   g==;
X-CSE-ConnectionGUID: DsGGEN/ZR4mdQXNLAl8QOQ==
X-CSE-MsgGUID: rrosdSLSQrq7VxHUaVURPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="95790490"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="95790490"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 02:23:59 -0800
X-CSE-ConnectionGUID: /tnuQFeSQb2tjbtePBW/Dw==
X-CSE-MsgGUID: ncYWQdrBQ3eVtEiWBfpDkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="206958324"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa008.fm.intel.com with ESMTP; 22 Jan 2026 02:23:56 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id B7E9295; Thu, 22 Jan 2026 11:23:55 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Tony Lindgren <tony@atomide.com>
Subject: [PATCH v1 0/2] serial: 8250: Remove highly customised deprecated interface
Date: Thu, 22 Jan 2026 11:19:46 +0100
Message-ID: <20260122102349.2395423-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-12498-lists,linux-serial=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-serial];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-serial@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,intel.com:dkim,linux.intel.com:mid]
X-Rspamd-Queue-Id: 7C45965622
X-Rspamd-Action: no action

The custom divisor interface not only old and deprecated, it's too much
driver-dependent. For the user it's not easy to understand what to supply
as a value (usually encoded) via that interface. On top of it, there is
an existing BOTHER mechanism that allows to do the same and more without
any tribal knowledge.

Remove highly customised deprecated interface to set baud rates.

Note, the "standard" custom_divisor that is used as a plain value
for "quot" is still left and may be used by the respective drivers
including but not limited to 8250.

Andy Shevchenko (2):
  serial: 8250_omap: Remove custom deprecated baud setting routine
  serial: 8250_pci: Remove custom deprecated baud setting routine

 Documentation/misc-devices/oxsemi-tornado.rst | 26 +-----
 drivers/tty/serial/8250/8250_omap.c           | 16 ----
 drivers/tty/serial/8250/8250_pci.c            | 85 ++++++++-----------
 3 files changed, 38 insertions(+), 89 deletions(-)

-- 
2.50.1


