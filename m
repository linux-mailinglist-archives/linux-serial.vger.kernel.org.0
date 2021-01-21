Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2F42FE5B5
	for <lists+linux-serial@lfdr.de>; Thu, 21 Jan 2021 10:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbhAUJBZ (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 21 Jan 2021 04:01:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:36584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728340AbhAUJBO (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 Jan 2021 04:01:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C776722473;
        Thu, 21 Jan 2021 09:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611219631;
        bh=K7tHFWmO+SytEv9K8H586UnBlSIX0eYSPupIZD2/lq8=;
        h=From:To:Cc:Subject:Date:From;
        b=1j7+qNnNzQTcRAq7KRiWv060duDdC7S1RHZDks/qVz0sgJtat7+aN85GQGoUHbYbJ
         K8B2GwXc3JPw/mW64/f0p63X/6IymaL7iWqVnFrPOt/GmxyqGwL5KcQTmD+0vG/80k
         QF1mxmbjfE/2o3zW+qm+T/4cMusQszOUmingrTxc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     jirislaby@kernel.org, linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, hch@lst.de, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, ohw.giles@gmail.com,
        r.karszniewicz@phytec.de,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 1/6] tty: implement write_iter
Date:   Thu, 21 Jan 2021 10:00:15 +0100
Message-Id: <20210121090020.3147058-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

This makes the tty layer use the .write_iter() function instead of the
traditional .write() functionality.

That allows writev(), but more importantly also makes it possible to
enable .splice_write() for ttys, reinstating the "splice to tty"
functionality that was lost in commit 36e2c7421f02 ("fs: don't allow
splice read/write without explicit ops").

Fixes: 36e2c7421f02 ("fs: don't allow splice read/write without explicit ops")
Reported-by: Oliver Giles <ohw.giles@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 drivers/tty/tty_io.c | 48 ++++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 56ade99ef99f..338bc4ef5549 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -143,9 +143,8 @@ LIST_HEAD(tty_drivers);			/* linked list of tty drivers */
 DEFINE_MUTEX(tty_mutex);
 
 static ssize_t tty_read(struct file *, char __user *, size_t, loff_t *);
-static ssize_t tty_write(struct file *, const char __user *, size_t, loff_t *);
-ssize_t redirected_tty_write(struct file *, const char __user *,
-							size_t, loff_t *);
+static ssize_t tty_write(struct kiocb *, struct iov_iter *);
+ssize_t redirected_tty_write(struct kiocb *, struct iov_iter *);
 static __poll_t tty_poll(struct file *, poll_table *);
 static int tty_open(struct inode *, struct file *);
 long tty_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
@@ -478,7 +477,8 @@ static void tty_show_fdinfo(struct seq_file *m, struct file *file)
 static const struct file_operations tty_fops = {
 	.llseek		= no_llseek,
 	.read		= tty_read,
-	.write		= tty_write,
+	.write_iter	= tty_write,
+	.splice_write	= iter_file_splice_write,
 	.poll		= tty_poll,
 	.unlocked_ioctl	= tty_ioctl,
 	.compat_ioctl	= tty_compat_ioctl,
@@ -491,7 +491,8 @@ static const struct file_operations tty_fops = {
 static const struct file_operations console_fops = {
 	.llseek		= no_llseek,
 	.read		= tty_read,
-	.write		= redirected_tty_write,
+	.write_iter	= redirected_tty_write,
+	.splice_write	= iter_file_splice_write,
 	.poll		= tty_poll,
 	.unlocked_ioctl	= tty_ioctl,
 	.compat_ioctl	= tty_compat_ioctl,
@@ -607,9 +608,9 @@ static void __tty_hangup(struct tty_struct *tty, int exit_session)
 	/* This breaks for file handles being sent over AF_UNIX sockets ? */
 	list_for_each_entry(priv, &tty->tty_files, list) {
 		filp = priv->file;
-		if (filp->f_op->write == redirected_tty_write)
+		if (filp->f_op->write_iter == redirected_tty_write)
 			cons_filp = filp;
-		if (filp->f_op->write != tty_write)
+		if (filp->f_op->write_iter != tty_write)
 			continue;
 		closecount++;
 		__tty_fasync(-1, filp, 0);	/* can't block */
@@ -902,9 +903,9 @@ static inline ssize_t do_tty_write(
 	ssize_t (*write)(struct tty_struct *, struct file *, const unsigned char *, size_t),
 	struct tty_struct *tty,
 	struct file *file,
-	const char __user *buf,
-	size_t count)
+	struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	ssize_t ret, written = 0;
 	unsigned int chunk;
 
@@ -956,14 +957,20 @@ static inline ssize_t do_tty_write(
 		size_t size = count;
 		if (size > chunk)
 			size = chunk;
+
 		ret = -EFAULT;
-		if (copy_from_user(tty->write_buf, buf, size))
+		if (copy_from_iter(tty->write_buf, size, from) != size)
 			break;
+
 		ret = write(tty, file, tty->write_buf, size);
 		if (ret <= 0)
 			break;
+
+		/* FIXME! Have Al check this! */
+		if (ret != size)
+			iov_iter_revert(from, size-ret);
+
 		written += ret;
-		buf += ret;
 		count -= ret;
 		if (!count)
 			break;
@@ -1023,9 +1030,9 @@ void tty_write_message(struct tty_struct *tty, char *msg)
  *	write method will not be invoked in parallel for each device.
  */
 
-static ssize_t tty_write(struct file *file, const char __user *buf,
-						size_t count, loff_t *ppos)
+static ssize_t tty_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	struct file *file = iocb->ki_filp;
 	struct tty_struct *tty = file_tty(file);
  	struct tty_ldisc *ld;
 	ssize_t ret;
@@ -1038,18 +1045,15 @@ static ssize_t tty_write(struct file *file, const char __user *buf,
 	if (tty->ops->write_room == NULL)
 		tty_err(tty, "missing write_room method\n");
 	ld = tty_ldisc_ref_wait(tty);
-	if (!ld)
-		return hung_up_tty_write(file, buf, count, ppos);
-	if (!ld->ops->write)
+	if (!ld || !ld->ops->write)
 		ret = -EIO;
 	else
-		ret = do_tty_write(ld->ops->write, tty, file, buf, count);
+		ret = do_tty_write(ld->ops->write, tty, file, from);
 	tty_ldisc_deref(ld);
 	return ret;
 }
 
-ssize_t redirected_tty_write(struct file *file, const char __user *buf,
-						size_t count, loff_t *ppos)
+ssize_t redirected_tty_write(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct file *p = NULL;
 
@@ -1060,11 +1064,11 @@ ssize_t redirected_tty_write(struct file *file, const char __user *buf,
 
 	if (p) {
 		ssize_t res;
-		res = vfs_write(p, buf, count, &p->f_pos);
+		res = vfs_iocb_iter_write(p, iocb, iter);
 		fput(p);
 		return res;
 	}
-	return tty_write(file, buf, count, ppos);
+	return tty_write(iocb, iter);
 }
 
 /**
@@ -2293,7 +2297,7 @@ static int tioccons(struct file *file)
 {
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
-	if (file->f_op->write == redirected_tty_write) {
+	if (file->f_op->write_iter == redirected_tty_write) {
 		struct file *f;
 		spin_lock(&redirect_lock);
 		f = redirect;
-- 
2.30.0

