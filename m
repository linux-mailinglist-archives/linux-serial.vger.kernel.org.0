Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93BE6163FB9
	for <lists+linux-serial@lfdr.de>; Wed, 19 Feb 2020 09:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgBSItz (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 19 Feb 2020 03:49:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:49786 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726784AbgBSItz (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Feb 2020 03:49:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5EF81AC69;
        Wed, 19 Feb 2020 08:49:53 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 10/10] n_gsm: switch escape to bool
Date:   Wed, 19 Feb 2020 09:49:49 +0100
Message-Id: <20200219084949.28074-10-jslaby@suse.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200219084949.28074-1-jslaby@suse.cz>
References: <20200219084949.28074-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

gsm_mux->escape is used as a bool, so treat it as such.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/n_gsm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index e0283bb24bb5..d77ed82a4840 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -215,7 +215,7 @@ struct gsm_mux {
 	unsigned int len;
 	unsigned int address;
 	unsigned int count;
-	int escape;
+	bool escape;
 	int encoding;
 	u8 control;
 	u8 fcs;
@@ -1976,7 +1976,7 @@ static void gsm1_receive(struct gsm_mux *gsm, unsigned char c)
 	}
 
 	if (c == GSM1_ESCAPE) {
-		gsm->escape = 1;
+		gsm->escape = true;
 		return;
 	}
 
@@ -1986,7 +1986,7 @@ static void gsm1_receive(struct gsm_mux *gsm, unsigned char c)
 
 	if (gsm->escape) {
 		c ^= GSM1_ESCAPE_BITS;
-		gsm->escape = 0;
+		gsm->escape = false;
 	}
 	switch (gsm->state) {
 	case GSM_START:		/* First byte after SOF */
-- 
2.25.0

