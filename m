Return-Path: <linux-serial+bounces-299-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4817FEDDD
	for <lists+linux-serial@lfdr.de>; Thu, 30 Nov 2023 12:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF9E91C20C2A
	for <lists+linux-serial@lfdr.de>; Thu, 30 Nov 2023 11:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FA63C69D;
	Thu, 30 Nov 2023 11:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XtWkDfK5"
X-Original-To: linux-serial@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD743C696;
	Thu, 30 Nov 2023 11:30:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39501C433C9;
	Thu, 30 Nov 2023 11:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701343806;
	bh=9wqXAJVEw+p80c6qcG/8U08Liv8b+fzMW7FHXTNRBlQ=;
	h=From:To:Cc:Subject:Date:From;
	b=XtWkDfK5Ujq91qSWGQYSJIxUxo6b+Nhu3g7upiTfRLRpMwsCnnKinL+nHRgO/v8D4
	 xWBCxkaG1WCwGO0e4j60aX1xZYwIofd7TBEleKTENLYLxltQfiJbow5ULOvJZotIG3
	 3kEDRh83ICmFGx2H6tIHyGyRQr7PvpnERUNY9ivCjCP+PTSUyKHyr3qqbFTxkqW64Q
	 MqtfqtZ/VyBHkQTwWy7BGpvG7TaZ14Rrf1nk95YHUk1HncQ3EcJzf5+YdIWn0OBFUi
	 5A0I1muWePw3VfGR3SRO2rmBqW+XoU/fh8gw7pAD2lGBtS6V59IVhWbmY/gZyhfB9g
	 QKJ9PWOvv8N7g==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	Amit Shah <amit@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	linux-alpha@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH] tty: virtio: drop virtio_cons_early_init()
Date: Thu, 30 Nov 2023 12:30:01 +0100
Message-ID: <20231130113001.29154-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The last user of virtio_cons_early_init() was dropped in commit
7fb2b2d51244 ("s390/virtio: remove the old KVM virtio transport").

So now, drop virtio_cons_early_init() and the logic and headers behind
too.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Amit Shah <amit@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: linux-alpha@vger.kernel.org
Cc: virtualization@lists.linux.dev
---
 MAINTAINERS                    |  1 -
 drivers/char/virtio_console.c  | 48 ----------------------------------
 include/linux/virtio_console.h | 38 ---------------------------
 3 files changed, 87 deletions(-)
 delete mode 100644 include/linux/virtio_console.h

diff --git a/MAINTAINERS b/MAINTAINERS
index b81da7a36a36..345797d89e11 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23055,7 +23055,6 @@ M:	Amit Shah <amit@kernel.org>
 L:	virtualization@lists.linux.dev
 S:	Maintained
 F:	drivers/char/virtio_console.c
-F:	include/linux/virtio_console.h
 F:	include/uapi/linux/virtio_console.h
 
 VIRTIO CORE AND NET DRIVERS
diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 431e9e5bf9c1..8abe599c1c07 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -230,9 +230,6 @@ struct port {
 	bool guest_connected;
 };
 
