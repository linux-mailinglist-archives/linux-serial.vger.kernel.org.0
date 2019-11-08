Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F356F4C87
	for <lists+linux-serial@lfdr.de>; Fri,  8 Nov 2019 14:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729775AbfKHNDq (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 8 Nov 2019 08:03:46 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:32906 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbfKHNCF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 8 Nov 2019 08:02:05 -0500
Received: by mail-lj1-f194.google.com with SMTP id t5so6157177ljk.0
        for <linux-serial@vger.kernel.org>; Fri, 08 Nov 2019 05:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=skc4BB3FfJVhrMQufim0pPb5lTLStBal+/ZiI3PgHrk=;
        b=XkJAhXffjW6sLGidyoW6envOidVvdJ8BQkPq8vG0pGpA/4S0zQDW1cQiCFn6AbkNVu
         lKSJ/fyLaTVT9YpDlOYtgCF6M0vAak9InlnDdRLV8faRxFEFc/5zQeELf0teqgHziaP1
         mc28TbmJQsB2/p7ad853POos5LlDUzylHoJ/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=skc4BB3FfJVhrMQufim0pPb5lTLStBal+/ZiI3PgHrk=;
        b=s58yqI2eUqPiFPr8nkZrGxReWV1EMWtJ2HoGUqxe+oB3lr9E2x5Ke5IVYHG+sSZu5U
         TZNBiv27Mg/DFDVO3FwcFeVURoR8n1P9rtVO35ffKwmnUlKP3zKWpaZSj0Er4sCa0+/R
         MnovSS0SpzEMRSrZSxGHli3YsFWcJeRrY0RxioUvwP1/YBiMMbSyAPa9isplnDdVPnRF
         tLVIdfHtePcyO5zcwlXGARWz5YOKJrsiYHWWmPhjaIBEgkEILps3j0SBOGUvFOok1fEI
         Iqmwl+HHe1oLIFR6+clgH9XVgYR92vj7n4+jCyWw6umE77DwZoZVC0l13WKWGQjU+twZ
         fKkQ==
X-Gm-Message-State: APjAAAWKMAL91oZRlYXNFXTQhiNkUp0nq/QztVefQSbgQVtGc2summRo
        /EmgrVOCvrx7AYqxI98omYDzzg==
X-Google-Smtp-Source: APXvYqxbFlgCtl6tta2OpdTxU9LRwd/l2khasl25WtDrijVbgbWeE5FWCtL/GrDLKg+orNEgarZjCg==
X-Received: by 2002:a2e:558:: with SMTP id 85mr6765994ljf.67.1573218123603;
        Fri, 08 Nov 2019 05:02:03 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id d28sm2454725lfn.33.2019.11.08.05.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 05:02:03 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-serial@vger.kernel.org
Subject: [PATCH v4 28/47] serial: ucc_uart: explicitly include soc/fsl/cpm.h
Date:   Fri,  8 Nov 2019 14:01:04 +0100
Message-Id: <20191108130123.6839-29-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This driver uses #defines from soc/fsl/cpm.h, so instead of relying on
some other header pulling that in, do that explicitly. This is
preparation for allowing this driver to build on ARM.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/tty/serial/ucc_uart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index a0555ae2b1ef..7e802616cba8 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -32,6 +32,7 @@
 #include <soc/fsl/qe/ucc_slow.h>
 
 #include <linux/firmware.h>
+#include <soc/fsl/cpm.h>
 #include <asm/reg.h>
 
 /*
-- 
2.23.0

