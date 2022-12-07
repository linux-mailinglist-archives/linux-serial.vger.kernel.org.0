Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8971B6463D4
	for <lists+linux-serial@lfdr.de>; Wed,  7 Dec 2022 23:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiLGWFe (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 7 Dec 2022 17:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiLGWFP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Dec 2022 17:05:15 -0500
X-Greylist: delayed 483 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 07 Dec 2022 14:04:15 PST
Received: from mail.someserver.de (mail2.someserver.de [31.15.66.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D3EAE85660
        for <linux-serial@vger.kernel.org>; Wed,  7 Dec 2022 14:04:15 -0800 (PST)
Received: from localhost (unknown [213.55.243.226])
        by mail.someserver.de (Postfix) with ESMTPSA id 39D44801C6;
        Wed,  7 Dec 2022 22:56:19 +0100 (CET)
From:   Christina Quast <contact@christina-quast.de>
To:     linux-serial@vger.kernel.org
Cc:     Christina Quast <contact@christina-quast.de>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Daniel Beer <daniel.beer@igorinstitute.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH tty-next 1/3] hid-ft260: Cleanup macro formatting
Date:   Wed,  7 Dec 2022 22:55:38 +0100
Message-Id: <20221207215540.114920-2-contact@christina-quast.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221207215540.114920-1-contact@christina-quast.de>
References: <20221207215540.114920-1-contact@christina-quast.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Signed-off-by: Christina Quast <contact@christina-quast.de>
Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: Daniel Beer <daniel.beer@igorinstitute.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/hid-ft260.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 79505c64dbfe..7edba9aaff43 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -29,7 +29,8 @@ MODULE_PARM_DESC(debug, "Toggle FT260 debugging messages");
 	} while (0)
 
 #define FT260_REPORT_MAX_LENGTH (64)
-#define FT260_I2C_DATA_REPORT_ID(len) (FT260_I2C_REPORT_MIN + (len - 1) / 4)
+#define FT260_I2C_DATA_REPORT_ID(len) (FT260_I2C_REPORT_MIN + ((len) - 1) / 4)
+
 /*
  * The input report format assigns 62 bytes for the data payload, but ft260
  * returns 60 and 2 in two separate transactions. To minimize transfer time
@@ -123,7 +124,7 @@ enum {
 	FT260_FLAG_START_STOP_REPEATED	= 0x07,
 };
 
-#define FT260_SET_REQUEST_VALUE(report_id) ((FT260_FEATURE << 8) | report_id)
+#define FT260_SET_REQUEST_VALUE(report_id) ((FT260_FEATURE << 8) | (report_id))
 
 /* Feature In reports */
 
-- 
2.35.1

