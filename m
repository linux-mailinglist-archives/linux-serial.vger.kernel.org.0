Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE4A554CC
	for <lists+linux-serial@lfdr.de>; Tue, 25 Jun 2019 18:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730067AbfFYQqW (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 25 Jun 2019 12:46:22 -0400
Received: from mx.cs.msu.ru ([188.44.42.42]:39849 "EHLO mail.cs.msu.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726397AbfFYQqW (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 25 Jun 2019 12:46:22 -0400
X-Greylist: delayed 2026 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Jun 2019 12:46:19 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cs.msu.ru;
         s=dkim; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OoqaO2J8ZR7ZTDB3ITBRQHWchvq9XJI7mROIrFJGfnw=; b=tCmgyFu8TKoyTsTIBJkfw+VuMb
        JwDdIpwybsznU+Yt+6HYXh1RsoBZ7Rpv1Yr7ikQZPCWn71dC4MOsO7o58P9tCHEzTSNcA0ivprEK9
        Oo14wFOSB90OxdhX4AZOlxlIa9IOGGSh2XRfcdgWXx1S4dnNL5iEyLJaOmZ5Drfgh1ZGI1K+BzuLC
        gym94LS5RPwX1ZQy8De2LUZ2opODpJMrR8/q49iA85RgSg3kK60K6bJehCfaF0e8YCdGGvOObXKTT
        ctU6ytiyy1eMdi94Vcap0VrfIItigtqFw2gBGFrp8hIoWq0FzeTWXNMhUZAp6a2N/KCQqrSS1Ahku
        QPm60GYQ==;
Received: from [10.7.4.141] (port=44632 helo=cello.cs.msu.ru)
        by mail.cs.msu.ru with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92 (FreeBSD))
        (envelope-from <ar@cs.msu.ru>)
        id 1hfo3G-0006Uf-Jb; Tue, 25 Jun 2019 19:12:11 +0300
From:   Arseny Maslennikov <ar@cs.msu.ru>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Vladimir D. Seleznev" <vseleznv@altlinux.org>,
        Rob Landley <rob@landley.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Pavel Machek <pavel@ucw.cz>, Arseny Maslennikov <ar@cs.msu.ru>
Date:   Tue, 25 Jun 2019 19:11:53 +0300
Message-Id: <20190625161153.29811-8-ar@cs.msu.ru>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190625161153.29811-1-ar@cs.msu.ru>
References: <20190625161153.29811-1-ar@cs.msu.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 10.7.4.141
X-SA-Exim-Mail-From: ar@cs.msu.ru
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.cs.msu.ru
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_ADSP_ALL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.2
Subject: [PATCH v2 7/7] n_tty: Provide an informational line on VSTATUS receipt
X-SA-Exim-Version: 4.2
X-SA-Exim-Scanned: Yes (on mail.cs.msu.ru)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

If the three termios local flags isig, icanon, iexten are enabled
and the local flag nokerninfo is disabled for a tty governed
by the n_tty line discipline, then on receiving the keyboard status
character n_tty will generate a status message and write it out to
the tty before sending SIGINFO to the tty's foreground process group.

This kerninfo line contains information about the current system load
as well as some properties of "the most interesting" process in the
tty's current foreground process group, namely:
 - its PID as seen inside its deepest PID namespace;
   * the whole process group ought to be in a single PID namespace,
     so this is actually deterministic
 - its saved command name truncated to 16 bytes (task_struct::comm);
   * at the time of writing TASK_COMM_LEN == 16
 - its state and some related bits, procps-style;
 - for S and D: its symbolic wait channel, if available; or a short
   description for other process states instead;
 - its user, system and real rusage time values;
 - its resident set size (as well as the high watermark) in kilobytes.

The "most interesting" process is chosen as follows:
 - runnables over everything
 - uninterruptibles over everything else
 - among 2 runnables pick the biggest utime + stime
 - any unresolved ties are decided in favour of greatest PID.

While the kerninfo line is not very useful for debugging the kernel
itself, since we have much more powerful debugging tools, it still gives
the user behind the terminal some meaningful feedback to a VSTATUS that
works even if no processes respond.

Signed-off-by: Arseny Maslennikov <ar@cs.msu.ru>
---
 drivers/tty/Makefile       |   3 +-
 drivers/tty/n_tty.c        |  22 +++
 drivers/tty/n_tty_status.c | 337 +++++++++++++++++++++++++++++++++++++
 include/linux/sched.h      |   7 +
 include/linux/tty.h        |   3 +
 5 files changed, 371 insertions(+), 1 deletion(-)
 create mode 100644 drivers/tty/n_tty_status.c

diff --git a/drivers/tty/Makefile b/drivers/tty/Makefile
index 020b1cd9294f..8bb5efb40b81 100644
--- a/drivers/tty/Makefile
+++ b/drivers/tty/Makefile
@@ -1,7 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_TTY)		+= tty_io.o n_tty.o tty_ioctl.o tty_ldisc.o \
+obj-$(CONFIG_TTY)		+= tty_io.o tty_ioctl.o tty_ldisc.o \
 				   tty_buffer.o tty_port.o tty_mutex.o \
 				   tty_ldsem.o tty_baudrate.o tty_jobctrl.o \
