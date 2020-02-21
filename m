Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11A01168578
	for <lists+linux-serial@lfdr.de>; Fri, 21 Feb 2020 18:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbgBURsP (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 21 Feb 2020 12:48:15 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:58235 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgBURsP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 21 Feb 2020 12:48:15 -0500
Received: from mwalle01.sab.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 2574C23D09;
        Fri, 21 Feb 2020 18:48:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1582307292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=bC6qDTC4k9cKBmVPiBFXfJbFBlREttiFm87AHMXXcFQ=;
        b=GOT/7lSkX4I/ogNMgucjXNWWlAjUnQ+RQKD+h91JIsKRY/i8hRs20skUQHa5Jcc4ajA1CU
        ITxjiXgFFElpSebBnKGuHsxu0o7TkdsgUnLg64U9L9n8MoknT8syV+AtLNcWG84PEgMpgv
        umf5vs0EfJx0Xuk79S/56pURAmgwbKA=
From:   Michael Walle <michael@walle.cc>
To:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Jiri Slaby <jslaby@suse.com>, Peng Fan <peng.fan@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 0/9] tty: serial: fsl_lpuart various fixes and LS1028A support
Date:   Fri, 21 Feb 2020 18:47:45 +0100
Message-Id: <20200221174754.5295-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
X-Spam-Level: ******
X-Rspamd-Server: web
X-Spam-Status: Yes, score=6.40
X-Spam-Score: 6.40
X-Rspamd-Queue-Id: 2574C23D09
X-Spamd-Result: default: False [6.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         NEURAL_SPAM(0.00)[0.764];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[13];
         MID_CONTAINS_FROM(1.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:12941, ipnet:213.135.0.0/19, country:DE];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam: Yes
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

These are various fixes for problems I found during development of the
LS1028A support for the LPUART. Sorry for the quick v2, but I didn't
thought I could fix the DMA issue that fast.

Also, I'm not sure if this series should be split between the "tty: serial:
fsl_lpuart" patches and the devicetree patches. So unless someone tell me
otherwise I keep them together to avoid mention any dependencies.

Changes since v1:
 - DMA support fixes.

New patches:
  tty: serial: fsl_lpuart: fix DMA mapping
  arm64: dts: ls1028a: add "fsl,vf610-edma" compatible

Modified patches:
  arm64: dts: ls1028a: add missing LPUART nodes
   - add dma phandles


Michael Walle (9):
  Revert "tty: serial: fsl_lpuart: drop EARLYCON_DECLARE"
  tty: serial: fsl_lpuart: free IDs allocated by IDA
  tty: serial: fsl_lpuart: handle EPROBE_DEFER for DMA
  tty: serial: fsl_lpuart: fix DMA mapping
  dt-bindings: serial: lpuart: add ls1028a compatibility
  tty: serial: fsl_lpuart: add LS1028A support
  tty: serial: fsl_lpuart: add LS1028A earlycon support
  arm64: dts: ls1028a: add "fsl,vf610-edma" compatible
  arm64: dts: ls1028a: add missing LPUART nodes

 .../devicetree/bindings/serial/fsl-lpuart.txt |  10 +-
 .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi |  75 ++++++-
 drivers/tty/serial/fsl_lpuart.c               | 201 +++++++++++++-----
 3 files changed, 226 insertions(+), 60 deletions(-)

-- 
2.20.1

