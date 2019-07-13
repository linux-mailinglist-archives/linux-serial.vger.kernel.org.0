Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5D467C06
	for <lists+linux-serial@lfdr.de>; Sat, 13 Jul 2019 23:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbfGMVMj (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sat, 13 Jul 2019 17:12:39 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:37654 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbfGMVMj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 13 Jul 2019 17:12:39 -0400
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23992886AbfGMVMh6VykN (ORCPT
        <rfc822;linux-serial@vger.kernel.org> + 1 other);
        Sat, 13 Jul 2019 23:12:37 +0200
Date:   Sat, 13 Jul 2019 23:12:33 +0200
From:   Ladislav Michl <ladis@linux-mips.org>
To:     linux-usb@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 5/5] usb: gadget: u_serial: Use bool for req_busy
Message-ID: <20190713211233.GF25753@lenoch>
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

Let's make code more consistent by using bool for req_busy
as it is done for similar variables in struct gs_port.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 Changes:
 - v2: None

 drivers/usb/gadget/function/u_serial.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index 2dd6e1211d4a..1b1359a168e7 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -89,7 +89,7 @@ struct gscons_info {
 	struct kfifo		con_buf;
 	/* protect the buf and busy flag */
 	spinlock_t		con_lock;
-	int			req_busy;
+	bool			req_busy;
 	struct usb_request	*console_req;
 };
 
@@ -918,7 +918,7 @@ static void gs_complete_out(struct usb_ep *ep, struct usb_request *req)
 	case 0:
 		/* normal completion */
 		spin_lock(&info->con_lock);
-		info->req_busy = 0;
+		info->req_busy = false;
 		spin_unlock(&info->con_lock);
 
 		wake_up_process(info->console_thread);
@@ -950,7 +950,6 @@ static int gs_console_connect(int port_num)
 		return -ENOMEM;
 	info->console_req->complete = gs_complete_out;
 	info->port = port;
-	info->req_busy = 0;
 	spin_unlock(&info->con_lock);
 	pr_vdebug("port[%d] console connect!\n", port_num);
 	return 0;
@@ -989,13 +988,13 @@ static int gs_console_thread(void *data)
 				size = len;
 
 			req->length = kfifo_out(&info->con_buf, req->buf, size);
-			info->req_busy = 1;
+			info->req_busy = true;
 
 			spin_unlock_irq(&info->con_lock);
 			status = usb_ep_queue(ep, req, GFP_ATOMIC);
 			spin_lock_irq(&info->con_lock);
 			if (status < 0)
-				info->req_busy = 0;
+				info->req_busy = false;
 		} else {
 sched:
 			spin_unlock_irq(&info->con_lock);
@@ -1019,7 +1018,7 @@ static int gs_console_setup(struct console *co, char *options)
 
 	info->port = NULL;
 	info->console_req = NULL;
-	info->req_busy = 0;
+	info->req_busy = false;
 
 	status = kfifo_alloc(&info->con_buf, GS_CONSOLE_BUF_SIZE, GFP_KERNEL);
 	if (status) {
-- 
2.22.0

