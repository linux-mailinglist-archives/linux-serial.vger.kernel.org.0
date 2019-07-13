Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB6067C00
	for <lists+linux-serial@lfdr.de>; Sat, 13 Jul 2019 23:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbfGMVLA (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sat, 13 Jul 2019 17:11:00 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:37654 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbfGMVLA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 13 Jul 2019 17:11:00 -0400
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23992479AbfGMVK7AdiON (ORCPT
        <rfc822;linux-serial@vger.kernel.org> + 1 other);
        Sat, 13 Jul 2019 23:10:59 +0200
Date:   Sat, 13 Jul 2019 23:10:58 +0200
From:   Ladislav Michl <ladis@linux-mips.org>
To:     linux-usb@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 2/5] usb: gadget: u_serial: Remove console specific
 alloc/free req functions
Message-ID: <20190713211057.GC25753@lenoch>
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

Driver already contains request allocation and deallocation
functions, so use them also for console_req.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 Changes:
 - v2: Move locking changes into separate patch

 drivers/usb/gadget/function/u_serial.c | 28 ++------------------------
 1 file changed, 2 insertions(+), 26 deletions(-)

diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index 876af4085cea..cb88a640179e 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -892,30 +892,6 @@ static struct tty_driver *gs_tty_driver;
 static struct gscons_info gscons_info;
 static struct console gserial_cons;
 
-static struct usb_request *gs_request_new(struct usb_ep *ep)
-{
-	struct usb_request *req = usb_ep_alloc_request(ep, GFP_ATOMIC);
-	if (!req)
-		return NULL;
-
-	req->buf = kmalloc(ep->maxpacket, GFP_ATOMIC);
-	if (!req->buf) {
-		usb_ep_free_request(ep, req);
-		return NULL;
-	}
-
-	return req;
-}
-
-static void gs_request_free(struct usb_request *req, struct usb_ep *ep)
-{
-	if (!req)
-		return;
-
-	kfree(req->buf);
-	usb_ep_free_request(ep, req);
-}
-
 static void gs_complete_out(struct usb_ep *ep, struct usb_request *req)
 {
 	struct gscons_info *info = &gscons_info;
@@ -955,7 +931,7 @@ static int gs_console_connect(int port_num)
 	port = ports[port_num].port;
 	ep = port->port_usb->in;
 	if (!info->console_req) {
-		info->console_req = gs_request_new(ep);
+		info->console_req = gs_alloc_req(ep, ep->maxpacket, GFP_ATOMIC);
 		if (!info->console_req)
 			return -ENOMEM;
 		info->console_req->complete = gs_complete_out;
@@ -974,7 +950,7 @@ static void gs_console_disconnect(struct usb_ep *ep)
 	struct gscons_info *info = &gscons_info;
 	struct usb_request *req = info->console_req;
 
-	gs_request_free(req, ep);
+	gs_free_req(ep, req);
 	info->console_req = NULL;
 }
 
-- 
2.22.0

