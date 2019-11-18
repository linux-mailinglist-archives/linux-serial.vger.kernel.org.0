Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F40881003F7
	for <lists+linux-serial@lfdr.de>; Mon, 18 Nov 2019 12:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbfKRLZb (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 18 Nov 2019 06:25:31 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51866 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbfKRLYO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 Nov 2019 06:24:14 -0500
Received: by mail-wm1-f67.google.com with SMTP id q70so16935397wme.1
        for <linux-serial@vger.kernel.org>; Mon, 18 Nov 2019 03:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zPi0SchlJBpcK2Uafamd7sY3psIZzF+ErFogb8EsMtA=;
        b=ZiZ90qqpfO5qG7SMgAh9/PB8QFX94uZpsWOqL6XjsbR9k5YCqcy9OSx87H09ThU+0w
         vys3j3NPV7goOMpCenbAPyOKNvRwKCMnbmiGxqi+1n2EGup9wl2ulfLkuB0N+ksQaWh5
         tpchHcQSPNzqhcfPrkJ1VxR3gsSN+rvrINqOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zPi0SchlJBpcK2Uafamd7sY3psIZzF+ErFogb8EsMtA=;
        b=cPrVNRBufWImyBjmYdlOHijdnzX/cz8jjj6kZgkflMUEKQJwj2ml0A9NGpBvvVxe/b
         FpYcrAUqKo7Bvk9bfbm8lZNF/VWnuRHj8aKx9M9Jqj0kT28hANS+4vP+UF3EYRLGu3i4
         7NrVUMVjXBlBx2FXyY03jgdt2o6IfBJ18Xldgs2K1d/TahP9booSW5ETJIV/f12ckqB8
         lhbFUthWYFzsxmOPCPwJbJoJQuHCSYhfBs3sSlFfFFTurvCUm8CTQjA/RQTjjn+h11D/
         kHKFVyX0qAJKkhSytWQat+tDkjkR9dJC721cElhKlRfRTGl2THa6cZeLW+HUA0LDXtX+
         OpLw==
X-Gm-Message-State: APjAAAUIJqqnczEYQ0th0TqhjOyIPUBPNA2OzWVMZPTH+HTATyFMkYEW
        4uxjffDV/kmfmFxuZEZVwC80gA==
X-Google-Smtp-Source: APXvYqyMlre0ptC746RrIs0o3/q5vSgHaOfHInZsRln9L66Xi9zEqoUBbz9OzBot4n1Ofcy+OJlHFw==
X-Received: by 2002:a1c:b607:: with SMTP id g7mr29865871wmf.94.1574076252099;
        Mon, 18 Nov 2019 03:24:12 -0800 (PST)
Received: from prevas-ravi.prevas.se (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id y2sm21140815wmy.2.2019.11.18.03.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 03:24:11 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-serial@vger.kernel.org
Subject: [PATCH v5 31/48] serial: ucc_uart: stub out soft_uart_init for !CONFIG_PPC32
Date:   Mon, 18 Nov 2019 12:23:07 +0100
Message-Id: <20191118112324.22725-32-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
References: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The Soft UART hack is only needed for some PPC-based SOCs. To allow
building this driver for non-PPC, guard soft_uart_init() and its
helpers by CONFIG_PPC32, and use a no-op soft_uart_init() otherwise.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/tty/serial/ucc_uart.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index f286e91714cb..313697842e24 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -33,7 +33,10 @@
 
 #include <linux/firmware.h>
 #include <soc/fsl/cpm.h>
-#include <asm/reg.h>
+
+#ifdef CONFIG_PPC32
+#include <asm/reg.h> /* mfspr, SPRN_SVR */
+#endif
 
 /*
  * The GUMR flag for Soft UART.  This would normally be defined in qe.h,
@@ -1096,6 +1099,8 @@ static const struct uart_ops qe_uart_pops = {
 	.verify_port    = qe_uart_verify_port,
 };
 
+
+#ifdef CONFIG_PPC32
 /*
  * Obtain the SOC model number and revision level
  *
@@ -1238,6 +1243,16 @@ static int soft_uart_init(struct platform_device *ofdev)
 	return 0;
 }
 
+#else /* !CONFIG_PPC32 */
+
+static int soft_uart_init(struct platform_device *ofdev)
+{
+	return 0;
+}
+
+#endif
+
+
 static int ucc_uart_probe(struct platform_device *ofdev)
 {
 	struct device_node *np = ofdev->dev.of_node;
-- 
2.23.0

