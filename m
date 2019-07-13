Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F294167C02
	for <lists+linux-serial@lfdr.de>; Sat, 13 Jul 2019 23:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbfGMVLZ (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sat, 13 Jul 2019 17:11:25 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:37654 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbfGMVLZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 13 Jul 2019 17:11:25 -0400
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23992479AbfGMVLXnQrDN (ORCPT
        <rfc822;linux-serial@vger.kernel.org> + 1 other);
        Sat, 13 Jul 2019 23:11:23 +0200
Date:   Sat, 13 Jul 2019 23:11:22 +0200
From:   Ladislav Michl <ladis@linux-mips.org>
To:     linux-usb@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 3/5] usb: gadget: u_serial: Fix console_req access race
Message-ID: <20190713211122.GD25753@lenoch>
References: <20190713210853.GA25753@lenoch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190713210853.GA25753@lenoch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

console_req is always null when calling gs_console_connect, so
remove check and put access under con_lock as we are racing with
gs_console_thread.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 Changes:
 - v2: New patch

 drivers/usb/gadget/function/u_serial.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index cb88a640179e..558a6929ce68 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -930,15 +930,12 @@ static int gs_console_connect(int port_num)
 
 	port = ports[port_num].port;
 	ep = port->port_usb->in;
-	if (!info->console_req) {
-		info->console_req = gs_alloc_req(ep, ep->maxpacket, GFP_ATOMIC);
-		if (!info->console_req)
-			return -ENOMEM;
-		info->console_req->complete = gs_complete_out;
-	}
-
-	info->port = port;
 	spin_lock(&info->con_lock);
+	info->console_req = gs_alloc_req(ep, ep->maxpacket, GFP_ATOMIC);
+	if (!info->console_req)
+		return -ENOMEM;
+	info->console_req->complete = gs_complete_out;
+	info->port = port;
 	info->req_busy = 0;
 	spin_unlock(&info->con_lock);
 	pr_vdebug("port[%d] console connect!\n", port_num);
@@ -948,10 +945,11 @@ static int gs_console_connect(int port_num)
 static void gs_console_disconnect(struct usb_ep *ep)
 {
 	struct gscons_info *info = &gscons_info;
-	struct usb_request *req = info->console_req;
 
-	gs_free_req(ep, req);
+	spin_lock(&info->con_lock);
+	gs_free_req(ep, info->console_req);
 	info->console_req = NULL;
+	spin_unlock(&info->con_lock);
 }
 
 static int gs_console_thread(void *data)
@@ -1008,7 +1006,6 @@ static int gs_console_setup(struct console *co, char *options)
 	info->port = NULL;
 	info->console_req = NULL;
 	info->req_busy = 0;
-	spin_lock_init(&info->con_lock);
 
 	status = kfifo_alloc(&info->con_buf, GS_CONSOLE_BUF_SIZE, GFP_KERNEL);
 	if (status) {
@@ -1064,6 +1061,9 @@ static struct console gserial_cons = {
 
 static void gserial_console_init(void)
 {
+	struct gscons_info *info = &gscons_info;
+
+	spin_lock_init(&info->con_lock);
 	register_console(&gserial_cons);
 }
 
-- 
2.22.0

