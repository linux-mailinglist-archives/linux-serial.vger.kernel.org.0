Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2076140AA55
	for <lists+linux-serial@lfdr.de>; Tue, 14 Sep 2021 11:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhINJND (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 14 Sep 2021 05:13:03 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33692 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhINJMz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Sep 2021 05:12:55 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2AA21220CC;
        Tue, 14 Sep 2021 09:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631610697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AllfHs/C0gAW47kfKHkGhj3X5BkDOeKWstqXtiAdJxM=;
        b=z+p3PbJnJYH93gGrSWmT8RBR6eMwtQvQAy3Dg+ZGOjSiiPYhfRqdtiC336/llYFCbVkLQD
        W8HC3gr2H09eEAPVCye8TcbJnLqoLmLgncTDGHGqDIZuQtnNmOw6CmIj3bbOL15E/yKGOw
        mydZuiEQUGn/SsPfaIbJH/p08+k00Dk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631610697;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AllfHs/C0gAW47kfKHkGhj3X5BkDOeKWstqXtiAdJxM=;
        b=zY9sk9rjCx3HURctUkVf2LnW9t9CISl9aQAayDYBBbB1/JWgln4G5y2RiMulZrF05vZWgM
        F43CeorWMyEkMCBQ==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C2C48A3B8E;
        Tue, 14 Sep 2021 09:11:36 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Andreas Koensgen <ajk@comnets.uni-bremen.de>,
        Paul Mackerras <paulus@samba.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 07/16] tty: remove file from tty_ldisc_ops::ioctl and compat_ioctl
Date:   Tue, 14 Sep 2021 11:11:25 +0200
Message-Id: <20210914091134.17426-7-jslaby@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210914091134.17426-1-jslaby@suse.cz>
References: <20210914091134.17426-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

After the previous patches, noone needs 'file' parameter in neither
ioctl hook from tty_ldisc_ops. So remove 'file' from both of them.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Andreas Koensgen <ajk@comnets.uni-bremen.de>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/bluetooth/hci_ldisc.c |  5 ++---
 drivers/input/serio/serport.c |  5 ++---
 drivers/net/can/slcan.c       |  4 ++--
 drivers/net/hamradio/6pack.c  |  4 ++--
 drivers/net/hamradio/mkiss.c  |  4 ++--
 drivers/net/ppp/ppp_async.c   |  3 +--
 drivers/net/ppp/ppp_synctty.c |  3 +--
 drivers/net/slip/slip.c       |  4 ++--
 drivers/tty/n_gsm.c           |  4 ++--
 drivers/tty/n_hdlc.c          |  5 ++---
 drivers/tty/n_tty.c           |  4 ++--
 drivers/tty/tty_io.c          |  8 ++++----
 include/linux/tty_ldisc.h     | 15 +++++++--------
 net/nfc/nci/uart.c            |  5 ++---
 14 files changed, 33 insertions(+), 40 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 824d1c7e3e53..6b5329784f17 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -736,14 +736,13 @@ static int hci_uart_set_flags(struct hci_uart *hu, unsigned long flags)
  * Arguments:
  *
  *    tty        pointer to tty instance data
- *    file       pointer to open file object for device
  *    cmd        IOCTL command code
  *    arg        argument for IOCTL call (cmd dependent)
  *
  * Return Value:    Command dependent
  */
