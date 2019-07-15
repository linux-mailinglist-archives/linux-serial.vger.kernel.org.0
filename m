Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4754069BF2
	for <lists+linux-serial@lfdr.de>; Mon, 15 Jul 2019 22:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732564AbfGOUAm (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 15 Jul 2019 16:00:42 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:54285 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732549AbfGOUAm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Jul 2019 16:00:42 -0400
Received: by mail-qt1-f201.google.com with SMTP id t5so15794786qtd.21
        for <linux-serial@vger.kernel.org>; Mon, 15 Jul 2019 13:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+BVs4+IbUnzxqigablcI43G/OcpEsyLzvDMqSyBhvlI=;
        b=jgN+Hy5rzJRsBCdzAEzybx+UKxNAwDH+7UJAzEJ2Cej0p1BYdTOfvUb/mP4HbNphci
         wrI7yB5rVVj8A0KGE1Fb6LoYjo7Pbc9q5dzrpOD95LWQon1UmAeJE4nwUMagb5z8r8d3
         wJS0X52iwL8P8Dk14P9COut/Pc9XhvXqzQ+SyzWPSqAFqRoPJ0Eg5MTWcfS304S/WHfS
         iWIW3wBMWMj0oDP+DU/dD4dI2hPNlFGpu6neH8iTGqAP7t7Im0bNLKehHfrhvor/J0oZ
         Ymvh2xn8z+PugScxAa/rXUXqRxdwnHJ3iJQNEakHptBYqM/si+stCFQjrTP56XmKQOFA
         d2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+BVs4+IbUnzxqigablcI43G/OcpEsyLzvDMqSyBhvlI=;
        b=XY36AjK54x0Xgmxe9INpqJCbaaaE7kreKADJe218EQBHbMbwTRqjpE0pXhcIutjhMM
         ROJGa/MCO1wOWh2EmEe4REo/g3FDDdahTJnC046DovaCLts45FNaRVnUkuZJ23jO/DQx
         V6cQJY/QtueMb9smD0eLfN0JIrhyABLP4iV/3j7PMcU52i6axT0eNfVm59CiWmoZ4IgU
         jwf/rfu5AihW2I2a4iNEC3leUmVBPoAQtZceq2wqnkgIjRfJQDNClqIMDzrKjG98TZDS
         vPHpxQOYwstUFuT+tnQdXPJI0k1/15LHqbH9hWQ63Elk9u3PzASJXYpIQwu2gXEbZBNk
         xsZw==
X-Gm-Message-State: APjAAAXiq6qG6KGEimfJqJYyKlTtKOLE/5B24m2ZyTG7eZDTZePUFZtl
        QAhxfx5ShkoHi7tt6qhc0Xeekr2SaP+9q3pDOqKiuw==
X-Google-Smtp-Source: APXvYqz5vvHyqfroaIhAkEducyiSejDIwwb5RxaoLydNSP26fz0XARD+t+kfcq7TPA3VrlndqDtTAjK4bu1ie1cI3VCE7g==
X-Received: by 2002:a05:620a:1286:: with SMTP id w6mr17687717qki.219.1563220841099;
 Mon, 15 Jul 2019 13:00:41 -0700 (PDT)
Date:   Mon, 15 Jul 2019 12:59:35 -0700
In-Reply-To: <20190715195946.223443-1-matthewgarrett@google.com>
Message-Id: <20190715195946.223443-19-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190715195946.223443-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V35 18/29] Lock down TIOCSSERIAL
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Lock down TIOCSSERIAL as that can be used to change the ioport and irq
settings on a serial port.  This only appears to be an issue for the serial
drivers that use the core serial code.  All other drivers seem to either
ignore attempts to change port/irq or give an error.

Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org
---
 drivers/tty/serial/serial_core.c | 5 +++++
 include/linux/security.h         | 1 +
 security/lockdown/lockdown.c     | 1 +
 3 files changed, 7 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 4223cb496764..6e713be1d4e9 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -22,6 +22,7 @@
 #include <linux/serial_core.h>
 #include <linux/delay.h>
 #include <linux/mutex.h>
+#include <linux/security.h>
 
 #include <linux/irq.h>
 #include <linux/uaccess.h>
@@ -862,6 +863,10 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 		goto check_and_exit;
 	}
 
+	retval = security_locked_down(LOCKDOWN_TIOCSSERIAL);
+	if (retval && (change_irq || change_port))
+		goto exit;
+
 	/*
 	 * Ask the low level driver to verify the settings.
 	 */
diff --git a/include/linux/security.h b/include/linux/security.h
index 3773ad09b831..8f7048395114 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -112,6 +112,7 @@ enum lockdown_reason {
 	LOCKDOWN_MSR,
 	LOCKDOWN_ACPI_TABLES,
 	LOCKDOWN_PCMCIA_CIS,
+	LOCKDOWN_TIOCSSERIAL,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 96106c2870ef..07a49667f234 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -27,6 +27,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_MSR] = "raw MSR access",
 	[LOCKDOWN_ACPI_TABLES] = "modified ACPI tables",
 	[LOCKDOWN_PCMCIA_CIS] = "direct PCMCIA CIS storage",
+	[LOCKDOWN_TIOCSSERIAL] = "reconfiguration of serial port IO",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.22.0.510.g264f2c817a-goog

