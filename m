Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF9345E92E
	for <lists+linux-serial@lfdr.de>; Fri, 26 Nov 2021 09:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353540AbhKZIX3 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 26 Nov 2021 03:23:29 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:50582 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359301AbhKZIV1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Nov 2021 03:21:27 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id AB97D21B45;
        Fri, 26 Nov 2021 08:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637914574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hxIWVJQUj9dY+wM+XTslgR2G5O3pgzS2brwCq6BGUWM=;
        b=fwqF+bRtiZROy4VCQ4er91v+Ve4FPsY0DQ2LD6u8i4zK7iwAfGASZUJj3ZwKtomLXCVCPB
        x729Y0UerAzV6+b+63aAipFIsPzl7Qq2svrHEW6Su7L9zHRBPyDR5E5RnD6L3ZK6hZ0Z6e
        NJJNFiKIdinZ2qZ7pwGMVE1JdgTPkTI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637914574;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hxIWVJQUj9dY+wM+XTslgR2G5O3pgzS2brwCq6BGUWM=;
        b=mKgJUJaUV53b0QLtGXbI44HIpGuuDQZyC9Iy7VrLg+4Nf9IdmGg2pp52p4nrmF2//L8F8R
        o3yITi84RDx0+HBQ==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 76C4FA3B83;
        Fri, 26 Nov 2021 08:16:14 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 12/23] tty: reformat kernel-doc in tty_io.c
Date:   Fri, 26 Nov 2021 09:16:00 +0100
Message-Id: <20211126081611.11001-13-jslaby@suse.cz>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211126081611.11001-1-jslaby@suse.cz>
References: <20211126081611.11001-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Kernel-doc is a bit strict about some formatting. So fix these:
1) When there is a tab in comments, it thinks the line is a continuation
   one. So the description of the functions end up as descriptions of
   the last parameter described. Remove the tabs.

2) Remove newlines before parameters description and after the comments.
   This was not wrong per se, only inconsistent with the rest of the
   file.

3) Add periods to the end of sentences where appropriate.

4) Add "()" to function names and "%" to constants, so that they are
   properly highlighted.

By the above, this patch also unifies these docs with the other
kernel-doc's in this file.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/tty_io.c | 871 +++++++++++++++++++++----------------------
 1 file changed, 419 insertions(+), 452 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 3c2349b2089c..b23269eb0cba 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -158,14 +158,13 @@ static int tty_fasync(int fd, struct file *filp, int on);
 static void release_tty(struct tty_struct *tty, int idx);
 
 /**
- *	free_tty_struct		-	free a disused tty
- *	@tty: tty struct to free
+ * free_tty_struct	-	free a disused tty
+ * @tty: tty struct to free
  *
- *	Free the write buffers, tty queue and tty memory itself.
+ * Free the write buffers, tty queue and tty memory itself.
  *
- *	Locking: none. Must be called after tty is definitely unused
+ * Locking: none. Must be called after tty is definitely unused
  */
-
 static void free_tty_struct(struct tty_struct *tty)
 {
 	tty_ldisc_deinit(tty);
@@ -206,8 +205,9 @@ void tty_add_file(struct tty_struct *tty, struct file *file)
 	spin_unlock(&tty->files_lock);
 }
 
-/*
+/**
  * tty_free_file - free file->private_data
+ * @file: to free private_data of
  *
  * This shall be used only for fail path handling when tty_add_file was not
  * called yet.
@@ -233,15 +233,14 @@ static void tty_del_file(struct file *file)
 }
 
 /**
- *	tty_name	-	return tty naming
- *	@tty: tty structure
+ * tty_name	-	return tty naming
+ * @tty: tty structure
  *
- *	Convert a tty structure into a name. The name reflects the kernel
- *	naming policy and if udev is in use may not reflect user space
+ * Convert a tty structure into a name. The name reflects the kernel naming
+ * policy and if udev is in use may not reflect user space
  *
- *	Locking: none
+ * Locking: none
  */
-
 const char *tty_name(const struct tty_struct *tty)
 {
 	if (!tty) /* Hmm.  NULL pointer.  That's fun. */
@@ -303,16 +302,15 @@ static int check_tty_count(struct tty_struct *tty, const char *routine)
 }
 
 /**
- *	get_tty_driver		-	find device of a tty
- *	@device: device identifier
- *	@index: returns the index of the tty
+ * get_tty_driver		-	find device of a tty
+ * @device: device identifier
+ * @index: returns the index of the tty
  *
- *	This routine returns a tty driver structure, given a device number
- *	and also passes back the index number.
+ * This routine returns a tty driver structure, given a device number and also
+ * passes back the index number.
  *
- *	Locking: caller must hold tty_mutex
+ * Locking: caller must hold tty_mutex
  */
