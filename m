Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8F22A5E2F
	for <lists+linux-serial@lfdr.de>; Wed,  4 Nov 2020 07:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbgKDGm0 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 4 Nov 2020 01:42:26 -0500
Received: from mail-m17613.qiye.163.com ([59.111.176.13]:6516 "EHLO
        mail-m17613.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgKDGmZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 4 Nov 2020 01:42:25 -0500
X-Greylist: delayed 526 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Nov 2020 01:42:23 EST
Received: from ubuntu.localdomain (unknown [58.213.83.157])
        by mail-m17613.qiye.163.com (Hmail) with ESMTPA id BA271482BD6;
        Wed,  4 Nov 2020 14:33:39 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     opensource.kernel@vivo.com, bernard@vivo.com
Subject: [PATCH 1/2] drivers/tty: delete break after return
Date:   Tue,  3 Nov 2020 22:33:23 -0800
Message-Id: <20201104063327.15572-2-bernard@vivo.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201104063327.15572-1-bernard@vivo.com>
References: <20201104063327.15572-1-bernard@vivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZSx0YHx0fTUsdThkZVkpNS09PTEpNSUtLSU1VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS09ISFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Oi46OQw*ST8iIxgUCTw0HSID
        OA1PFApVSlVKTUtPT0xKTUlLT09NVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlOQ1VJ
        SkhVQ0hVSk5MWVdZCAFZQUlNTkI3Bg++
X-HM-Tid: 0a7591f6018c93bakuwsba271482bd6
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Delete break after return, which will never run.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/tty/nozomi.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
index d42b854cb7df..946cc16827aa 100644
--- a/drivers/tty/nozomi.c
+++ b/drivers/tty/nozomi.c
@@ -414,11 +414,9 @@ static void read_mem32(u32 *buf, const void __iomem *mem_addr_start,
 		buf16 = (u16 *) buf;
 		*buf16 = __le16_to_cpu(readw(ptr));
 		goto out;
-		break;
 	case 4:	/* 4 bytes */
 		*(buf) = __le32_to_cpu(readl(ptr));
 		goto out;
-		break;
 	}
 
 	while (i < size_bytes) {
@@ -460,7 +458,6 @@ static u32 write_mem32(void __iomem *mem_addr_start, const u32 *buf,
 		buf16 = (const u16 *)buf;
 		writew(__cpu_to_le16(*buf16), ptr);
 		return 2;
-		break;
 	case 1: /*
 		 * also needs to write 4 bytes in this case
 		 * so falling through..
@@ -468,7 +465,6 @@ static u32 write_mem32(void __iomem *mem_addr_start, const u32 *buf,
 	case 4: /* 4 bytes */
 		writel(__cpu_to_le32(*buf), ptr);
 		return 4;
-		break;
 	}
 
 	while (i < size_bytes) {
-- 
2.29.0