+				   n_tty.o n_tty_status.o \
 				   n_null.o
 obj-$(CONFIG_LEGACY_PTYS)	+= pty.o
 obj-$(CONFIG_UNIX98_PTYS)	+= pty.o
diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 7d7d84adcffe..74e6b4bf86bd 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -34,6 +34,7 @@
 #include <linux/signal.h>
 #include <linux/fcntl.h>
 #include <linux/sched.h>
+#include <linux/kallsyms.h>
 #include <linux/interrupt.h>
 #include <linux/tty.h>
 #include <linux/timer.h>
@@ -79,6 +80,8 @@
 #define ECHO_BLOCK		256
 #define ECHO_DISCARD_WATERMARK	N_TTY_BUF_SIZE - (ECHO_BLOCK + 32)
 
+#define STATUS_LINE_LEN (2 * KSYM_NAME_LEN)
+
 #define SIG_FLUSHING_MASK ( \
 	rt_sigmask(SIGINT) | rt_sigmask(SIGQUIT) | \
 	rt_sigmask(SIGTSTP)			 )
@@ -158,6 +161,8 @@ static inline unsigned char *echo_buf_addr(struct n_tty_data *ldata, size_t i)
 	return &ldata->echo_buf[i & (N_TTY_BUF_SIZE - 1)];
 }
 
+static void n_tty_status_line(struct tty_struct *tty);
+
 /* If we are not echoing the data, perhaps this is a secret so erase it */
 static void zero_buffer(struct tty_struct *tty, u8 *buffer, int size)
 {
@@ -1300,6 +1305,8 @@ n_tty_receive_char_special(struct tty_struct *tty, unsigned char c)
 			n_tty_receive_signal_char(tty, SIGTSTP, c);
 			return 0;
 		} else if (c == STATUS_CHAR(tty)) {
+			if (!L_NOKERNINFO(tty))
+				n_tty_status_line(tty);
 			n_tty_receive_signal_char(tty, SIGINFO, c);
 			return 0;
 		}
@@ -2489,6 +2496,21 @@ static int n_tty_ioctl(struct tty_struct *tty, struct file *file,
 	}
 }
 
