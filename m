Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC8F16857C
	for <lists+linux-serial@lfdr.de>; Fri, 21 Feb 2020 18:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbgBURsQ (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 21 Feb 2020 12:48:16 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:33945 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbgBURsP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 21 Feb 2020 12:48:15 -0500
Received: from mwalle01.sab.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id DE8CE23E26;
        Fri, 21 Feb 2020 18:48:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1582307293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s6EOAobt5saGFt58QDGrFmkjtzz3qIh/p10CWvZHnSU=;
        b=UNx4zy9CvmqEXj8lMfakIi9EiS67awLFipGLq73dNeAQaVqC7CBAhGe93kRrl5zY4iBq7c
        Gui/UiEobRzk8FqsHbTHqv42dxAh0B8PxauLCB8T4sBE9P+9FXMxKSD9H3kNQcAlV/UTbQ
        wIxkQa/9AcV4EBEomT9ozZkUJDW0pZ0=
From:   Michael Walle <michael@walle.cc>
To:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Jiri Slaby <jslaby@suse.com>, Peng Fan <peng.fan@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 1/9] Revert "tty: serial: fsl_lpuart: drop EARLYCON_DECLARE"
Date:   Fri, 21 Feb 2020 18:47:46 +0100
Message-Id: <20200221174754.5295-2-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200221174754.5295-1-michael@walle.cc>
References: <20200221174754.5295-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
X-Spam-Level: ******
X-Rspamd-Server: web
X-Spam-Status: Yes, score=6.40
X-Spam-Score: 6.40
X-Rspamd-Queue-Id: DE8CE23E26
X-Spamd-Result: default: False [6.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         NEURAL_SPAM(0.00)[0.758];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[13];
         MID_CONTAINS_FROM(1.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:12941, ipnet:213.135.0.0/19, country:DE];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam: Yes
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This reverts commit a659652f6169240a5818cb244b280c5a362ef5a4.

This broke the earlycon on LS1021A processors because the order of the
earlycon_setup() functions were changed. Before the commit the normal
lpuart32_early_console_setup() was called. After the commit the
lpuart32_imx_early_console_setup() is called instead.

Fixes: a659652f6169 ("tty: serial: fsl_lpuart: drop EARLYCON_DECLARE")
Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/tty/serial/fsl_lpuart.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 91e2805e6441..27fdc131c352 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2390,6 +2390,8 @@ static int __init lpuart32_imx_early_console_setup(struct earlycon_device *devic
 OF_EARLYCON_DECLARE(lpuart, "fsl,vf610-lpuart", lpuart_early_console_setup);
 OF_EARLYCON_DECLARE(lpuart32, "fsl,ls1021a-lpuart", lpuart32_early_console_setup);
 OF_EARLYCON_DECLARE(lpuart32, "fsl,imx7ulp-lpuart", lpuart32_imx_early_console_setup);
+EARLYCON_DECLARE(lpuart, lpuart_early_console_setup);
+EARLYCON_DECLARE(lpuart32, lpuart32_early_console_setup);
 
 #define LPUART_CONSOLE	(&lpuart_console)
 #define LPUART32_CONSOLE	(&lpuart32_console)
-- 
2.20.1

