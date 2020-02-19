Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3E7F163FB3
	for <lists+linux-serial@lfdr.de>; Wed, 19 Feb 2020 09:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgBSItw (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 19 Feb 2020 03:49:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:49730 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbgBSItw (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Feb 2020 03:49:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2D75FACF2;
        Wed, 19 Feb 2020 08:49:51 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 03/10] n_gsm: introduce enum gsm_dlci_mode
Date:   Wed, 19 Feb 2020 09:49:42 +0100
Message-Id: <20200219084949.28074-3-jslaby@suse.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200219084949.28074-1-jslaby@suse.cz>
References: <20200219084949.28074-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

gsm_dlci->mode is clearly an enumeration. So introduce one and use it
-- compiler now checks if valid values are assigned to the field.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/n_gsm.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 1d0a140027ff..7fee5a580f21 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -107,6 +107,11 @@ enum gsm_dlci_state {
 	DLCI_CLOSING,		/* Sending DISC not seen UA/DM */
 };
 
+enum gsm_dlci_mode {
+	DLCI_MODE_ABM,		/* Normal Asynchronous Balanced Mode */
+	DLCI_MODE_ADM,		/* Asynchronous Disconnected Mode */
+};
+
 /*
  *	Each active data link has a gsm_dlci structure associated which ties
  *	the link layer to an optional tty (if the tty side is open). To avoid
@@ -124,9 +129,7 @@ struct gsm_dlci {
 	struct mutex mutex;
 
 	/* Link layer */
-	int mode;
-#define DLCI_MODE_ABM		0	/* Normal Asynchronous Balanced Mode */
-#define DLCI_MODE_ADM		1	/* Asynchronous Disconnected Mode */
+	enum gsm_dlci_mode mode;
 	spinlock_t lock;	/* Protects the internal state */
 	struct timer_list t1;	/* Retransmit timer for SABM and UA */
 	int retries;
-- 
2.25.0