-/* This is the very early arch-specified put chars function. */
-static int (*early_put_chars)(u32, const char *, int);
-
 static struct port *find_port_by_vtermno(u32 vtermno)
 {
 	struct port *port;
@@ -1114,9 +1111,6 @@ static int put_chars(u32 vtermno, const char *buf, int count)
 	void *data;
 	int ret;
 
-	if (unlikely(early_put_chars))
-		return early_put_chars(vtermno, buf, count);
-
 	port = find_port_by_vtermno(vtermno);
 	if (!port)
 		return -EPIPE;
@@ -1142,10 +1136,6 @@ static int get_chars(u32 vtermno, char *buf, int count)
 {
 	struct port *port;
 
-	/* If we've not set up the port yet, we have no input to give. */
-	if (unlikely(early_put_chars))
-		return 0;
-
 	port = find_port_by_vtermno(vtermno);
 	if (!port)
 		return -EPIPE;
@@ -1201,21 +1191,6 @@ static const struct hv_ops hv_ops = {
 	.notifier_hangup = notifier_del_vio,
 };
 
-/*
- * Console drivers are initialized very early so boot messages can go
- * out, so we do things slightly differently from the generic virtio
- * initialization of the net and block drivers.
- *
- * At this stage, the console is output-only.  It's too early to set
- * up a virtqueue, so we let the drivers do some boutique early-output
- * thing.
- */
-int __init virtio_cons_early_init(int (*put_chars)(u32, const char *, int))
-{
-	early_put_chars = put_chars;
-	return hvc_instantiate(0, 0, &hv_ops);
-}
-
 static int init_port_console(struct port *port)
 {
 	int ret;
@@ -1256,13 +1231,6 @@ static int init_port_console(struct port *port)
 	spin_unlock_irq(&pdrvdata_lock);
 	port->guest_connected = true;
 
-	/*
-	 * Start using the new console output if this is the first
-	 * console to come up.
-	 */
-	if (early_put_chars)
-		early_put_chars = NULL;
-
 	/* Notify host of port being opened */
 	send_control_msg(port, VIRTIO_CONSOLE_PORT_OPEN, 1);
 
@@ -1999,7 +1967,6 @@ static int virtcons_probe(struct virtio_device *vdev)
 	struct ports_device *portdev;
 	int err;
 	bool multiport;
-	bool early = early_put_chars != NULL;
 
 	/* We only need a config space if features are offered */
 	if (!vdev->config->get &&
@@ -2010,9 +1977,6 @@ static int virtcons_probe(struct virtio_device *vdev)
 		return -EINVAL;
 	}
 
-	/* Ensure to read early_put_chars now */
-	barrier();
-
 	portdev = kmalloc(sizeof(*portdev), GFP_KERNEL);
 	if (!portdev) {
 		err = -ENOMEM;
@@ -2100,18 +2064,6 @@ static int virtcons_probe(struct virtio_device *vdev)
 	__send_control_msg(portdev, VIRTIO_CONSOLE_BAD_ID,
 			   VIRTIO_CONSOLE_DEVICE_READY, 1);
 
-	/*
-	 * If there was an early virtio console, assume that there are no
-	 * other consoles. We need to wait until the hvc_alloc matches the
-	 * hvc_instantiate, otherwise tty_open will complain, resulting in
-	 * a "Warning: unable to open an initial console" boot failure.
-	 * Without multiport this is done in add_port above. With multiport
-	 * this might take some host<->guest communication - thus we have to
-	 * wait.
-	 */
-	if (multiport && early)
-		wait_for_completion(&early_console_added);
-
 	return 0;
 
 free_chrdev:
diff --git a/include/linux/virtio_console.h b/include/linux/virtio_console.h
deleted file mode 100644
index d2e2785af602..000000000000
--- a/include/linux/virtio_console.h
+++ /dev/null
@@ -1,38 +0,0 @@
-/*
- * This header, excluding the #ifdef __KERNEL__ part, is BSD licensed so
- * anyone can use the definitions to implement compatible drivers/servers:
- *
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- * 1. Redistributions of source code must retain the above copyright
- *    notice, this list of conditions and the following disclaimer.
- * 2. Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in the
- *    documentation and/or other materials provided with the distribution.
- * 3. Neither the name of IBM nor the names of its contributors
- *    may be used to endorse or promote products derived from this software
- *    without specific prior written permission.
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS ``AS IS'' AND
- * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED.  IN NO EVENT SHALL IBM OR CONTRIBUTORS BE LIABLE
- * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
- * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
- * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
- * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
- * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
- * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
- * SUCH DAMAGE.
- *
- * Copyright (C) Red Hat, Inc., 2009, 2010, 2011
- * Copyright (C) Amit Shah <amit.shah@redhat.com>, 2009, 2010, 2011
- */
-#ifndef _LINUX_VIRTIO_CONSOLE_H
-#define _LINUX_VIRTIO_CONSOLE_H
-
-#include <uapi/linux/virtio_console.h>
-
-int __init virtio_cons_early_init(int (*put_chars)(u32, const char *, int));
-#endif /* _LINUX_VIRTIO_CONSOLE_H */
-- 
2.43.0


