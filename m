Return-Path: <linux-serial+bounces-7983-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A13A3D84E
	for <lists+linux-serial@lfdr.de>; Thu, 20 Feb 2025 12:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B561218899F7
	for <lists+linux-serial@lfdr.de>; Thu, 20 Feb 2025 11:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADF520B7E1;
	Thu, 20 Feb 2025 11:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTUW7V4F"
X-Original-To: linux-serial@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709341F3B8A;
	Thu, 20 Feb 2025 11:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050203; cv=none; b=DUR4eNa46qIW/9Ra8xI0WMCLwJobFetHpstowa9ThVu8QLk9eqzVgMP3BKePEsBdDxgXHI9031vY7KMn+daBbh5eM3dy6dOxUhfsaNCXFhHCFEIB4ytCl9y28BSHyI6EzCTntC4wEoaW7HTzgge8J50stV2PQHJZghRzlgm1I7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050203; c=relaxed/simple;
	bh=Nzn39Gj0zDV8oO5kv9Dt85bKRYqHcU7BvP/2szVpfw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YU7E9kEWWzhovbccETFCXpFxtU0ekKj1UdNblNxWmhHHLm3du0AzZaMMP4gwuGRjfS1trZ1tsuCJRYlaG52m2WlsEPn5ucWSnJDrB2RI+1ejrOw7THK5pi8clJF5bU/b8tN1JSpBdP+So9c/yrPwHN4uzer/dZkVbY89BoPPdK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTUW7V4F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A5AC4CEE4;
	Thu, 20 Feb 2025 11:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740050203;
	bh=Nzn39Gj0zDV8oO5kv9Dt85bKRYqHcU7BvP/2szVpfw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VTUW7V4F02DLH1GSJEnrerkTin2mCYVLJykjPHpW9UVOvJHtAc24pCQdUnYZb0MOc
	 a+SwTuRo2B/mpZNh8XJedi+GsfrK3zSMx/m/vx7Le3qnxDIwpnY1P7WH3aKQQXxi+J
	 hDYEAAVfGxCbN82yBKN16oG1hYVBkn5FMmMIQIvPyBs9An8w+BwuqIeVELzTNH+jGK
	 6XStAuxaHfcDKkv2xCrIB3SwcMZG7Hi1dlu1FRZz+DK5oS5CfFgQUpQFsbxF7B6EOy
	 gp4QqJUOvjEoPPlVCTupyBwWfJnPN/CEnvmX3OmbSmJ3ll2TFODWmN5WSpFSadIlia
	 02ONDp9LjERRA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 19/29] tty: moxa: carve out special ioctls and extra tty_port