+static void n_tty_status_line(struct tty_struct *tty)
+{
+	struct n_tty_data *ldata = tty->disc_data;
+	char *msg, *buf;
+	msg = buf = kzalloc(STATUS_LINE_LEN, GFP_KERNEL);
+	tty_sprint_status_line(tty, buf + 1, STATUS_LINE_LEN - 1);
+	/* The only current caller of this takes output_lock for us. */
+	if (ldata->column != 0)
+		*msg = '\n';
+	else
+		msg++;
+	do_n_tty_write(tty, NULL, msg, strlen(msg));
+	kfree(buf);
+}
+
 static struct tty_ldisc_ops n_tty_ops = {
 	.magic           = TTY_LDISC_MAGIC,
 	.name            = "n_tty",
diff --git a/drivers/tty/n_tty_status.c b/drivers/tty/n_tty_status.c
new file mode 100644
index 000000000000..4836710a8306
--- /dev/null
+++ b/drivers/tty/n_tty_status.c
@@ -0,0 +1,337 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <linux/kallsyms.h>
+#include <linux/pid.h>
+#include <linux/sched.h>
+#include <linux/sched/signal.h>
+#include <linux/sched/loadavg.h>
+#include <linux/sched/cputime.h>
+#include <linux/sched/mm.h>
+#include <linux/slab.h>
+#include <linux/tty.h>
+
+#define BCOMPARE(lbool, rbool) ((lbool) << 1 | (rbool))
+#define BCOMPARE_NONE 0
+#define BCOMPARE_RIGHT 1
+#define BCOMPARE_LEFT 2
+#define BCOMPARE_BOTH (BCOMPARE_LEFT | BCOMPARE_RIGHT)
+
+/*
+ * Select the most interesting task of two.
+ *
+ * The implemented approach is simple for now:
+ * - pick runnable
+ * - if no runnables, pick uninterruptible
+ * - if tie between runnables, pick highest utime + stime
+ * - if a tie is not broken by the above, pick highest pid nr.
+ *
+ * For reference, here's the one used in FreeBSD:
+ * - pick runnables over anything
+ * - if both runnables, pick highest cpu utilization
+ * - if no runnables, pick shortest sleep time (the scheduler
+ *   actually takes care to maintain this statistic)
+ * - other ties are decided in favour of youngest process.
+ */
+static struct task_struct *__better_proc_R(struct task_struct *a,
+		struct task_struct *b)
+{
+	unsigned long flags;
+	u64 atime, btime, tgutime, tgstime;
+	struct task_struct *ret;
+
+	if (!lock_task_sighand(a, &flags))
+		goto out_a_unlocked;
+	thread_group_cputime_adjusted(a, &tgutime, &tgstime);
+	atime = tgutime + tgstime;
+	unlock_task_sighand(a, &flags);
+
+	if (!lock_task_sighand(b, &flags))
+		goto out_b_unlocked;
+	thread_group_cputime_adjusted(b, &tgutime, &tgstime);
+	btime = tgutime + tgstime;
+	unlock_task_sighand(b, &flags);
+
+	ret = atime > btime ? a : b;
+
+	return ret;
+
+out_b_unlocked:
+out_a_unlocked:
+	return task_pid_vinr(a) > task_pid_vinr(b) ? a : b;
+}
+
+static struct task_struct *__better_proc(struct task_struct *a,
+		struct task_struct *b)
+{
+	if (!pid_alive(a))
+		return b;
+	if (!pid_alive(b))
+		return a;
+
+	switch (BCOMPARE(a->state == TASK_RUNNING,
+			b->state == TASK_RUNNING)) {
+	case BCOMPARE_LEFT:
+		return a;
+	case BCOMPARE_RIGHT:
+		return b;
+	case BCOMPARE_BOTH:
+		return __better_proc_R(a, b);
+	}
+
+	switch (BCOMPARE(a->state == TASK_UNINTERRUPTIBLE,
+			b->state == TASK_UNINTERRUPTIBLE)) {
+	case BCOMPARE_LEFT:
+		return a;
+	case BCOMPARE_RIGHT:
+		return b;
+	case BCOMPARE_BOTH:
+		break;
+	}
+
+	/* TODO: Perhaps we should check something else... */
+	return task_pid_vinr(a) > task_pid_vinr(b) ? a : b;
+}
+
+/* Weed out NULLs. */
+static inline struct task_struct *better_proc(struct task_struct *a,
+		struct task_struct *b) {
+	return a ? (b ? __better_proc(a, b) : a) : b;
+}
+
+static int scnprint_load(char *msgp, size_t size)
+{
+	unsigned long la[3];
+
+	get_avenrun(la, FIXED_1/200, 0);
+	return scnprintf(msgp, size, "load: %lu.%02lu; ",
+			LOAD_INT(la[0]), LOAD_FRAC(la[0]));
+}
+
+static int scnprint_task(char *msgp, size_t size, struct task_struct *task)
+{
+	char commname[TASK_COMM_LEN];
+
+	get_task_comm(commname, task);
+	return scnprintf(msgp, size, "%d/%s:", task_pid_vinr(task), commname);
+}
+
+static int scnprint_rusage(char *msgp, ssize_t size,
+		struct task_struct *task, struct mm_struct *mm)
+{
+	struct rusage ru;
+	struct timeval utime, stime;
+	struct timespec rtime;
+	u64 now;
+	int ret = 0;
+	int psz = 0;
+
+	getrusage(task, RUSAGE_BOTH, &ru);
+	now = ktime_get_ns();
+
+	utime = ru.ru_utime;
+	stime = ru.ru_stime;
+	rtime.tv_nsec = now - task->start_time;
+	rtime.tv_sec = rtime.tv_nsec / 1000000000;
+	rtime.tv_nsec %= 1000000000;
+
+	psz = scnprintf(msgp, size,
+			"%lu.%03lur %lu.%03luu %lu.%03lus",
+			rtime.tv_sec, rtime.tv_nsec / 1000000,
+			utime.tv_sec, utime.tv_usec / 1000,
+			stime.tv_sec, stime.tv_usec / 1000);
+	ret += psz;
+	msgp += psz;
+	size -= psz;
+
+	if (mm) {
+		psz = scnprintf(msgp, size,
+				" %luk/%luk",
+				get_mm_rss(mm) * PAGE_SIZE / 1024,
+				get_mm_hiwater_rss(mm) * PAGE_SIZE / 1024);
+		ret += psz;
+	}
+	return ret;
+}
+
+static int scnprint_state(char *msgp, ssize_t size,
+		struct task_struct *task, struct mm_struct *mm)
+{
+	char stat[8] = {0};
+	const char *state_descr = "";
+	struct task_struct *parent = NULL;
+	struct task_struct *real_parent = NULL;
+	unsigned long wchan = 0;
+	int psz = 0;
+	char symname[KSYM_NAME_LEN];
+
+	stat[psz++] = task_state_to_char(task);
+	if (task_nice(task) < 0)
+		stat[psz++] = '<';
+	else if (task_nice(task) > 0)
+		stat[psz++] = 'N';
+	if (mm && mm->locked_vm)
+		stat[psz++] = 'L';
+	if (get_nr_threads(task) > 1)
+		stat[psz++] = 'l';
+
+	switch (stat[0]) {
+	case 'R':
+		if (task_curr(task))
+			stat[psz++] = '!';
+		break;
+	case 'S':
+	case 'D':
+		wchan = get_wchan(task);
+		if (!wchan)
+			break;
+		if (!lookup_symbol_name(wchan, symname))
+			state_descr = symname;
+		else
+			/* get_wchan() returned something
+			 * that looks like no kernel symbol.
+			 */
+			state_descr = "*unknown*";
+		break;
+	case 'T':
+		state_descr = "stopped";
+		break;
+	case 't':
+		state_descr = "traced";
+		break;
+	case 'Z':
+		rcu_read_lock();
+		real_parent = rcu_dereference(task->real_parent);
+		parent = rcu_dereference(task->parent);
+		psz = sprintf(symname, "zombie; ppid=%d",
+			task_tgid_nr_ns(real_parent,
+				ns_of_pid(task_pid(task))));
+		if (parent != real_parent)
+			sprintf(symname + psz, " reaper=%d",
+				task_tgid_nr_ns(parent,
+					ns_of_pid(task_pid(task))));
+		rcu_read_unlock();
+		state_descr = symname;
+		break;
+	case 'I':
+		/* Can this even happen? */
+		state_descr = "idle";
+		break;
+	default:
+		state_descr = "unknown";
+	}
+
+	psz = scnprintf(msgp, size, "%s", stat);
+	msgp += psz;
+	size -= psz;
+	if (*state_descr)
+		psz += scnprintf(msgp, size, wchan ? " [%s]" : " (%s)", state_descr);
+
+	return psz;
+}
+
+/**
+ *	tty_sprint_status_line	-		produce kerninfo line
+ *	@tty: terminal device
+ *	@msg: preallocated memory buffer
+ *	@length: maximum line length
+ *
+ *	Reports state of foreground process group in a null-terminated string
+ *	located at @msg, @length bytes long. If @length is insufficient,
+ *	the line gets truncated.
+ */
+void tty_sprint_status_line(struct tty_struct *t, char *msg, size_t length)
+{
+	struct task_struct *tsk = NULL, *mit = NULL;
+	struct mm_struct *mm;
+	struct pid *pgrp = NULL;
+	char *msgp = msg;
+	int psz = 0;
+
+	if (!length)
+		return;
+	length--; /* Make room for trailing '\n' */
+
+	psz = scnprint_load(msgp, length);
+	if (psz > 0) {
+		msgp += psz;
+		length -= psz;
+	}
+	if (!length)
+		goto finalize_message;
+
+	/* Not sure if session pid is protected by ctrl_lock
+	 * or tasklist_lock...
+	 */
+	pgrp = t->session;
+	if (pgrp == NULL) {
+		psz = scnprintf(msgp, length, "not a controlling tty");
+		if (psz > 0)
+			msgp += psz;
+		goto finalize_message;
+	}
+	pgrp = tty_get_pgrp(t);
+	if (pgrp == NULL) {
+		psz = scnprintf(msgp, length, "no foreground process group");
+		if (psz > 0)
+			msgp += psz;
+		goto finalize_message;
+	}
+
+	read_lock(&tasklist_lock);
+	do_each_pid_task(pgrp, PIDTYPE_PGID, tsk)
+	{
+		/* Select the most interesting task. */
+		if (tsk == better_proc(mit, tsk))
+			mit = tsk;
+	} while_each_pid_task(pgrp, PIDTYPE_PGID, tsk);
+	read_unlock(&tasklist_lock);
+
+	if (!pid_alive(mit))
+		goto finalize_message;
+
+	/* Gather intel on most interesting task. */
+	/* Can the mm of a foreground process turn out to be NULL?
+	 * Definitely; for example, if it is a zombie.
+	 */
+	mm = get_task_mm(mit);
+
+	psz = scnprint_task(msgp, length, mit);
+	if (psz > 0) {
+		msgp += psz;
+		length -= psz;
+	}
+	if (!length)
+		goto finalize_message;
+	*msgp++ = ' ';
+	length--;
+
+	psz = scnprint_state(msgp, length, mit, mm);
+	if (psz > 0) {
+		msgp += psz;
+		length -= psz;
+	}
+	if (!length)
+		goto finalize_message;
+	*msgp++ = ' ';
+	length--;
+
+	psz = scnprint_rusage(msgp, length, mit, mm);
+	if (psz > 0) {
+		msgp += psz;
+		length -= psz;
+	}
+	if (!length)
+		goto finalize_message;
+	*msgp++ = ' ';
+	length--;
+
+	if (!mm)
+		goto finalize_message;
+
+	mmput(mm);
+
+finalize_message:
+	*msgp++ = '\n';
+	if (pgrp)
+		put_pid(pgrp);
+}
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 11837410690f..21bcb7fb0888 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1229,6 +1229,8 @@ static inline struct pid *task_pid(struct task_struct *task)
  * task_xid_nr()     : global id, i.e. the id seen from the init namespace;
  * task_xid_vnr()    : virtual id, i.e. the id seen from the pid namespace of
  *                     current.
+ * task_xid_vinr()   : virtual inner id, i.e. the id seen from the namespace of
+ *                     the task itself;
  * task_xid_nr_ns()  : id seen from the ns specified;
  *
  * see also pid_nr() etc in include/linux/pid.h
@@ -1250,6 +1252,11 @@ static inline pid_t task_pid_vnr(struct task_struct *tsk)
 	return __task_pid_nr_ns(tsk, PIDTYPE_PID, NULL);
 }
 
+static inline pid_t task_pid_vinr(struct task_struct *tsk)
+{
+	return __task_pid_nr_ns(tsk, PIDTYPE_PID, ns_of_pid(task_pid(tsk)));
+}
+
 
 static inline pid_t task_tgid_nr(struct task_struct *tsk)
 {
diff --git a/include/linux/tty.h b/include/linux/tty.h
index ddb97704956d..a8e4df6d64b4 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -725,6 +725,9 @@ extern void __init n_tty_init(void);
 static inline void n_tty_init(void) { }
 #endif
 
+/* n_tty_status.c */
+extern void tty_sprint_status_line(struct tty_struct *tty, char *msg, size_t size);
+
 /* tty_audit.c */
 #ifdef CONFIG_AUDIT
 extern void tty_audit_add_data(struct tty_struct *tty, const void *data,
-- 
2.20.1

