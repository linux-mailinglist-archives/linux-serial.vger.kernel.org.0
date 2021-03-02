Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0731E32B07D
	for <lists+linux-serial@lfdr.de>; Wed,  3 Mar 2021 04:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240701AbhCCCQz (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 2 Mar 2021 21:16:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:39910 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1835887AbhCBGYp (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 2 Mar 2021 01:24:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 53225B025;
        Tue,  2 Mar 2021 06:22:19 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 22/44] tty: nozomi, remove struct buffer
Date:   Tue,  2 Mar 2021 07:21:52 +0100
Message-Id: <20210302062214.29627-22-jslaby@suse.cz>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302062214.29627-1-jslaby@suse.cz>
References: <20210302062214.29627-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

It is unused.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/nozomi.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
index 861e95043191..83490925a3e2 100644
--- a/drivers/tty/nozomi.c
+++ b/drivers/tty/nozomi.c
@@ -359,12 +359,6 @@ struct nozomi {
 	u32 open_ttys;
 };
 
-/* This is a data packet that is read or written to/from card */
-struct buffer {
-	u32 size;		/* size is the length of the data buffer */
-	u8 *data;
-} __attribute__ ((packed));
-
 /* Global variables */
 static const struct pci_device_id nozomi_pci_tbl[] = {
 	{PCI_DEVICE(0x1931, 0x000c)},	/* Nozomi HSDPA */
-- 
2.30.1

