Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74D941362E3
	for <lists+linux-serial@lfdr.de>; Thu,  9 Jan 2020 22:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbgAIVzH (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 9 Jan 2020 16:55:07 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:55362 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbgAIVzG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 9 Jan 2020 16:55:06 -0500
Received: by mail-pj1-f68.google.com with SMTP id d5so64395pjz.5
        for <linux-serial@vger.kernel.org>; Thu, 09 Jan 2020 13:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PzduO3ezdq2YxbApEf/p7n8rWrnulpFMg5X7ZAYRvh4=;
        b=NACYKqJUKlrtSZDdGRKTweW0ZYhfwtIpUyehrAlSEABjHgI3DuvSm1Wh6eObC3hI6U
         4aarbHexpqYc3gVdpOJOyIuRhuV9FsqQgY90zrJy8nj76iIy7xi6uRRYrl6Qfs5dWzzn
         Q3R8gdNHixCz2Mf4yP3wDRJDiRB8zFiDt8Og0SVdu4KaG1mxOpTrp7w5KuwLrS8f317u
         +sOLTcUyIKBH0T9zVnALwzEjl/W4xnDAl4u3qXwzpa50ONEh3l4BUJtnVEhxc4asOSgD
         QnJzrubWX5jDv/8HVnbEyGIWG03VGzXqx5AN4qtyUEISRQFeNsJJBexhjAT2SyloQSV1
         L6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PzduO3ezdq2YxbApEf/p7n8rWrnulpFMg5X7ZAYRvh4=;
        b=ggXqe4uvK04+7B1czKvc4p8cOC49TOe9iPOw3iuWibt/hATSACV9E/dn5bvLH00cBF
         7+jufheCx33AGnR5zl4pLq5sjXcTigWXrYaevaFHRI3MV1yX+oVXeKWQzhoS9SylrwTI
         83JccRywsVLUM6DvuCFz/9s17HVetOO18V97WE6XYSUk80MstyLdHzdKEzpPdEINVQAV
         4CpgcYk/3axa7H6wMcL3TuWsk3QUpVVCTlcCjztWHUyLgbHRVno+IyZA579bNZ5h1xCV
         +I4/pi3BIChYDoRm5VVJVDW7w0ONJEBeOG4+m861fZMwl6RFld82VAe35EcHL38UkwyJ
         XlzQ==
X-Gm-Message-State: APjAAAWdcNmoQR1nedXYwGSBDckwycag7P97Q8ivR+ugNbZcdnyYg3Tc
        OxJYGLQcvHiNI3px3LPcWYyyWg==
X-Google-Smtp-Source: APXvYqyuhalmHNEKi9rgUlX1W2D500mU/5hrB2Skd8Ar7XDjSAlhUXV0PYnZH6LApctxTDXOELTgYA==
X-Received: by 2002:a17:90a:1b66:: with SMTP id q93mr320993pjq.102.1578606906076;
        Thu, 09 Jan 2020 13:55:06 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r20sm8711536pgu.89.2020.01.09.13.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 13:55:05 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: [PATCH-next 1/3] serial_core: Move sysrq functions from header file
Date:   Thu,  9 Jan 2020 21:54:42 +0000
Message-Id: <20200109215444.95995-2-dima@arista.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200109215444.95995-1-dima@arista.com>
References: <20200109215444.95995-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

It's not worth to have them in every serial driver and I'm about to add
another helper function.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/serial/serial_core.c | 83 +++++++++++++++++++++++++++++++
 include/linux/serial_core.h      | 84 ++------------------------------
 2 files changed, 88 insertions(+), 79 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 7c2782785736..6ac9dfed3423 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3081,6 +3081,89 @@ void uart_insert_char(struct uart_port *port, unsigned int status,
 }
 EXPORT_SYMBOL_GPL(uart_insert_char);
 
+int uart_handle_sysrq_char(struct uart_port *port, unsigned int ch)
+{
+	if (!IS_ENABLED(CONFIG_MAGIC_SYSRQ_SERIAL))
+		return 0;
+
+	if (!port->has_sysrq || !port->sysrq)
+		return 0;
+
+	if (ch && time_before(jiffies, port->sysrq)) {
+		handle_sysrq(ch);
+		port->sysrq = 0;
+		return 1;
+	}
+	port->sysrq = 0;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(uart_handle_sysrq_char);
+
+int uart_prepare_sysrq_char(struct uart_port *port, unsigned int ch)
+{
+	if (!IS_ENABLED(CONFIG_MAGIC_SYSRQ_SERIAL))
+		return 0;
+
+	if (!port->has_sysrq || !port->sysrq)
+		return 0;
+
+	if (ch && time_before(jiffies, port->sysrq)) {
+		port->sysrq_ch = ch;
+		port->sysrq = 0;
+		return 1;
+	}
+	port->sysrq = 0;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(uart_prepare_sysrq_char);
+
+void uart_unlock_and_check_sysrq(struct uart_port *port, unsigned long irqflags)
+{
+	int sysrq_ch;
+
+	if (!port->has_sysrq) {
+		spin_unlock_irqrestore(&port->lock, irqflags);
+		return;
+	}
+
+	sysrq_ch = port->sysrq_ch;
+	port->sysrq_ch = 0;
+
+	spin_unlock_irqrestore(&port->lock, irqflags);
+
+	if (sysrq_ch)
+		handle_sysrq(sysrq_ch);
+}
+EXPORT_SYMBOL_GPL(uart_unlock_and_check_sysrq);
+
+/*
+ * We do the SysRQ and SAK checking like this...
+ */
+int uart_handle_break(struct uart_port *port)
+{
+	struct uart_state *state = port->state;
+
+	if (port->handle_break)
+		port->handle_break(port);
+
+	if (port->has_sysrq) {
+		if (port->cons && port->cons->index == port->line) {
+			if (!port->sysrq) {
+				port->sysrq = jiffies + HZ*5;
+				return 1;
+			}
+			port->sysrq = 0;
+		}
+	}
+
+	if (port->flags & UPF_SAK)
+		do_SAK(state->port.tty);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(uart_handle_break);
+
 EXPORT_SYMBOL(uart_write_wakeup);
 EXPORT_SYMBOL(uart_register_driver);
 EXPORT_SYMBOL(uart_unregister_driver);
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 9cf1682dc580..255e86a474e9 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -460,85 +460,11 @@ extern void uart_handle_cts_change(struct uart_port *uport,
 extern void uart_insert_char(struct uart_port *port, unsigned int status,
 		 unsigned int overrun, unsigned int ch, unsigned int flag);
 
-static inline int
-uart_handle_sysrq_char(struct uart_port *port, unsigned int ch)
-{
-	if (!IS_ENABLED(CONFIG_MAGIC_SYSRQ_SERIAL))
-		return 0;
-
-	if (!port->has_sysrq || !port->sysrq)
-		return 0;
-
-	if (ch && time_before(jiffies, port->sysrq)) {
-		handle_sysrq(ch);
-		port->sysrq = 0;
-		return 1;
-	}
-	port->sysrq = 0;
-
-	return 0;
-}
-static inline int
-uart_prepare_sysrq_char(struct uart_port *port, unsigned int ch)
-{
-	if (!IS_ENABLED(CONFIG_MAGIC_SYSRQ_SERIAL))
-		return 0;
-
-	if (!port->has_sysrq || !port->sysrq)
-		return 0;
-
-	if (ch && time_before(jiffies, port->sysrq)) {
-		port->sysrq_ch = ch;
-		port->sysrq = 0;
-		return 1;
-	}
-	port->sysrq = 0;
-
-	return 0;
-}
-static inline void
-uart_unlock_and_check_sysrq(struct uart_port *port, unsigned long irqflags)
-{
-	int sysrq_ch;
-
-	if (!port->has_sysrq) {
-		spin_unlock_irqrestore(&port->lock, irqflags);
-		return;
-	}
-
-	sysrq_ch = port->sysrq_ch;
-	port->sysrq_ch = 0;
-
-	spin_unlock_irqrestore(&port->lock, irqflags);
-
-	if (sysrq_ch)
-		handle_sysrq(sysrq_ch);
-}
-
-/*
- * We do the SysRQ and SAK checking like this...
- */
-static inline int uart_handle_break(struct uart_port *port)
-{
-	struct uart_state *state = port->state;
-
-	if (port->handle_break)
-		port->handle_break(port);
-
-	if (port->has_sysrq) {
-		if (port->cons && port->cons->index == port->line) {
-			if (!port->sysrq) {
-				port->sysrq = jiffies + HZ*5;
-				return 1;
-			}
-			port->sysrq = 0;
-		}
-	}
-
-	if (port->flags & UPF_SAK)
-		do_SAK(state->port.tty);
-	return 0;
-}
+extern int uart_handle_sysrq_char(struct uart_port *port, unsigned int ch);
+extern int uart_prepare_sysrq_char(struct uart_port *port, unsigned int ch);
+extern void uart_unlock_and_check_sysrq(struct uart_port *port,
+					unsigned long irqflags);
+extern int uart_handle_break(struct uart_port *port);
 
 /*
  *	UART_ENABLE_MS - determine if port should enable modem status irqs
-- 
2.24.1

