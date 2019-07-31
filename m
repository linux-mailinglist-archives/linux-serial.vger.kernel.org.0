Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1C67D0A3
	for <lists+linux-serial@lfdr.de>; Thu,  1 Aug 2019 00:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730465AbfGaWRN (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 31 Jul 2019 18:17:13 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:47971 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731330AbfGaWRN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 31 Jul 2019 18:17:13 -0400
Received: by mail-pg1-f201.google.com with SMTP id l11so22343307pgc.14
        for <linux-serial@vger.kernel.org>; Wed, 31 Jul 2019 15:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AYLtZ41z1RHlFpOZnl+JGLaHaK4EJ2Av6xB01tUKIjQ=;
        b=vvpeXRKyc5OhHv4Gr/tukOYbwIwjOYYXtqIP/Io9iIGtPO3Kve6jw/W7bz2rF/pLv1
         RlW5o4cGWbTXLPdROo8nSoKA3X7rpN7sDIwV1d/Fkm3vpj5fFKlODN732XeUwRiYz3Ke
         TW9ChBbAGCWNTBdcbOZ73xw4f5kes2Emo/1AT/+3MfhQ8BoEcrnKZHlAFFwFtqt85uMv
         Hrp+989qk4cKlnGSLSV1ao/ObzrMwaeocP0iHhwU4p9uXakErgQiaqLm3O0VzWsyNNyY
         9CqLjrTvWM8AjYlNkYT/fe066FOTrmczakFGWc6cjFSFGLsLIYYWVoFByBrYFECbZTDO
         MNew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AYLtZ41z1RHlFpOZnl+JGLaHaK4EJ2Av6xB01tUKIjQ=;
        b=POIy+y5PkYm8LSvp95nX0UCaUUNdPEYVTHjHyWSP+CWBrPS9Pg9lDzzPQ95zqlJh1D
         IIgh6nz5fq/kO8Ayg9L7AjcMtK1PoZ9XgU2yA7WiwvHgY4cuE/wom1cy62q+zZBKUgsn
         Im36FC5/udxpRl6cI/5v5u1WI5uHhLsT3sZI8jq3HBaA0ODiQQJOvtENenLAavCJKbP8
         oM9TcAZWRuf9dUNszuwknmtsG76lf9jWUrHeBHClwrkUoke5vWghHZDtWWMMq6LcBkdm
         BTtawaZapXZlfIVGjH6Cd8KBg2wIzaMatePzS9lf4gOp0AUmklNdB8NftDd7wMpS34S5
         FMDw==
X-Gm-Message-State: APjAAAXANg9hZeHdFk4zrH2ODNTGDZrOU7XxcBNYIToqTjQFQ5jALYgD
        n21yXefC9uzBpVvc2nI/y4jPdQXugHyK8x3USNcPWw==
X-Google-Smtp-Source: APXvYqzkiW7uEdQQUtaZ0YHcWPNEQQcr9wR/H4mTJIlJ8xEUbv8Q5RP5zNIsLLGkfkAO0eul945srgorH4QzlUVn11pgkg==
X-Received: by 2002:a63:5402:: with SMTP id i2mr88751122pgb.414.1564611431661;
 Wed, 31 Jul 2019 15:17:11 -0700 (PDT)
Date:   Wed, 31 Jul 2019 15:16:06 -0700
In-Reply-To: <20190731221617.234725-1-matthewgarrett@google.com>
Message-Id: <20190731221617.234725-19-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190731221617.234725-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V37 18/29] Lock down TIOCSSERIAL
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
index 22482e1b9a77..00a3a6438dd2 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -27,6 +27,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_MSR] = "raw MSR access",
 	[LOCKDOWN_ACPI_TABLES] = "modifying ACPI tables",
 	[LOCKDOWN_PCMCIA_CIS] = "direct PCMCIA CIS storage",
+	[LOCKDOWN_TIOCSSERIAL] = "reconfiguration of serial port IO",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.22.0.770.g0f2c4a37fd-goog

