Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 589511362E8
	for <lists+linux-serial@lfdr.de>; Thu,  9 Jan 2020 22:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbgAIVzQ (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 9 Jan 2020 16:55:16 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:32851 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729032AbgAIVzP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 9 Jan 2020 16:55:15 -0500
Received: by mail-pl1-f194.google.com with SMTP id ay11so14267plb.0
        for <linux-serial@vger.kernel.org>; Thu, 09 Jan 2020 13:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0t7GY6iSUUJjTNq+571aHFfJqJAb8s1IuRDcFTf/E44=;
        b=mHJoCq0IIBFpUNEH5TNsxx2Mdg9Kp9foE409HrV8dHsT/E4UFq2VGrpwkcBaMNfwAG
         FPCN6CE701wFATLa9eCoWonTQVXQKKsm8v1PHLkhl7JtUvyhBVoeeX+nNEXNV+jD9fVP
         A6/etzJFI1ZdSjp2bd8DchmM7T+hqznrY5Qw6piob5vdk6Utqb6a4nGBHUbIH8nDV1xO
         jEwkacqEFHo5dPZ6cnktqnFZCmajRaLCsQz8ykyWwlL0SnEQMeKvGM9g6xHtkV8KNGWI
         KqWQIk8sdTrhoiITCbToQqw7/vuLVRLXpeOpMuRsQzNqSffXaTxrVE9SBPuIXCMzq0ZH
         9Mgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0t7GY6iSUUJjTNq+571aHFfJqJAb8s1IuRDcFTf/E44=;
        b=cQ8qUpPtIgzTXISS0fWD7Uxl2/dD9tb7jmShzGWt8BLHEqJ6wuybDY5+gv8kWwPSAU
         bAIZM35gbgSkb4HZN+UXrZNHtyzYzfRhBupr7aBX/vgYN1E9aZA3ui7EgYnJ8JcmMvzY
         uTQ+ics+wurVvZJnr3u9VZMMQlfU/G1J2Vj68WBSFiX8Gzs3RUtGWx9j1FYgVssFPWeL
         KhBgVjHD1kX464q+7GxcPujJnQ+TLqzK7lMiuS6Kt6If/Rx+lFRc3qp53WsZOQhyGUEY
         HRQDQ1M00L8wpDcGvKydGHE3z8Kd6B/NFIzAtZY5OyU5JJE8OqUtMSVAvS6K67+Fq8Mr
         GZ2w==
X-Gm-Message-State: APjAAAVEGuKoqqrF0UXzNkTs5JMbMA8ImuZ781h0ShQ1Q4jJSr9NEEAw
        MeJTn7hF78Iyy1zqFBEvitNJKw==
X-Google-Smtp-Source: APXvYqwE8mz5Ea5w1E08qFqHvPBY8vLXirpMFLgZXzw8CUgYKwU1ONgqf4eVhGrAwj8q/Y8ewVaVHg==
X-Received: by 2002:a17:902:8497:: with SMTP id c23mr141511plo.59.1578606914837;
        Thu, 09 Jan 2020 13:55:14 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r20sm8711536pgu.89.2020.01.09.13.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 13:55:14 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: [PATCH-next 3/3] serial/sysrq: Add MAGIC_SYSRQ_SERIAL_SEQUENCE
Date:   Thu,  9 Jan 2020 21:54:44 +0000
Message-Id: <20200109215444.95995-4-dima@arista.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200109215444.95995-1-dima@arista.com>
References: <20200109215444.95995-1-dima@arista.com>
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
index 6ac9dfed3423..f70eba032d0b 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3081,6 +3081,38 @@ void uart_insert_char(struct uart_port *port, unsigned int status,
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
@@ -3090,9 +3122,13 @@ int uart_handle_sysrq_char(struct uart_port *port, unsigned int ch)
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
 
@@ -3109,9 +3145,13 @@ int uart_prepare_sysrq_char(struct uart_port *port, unsigned int ch)
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
index 330909c600b1..f6f3e82fee25 100644
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
2.24.1

