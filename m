Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B2D4BB365
	for <lists+linux-serial@lfdr.de>; Fri, 18 Feb 2022 08:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbiBRHdC (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 18 Feb 2022 02:33:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbiBRHdA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Feb 2022 02:33:00 -0500
X-Greylist: delayed 67 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Feb 2022 23:32:39 PST
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06F9298AD8
        for <linux-serial@vger.kernel.org>; Thu, 17 Feb 2022 23:32:37 -0800 (PST)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20220218073127f282a3e7496fc0a801
        for <linux-serial@vger.kernel.org>;
        Fri, 18 Feb 2022 08:31:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=EBXVVXzuqxQZpJ7v89UZdV7W1f/O/+KXI4n9OYKaozE=;
 b=eX9Xm9P7vjJCE2roMer44/L2/Azjd4/a22KhwDrLONyLD1Ln8GVkkzf+9A/mab16Q1yzIC
 eQv4aBZUIrzi4iBW81JLcn71RX0ALV1cr4jeR5cm54GGx6jyAWsVU18TFG75vA1bq2CtcPU6
 pP69fzGbsL8dhalxTelUAmZ3VcFKE=;
From:   daniel.starke@siemens.com
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 3/7] tty: n_gsm: fix proper link termination after failed open
Date:   Thu, 17 Feb 2022 23:31:19 -0800
Message-Id: <20220218073123.2121-3-daniel.starke@siemens.com>
In-Reply-To: <20220218073123.2121-1-daniel.starke@siemens.com>
References: <20220218073123.2121-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-7517:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Trying to open a DLCI by sending a SABM frame may fail with a timeout.
The link is closed on the initiator side without informing the responder
about this event. The responder assumes the link is open after sending a
UA frame to answer the SABM frame. The link gets stuck in a half open
state.

This patch fixes this by initiating the proper link termination procedure
after link setup timeout instead of silently closing it down.

Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 0b1808e3a912..52224a3494a0 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1514,7 +1514,7 @@ static void gsm_dlci_t1(struct timer_list *t)
 			dlci->mode = DLCI_MODE_ADM;
 			gsm_dlci_open(dlci);
 		} else {
-			gsm_dlci_close(dlci);
+			gsm_dlci_begin_close(dlci); /* prevent half open link */
 		}
 
 		break;
-- 
2.25.1

