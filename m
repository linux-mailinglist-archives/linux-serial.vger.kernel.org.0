Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8833800A4
	for <lists+linux-serial@lfdr.de>; Fri, 14 May 2021 01:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhEMXDg (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 13 May 2021 19:03:36 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49577 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbhEMXDg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 13 May 2021 19:03:36 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lhKLY-0002Iw-Kp; Thu, 13 May 2021 23:02:24 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] serial: kgdb_nmi: remove redundant initialization of variable c
Date:   Fri, 14 May 2021 00:02:24 +0100
Message-Id: <20210513230224.138859-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable c is being initialized with a value that is never
read, it is being updated later on. The assignment is redundant and
can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/tty/serial/kgdb_nmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/kgdb_nmi.c b/drivers/tty/serial/kgdb_nmi.c
index db059b66438e..7e07ee915f3f 100644
--- a/drivers/tty/serial/kgdb_nmi.c
+++ b/drivers/tty/serial/kgdb_nmi.c
@@ -115,7 +115,7 @@ static void kgdb_tty_recv(int ch)
 static int kgdb_nmi_poll_one_knock(void)
 {
 	static int n;
-	int c = -1;
+	int c;
 	const char *magic = kgdb_nmi_magic;
 	size_t m = strlen(magic);
 	bool printch = false;
-- 
2.30.2