-static int hci_uart_tty_ioctl(struct tty_struct *tty, struct file *file,
-			      unsigned int cmd, unsigned long arg)
+static int hci_uart_tty_ioctl(struct tty_struct *tty, unsigned int cmd,
+		unsigned long arg)
 {
 	struct hci_uart *hu = tty->disc_data;
 	int err = 0;
diff --git a/drivers/input/serio/serport.c b/drivers/input/serio/serport.c
index 17eb8f2aa48d..55e91d0e70ec 100644
--- a/drivers/input/serio/serport.c
+++ b/drivers/input/serio/serport.c
@@ -207,8 +207,8 @@ static void serport_set_type(struct tty_struct *tty, unsigned long type)
  * serport_ldisc_ioctl() allows to set the port protocol, and device ID
  */
 
-static int serport_ldisc_ioctl(struct tty_struct *tty, struct file *file,
-			       unsigned int cmd, unsigned long arg)
+static int serport_ldisc_ioctl(struct tty_struct *tty, unsigned int cmd,
+		unsigned long arg)
 {
 	if (cmd == SPIOCSTYPE) {
 		unsigned long type;
@@ -226,7 +226,6 @@ static int serport_ldisc_ioctl(struct tty_struct *tty, struct file *file,
 #ifdef CONFIG_COMPAT
 #define COMPAT_SPIOCSTYPE	_IOW('q', 0x01, compat_ulong_t)
 static int serport_ldisc_compat_ioctl(struct tty_struct *tty,
-				       struct file *file,
 				       unsigned int cmd, unsigned long arg)
 {
 	if (cmd == COMPAT_SPIOCSTYPE) {
diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
index 9a4ebda30510..de2da1b09a79 100644
--- a/drivers/net/can/slcan.c
+++ b/drivers/net/can/slcan.c
@@ -670,8 +670,8 @@ static void slcan_hangup(struct tty_struct *tty)
 }
 
 /* Perform I/O control on an active SLCAN channel. */
-static int slcan_ioctl(struct tty_struct *tty, struct file *file,
-		       unsigned int cmd, unsigned long arg)
+static int slcan_ioctl(struct tty_struct *tty, unsigned int cmd,
+		unsigned long arg)
 {
 	struct slcan *sl = (struct slcan *) tty->disc_data;
 	unsigned int tmp;
diff --git a/drivers/net/hamradio/6pack.c b/drivers/net/hamradio/6pack.c
index 05404f7a3204..300731ccbd66 100644
--- a/drivers/net/hamradio/6pack.c
+++ b/drivers/net/hamradio/6pack.c
@@ -680,8 +680,8 @@ static void sixpack_close(struct tty_struct *tty)
 }
 
 /* Perform I/O control on an active 6pack channel. */
-static int sixpack_ioctl(struct tty_struct *tty, struct file *file,
-	unsigned int cmd, unsigned long arg)
+static int sixpack_ioctl(struct tty_struct *tty, unsigned int cmd,
+		unsigned long arg)
 {
 	struct sixpack *sp = sp_get(tty);
 	struct net_device *dev;
diff --git a/drivers/net/hamradio/mkiss.c b/drivers/net/hamradio/mkiss.c
index 8666110bec55..1a4877abc562 100644
--- a/drivers/net/hamradio/mkiss.c
+++ b/drivers/net/hamradio/mkiss.c
@@ -803,8 +803,8 @@ static void mkiss_close(struct tty_struct *tty)
 }
 
 /* Perform I/O control on an active ax25 channel. */
-static int mkiss_ioctl(struct tty_struct *tty, struct file *file,
-	unsigned int cmd, unsigned long arg)
+static int mkiss_ioctl(struct tty_struct *tty, unsigned int cmd,
+		unsigned long arg)
 {
 	struct mkiss *ax = mkiss_get(tty);
 	struct net_device *dev;
diff --git a/drivers/net/ppp/ppp_async.c b/drivers/net/ppp/ppp_async.c
index f4429b93a9c8..15a179631903 100644
--- a/drivers/net/ppp/ppp_async.c
+++ b/drivers/net/ppp/ppp_async.c
@@ -281,8 +281,7 @@ ppp_asynctty_write(struct tty_struct *tty, struct file *file,
  */
 
 static int
-ppp_asynctty_ioctl(struct tty_struct *tty, struct file *file,
-		   unsigned int cmd, unsigned long arg)
+ppp_asynctty_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
 {
 	struct asyncppp *ap = ap_get(tty);
 	int err, val;
diff --git a/drivers/net/ppp/ppp_synctty.c b/drivers/net/ppp/ppp_synctty.c
index b3a71b409a80..18283b7b94bc 100644
--- a/drivers/net/ppp/ppp_synctty.c
+++ b/drivers/net/ppp/ppp_synctty.c
@@ -274,8 +274,7 @@ ppp_sync_write(struct tty_struct *tty, struct file *file,
 }
 
 static int
-ppp_synctty_ioctl(struct tty_struct *tty, struct file *file,
-		  unsigned int cmd, unsigned long arg)
+ppp_synctty_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
 {
 	struct syncppp *ap = sp_get(tty);
 	int __user *p = (int __user *)arg;
diff --git a/drivers/net/slip/slip.c b/drivers/net/slip/slip.c
index 9f3b4c1aa5ce..98f586f910fb 100644
--- a/drivers/net/slip/slip.c
+++ b/drivers/net/slip/slip.c
@@ -1072,8 +1072,8 @@ static void slip_unesc6(struct slip *sl, unsigned char s)
 #endif /* CONFIG_SLIP_MODE_SLIP6 */
 
 /* Perform I/O control on an active SLIP channel. */
-static int slip_ioctl(struct tty_struct *tty, struct file *file,
-					unsigned int cmd, unsigned long arg)
+static int slip_ioctl(struct tty_struct *tty, unsigned int cmd,
+		unsigned long arg)
 {
 	struct slip *sl = tty->disc_data;
 	unsigned int tmp;
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 03a98c93006a..59bbd4f6a610 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2630,8 +2630,8 @@ static __poll_t gsmld_poll(struct tty_struct *tty, struct file *file,
 	return mask;
 }
 
-static int gsmld_ioctl(struct tty_struct *tty, struct file *file,
-		       unsigned int cmd, unsigned long arg)
+static int gsmld_ioctl(struct tty_struct *tty, unsigned int cmd,
+		unsigned long arg)
 {
 	struct gsm_config c;
 	struct gsm_mux *gsm = tty->disc_data;
diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index 7e0884ecc74f..7fdbae81bf1d 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -572,14 +572,13 @@ static ssize_t n_hdlc_tty_write(struct tty_struct *tty, struct file *file,
 /**
  * n_hdlc_tty_ioctl - process IOCTL system call for the tty device.
  * @tty: pointer to tty instance data
- * @file: pointer to open file object for device
  * @cmd: IOCTL command code
  * @arg: argument for IOCTL call (cmd dependent)
  *
  * Returns command dependent result.
  */
-static int n_hdlc_tty_ioctl(struct tty_struct *tty, struct file *file,
-			    unsigned int cmd, unsigned long arg)
+static int n_hdlc_tty_ioctl(struct tty_struct *tty, unsigned int cmd,
+		unsigned long arg)
 {
 	struct n_hdlc *n_hdlc = tty->disc_data;
 	int error = 0;
diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 9fc2319a394d..011ce4a2a01a 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -2400,8 +2400,8 @@ static unsigned long inq_canon(struct n_tty_data *ldata)
 	return nr;
 }
 
-static int n_tty_ioctl(struct tty_struct *tty, struct file *file,
-		       unsigned int cmd, unsigned long arg)
+static int n_tty_ioctl(struct tty_struct *tty, unsigned int cmd,
+		unsigned long arg)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 	int retval;
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 6616d4a0d41d..2f1bf1bb7710 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2811,7 +2811,7 @@ long tty_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		return hung_up_tty_ioctl(file, cmd, arg);
 	retval = -EINVAL;
 	if (ld->ops->ioctl) {
-		retval = ld->ops->ioctl(tty, file, cmd, arg);
+		retval = ld->ops->ioctl(tty, cmd, arg);
 		if (retval == -ENOIOCTLCMD)
 			retval = -ENOTTY;
 	}
@@ -2990,10 +2990,10 @@ static long tty_compat_ioctl(struct file *file, unsigned int cmd,
 	if (!ld)
 		return hung_up_tty_compat_ioctl(file, cmd, arg);
 	if (ld->ops->compat_ioctl)
-		retval = ld->ops->compat_ioctl(tty, file, cmd, arg);
+		retval = ld->ops->compat_ioctl(tty, cmd, arg);
 	if (retval == -ENOIOCTLCMD && ld->ops->ioctl)
-		retval = ld->ops->ioctl(tty, file,
-				(unsigned long)compat_ptr(cmd), arg);
+		retval = ld->ops->ioctl(tty, (unsigned long)compat_ptr(cmd),
+				arg);
 	tty_ldisc_deref(ld);
 
 	return retval;
diff --git a/include/linux/tty_ldisc.h b/include/linux/tty_ldisc.h
index b85d84fb5f49..25f07017bbad 100644
--- a/include/linux/tty_ldisc.h
+++ b/include/linux/tty_ldisc.h
@@ -45,8 +45,7 @@ struct tty_struct;
  *	some processing on the characters first.  If this function is
  *	not defined, the user will receive an EIO error.
  *
- * int	(*ioctl)(struct tty_struct * tty, struct file * file,
- *		 unsigned int cmd, unsigned long arg);
+ * int	(*ioctl)(struct tty_struct *tty, unsigned int cmd, unsigned long arg);
  *
  *	This function is called when the user requests an ioctl which
  *	is not handled by the tty layer or the low-level tty driver.
@@ -56,8 +55,8 @@ struct tty_struct;
  *	low-level driver can "grab" an ioctl request before the line
  *	discpline has a chance to see it.
  *
- * int	(*compat_ioctl)(struct tty_struct * tty, struct file * file,
- *		        unsigned int cmd, unsigned long arg);
+ * int	(*compat_ioctl)(struct tty_struct *tty, unsigned int cmd,
+ *			unsigned long arg);
  *
  *	Process ioctl calls from 32-bit process on 64-bit system
  *
@@ -192,10 +191,10 @@ struct tty_ldisc_ops {
 			void **cookie, unsigned long offset);
 	ssize_t	(*write)(struct tty_struct *tty, struct file *file,
 			 const unsigned char *buf, size_t nr);
-	int	(*ioctl)(struct tty_struct *tty, struct file *file,
-			 unsigned int cmd, unsigned long arg);
-	int	(*compat_ioctl)(struct tty_struct *tty, struct file *file,
-				unsigned int cmd, unsigned long arg);
+	int	(*ioctl)(struct tty_struct *tty, unsigned int cmd,
+			unsigned long arg);
+	int	(*compat_ioctl)(struct tty_struct *tty, unsigned int cmd,
+			unsigned long arg);
 	void	(*set_termios)(struct tty_struct *tty, struct ktermios *old);
 	__poll_t (*poll)(struct tty_struct *, struct file *,
 			     struct poll_table_struct *);
diff --git a/net/nfc/nci/uart.c b/net/nfc/nci/uart.c
index 9bdd9a7d187e..17e29c8b28de 100644
--- a/net/nfc/nci/uart.c
+++ b/net/nfc/nci/uart.c
@@ -329,14 +329,13 @@ static void nci_uart_tty_receive(struct tty_struct *tty, const u8 *data,
  * Arguments:
  *
  *    tty        pointer to tty instance data
- *    file       pointer to open file object for device
  *    cmd        IOCTL command code
  *    arg        argument for IOCTL call (cmd dependent)
  *
  * Return Value:    Command dependent
  */
-static int nci_uart_tty_ioctl(struct tty_struct *tty, struct file *file,
-			      unsigned int cmd, unsigned long arg)
+static int nci_uart_tty_ioctl(struct tty_struct *tty, unsigned int cmd,
+		unsigned long arg)
 {
 	struct nci_uart *nu = (void *)tty->disc_data;
 	int err = 0;
-- 
2.33.0