-
 static struct tty_driver *get_tty_driver(dev_t device, int *index)
 {
 	struct tty_driver *p;
@@ -329,17 +327,17 @@ static struct tty_driver *get_tty_driver(dev_t device, int *index)
 }
 
 /**
- *	tty_dev_name_to_number	-	return dev_t for device name
- *	@name: user space name of device under /dev
- *	@number: pointer to dev_t that this function will populate
+ * tty_dev_name_to_number	-	return dev_t for device name
+ * @name: user space name of device under /dev
+ * @number: pointer to dev_t that this function will populate
  *
- *	This function converts device names like ttyS0 or ttyUSB1 into dev_t
- *	like (4, 64) or (188, 1). If no corresponding driver is registered then
- *	the function returns -ENODEV.
+ * This function converts device names like ttyS0 or ttyUSB1 into dev_t like
+ * (4, 64) or (188, 1). If no corresponding driver is registered then the
+ * function returns -%ENODEV.
  *
- *	Locking: this acquires tty_mutex to protect the tty_drivers list from
- *		being modified while we are traversing it, and makes sure to
- *		release it before exiting.
+ * Locking: this acquires tty_mutex to protect the tty_drivers list from
+ *	being modified while we are traversing it, and makes sure to
+ *	release it before exiting.
  */
 int tty_dev_name_to_number(const char *name, dev_t *number)
 {
@@ -381,13 +379,12 @@ EXPORT_SYMBOL_GPL(tty_dev_name_to_number);
 #ifdef CONFIG_CONSOLE_POLL
 
 /**
- *	tty_find_polling_driver	-	find device of a polled tty
- *	@name: name string to match
- *	@line: pointer to resulting tty line nr
+ * tty_find_polling_driver	-	find device of a polled tty
+ * @name: name string to match
+ * @line: pointer to resulting tty line nr
  *
- *	This routine returns a tty driver structure, given a name
- *	and the condition that the tty driver is capable of polled
- *	operation.
+ * This routine returns a tty driver structure, given a name and the condition
+ * that the tty driver is capable of polled operation.
  */
 struct tty_driver *tty_find_polling_driver(char *name, int *line)
 {
@@ -515,14 +512,13 @@ static DEFINE_SPINLOCK(redirect_lock);
 static struct file *redirect;
 
 /**
- *	tty_wakeup	-	request more data
- *	@tty: terminal
+ * tty_wakeup	-	request more data
+ * @tty: terminal
  *
- *	Internal and external helper for wakeups of tty. This function
- *	informs the line discipline if present that the driver is ready
- *	to receive more output data.
+ * Internal and external helper for wakeups of tty. This function informs the
+ * line discipline if present that the driver is ready to receive more output
+ * data.
  */
-
 void tty_wakeup(struct tty_struct *tty)
 {
 	struct tty_ldisc *ld;
@@ -540,11 +536,11 @@ void tty_wakeup(struct tty_struct *tty)
 EXPORT_SYMBOL_GPL(tty_wakeup);
 
 /**
- *	tty_release_redirect	-	Release a redirect on a pty if present
- *	@tty: tty device
+ * tty_release_redirect	-	Release a redirect on a pty if present
+ * @tty: tty device
  *
- *	This is available to the pty code so if the master closes, if the
- *	slave is a redirect it can release the redirect.
+ * This is available to the pty code so if the master closes, if the slave is a
+ * redirect it can release the redirect.
  */
 static struct file *tty_release_redirect(struct tty_struct *tty)
 {
@@ -561,27 +557,29 @@ static struct file *tty_release_redirect(struct tty_struct *tty)
 }
 
 /**
- *	__tty_hangup		-	actual handler for hangup events
- *	@tty: tty device
- *	@exit_session: if non-zero, signal all foreground group processes
- *
- *	This can be called by a "kworker" kernel thread.  That is process
- *	synchronous but doesn't hold any locks, so we need to make sure we
- *	have the appropriate locks for what we're doing.
- *
- *	The hangup event clears any pending redirections onto the hung up
- *	device. It ensures future writes will error and it does the needed
- *	line discipline hangup and signal delivery. The tty object itself
- *	remains intact.
- *
- *	Locking:
- *		BTM
- *		  redirect lock for undoing redirection
- *		  file list lock for manipulating list of ttys
- *		  tty_ldiscs_lock from called functions
- *		  termios_rwsem resetting termios data
- *		  tasklist_lock to walk task list for hangup event
- *		    ->siglock to protect ->signal/->sighand
+ * __tty_hangup		-	actual handler for hangup events
+ * @tty: tty device
+ * @exit_session: if non-zero, signal all foreground group processes
+ *
+ * This can be called by a "kworker" kernel thread. That is process synchronous
+ * but doesn't hold any locks, so we need to make sure we have the appropriate
+ * locks for what we're doing.
+ *
+ * The hangup event clears any pending redirections onto the hung up device. It
+ * ensures future writes will error and it does the needed line discipline
+ * hangup and signal delivery. The tty object itself remains intact.
+ *
+ * Locking:
+ *  * BTM
+ *
+ *   * redirect lock for undoing redirection
+ *   * file list lock for manipulating list of ttys
+ *   * tty_ldiscs_lock from called functions
+ *   * termios_rwsem resetting termios data
+ *   * tasklist_lock to walk task list for hangup event
+ *
+ *    * ->siglock to protect ->signal/->sighand
+ *
  */
 static void __tty_hangup(struct tty_struct *tty, int exit_session)
 {
@@ -682,13 +680,12 @@ static void do_tty_hangup(struct work_struct *work)
 }
 
 /**
- *	tty_hangup		-	trigger a hangup event
- *	@tty: tty to hangup
+ * tty_hangup		-	trigger a hangup event
+ * @tty: tty to hangup
  *
- *	A carrier loss (virtual or otherwise) has occurred on this like
- *	schedule a hangup sequence to run after this event.
+ * A carrier loss (virtual or otherwise) has occurred on @tty. Schedule a
+ * hangup sequence to run after this event.
  */
-
 void tty_hangup(struct tty_struct *tty)
 {
 	tty_debug_hangup(tty, "hangup\n");
@@ -697,14 +694,13 @@ void tty_hangup(struct tty_struct *tty)
 EXPORT_SYMBOL(tty_hangup);
 
 /**
- *	tty_vhangup		-	process vhangup
- *	@tty: tty to hangup
+ * tty_vhangup		-	process vhangup
+ * @tty: tty to hangup
  *
- *	The user has asked via system call for the terminal to be hung up.
- *	We do this synchronously so that when the syscall returns the process
- *	is complete. That guarantee is necessary for security reasons.
+ * The user has asked via system call for the terminal to be hung up. We do
+ * this synchronously so that when the syscall returns the process is complete.
+ * That guarantee is necessary for security reasons.
  */
-
 void tty_vhangup(struct tty_struct *tty)
 {
 	tty_debug_hangup(tty, "vhangup\n");
@@ -714,11 +710,10 @@ EXPORT_SYMBOL(tty_vhangup);
 
 
 /**
- *	tty_vhangup_self	-	process vhangup for own ctty
+ * tty_vhangup_self	-	process vhangup for own ctty
  *
- *	Perform a vhangup on the current controlling tty
+ * Perform a vhangup on the current controlling tty
  */
-
 void tty_vhangup_self(void)
 {
 	struct tty_struct *tty;
@@ -731,16 +726,15 @@ void tty_vhangup_self(void)
 }
 
 /**
- *	tty_vhangup_session		-	hangup session leader exit
- *	@tty: tty to hangup
+ * tty_vhangup_session	-	hangup session leader exit
+ * @tty: tty to hangup
  *
- *	The session leader is exiting and hanging up its controlling terminal.
- *	Every process in the foreground process group is signalled SIGHUP.
+ * The session leader is exiting and hanging up its controlling terminal.
+ * Every process in the foreground process group is signalled %SIGHUP.
  *
- *	We do this synchronously so that when the syscall returns the process
- *	is complete. That guarantee is necessary for security reasons.
+ * We do this synchronously so that when the syscall returns the process is
+ * complete. That guarantee is necessary for security reasons.
  */
-
 void tty_vhangup_session(struct tty_struct *tty)
 {
 	tty_debug_hangup(tty, "session hangup\n");
@@ -748,13 +742,11 @@ void tty_vhangup_session(struct tty_struct *tty)
 }
 
 /**
- *	tty_hung_up_p		-	was tty hung up
- *	@filp: file pointer of tty
+ * tty_hung_up_p	-	was tty hung up
+ * @filp: file pointer of tty
  *
- *	Return true if the tty has been subject to a vhangup or a carrier
- *	loss
+ * Return: true if the tty has been subject to a vhangup or a carrier loss
  */
-
 int tty_hung_up_p(struct file *filp)
 {
 	return (filp && filp->f_op == &hung_up_tty_fops);
@@ -771,20 +763,18 @@ void __stop_tty(struct tty_struct *tty)
 }
 
 /**
- *	stop_tty	-	propagate flow control
- *	@tty: tty to stop
+ * stop_tty	-	propagate flow control
+ * @tty: tty to stop
  *
- *	Perform flow control to the driver. May be called
- *	on an already stopped device and will not re-call the driver
- *	method.
+ * Perform flow control to the driver. May be called on an already stopped
+ * device and will not re-call the &tty_driver->stop() method.
  *
- *	This functionality is used by both the line disciplines for
- *	halting incoming flow and by the driver. It may therefore be
- *	called from any context, may be under the tty atomic_write_lock
- *	but not always.
+ * This functionality is used by both the line disciplines for halting incoming
+ * flow and by the driver. It may therefore be called from any context, may be
+ * under the tty %atomic_write_lock but not always.
  *
- *	Locking:
- *		flow.lock
+ * Locking:
+ *	flow.lock
  */
 void stop_tty(struct tty_struct *tty)
 {
@@ -807,15 +797,15 @@ void __start_tty(struct tty_struct *tty)
 }
 
 /**
- *	start_tty	-	propagate flow control
- *	@tty: tty to start
+ * start_tty	-	propagate flow control
+ * @tty: tty to start
  *
- *	Start a tty that has been stopped if at all possible. If this
- *	tty was previous stopped and is now being started, the driver
- *	start method is invoked and the line discipline woken.
+ * Start a tty that has been stopped if at all possible. If @tty was previously
+ * stopped and is now being started, the &tty_driver->start() method is invoked
+ * and the line discipline woken.
  *
- *	Locking:
- *		flow.lock
+ * Locking:
+ *	flow.lock
  */
 void start_tty(struct tty_struct *tty)
 {
@@ -908,18 +898,17 @@ static int iterate_tty_read(struct tty_ldisc *ld, struct tty_struct *tty,
 
 
 /**
- *	tty_read	-	read method for tty device files
- *	@iocb: kernel I/O control block
- *	@to: destination for the data read
+ * tty_read	-	read method for tty device files
+ * @iocb: kernel I/O control block
+ * @to: destination for the data read
  *
- *	Perform the read system call function on this terminal device. Checks
- *	for hung up devices before calling the line discipline method.
+ * Perform the read system call function on this terminal device. Checks
+ * for hung up devices before calling the line discipline method.
  *
- *	Locking:
- *		Locks the line discipline internally while needed. Multiple
- *	read calls may be outstanding in parallel.
+ * Locking:
+ *	Locks the line discipline internally while needed. Multiple read calls
+ *	may be outstanding in parallel.
  */
-
 static ssize_t tty_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	int i;
@@ -1069,13 +1058,12 @@ static inline ssize_t do_tty_write(
  * @tty: the destination tty_struct
  * @msg: the message to write
  *
- * This is used for messages that need to be redirected to a specific tty.
- * We don't put it into the syslog queue right now maybe in the future if
- * really needed.
+ * This is used for messages that need to be redirected to a specific tty. We
+ * don't put it into the syslog queue right now maybe in the future if really
+ * needed.
  *
  * We must still hold the BTM and test the CLOSING flag for the moment.
  */
-
 void tty_write_message(struct tty_struct *tty, char *msg)
 {
 	if (tty) {
@@ -1113,18 +1101,18 @@ static ssize_t file_tty_write(struct file *file, struct kiocb *iocb, struct iov_
 }
 
 /**
- *	tty_write		-	write method for tty device file
- *	@iocb: kernel I/O control block
- *	@from: iov_iter with data to write
+ * tty_write		-	write method for tty device file
+ * @iocb: kernel I/O control block
+ * @from: iov_iter with data to write
  *
- *	Write data to a tty device via the line discipline.
+ * Write data to a tty device via the line discipline.
  *
- *	Locking:
- *		Locks the line discipline as required
- *		Writes to the tty driver are serialized by the atomic_write_lock
- *		and are then processed in chunks to the device. The line
- *		discipline write method will not be invoked in parallel for
- *		each device.
+ * Locking:
+ *	Locks the line discipline as required
+ *	Writes to the tty driver are serialized by the atomic_write_lock
+ *	and are then processed in chunks to the device. The line
+ *	discipline write method will not be invoked in parallel for
+ *	each device.
  */
 static ssize_t tty_write(struct kiocb *iocb, struct iov_iter *from)
 {
@@ -1154,14 +1142,15 @@ ssize_t redirected_tty_write(struct kiocb *iocb, struct iov_iter *iter)
 	return tty_write(iocb, iter);
 }
 
-/*
- *	tty_send_xchar	-	send priority character
+/**
+ * tty_send_xchar	-	send priority character
+ * @tty: the tty to send to
+ * @ch: xchar to send
  *
- *	Send a high priority character to the tty even if stopped
+ * Send a high priority character to the tty even if stopped.
  *
- *	Locking: none for xchar method, write ordering for write method.
+ * Locking: none for xchar method, write ordering for write method.
  */
-
 int tty_send_xchar(struct tty_struct *tty, char ch)
 {
 	bool was_stopped = tty->flow.stopped;
@@ -1188,15 +1177,15 @@ int tty_send_xchar(struct tty_struct *tty, char ch)
 }
 
 /**
- *	pty_line_name	-	generate name for a pty
- *	@driver: the tty driver in use
- *	@index: the minor number
- *	@p: output buffer of at least 6 bytes
+ * pty_line_name	-	generate name for a pty
+ * @driver: the tty driver in use
+ * @index: the minor number
+ * @p: output buffer of at least 6 bytes
  *
- *	Generate a name from a driver reference and write it to the output
- *	buffer.
+ * Generate a name from a @driver reference and write it to the output buffer
+ * @p.
  *
- *	Locking: None
+ * Locking: None
  */
 static void pty_line_name(struct tty_driver *driver, int index, char *p)
 {
@@ -1209,15 +1198,15 @@ static void pty_line_name(struct tty_driver *driver, int index, char *p)
 }
 
 /**
- *	tty_line_name	-	generate name for a tty
- *	@driver: the tty driver in use
- *	@index: the minor number
- *	@p: output buffer of at least 7 bytes
+ * tty_line_name	-	generate name for a tty
+ * @driver: the tty driver in use
+ * @index: the minor number
+ * @p: output buffer of at least 7 bytes
  *
- *	Generate a name from a driver reference and write it to the output
- *	buffer.
+ * Generate a name from a @driver reference and write it to the output buffer
+ * @p.
  *
- *	Locking: None
+ * Locking: None
  */
 static ssize_t tty_line_name(struct tty_driver *driver, int index, char *p)
 {
@@ -1229,15 +1218,15 @@ static ssize_t tty_line_name(struct tty_driver *driver, int index, char *p)
 }
 
 /**
- *	tty_driver_lookup_tty() - find an existing tty, if any
- *	@driver: the driver for the tty
- *	@file:   file object
- *	@idx:	 the minor number
+ * tty_driver_lookup_tty() - find an existing tty, if any
+ * @driver: the driver for the tty
+ * @file: file object
+ * @idx: the minor number
  *
- *	Return the tty, if found. If not found, return NULL or ERR_PTR() if the
- *	driver lookup() method returns an error.
+ * Return: the tty, if found. If not found, return %NULL or ERR_PTR() if the
+ * driver lookup() method returns an error.
  *
- *	Locking: tty_mutex must be held. If the tty is found, bump the tty kref.
+ * Locking: tty_mutex must be held. If the tty is found, bump the tty kref.
  */
 static struct tty_struct *tty_driver_lookup_tty(struct tty_driver *driver,
 		struct file *file, int idx)
@@ -1258,13 +1247,12 @@ static struct tty_struct *tty_driver_lookup_tty(struct tty_driver *driver,
 }
 
 /**
- *	tty_init_termios	-  helper for termios setup
- *	@tty: the tty to set up
+ * tty_init_termios	-  helper for termios setup
+ * @tty: the tty to set up
  *
- *	Initialise the termios structure for this tty. This runs under
- *	the tty_mutex currently so we can be relaxed about ordering.
+ * Initialise the termios structure for this tty. This runs under the
+ * %tty_mutex currently so we can be relaxed about ordering.
  */
-
 void tty_init_termios(struct tty_struct *tty)
 {
 	struct ktermios *tp;
@@ -1298,16 +1286,15 @@ int tty_standard_install(struct tty_driver *driver, struct tty_struct *tty)
 EXPORT_SYMBOL_GPL(tty_standard_install);
 
 /**
- *	tty_driver_install_tty() - install a tty entry in the driver
- *	@driver: the driver for the tty
- *	@tty: the tty
+ * tty_driver_install_tty() - install a tty entry in the driver
+ * @driver: the driver for the tty
+ * @tty: the tty
  *
- *	Install a tty object into the driver tables. The tty->index field
- *	will be set by the time this is called. This method is responsible
- *	for ensuring any need additional structures are allocated and
- *	configured.
+ * Install a tty object into the driver tables. The @tty->index field will be
+ * set by the time this is called. This method is responsible for ensuring any
+ * need additional structures are allocated and configured.
  *
- *	Locking: tty_mutex for now
+ * Locking: tty_mutex for now
  */
 static int tty_driver_install_tty(struct tty_driver *driver,
 						struct tty_struct *tty)
@@ -1317,14 +1304,14 @@ static int tty_driver_install_tty(struct tty_driver *driver,
 }
 
 /**
- *	tty_driver_remove_tty() - remove a tty from the driver tables
- *	@driver: the driver for the tty
- *	@tty: tty to remove
+ * tty_driver_remove_tty() - remove a tty from the driver tables
+ * @driver: the driver for the tty
+ * @tty: tty to remove
  *
- *	Remvoe a tty object from the driver tables. The tty->index field
- *	will be set by the time this is called.
+ * Remove a tty object from the driver tables. The tty->index field will be set
+ * by the time this is called.
  *
- *	Locking: tty_mutex for now
+ * Locking: tty_mutex for now
  */
 static void tty_driver_remove_tty(struct tty_driver *driver, struct tty_struct *tty)
 {
@@ -1335,13 +1322,13 @@ static void tty_driver_remove_tty(struct tty_driver *driver, struct tty_struct *
 }
 
 /**
- *	tty_reopen()	- fast re-open of an open tty
- *	@tty: the tty to open
+ * tty_reopen()	- fast re-open of an open tty
+ * @tty: the tty to open
  *
- *	Return 0 on success, -errno on error.
- *	Re-opens on master ptys are not allowed and return -EIO.
+ * Re-opens on master ptys are not allowed and return -%EIO.
  *
- *	Locking: Caller must hold tty_lock
+ * Locking: Caller must hold tty_lock
+ * Return: 0 on success, -errno on error.
  */
 static int tty_reopen(struct tty_struct *tty)
 {
@@ -1379,30 +1366,28 @@ static int tty_reopen(struct tty_struct *tty)
 }
 
 /**
- *	tty_init_dev		-	initialise a tty device
- *	@driver: tty driver we are opening a device on
- *	@idx: device index
+ * tty_init_dev		-	initialise a tty device
+ * @driver: tty driver we are opening a device on
+ * @idx: device index
  *
- *	Prepare a tty device. This may not be a "new" clean device but
- *	could also be an active device. The pty drivers require special
- *	handling because of this.
+ * Prepare a tty device. This may not be a "new" clean device but could also be
+ * an active device. The pty drivers require special handling because of this.
  *
- *	Locking:
- *		The function is called under the tty_mutex, which
- *	protects us from the tty struct or driver itself going away.
+ * Locking:
+ *	The function is called under the tty_mutex, which protects us from the
+ *	tty struct or driver itself going away.
  *
- *	On exit the tty device has the line discipline attached and
- *	a reference count of 1. If a pair was created for pty/tty use
- *	and the other was a pty master then it too has a reference count of 1.
+ * On exit the tty device has the line discipline attached and a reference
+ * count of 1. If a pair was created for pty/tty use and the other was a pty
+ * master then it too has a reference count of 1.
  *
- * WSH 06/09/97: Rewritten to remove races and properly clean up after a
- * failed open.  The new code protects the open with a mutex, so it's
- * really quite straightforward.  The mutex locking can probably be
- * relaxed for the (most common) case of reopening a tty.
+ * WSH 06/09/97: Rewritten to remove races and properly clean up after a failed
+ * open. The new code protects the open with a mutex, so it's really quite
+ * straightforward. The mutex locking can probably be relaxed for the (most
+ * common) case of reopening a tty.
  *
- *	Return: returned tty structure
+ * Return: new tty structure
  */
-
 struct tty_struct *tty_init_dev(struct tty_driver *driver, int idx)
 {
 	struct tty_struct *tty;
@@ -1503,10 +1488,10 @@ void tty_save_termios(struct tty_struct *tty)
 EXPORT_SYMBOL_GPL(tty_save_termios);
 
 /**
- *	tty_flush_works		-	flush all works of a tty/pty pair
- *	@tty: tty device to flush works for (or either end of a pty pair)
+ * tty_flush_works	-	flush all works of a tty/pty pair
+ * @tty: tty device to flush works for (or either end of a pty pair)
  *
- *	Sync flush all works belonging to @tty (and the 'other' tty).
+ * Sync flush all works belonging to @tty (and the 'other' tty).
  */
 static void tty_flush_works(struct tty_struct *tty)
 {
@@ -1519,19 +1504,19 @@ static void tty_flush_works(struct tty_struct *tty)
 }
 
 /**
- *	release_one_tty		-	release tty structure memory
- *	@work: work of tty we are obliterating
+ * release_one_tty	-	release tty structure memory
+ * @work: work of tty we are obliterating
  *
- *	Releases memory associated with a tty structure, and clears out the
- *	driver table slots. This function is called when a device is no longer
- *	in use. It also gets called when setup of a device fails.
+ * Releases memory associated with a tty structure, and clears out the
+ * driver table slots. This function is called when a device is no longer
+ * in use. It also gets called when setup of a device fails.
  *
- *	Locking:
- *		takes the file list lock internally when working on the list
- *	of ttys that the driver keeps.
+ * Locking:
+ *	takes the file list lock internally when working on the list of ttys
+ *	that the driver keeps.
  *
- *	This method gets called from a work queue so that the driver private
- *	cleanup ops can sleep (needed for USB at least)
+ * This method gets called from a work queue so that the driver private
+ * cleanup ops can sleep (needed for USB at least)
  */
 static void release_one_tty(struct work_struct *work)
 {
@@ -1568,13 +1553,12 @@ static void queue_release_one_tty(struct kref *kref)
 }
 
 /**
- *	tty_kref_put		-	release a tty kref
- *	@tty: tty device
+ * tty_kref_put		-	release a tty kref
+ * @tty: tty device
  *
- *	Release a reference to a tty device and if need be let the kref
- *	layer destruct the object for us
+ * Release a reference to the @tty device and if need be let the kref layer
+ * destruct the object for us.
  */
-
 void tty_kref_put(struct tty_struct *tty)
 {
 	if (tty)
@@ -1583,18 +1567,17 @@ void tty_kref_put(struct tty_struct *tty)
 EXPORT_SYMBOL(tty_kref_put);
 
 /**
- *	release_tty		-	release tty structure memory
- *	@tty: tty device release
- *	@idx: index of the tty device release
- *
- *	Release both @tty and a possible linked partner (think pty pair),
- *	and decrement the refcount of the backing module.
+ * release_tty		-	release tty structure memory
+ * @tty: tty device release
+ * @idx: index of the tty device release
  *
- *	Locking:
- *		tty_mutex
- *		takes the file list lock internally when working on the list
- *	of ttys that the driver keeps.
+ * Release both @tty and a possible linked partner (think pty pair),
+ * and decrement the refcount of the backing module.
  *
+ * Locking:
+ *	tty_mutex
+ *	takes the file list lock internally when working on the list of ttys
+ *	that the driver keeps.
  */
 static void release_tty(struct tty_struct *tty, int idx)
 {
@@ -1619,12 +1602,12 @@ static void release_tty(struct tty_struct *tty, int idx)
 }
 
 /**
- *	tty_release_checks - check a tty before real release
- *	@tty: tty to check
- *	@idx: index of the tty
+ * tty_release_checks - check a tty before real release
+ * @tty: tty to check
+ * @idx: index of the tty
  *
- *	Performs some paranoid checking before true release of the @tty.
- *	This is a no-op unless TTY_PARANOIA_CHECK is defined.
+ * Performs some paranoid checking before true release of the @tty. This is a
+ * no-op unless %TTY_PARANOIA_CHECK is defined.
  */
 static int tty_release_checks(struct tty_struct *tty, int idx)
 {
@@ -1661,12 +1644,12 @@ static int tty_release_checks(struct tty_struct *tty, int idx)
 }
 
 /**
- *      tty_kclose      -       closes tty opened by tty_kopen
- *      @tty: tty device
+ * tty_kclose      -       closes tty opened by tty_kopen
+ * @tty: tty device
  *
- *      Performs the final steps to release and free a tty device. It is the
- *      same as tty_release_struct except that it also resets TTY_PORT_KOPENED
- *      flag on tty->port.
+ * Performs the final steps to release and free a tty device. It is the same as
+ * tty_release_struct() except that it also resets %TTY_PORT_KOPENED flag on
+ * @tty->port.
  */
 void tty_kclose(struct tty_struct *tty)
 {
@@ -1691,12 +1674,12 @@ void tty_kclose(struct tty_struct *tty)
 EXPORT_SYMBOL_GPL(tty_kclose);
 
 /**
- *	tty_release_struct	-	release a tty struct
- *	@tty: tty device
- *	@idx: index of the tty
+ * tty_release_struct	-	release a tty struct
+ * @tty: tty device
+ * @idx: index of the tty
  *
- *	Performs the final steps to release and free a tty device. It is
- *	roughly the reverse of tty_init_dev.
+ * Performs the final steps to release and free a tty device. It is roughly the
+ * reverse of tty_init_dev().
  */
 void tty_release_struct(struct tty_struct *tty, int idx)
 {
@@ -1720,24 +1703,23 @@ void tty_release_struct(struct tty_struct *tty, int idx)
 EXPORT_SYMBOL_GPL(tty_release_struct);
 
 /**
- *	tty_release		-	vfs callback for close
- *	@inode: inode of tty
- *	@filp: file pointer for handle to tty
+ * tty_release		-	vfs callback for close
+ * @inode: inode of tty
+ * @filp: file pointer for handle to tty
  *
- *	Called the last time each file handle is closed that references
- *	this tty. There may however be several such references.
+ * Called the last time each file handle is closed that references this tty.
+ * There may however be several such references.
  *
- *	Locking:
- *		Takes bkl. See tty_release_dev
+ * Locking:
+ *	Takes BKL. See tty_release_dev().
  *
- * Even releasing the tty structures is a tricky business.. We have
- * to be very careful that the structures are all released at the
- * same time, as interrupts might otherwise get the wrong pointers.
+ * Even releasing the tty structures is a tricky business. We have to be very
+ * careful that the structures are all released at the same time, as interrupts
+ * might otherwise get the wrong pointers.
  *
  * WSH 09/09/97: rewritten to avoid some nasty race conditions that could
  * lead to double frees or releasing memory still in use.
  */
-
 int tty_release(struct inode *inode, struct file *filp)
 {
 	struct tty_struct *tty = file_tty(filp);
@@ -1880,15 +1862,15 @@ int tty_release(struct inode *inode, struct file *filp)
 }
 
 /**
- *	tty_open_current_tty - get locked tty of current task
- *	@device: device number
- *	@filp: file pointer to tty
- *	@return: locked tty of the current task iff @device is /dev/tty
+ * tty_open_current_tty - get locked tty of current task
+ * @device: device number
+ * @filp: file pointer to tty
+ * @return: locked tty of the current task iff @device is /dev/tty
  *
- *	Performs a re-open of the current task's controlling tty.
+ * Performs a re-open of the current task's controlling tty.
  *
- *	We cannot return driver and index like for the other nodes because
- *	devpts will not work then. It expects inodes to be from devpts FS.
+ * We cannot return driver and index like for the other nodes because devpts
+ * will not work then. It expects inodes to be from devpts FS.
  */
 static struct tty_struct *tty_open_current_tty(dev_t device, struct file *filp)
 {
@@ -1916,16 +1898,17 @@ static struct tty_struct *tty_open_current_tty(dev_t device, struct file *filp)
 }
 
 /**
- *	tty_lookup_driver - lookup a tty driver for a given device file
- *	@device: device number
- *	@filp: file pointer to tty
- *	@index: index for the device in the @return driver
- *	@return: driver for this inode (with increased refcount)
+ * tty_lookup_driver - lookup a tty driver for a given device file
+ * @device: device number
+ * @filp: file pointer to tty
+ * @index: index for the device in the @return driver
  *
- *	If @return is not erroneous, the caller is responsible to decrement the
- *	refcount by tty_driver_kref_put.
+ * If returned value is not erroneous, the caller is responsible to decrement
+ * the refcount by tty_driver_kref_put().
  *
- *	Locking: tty_mutex protects get_tty_driver
+ * Locking: %tty_mutex protects get_tty_driver()
+ *
+ * Return: driver for this inode (with increased refcount)
  */
 static struct tty_driver *tty_lookup_driver(dev_t device, struct file *filp,
 		int *index)
@@ -2001,19 +1984,18 @@ static struct tty_struct *tty_kopen(dev_t device, int shared)
 }
 
 /**
- *	tty_kopen_exclusive	-	open a tty device for kernel
- *	@device: dev_t of device to open
+ * tty_kopen_exclusive	-	open a tty device for kernel
+ * @device: dev_t of device to open
  *
- *	Opens tty exclusively for kernel. Performs the driver lookup,
- *	makes sure it's not already opened and performs the first-time
- *	tty initialization.
+ * Opens tty exclusively for kernel. Performs the driver lookup, makes sure
+ * it's not already opened and performs the first-time tty initialization.
  *
- *	Returns the locked initialized &tty_struct
+ * Claims the global %tty_mutex to serialize:
+ *  * concurrent first-time tty initialization
+ *  * concurrent tty driver removal w/ lookup
+ *  * concurrent tty removal from driver table
  *
- *	Claims the global tty_mutex to serialize:
- *	  - concurrent first-time tty initialization
- *	  - concurrent tty driver removal w/ lookup
- *	  - concurrent tty removal from driver table
+ * Return: the locked initialized &tty_struct
  */
 struct tty_struct *tty_kopen_exclusive(dev_t device)
 {
@@ -2022,13 +2004,13 @@ struct tty_struct *tty_kopen_exclusive(dev_t device)
 EXPORT_SYMBOL_GPL(tty_kopen_exclusive);
 
 /**
- *	tty_kopen_shared	-	open a tty device for shared in-kernel use
- *	@device: dev_t of device to open
+ * tty_kopen_shared	-	open a tty device for shared in-kernel use
+ * @device: dev_t of device to open
  *
- *	Opens an already existing tty for in-kernel use. Compared to
- *	tty_kopen_exclusive() above it doesn't ensure to be the only user.
+ * Opens an already existing tty for in-kernel use. Compared to
+ * tty_kopen_exclusive() above it doesn't ensure to be the only user.
  *
- *	Locking is identical to tty_kopen() above.
+ * Locking: identical to tty_kopen() above.
  */
 struct tty_struct *tty_kopen_shared(dev_t device)
 {
@@ -2037,19 +2019,20 @@ struct tty_struct *tty_kopen_shared(dev_t device)
 EXPORT_SYMBOL_GPL(tty_kopen_shared);
 
 /**
- *	tty_open_by_driver	-	open a tty device
- *	@device: dev_t of device to open
- *	@filp: file pointer to tty
+ * tty_open_by_driver	-	open a tty device
+ * @device: dev_t of device to open
+ * @filp: file pointer to tty
+ *
+ * Performs the driver lookup, checks for a reopen, or otherwise performs the
+ * first-time tty initialization.
  *
- *	Performs the driver lookup, checks for a reopen, or otherwise
- *	performs the first-time tty initialization.
  *
- *	Returns the locked initialized or re-opened &tty_struct
+ * Claims the global tty_mutex to serialize:
+ *  * concurrent first-time tty initialization
+ *  * concurrent tty driver removal w/ lookup
+ *  * concurrent tty removal from driver table
  *
- *	Claims the global tty_mutex to serialize:
- *	  - concurrent first-time tty initialization
- *	  - concurrent tty driver removal w/ lookup
- *	  - concurrent tty removal from driver table
+ * Return: the locked initialized or re-opened &tty_struct
  */
 static struct tty_struct *tty_open_by_driver(dev_t device,
 					     struct file *filp)
@@ -2104,29 +2087,28 @@ static struct tty_struct *tty_open_by_driver(dev_t device,
 }
 
 /**
- *	tty_open		-	open a tty device
- *	@inode: inode of device file
- *	@filp: file pointer to tty
+ * tty_open	-	open a tty device
+ * @inode: inode of device file
+ * @filp: file pointer to tty
  *
- *	tty_open and tty_release keep up the tty count that contains the
- *	number of opens done on a tty. We cannot use the inode-count, as
- *	different inodes might point to the same tty.
+ * tty_open() and tty_release() keep up the tty count that contains the number
+ * of opens done on a tty. We cannot use the inode-count, as different inodes
+ * might point to the same tty.
  *
- *	Open-counting is needed for pty masters, as well as for keeping
- *	track of serial lines: DTR is dropped when the last close happens.
- *	(This is not done solely through tty->count, now.  - Ted 1/27/92)
+ * Open-counting is needed for pty masters, as well as for keeping track of
+ * serial lines: DTR is dropped when the last close happens.
+ * (This is not done solely through tty->count, now.  - Ted 1/27/92)
  *
- *	The termios state of a pty is reset on first open so that
- *	settings don't persist across reuse.
+ * The termios state of a pty is reset on the first open so that settings don't
+ * persist across reuse.
  *
- *	Locking: tty_mutex protects tty, tty_lookup_driver and tty_init_dev.
- *		 tty->count should protect the rest.
- *		 ->siglock protects ->signal/->sighand
+ * Locking:
+ *  * %tty_mutex protects tty, tty_lookup_driver() and tty_init_dev().
+ *  * @tty->count should protect the rest.
+ *  * ->siglock protects ->signal/->sighand
  *
- *	Note: the tty_unlock/lock cases without a ref are only safe due to
- *	tty_mutex
+ * Note: the tty_unlock/lock cases without a ref are only safe due to %tty_mutex
  */
-
 static int tty_open(struct inode *inode, struct file *filp)
 {
 	struct tty_struct *tty;
@@ -2198,19 +2180,17 @@ static int tty_open(struct inode *inode, struct file *filp)
 }
 
 
-
 /**
- *	tty_poll	-	check tty status
- *	@filp: file being polled
- *	@wait: poll wait structures to update
+ * tty_poll	-	check tty status
+ * @filp: file being polled
+ * @wait: poll wait structures to update
  *
- *	Call the line discipline polling method to obtain the poll
- *	status of the device.
+ * Call the line discipline polling method to obtain the poll status of the
+ * device.
  *
- *	Locking: locks called line discipline but ldisc poll method
- *	may be re-entered freely by other callers.
+ * Locking: locks called line discipline but ldisc poll method may be
+ * re-entered freely by other callers.
  */
-
 static __poll_t tty_poll(struct file *filp, poll_table *wait)
 {
 	struct tty_struct *tty = file_tty(filp);
@@ -2278,20 +2258,18 @@ static int tty_fasync(int fd, struct file *filp, int on)
 }
 
 /**
- *	tiocsti			-	fake input character
- *	@tty: tty to fake input into
- *	@p: pointer to character
+ * tiocsti		-	fake input character
+ * @tty: tty to fake input into
+ * @p: pointer to character
  *
- *	Fake input to a tty device. Does the necessary locking and
- *	input management.
+ * Fake input to a tty device. Does the necessary locking and input management.
  *
- *	FIXME: does not honour flow control ??
+ * FIXME: does not honour flow control ??
  *
- *	Locking:
- *		Called functions take tty_ldiscs_lock
- *		current->signal->tty check is safe without locks
+ * Locking:
+ *  * Called functions take tty_ldiscs_lock
+ *  * current->signal->tty check is safe without locks
  */
-
 static int tiocsti(struct tty_struct *tty, char __user *p)
 {
 	char ch, mbz = 0;
@@ -2314,16 +2292,15 @@ static int tiocsti(struct tty_struct *tty, char __user *p)
 }
 
 /**
- *	tiocgwinsz		-	implement window query ioctl
- *	@tty: tty
- *	@arg: user buffer for result
+ * tiocgwinsz		-	implement window query ioctl
+ * @tty: tty
+ * @arg: user buffer for result
  *
- *	Copies the kernel idea of the window size into the user buffer.
+ * Copies the kernel idea of the window size into the user buffer.
  *
- *	Locking: tty->winsize_mutex is taken to ensure the winsize data
- *		is consistent.
+ * Locking: @tty->winsize_mutex is taken to ensure the winsize data is
+ * consistent.
  */
-
 static int tiocgwinsz(struct tty_struct *tty, struct winsize __user *arg)
 {
 	int err;
@@ -2336,14 +2313,13 @@ static int tiocgwinsz(struct tty_struct *tty, struct winsize __user *arg)
 }
 
 /**
- *	tty_do_resize		-	resize event
- *	@tty: tty being resized
- *	@ws: new dimensions
+ * tty_do_resize	-	resize event
+ * @tty: tty being resized
+ * @ws: new dimensions
  *
- *	Update the termios variables and send the necessary signals to
- *	peform a terminal resize correctly
+ * Update the termios variables and send the necessary signals to peform a
+ * terminal resize correctly.
  */
-
 int tty_do_resize(struct tty_struct *tty, struct winsize *ws)
 {
 	struct pid *pgrp;
@@ -2367,20 +2343,19 @@ int tty_do_resize(struct tty_struct *tty, struct winsize *ws)
 EXPORT_SYMBOL(tty_do_resize);
 
 /**
- *	tiocswinsz		-	implement window size set ioctl
- *	@tty: tty side of tty
- *	@arg: user buffer for result
+ * tiocswinsz		-	implement window size set ioctl
+ * @tty: tty side of tty
+ * @arg: user buffer for result
  *
- *	Copies the user idea of the window size to the kernel. Traditionally
- *	this is just advisory information but for the Linux console it
- *	actually has driver level meaning and triggers a VC resize.
+ * Copies the user idea of the window size to the kernel. Traditionally this is
+ * just advisory information but for the Linux console it actually has driver
+ * level meaning and triggers a VC resize.
  *
- *	Locking:
- *		Driver dependent. The default do_resize method takes the
- *	tty termios mutex and ctrl.lock. The console takes its own lock
- *	then calls into the default method.
+ * Locking:
+ *	Driver dependent. The default do_resize method takes the tty termios
+ *	mutex and ctrl.lock. The console takes its own lock then calls into the
+ *	default method.
  */
-
 static int tiocswinsz(struct tty_struct *tty, struct winsize __user *arg)
 {
 	struct winsize tmp_ws;
@@ -2395,14 +2370,13 @@ static int tiocswinsz(struct tty_struct *tty, struct winsize __user *arg)
 }
 
 /**
- *	tioccons	-	allow admin to move logical console
- *	@file: the file to become console
+ * tioccons	-	allow admin to move logical console
+ * @file: the file to become console
  *
- *	Allow the administrator to move the redirected console device
+ * Allow the administrator to move the redirected console device.
  *
- *	Locking: uses redirect_lock to guard the redirect information
+ * Locking: uses redirect_lock to guard the redirect information
  */
-
 static int tioccons(struct file *file)
 {
 	if (!capable(CAP_SYS_ADMIN))
@@ -2435,15 +2409,14 @@ static int tioccons(struct file *file)
 }
 
 /**
- *	tiocsetd	-	set line discipline
- *	@tty: tty device
- *	@p: pointer to user data
+ * tiocsetd	-	set line discipline
+ * @tty: tty device
+ * @p: pointer to user data
  *
- *	Set the line discipline according to user request.
+ * Set the line discipline according to user request.
  *
- *	Locking: see tty_set_ldisc, this function is just a helper
+ * Locking: see tty_set_ldisc(), this function is just a helper
  */
-
 static int tiocsetd(struct tty_struct *tty, int __user *p)
 {
 	int disc;
@@ -2458,16 +2431,15 @@ static int tiocsetd(struct tty_struct *tty, int __user *p)
 }
 
 /**
- *	tiocgetd	-	get line discipline
- *	@tty: tty device
- *	@p: pointer to user data
+ * tiocgetd	-	get line discipline
+ * @tty: tty device
+ * @p: pointer to user data
  *
- *	Retrieves the line discipline id directly from the ldisc.
+ * Retrieves the line discipline id directly from the ldisc.
  *
- *	Locking: waits for ldisc reference (in case the line discipline
- *		is changing or the tty is being hungup)
+ * Locking: waits for ldisc reference (in case the line discipline is changing
+ * or the @tty is being hungup)
  */
-
 static int tiocgetd(struct tty_struct *tty, int __user *p)
 {
 	struct tty_ldisc *ld;
@@ -2482,18 +2454,16 @@ static int tiocgetd(struct tty_struct *tty, int __user *p)
 }
 
 /**
- *	send_break	-	performed time break
- *	@tty: device to break on
- *	@duration: timeout in mS
+ * send_break	-	performed time break
+ * @tty: device to break on
+ * @duration: timeout in mS
  *
- *	Perform a timed break on hardware that lacks its own driver level
- *	timed break functionality.
- *
- *	Locking:
- *		atomic_write_lock serializes
+ * Perform a timed break on hardware that lacks its own driver level timed
+ * break functionality.
  *
+ * Locking:
+ *	@tty->atomic_write_lock serializes
  */
-
 static int send_break(struct tty_struct *tty, unsigned int duration)
 {
 	int retval;
@@ -2522,16 +2492,15 @@ static int send_break(struct tty_struct *tty, unsigned int duration)
 }
 
 /**
- *	tty_tiocmget		-	get modem status
- *	@tty: tty device
- *	@p: pointer to result
+ * tty_tiocmget		-	get modem status
+ * @tty: tty device
+ * @p: pointer to result
  *
- *	Obtain the modem status bits from the tty driver if the feature
- *	is supported. Return -ENOTTY if it is not available.
+ * Obtain the modem status bits from the tty driver if the feature is
+ * supported. Return -%ENOTTY if it is not available.
  *
- *	Locking: none (up to the driver)
+ * Locking: none (up to the driver)
  */
-
 static int tty_tiocmget(struct tty_struct *tty, int __user *p)
 {
 	int retval = -ENOTTY;
@@ -2546,17 +2515,16 @@ static int tty_tiocmget(struct tty_struct *tty, int __user *p)
 }
 
 /**
- *	tty_tiocmset		-	set modem status
- *	@tty: tty device
- *	@cmd: command - clear bits, set bits or set all
- *	@p: pointer to desired bits
+ * tty_tiocmset		-	set modem status
+ * @tty: tty device
+ * @cmd: command - clear bits, set bits or set all
+ * @p: pointer to desired bits
  *
- *	Set the modem status bits from the tty driver if the feature
- *	is supported. Return -ENOTTY if it is not available.
+ * Set the modem status bits from the tty driver if the feature
+ * is supported. Return -%ENOTTY if it is not available.
  *
- *	Locking: none (up to the driver)
+ * Locking: none (up to the driver)
  */
-
 static int tty_tiocmset(struct tty_struct *tty, unsigned int cmd,
 	     unsigned __user *p)
 {
@@ -2588,13 +2556,13 @@ static int tty_tiocmset(struct tty_struct *tty, unsigned int cmd,
 }
 
 /**
- *	tty_get_icount		-	get tty statistics
- *	@tty: tty device
- *	@icount: output parameter
+ * tty_get_icount	-	get tty statistics
+ * @tty: tty device
+ * @icount: output parameter
  *
- *	Gets a copy of the tty's icount statistics.
+ * Gets a copy of the @tty's icount statistics.
  *
- *	Locking: none (up to the driver)
+ * Locking: none (up to the driver)
  */
 int tty_get_icount(struct tty_struct *tty,
 		   struct serial_icounter_struct *icount)
@@ -3102,14 +3070,15 @@ static struct device *tty_get_device(struct tty_struct *tty)
 }
 
 
-/*
- *	alloc_tty_struct
+/**
+ * alloc_tty_struct - allocate a new tty
+ * @driver: driver which will handle the returned tty
+ * @idx: minor of the tty
  *
- *	This subroutine allocates and initializes a tty structure.
+ * This subroutine allocates and initializes a tty structure.
  *
- *	Locking: none - tty in question is not exposed at this point
+ * Locking: none - @tty in question is not exposed at this point
  */
-
 struct tty_struct *alloc_tty_struct(struct tty_driver *driver, int idx)
 {
 	struct tty_struct *tty;
@@ -3151,17 +3120,18 @@ struct tty_struct *alloc_tty_struct(struct tty_driver *driver, int idx)
 }
 
 /**
- *	tty_put_char	-	write one character to a tty
- *	@tty: tty
- *	@ch: character
+ * tty_put_char	- write one character to a tty
+ * @tty: tty
+ * @ch: character to write
+ *
+ * Write one byte to the @tty using the provided @tty->ops->put_char() method
+ * if present.
  *
- *	Write one byte to the tty using the provided put_char method
- *	if present. Returns the number of characters successfully output.
+ * Note: the specific put_char operation in the driver layer may go
+ * away soon. Don't call it directly, use this method
  *
- *	Note: the specific put_char operation in the driver layer may go
- *	away soon. Don't call it directly, use this method
+ * Return: the number of characters successfully output.
  */
-
 int tty_put_char(struct tty_struct *tty, unsigned char ch)
 {
 	if (tty->ops->put_char)
@@ -3190,24 +3160,23 @@ static int tty_cdev_add(struct tty_driver *driver, dev_t dev,
 }
 
 /**
- *	tty_register_device - register a tty device
- *	@driver: the tty driver that describes the tty device
- *	@index: the index in the tty driver for this tty device
- *	@device: a struct device that is associated with this tty device.
- *		This field is optional, if there is no known struct device
- *		for this tty device it can be set to NULL safely.
+ * tty_register_device - register a tty device
+ * @driver: the tty driver that describes the tty device
+ * @index: the index in the tty driver for this tty device
+ * @device: a struct device that is associated with this tty device.
+ *	This field is optional, if there is no known struct device
+ *	for this tty device it can be set to NULL safely.
  *
- *	Returns a pointer to the struct device for this tty device
- *	(or ERR_PTR(-EFOO) on error).
+ * This call is required to be made to register an individual tty device
+ * if the tty driver's flags have the %TTY_DRIVER_DYNAMIC_DEV bit set.  If
+ * that bit is not set, this function should not be called by a tty
+ * driver.
  *
- *	This call is required to be made to register an individual tty device
- *	if the tty driver's flags have the TTY_DRIVER_DYNAMIC_DEV bit set.  If
- *	that bit is not set, this function should not be called by a tty
- *	driver.
+ * Locking: ??
  *
- *	Locking: ??
+ * Return: A pointer to the struct device for this tty device (or
+ * ERR_PTR(-EFOO) on error).
  */
-
 struct device *tty_register_device(struct tty_driver *driver, unsigned index,
 				   struct device *device)
 {
@@ -3222,24 +3191,23 @@ static void tty_device_create_release(struct device *dev)
 }
 
 /**
- *	tty_register_device_attr - register a tty device
- *	@driver: the tty driver that describes the tty device
- *	@index: the index in the tty driver for this tty device
- *	@device: a struct device that is associated with this tty device.
- *		This field is optional, if there is no known struct device
- *		for this tty device it can be set to NULL safely.
- *	@drvdata: Driver data to be set to device.
- *	@attr_grp: Attribute group to be set on device.
+ * tty_register_device_attr - register a tty device
+ * @driver: the tty driver that describes the tty device
+ * @index: the index in the tty driver for this tty device
+ * @device: a struct device that is associated with this tty device.
+ *	This field is optional, if there is no known struct device
+ *	for this tty device it can be set to %NULL safely.
+ * @drvdata: Driver data to be set to device.
+ * @attr_grp: Attribute group to be set on device.
  *
- *	Returns a pointer to the struct device for this tty device
- *	(or ERR_PTR(-EFOO) on error).
+ * This call is required to be made to register an individual tty device if the
+ * tty driver's flags have the %TTY_DRIVER_DYNAMIC_DEV bit set. If that bit is
+ * not set, this function should not be called by a tty driver.
  *
- *	This call is required to be made to register an individual tty device
- *	if the tty driver's flags have the TTY_DRIVER_DYNAMIC_DEV bit set.  If
- *	that bit is not set, this function should not be called by a tty
- *	driver.
+ * Locking: ??
  *
- *	Locking: ??
+ * Return: A pointer to the struct device for this tty device (or
+ * ERR_PTR(-EFOO) on error).
  */
 struct device *tty_register_device_attr(struct tty_driver *driver,
 				   unsigned index, struct device *device,
@@ -3312,16 +3280,15 @@ struct device *tty_register_device_attr(struct tty_driver *driver,
 EXPORT_SYMBOL_GPL(tty_register_device_attr);
 
 /**
- *	tty_unregister_device - unregister a tty device
- *	@driver: the tty driver that describes the tty device
- *	@index: the index in the tty driver for this tty device
+ * tty_unregister_device - unregister a tty device
+ * @driver: the tty driver that describes the tty device
+ * @index: the index in the tty driver for this tty device
  *
- *	If a tty device is registered with a call to tty_register_device() then
- *	this function must be called when the tty device is gone.
+ * If a tty device is registered with a call to tty_register_device() then
+ * this function must be called when the tty device is gone.
  *
- *	Locking: ??
+ * Locking: ??
  */
-
 void tty_unregister_device(struct tty_driver *driver, unsigned index)
 {
 	device_destroy(tty_class,
@@ -3337,10 +3304,10 @@ EXPORT_SYMBOL(tty_unregister_device);
  * __tty_alloc_driver -- allocate tty driver
  * @lines: count of lines this driver can handle at most
  * @owner: module which is responsible for this driver
- * @flags: some of TTY_DRIVER_* flags, will be set in driver->flags
+ * @flags: some of %TTY_DRIVER_ flags, will be set in driver->flags
  *
  * This should not be called directly, some of the provided macros should be
- * used instead. Use IS_ERR and friends on @retval.
+ * used instead. Use IS_ERR() and friends on @retval.
  */
 struct tty_driver *__tty_alloc_driver(unsigned int lines, struct module *owner,
 		unsigned long flags)
-- 
2.34.0

