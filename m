Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC7511DAC8
	for <lists+linux-serial@lfdr.de>; Fri, 13 Dec 2019 01:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731965AbfLMAKI (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 12 Dec 2019 19:10:08 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:46278 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731960AbfLMAKH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Dec 2019 19:10:07 -0500
Received: by mail-pj1-f68.google.com with SMTP id z21so331768pjq.13
        for <linux-serial@vger.kernel.org>; Thu, 12 Dec 2019 16:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KvnAD1yLF9GgQIu36T7GgNkVG8ZaovS9k11def32GLk=;
        b=DsxoXaecMZhFuQ9HHYo1wLpJR/KXsn91l8qAUKj2Fmht53+CzGnDGhqZhvRAbQIq5h
         PQwa6xxPYVH+f1/g7S1cslltMF37CjvX7pKu54tvmzII5WOa5TxdBTnqS8fBlcKIf0Ng
         uhPSZnyqbMqf2w/12jAi/3ZeK7jLc1cAwd0un7v/GKxiWt6Rw0uQ08U2gPPFVoBJl1IA
         0mSIH9FjJWY9bVGo8NQhApra+Rq/r8216n92yVw6uyt8xoeZNOZf7AFtgTLoC5/nFd1D
         vDzQl7gaKNbNDQid9bumtV8UzNIl7EMmL8TltffMwGcGnDmBKGSXhaO5TRzUnMacBk+L
         IdGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KvnAD1yLF9GgQIu36T7GgNkVG8ZaovS9k11def32GLk=;
        b=QZ8bY+OJLUce1kTvAofdZPILwUSL1U5kHhTGTQZpcwbwYLY6NDq36ZdyY7rSgY0TCx
         SqCG2gURL6QTR0APWInw0HjzkESGXGM3/7uc8SN6HXpVfom6XhAWXW3viW2qrfnLwD6D
         QQFnlfdEb2C70Sb+KfiDdk+EjUCQmDI5qUthaxp955H4wSAPJNF63zjhT9cKqzhOuoVw
         kgsepYTokU9MznjgUdQrX5dW6uFzVbyhZ8ve0xlSNE8CbyhyhOq22uj+1dmOQ+V4zFxC
         a7B4ysVDqNCgaMSOQX0FOuqswWblCPvm5tedkisUlBP0EzFtUPwAXH9gI5D742pg+bEc
         EsHw==
X-Gm-Message-State: APjAAAU+EKMflNtpHvNru1MKAQ56D+wgP932NHoJY8Y2FP1GJPYRWo5H
        TodyBg/qQyVHAUUnWE/c8ZCUIw==
X-Google-Smtp-Source: APXvYqzOJEsUzplWsJptPWJIAve8pBr8JefnlaBZXWg+ieCxN4q7oTVtzSo4WTQU8dsjSlhb7x2yfw==
X-Received: by 2002:a17:90b:8cf:: with SMTP id ds15mr13292832pjb.134.1576195806784;
        Thu, 12 Dec 2019 16:10:06 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:10:05 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: [PATCH 58/58] serial/sysrq: Add MAGIC_SYSRQ_SERIAL_SEQUENCE
Date:   Fri, 13 Dec 2019 00:06:57 +0000
Message-Id: <20191213000657.931618-59-dima@arista.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191213000657.931618-1-dima@arista.com>
References: <20191213000657.931618-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Many embedded boards have a disconnected TTL level serial which can
generate some garbage that can lead to spurious false sysrq detects.

Currently, sysrq can be either completely disabled for serial console
or always disabled (with CONFIG_MAGIC_SYSRQ_SERIAL), since
commit 732dbf3a6104 ("serial: do not accept sysrq characters via serial port")

At Arista, we have such boards that can generate BREAK and random
garbage. While disabling sysrq for serial console would solve
the problem with spurious false sysrq triggers, it's also desirable
to have a way to enable sysrq back.

As a measure of balance between on and off options, add
MAGIC_SYSRQ_SERIAL_SEQUENCE which is a string sequence that can enable
sysrq if it follows BREAK on a serial line. The longer the string - the
less likely it may be in the garbage.

Having the way to enable sysrq was beneficial to debug lockups with
a manual investigation in field and on the other side preventing false
sysrq detections.

Based-on-patch-by: Vasiliy Khoruzhick <vasilykh@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/serial/serial_core.c | 52 ++++++++++++++++++++++++++++----
 include/linux/serial_core.h      |  2 +-
 lib/Kconfig.debug                |  8 +++++
 3 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index ef43c168e848..4570c99a137a 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3080,6 +3080,38 @@ void uart_insert_char(struct uart_port *port, unsigned int status,
 }
 EXPORT_SYMBOL_GPL(uart_insert_char);
 
+const char sysrq_toggle_seq[] = CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE;
+
+static void uart_sysrq_on(struct work_struct *w)
+{
+	sysrq_toggle_support(1);
+	pr_info("SysRq is enabled by magic sequience on serial\n");
+}
+static DECLARE_WORK(sysrq_enable_work, uart_sysrq_on);
+
+static int uart_try_toggle_sysrq(struct uart_port *port, unsigned int ch)
+{
+	if (sysrq_toggle_seq[0] == '\0')
+		return 0;
+
+	BUILD_BUG_ON(ARRAY_SIZE(sysrq_toggle_seq) >= sizeof(port->sysrq_seq)*U8_MAX);
+	if (sysrq_toggle_seq[port->sysrq_seq] != ch) {
+		port->sysrq_seq = 0;
+		return 0;
+	}
+
+	/* Without the last \0 */
+	if (++port->sysrq_seq < (ARRAY_SIZE(sysrq_toggle_seq) - 1)) {
+		port->sysrq = jiffies + HZ*5;
+		return 1;
+	}
+
+	schedule_work(&sysrq_enable_work);
+
+	port->sysrq = 0;
+	return 1;
+}
+
 int uart_handle_sysrq_char(struct uart_port *port, unsigned int ch)
 {
 	if (!IS_ENABLED(CONFIG_MAGIC_SYSRQ_SERIAL))
@@ -3089,9 +3121,13 @@ int uart_handle_sysrq_char(struct uart_port *port, unsigned int ch)
 		return 0;
 
 	if (ch && time_before(jiffies, port->sysrq)) {
-		handle_sysrq(ch);
-		port->sysrq = 0;
-		return 1;
+		if (sysrq_get_mask()) {
+			handle_sysrq(ch);
+			port->sysrq = 0;
+			return 1;
+		}
+		if (uart_try_toggle_sysrq(port, ch))
+			return 1;
 	}
 	port->sysrq = 0;
 
@@ -3108,9 +3144,13 @@ int uart_prepare_sysrq_char(struct uart_port *port, unsigned int ch)
 		return 0;
 
 	if (ch && time_before(jiffies, port->sysrq)) {
-		port->sysrq_ch = ch;
-		port->sysrq = 0;
-		return 1;
+		if (sysrq_get_mask()) {
+			port->sysrq_ch = ch;
+			port->sysrq = 0;
+			return 1;
+		}
+		if (uart_try_toggle_sysrq(port, ch))
+			return 1;
 	}
 	port->sysrq = 0;
 
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 255e86a474e9..1f4443db5474 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -243,10 +243,10 @@ struct uart_port {
 	unsigned long		sysrq;			/* sysrq timeout */
 	unsigned int		sysrq_ch;		/* char for sysrq */
 	unsigned char		has_sysrq;
+	unsigned char		sysrq_seq;		/* index in sysrq_toggle_seq */
 
 	unsigned char		hub6;			/* this should be in the 8250 driver */
 	unsigned char		suspended;
-	unsigned char		unused;
 	const char		*name;			/* port name */
 	struct attribute_group	*attr_group;		/* port specific attributes */
 	const struct attribute_group **tty_groups;	/* all attributes (serial core use only) */
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index d1842fe756d5..babc464ce14a 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -431,6 +431,14 @@ config MAGIC_SYSRQ_SERIAL
 	  This option allows you to decide whether you want to enable the
 	  magic SysRq key.
 
+config MAGIC_SYSRQ_SERIAL_SEQUENCE
+	string "Char sequence that enables magic SysRq over serial"
+	depends on MAGIC_SYSRQ_SERIAL
+	default ""
+	help
+	  Specifies a sequence of characters that can follow BREAK to enable
+	  SysRq on a serial console.
+
 config DEBUG_FS
 	bool "Debug Filesystem"
 	help
-- 
2.24.0

