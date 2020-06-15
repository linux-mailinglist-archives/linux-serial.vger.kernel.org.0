Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5E01F9082
	for <lists+linux-serial@lfdr.de>; Mon, 15 Jun 2020 09:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbgFOHug (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 15 Jun 2020 03:50:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:40062 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728863AbgFOHtU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Jun 2020 03:49:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C604AB036;
        Mon, 15 Jun 2020 07:49:18 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 20/38] vc: simplify condition in vc_con_write_normal
Date:   Mon, 15 Jun 2020 09:48:52 +0200
Message-Id: <20200615074910.19267-20-jslaby@suse.cz>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200615074910.19267-1-jslaby@suse.cz>
References: <20200615074910.19267-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Convert (!(A && !B) || C) into (!A || B || C) to improve readability.

No functional changes, as was just proven by objdump.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 893f72dc812c..d3cd256ba0fa 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2747,7 +2747,7 @@ static int vc_con_write_normal(struct vc_data *vc, int tc, int c,
 			return -1; /* nothing to display */
 
 		/* Glyph not found */
-		if ((!(vc->vc_utf && !vc->vc_disp_ctrl) || c < 128) &&
+		if ((!vc->vc_utf || vc->vc_disp_ctrl || c < 128) &&
 				!(c & ~charmask)) {
 			/*
 			 * In legacy mode use the glyph we get by a 1:1
-- 
2.27.0

