Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C60A411DA6C
	for <lists+linux-serial@lfdr.de>; Fri, 13 Dec 2019 01:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731372AbfLMAHW (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 12 Dec 2019 19:07:22 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37599 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731128AbfLMAHU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Dec 2019 19:07:20 -0500
Received: by mail-pg1-f196.google.com with SMTP id q127so542622pga.4
        for <linux-serial@vger.kernel.org>; Thu, 12 Dec 2019 16:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+c98ZzOoZa6r4oh0WHvCTRmQQ3Z1F+2HIMc70hjB/hU=;
        b=jEsgZRumRQgH2VTgb7IeNELwg6EsCFbkQ6k+lMA5NcFyPPxcLIoX7AL6uyea78KEc8
         49DZo0LWs9eTr1cRpFmpLqmCdvRvtFYienwXJTiQrmOmxbusdeCx8hyOPVooq8w+WGun
         Y+8vzZciN1QI0taHL4RSf5PS/UkXz6lAKeCiZOaEjaDw3kf6h+r3GeYmiUiTNSXbBcxt
         595481evp0kvUEWPNYWY6JNHier+4Qf16k+Mca5m6hx8M9RMp9/CRtplGm7N6PLSgdTI
         EsEy+U9K4k1wz2p9HbwRXTQ4E9KZ8DOZN/EcvYVAZoqpxkeHPZ6IHbKvTFg7vPdO1M5l
         yLKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+c98ZzOoZa6r4oh0WHvCTRmQQ3Z1F+2HIMc70hjB/hU=;
        b=dpPZ5Gh5h5iGc6oknWyOtqvP4sA1lKHGfi34Se4hCWeY99MLgPreMxV2KGS2IZHoNU
         crMo9RmeEK6Hl9tWpcMMFK8K9eM7Ji2//7FVsRKkboMf/12axIl5HSQrseVAP/iYTwC/
         4qzZvKndD/kpouF6zI+yjH/ydFhb7vYliAyICkdfTdF6d92JMF38LprVnZXJCLc1hRsB
         rhk3LWlUf0gScin2114V0gAD3aldEOEXdNLOWpWpKiA3e1a1PsvY3+ismlXlN9ZP396Z
         4ib3d2KMLswcW+AliLUIPcVchvy4v67MM/WwseDBXbfL4EALlJ/S0s7EDUPUzdnn7NyE
         R5vA==
X-Gm-Message-State: APjAAAUZo4gEZezC6lF/hK9lV6gIVBvnAaRfrMz7wjryUJv/aDV6ZTZV
        qAF4JsaY/fRQbKrpfgoD2ZbCGQ==
X-Google-Smtp-Source: APXvYqz5fQ+7DouCDoyrPelCmS/wHA9WAdlujQLAMlQCjfldKxAtxyGpHXYSKFLtaHn0VOlC0r4y2Q==
X-Received: by 2002:a63:5a64:: with SMTP id k36mr13933148pgm.323.1576195639965;
        Thu, 12 Dec 2019 16:07:19 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:07:19 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: [PATCH 02/58] serial: Move sysrq members above
Date:   Fri, 13 Dec 2019 00:06:01 +0000
Message-Id: <20191213000657.931618-3-dima@arista.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191213000657.931618-1-dima@arista.com>
References: <20191213000657.931618-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

At the current place members those follow are:
:	upf_t			flags;
:	upstat_t		status;
:	int			hw_stopped;
:	unsigned int		mctrl;
:	unsigned int		timeout;
:	unsigned int		type;
:	const struct uart_ops	*ops;

Together, they give (*ops) 8-byte align on 64-bit platforms.
And `sysrq_ch` introduces 4-byte padding.

On the other side, above:
:	struct device		*dev;
:	unsigned char		hub6;
:	unsigned char		suspended;
:	unsigned char		unused[2];
:	const char		*name;

Adds another 4-byte padding.

Moving sysrq members just before `hub6` allows to save 8 bytes
per-uart_port on 64-bit platforms:
On my gcc, x86_64 sizeof(struct uart_port) goes from 528 to 520.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/linux/serial_core.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 2b78cc734719..bbbe57bf5163 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -161,11 +161,6 @@ struct uart_port {
 	struct uart_icount	icount;			/* statistics */
 
 	struct console		*cons;			/* struct console, if any */
-#if defined(CONFIG_SERIAL_CORE_CONSOLE) || defined(SUPPORT_SYSRQ)
-	unsigned long		sysrq;			/* sysrq timeout */
-	unsigned int		sysrq_ch;		/* char for sysrq */
-#endif
-
 	/* flags must be updated while holding port mutex */
 	upf_t			flags;
 
@@ -244,6 +239,12 @@ struct uart_port {
 	resource_size_t		mapbase;		/* for ioremap */
 	resource_size_t		mapsize;
 	struct device		*dev;			/* parent device */
+
+#if defined(CONFIG_SERIAL_CORE_CONSOLE) || defined(SUPPORT_SYSRQ)
+	unsigned long		sysrq;			/* sysrq timeout */
+	unsigned int		sysrq_ch;		/* char for sysrq */
+#endif
+
 	unsigned char		hub6;			/* this should be in the 8250 driver */
 	unsigned char		suspended;
 	unsigned char		unused[2];
-- 
2.24.0

