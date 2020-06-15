Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 506651F9076
	for <lists+linux-serial@lfdr.de>; Mon, 15 Jun 2020 09:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbgFOHuN (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 15 Jun 2020 03:50:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:40052 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728866AbgFOHtU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Jun 2020 03:49:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 293C6AFDF;
        Mon, 15 Jun 2020 07:49:21 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 28/38] vt: simplify noncolor attributes in build_attr
Date:   Mon, 15 Jun 2020 09:49:00 +0200
Message-Id: <20200615074910.19267-28-jslaby@suse.cz>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200615074910.19267-1-jslaby@suse.cz>
References: <20200615074910.19267-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

All the attributes are bools, so do a simple shift instead of tests and
constants as bool is either 0 or 1.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 3aff2e3cf5a6..673177d4e859 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -719,10 +719,10 @@ static u8 build_attr(struct vc_data *vc, u8 _color,
 	u8 a = _color;
 	if (!vc->vc_can_do_color)
 		return _intensity |
-		       (_italic ? 2 : 0) |
-		       (_underline ? 4 : 0) |
-		       (_reverse ? 8 : 0) |
-		       (_blink ? 0x80 : 0);
+		       (_italic    << 1) |
+		       (_underline << 2) |
+		       (_reverse   << 3) |
+		       (_blink     << 7);
 	if (_italic)
 		a = (a & 0xF0) | vc->vc_itcolor;
 	else if (_underline)
-- 
2.27.0

