Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5196D67BFE
	for <lists+linux-serial@lfdr.de>; Sat, 13 Jul 2019 23:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbfGMVKe (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sat, 13 Jul 2019 17:10:34 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:37654 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbfGMVKe (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 13 Jul 2019 17:10:34 -0400
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23992479AbfGMVKcjU9tN (ORCPT
        <rfc822;linux-serial@vger.kernel.org> + 1 other);
        Sat, 13 Jul 2019 23:10:32 +0200
Date:   Sat, 13 Jul 2019 23:10:31 +0200
From:   Ladislav Michl <ladis@linux-mips.org>
To:     linux-usb@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 1/5] usb: gadget: u_serial: Fix console_req complete event
 race
Message-ID: <20190713211031.GB25753@lenoch>
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

gs_complete_out might be called before con_lock following usb_ep_queue
is locked, which prevents any future output on the console. Fix that by
resetting req_busy only if usb_ep_queue fails. While there also put
variable access we are racing with connection/disconnection events
under con_lock as well.

Fixes: a5beaaf39455 ("usb: gadget: Add the console support for usb-to-serial port")
Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 Changes:
 - v2: None

 drivers/usb/gadget/function/u_serial.c | 41 +++++++++++---------------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index 65f634ec7fc2..876af4085cea 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -984,47 +984,40 @@ static int gs_console_thread(void *data)
 	struct gs_port *port;
 	struct usb_request *req;
 	struct usb_ep *ep;
-	int xfer, ret, count, size;
+	int len, size, status;
 
+	spin_lock_irq(&info->con_lock);
 	do {
 		port = info->port;
-		set_current_state(TASK_INTERRUPTIBLE);
-		if (!port || !port->port_usb
-		    || !port->port_usb->in || !info->console_req)
+		if (!port || !port->port_usb || !info->console_req)
 			goto sched;
 
 		req = info->console_req;
 		ep = port->port_usb->in;
+		len = kfifo_len(&info->con_buf);
+		if (len > 0 && !info->req_busy) {
+			size = ep->maxpacket;
+			if (len < size)
+				size = len;
 
-		spin_lock_irq(&info->con_lock);
-		count = kfifo_len(&info->con_buf);
-		size = ep->maxpacket;
-
-		if (count > 0 && !info->req_busy) {
-			set_current_state(TASK_RUNNING);
-			if (count < size)
-				size = count;
-
-			xfer = kfifo_out(&info->con_buf, req->buf, size);
-			req->length = xfer;
-
-			spin_unlock(&info->con_lock);
-			ret = usb_ep_queue(ep, req, GFP_ATOMIC);
-			spin_lock(&info->con_lock);
-			if (ret < 0)
-				info->req_busy = 0;
-			else
-				info->req_busy = 1;
+			req->length = kfifo_out(&info->con_buf, req->buf, size);
+			info->req_busy = 1;
 
 			spin_unlock_irq(&info->con_lock);
+			status = usb_ep_queue(ep, req, GFP_ATOMIC);
+			spin_lock_irq(&info->con_lock);
+			if (status < 0)
+				info->req_busy = 0;
 		} else {
-			spin_unlock_irq(&info->con_lock);
 sched:
+			spin_unlock_irq(&info->con_lock);
 			if (kthread_should_stop()) {
 				set_current_state(TASK_RUNNING);
 				break;
 			}
 			schedule();
+			set_current_state(TASK_INTERRUPTIBLE);
+			spin_lock_irq(&info->con_lock);
 		}
 	} while (1);
 
-- 
2.22.0