Date: Thu, 20 Feb 2025 12:15:56 +0100
Message-ID: <20250220111606.138045-20-jirislaby@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220111606.138045-1-jirislaby@kernel.org>
References: <20250220111606.138045-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These ioctls are undocumented and not exposed -- they are defined
locally. Given they need a special tty_port just for them, this is very
ugly. So drop this whole functionality. It is barely used for something
real. (And if it is, we'd need a common functionality to all drivers.)

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/moxa.c | 146 +--------------------------------------------
 1 file changed, 1 insertion(+), 145 deletions(-)

diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
index a753afcb53b5..1348e2214b81 100644
--- a/drivers/tty/moxa.c
+++ b/drivers/tty/moxa.c
@@ -43,15 +43,6 @@
 #include <linux/ratelimit.h>
 
 #include <asm/io.h>
-#include <linux/uaccess.h>
-
-#define	MOXA			0x400
-#define MOXA_GET_IQUEUE		(MOXA + 1)	/* get input buffered count */
-#define MOXA_GET_OQUEUE		(MOXA + 2)	/* get output buffered count */
-#define MOXA_GETDATACOUNT       (MOXA + 23)
-#define MOXA_GET_IOQUEUE	(MOXA + 27)
-#define MOXA_FLUSH_QUEUE	(MOXA + 28)
-#define MOXA_GETMSTATUS         (MOXA + 65)
 
 /*
  *    System Configuration
@@ -397,19 +388,6 @@ static struct moxa_board_conf {
 	void __iomem *intTable;
 } moxa_boards[MAX_BOARDS];
 
-struct mxser_mstatus {
-	tcflag_t cflag;
-	int cts;
-	int dsr;
-	int ri;
-	int dcd;
-};
-
-struct moxaq_str {
-	int inq;
-	int outq;
-};
-
 struct moxa_port {
 	struct tty_port port;
 	struct moxa_board_conf *board;
@@ -424,12 +402,6 @@ struct moxa_port {
 	u8 lowChkFlag;
 };
 
-struct mon_str {
-	int tick;
-	int rxcnt[MAX_PORTS];
-	int txcnt[MAX_PORTS];
-};
-
 /* statusflags */
 #define TXSTOPPED	1
 #define LOWWAIT 	2
@@ -439,14 +411,11 @@ struct mon_str {
 #define WAKEUP_CHARS		256
 
 static int ttymajor = MOXAMAJOR;
-static struct mon_str moxaLog;
 static unsigned int moxaFuncTout = HZ / 2;
 static unsigned int moxaLowWaterChk;
 static DEFINE_MUTEX(moxa_openlock);
 static DEFINE_SPINLOCK(moxa_lock);
 
-static struct tty_port moxa_service_port;
-
 MODULE_AUTHOR("William Chen");
 MODULE_DESCRIPTION("MOXA Intellio Family Multiport Board Device Driver");
 MODULE_LICENSE("GPL");
@@ -557,104 +526,6 @@ static void moxa_low_water_check(void __iomem *ofsAddr)
  * TTY operations
  */
 
-static int moxa_ioctl(struct tty_struct *tty,
-		      unsigned int cmd, unsigned long arg)
-{
-	struct moxa_port *ch = tty->driver_data;
-	void __user *argp = (void __user *)arg;
-	int status, ret = 0;
-
-	if (tty->index == MAX_PORTS) {
-		if (cmd != MOXA_GETDATACOUNT && cmd != MOXA_GET_IOQUEUE &&
-				cmd != MOXA_GETMSTATUS)
-			return -EINVAL;
-	} else if (!ch)
-		return -ENODEV;
-
-	switch (cmd) {
-	case MOXA_GETDATACOUNT:
-		moxaLog.tick = jiffies;
-		if (copy_to_user(argp, &moxaLog, sizeof(moxaLog)))
-			ret = -EFAULT;
-		break;
-	case MOXA_FLUSH_QUEUE:
-		MoxaPortFlushData(ch, arg);
-		break;
-	case MOXA_GET_IOQUEUE: {
-		struct moxaq_str __user *argm = argp;
-		struct moxaq_str tmp;
-		struct moxa_port *p;
-		unsigned int i, j;
-
-		for (i = 0; i < MAX_BOARDS; i++) {
-			p = moxa_boards[i].ports;
-			for (j = 0; j < MAX_PORTS_PER_BOARD; j++, p++, argm++) {
-				memset(&tmp, 0, sizeof(tmp));
-				spin_lock_bh(&moxa_lock);
-				if (moxa_boards[i].ready) {
-					tmp.inq = MoxaPortRxQueue(p);
-					tmp.outq = MoxaPortTxQueue(p);
-				}
-				spin_unlock_bh(&moxa_lock);
-				if (copy_to_user(argm, &tmp, sizeof(tmp)))
-					return -EFAULT;
-			}
-		}
-		break;
-	} case MOXA_GET_OQUEUE:
-		status = MoxaPortTxQueue(ch);
-		ret = put_user(status, (unsigned long __user *)argp);
-		break;
-	case MOXA_GET_IQUEUE:
-		status = MoxaPortRxQueue(ch);
-		ret = put_user(status, (unsigned long __user *)argp);
-		break;
-	case MOXA_GETMSTATUS: {
-		struct mxser_mstatus __user *argm = argp;
-		struct mxser_mstatus tmp;
-		struct moxa_port *p;
-		unsigned int i, j;
-
-		for (i = 0; i < MAX_BOARDS; i++) {
-			p = moxa_boards[i].ports;
-			for (j = 0; j < MAX_PORTS_PER_BOARD; j++, p++, argm++) {
-				struct tty_struct *ttyp;
-				memset(&tmp, 0, sizeof(tmp));
-				spin_lock_bh(&moxa_lock);
-				if (!moxa_boards[i].ready) {
-				        spin_unlock_bh(&moxa_lock);
-					goto copy;
-                                }
-
-				status = MoxaPortLineStatus(p);
-				spin_unlock_bh(&moxa_lock);
-
-				if (status & 1)
-					tmp.cts = 1;
-				if (status & 2)
-					tmp.dsr = 1;
-				if (status & 4)
-					tmp.dcd = 1;
-
-				ttyp = tty_port_tty_get(&p->port);
-				if (!ttyp)
-					tmp.cflag = p->cflag;
-				else
-					tmp.cflag = ttyp->termios.c_cflag;
-				tty_kref_put(ttyp);
-copy:
-				if (copy_to_user(argm, &tmp, sizeof(tmp)))
-					return -EFAULT;
-			}
-		}
-		break;
-	}
-	default:
-		ret = -ENOIOCTLCMD;
-	}
-	return ret;
-}
-
 static int moxa_break_ctl(struct tty_struct *tty, int state)
 {
 	struct moxa_port *port = tty->driver_data;
@@ -671,7 +542,6 @@ static const struct tty_operations moxa_ops = {
 	.write_room = moxa_write_room,
 	.flush_buffer = moxa_flush_buffer,
 	.chars_in_buffer = moxa_chars_in_buffer,
-	.ioctl = moxa_ioctl,
 	.set_termios = moxa_set_termios,
 	.stop = moxa_stop,
 	.start = moxa_start,
@@ -1283,9 +1153,7 @@ static int __init moxa_init(void)
 {
 	int retval = 0;
 
-	tty_port_init(&moxa_service_port);
-
-	moxaDriver = tty_alloc_driver(MAX_PORTS + 1,
+	moxaDriver = tty_alloc_driver(MAX_PORTS,
 			TTY_DRIVER_REAL_RAW |
 			TTY_DRIVER_DYNAMIC_DEV);
 	if (IS_ERR(moxaDriver))
@@ -1301,8 +1169,6 @@ static int __init moxa_init(void)
 	moxaDriver->init_termios.c_ispeed = 9600;
 	moxaDriver->init_termios.c_ospeed = 9600;
 	tty_set_operations(moxaDriver, &moxa_ops);
-	/* Having one more port only for ioctls is ugly */
-	tty_port_link_device(&moxa_service_port, moxaDriver, MAX_PORTS);
 
 	if (tty_register_driver(moxaDriver)) {
 		printk(KERN_ERR "can't register MOXA Smartio tty driver!\n");
@@ -1362,9 +1228,6 @@ static int moxa_open(struct tty_struct *tty, struct file *filp)
 	int port;
 
 	port = tty->index;
-	if (port == MAX_PORTS) {
-		return capable(CAP_SYS_ADMIN) ? 0 : -EPERM;
-	}
 	if (mutex_lock_interruptible(&moxa_openlock))
 		return -ERESTARTSYS;
 	brd = &moxa_boards[port / MAX_PORTS_PER_BOARD];
@@ -2087,7 +1950,6 @@ static ssize_t MoxaPortWriteData(struct tty_struct *tty, const u8 *buffer,
 	c = (head > tail) ? (head - tail - 1) : (head - tail + tx_mask);
 	if (c > len)
 		c = len;
-	moxaLog.txcnt[port->port.tty->index] += c;
 	total = c;
 	if (spage == epage) {
 		bufhead = readw(ofsAddr + Ofs_txb);
@@ -2129,7 +1991,6 @@ static ssize_t MoxaPortWriteData(struct tty_struct *tty, const u8 *buffer,
 
 static int MoxaPortReadData(struct moxa_port *port)
 {
-	struct tty_struct *tty = port->port.tty;
 	void __iomem *baseAddr, *ofsAddr, *ofs;
 	u8 *dst;
 	unsigned int count, len, total;
@@ -2148,7 +2009,6 @@ static int MoxaPortReadData(struct moxa_port *port)
 		return 0;
 
 	total = count;
-	moxaLog.rxcnt[tty->index] += total;
 	if (spage == epage) {
 		bufhead = readw(ofsAddr + Ofs_rxb);
 		writew(spage, baseAddr + Control_reg);
@@ -2236,8 +2096,6 @@ static int moxa_get_serial_info(struct tty_struct *tty,
 {
 	struct moxa_port *info = tty->driver_data;
 
-	if (tty->index == MAX_PORTS)
-		return -EINVAL;
 	if (!info)
 		return -ENODEV;
 	mutex_lock(&info->port.mutex);
@@ -2257,8 +2115,6 @@ static int moxa_set_serial_info(struct tty_struct *tty,
 	struct moxa_port *info = tty->driver_data;
 	unsigned int close_delay;
 
-	if (tty->index == MAX_PORTS)
-		return -EINVAL;
 	if (!info)
 		return -ENODEV;
 
-- 
2.48.1


