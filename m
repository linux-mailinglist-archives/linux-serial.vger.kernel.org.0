Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEC78249124
	for <lists+linux-serial@lfdr.de>; Wed, 19 Aug 2020 00:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgHRWp2 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 18 Aug 2020 18:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbgHRWp2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 Aug 2020 18:45:28 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91A7C061389
        for <linux-serial@vger.kernel.org>; Tue, 18 Aug 2020 15:45:24 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id n129so19925979qkd.6
        for <linux-serial@vger.kernel.org>; Tue, 18 Aug 2020 15:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WnWs5M+4neEOa//6tNo473Dr58NPVdqL+IgjOZRAt7Q=;
        b=JbHOoutmMcyX0HjMwj51UuJNQyCVrkIREDvbVjHcgalWJEc6gVyHjURwJH4jS42DBf
         LulDyIInSxDFzUfEQ/zFcIkJ7fTwvDxe9CAkSEwG34CdLK/XOVFonLU2aze1SrLOCgx7
         aw78h2GFArqq1Ft+mbgzxfr5Zn6vBgATq5yY5kijNvHI+CZmozES7Gzr6Wo6Z5w3/t6L
         LPsandv3GkmtZhCscws3q8/6LdWZ+cdhzidmcVRrbQE3jlY6Kp5iRpQHJ3HPkauenuP0
         Jt5Imk3GAXoP+OTZtznSSQYgpqqQmkiyIaayRZaStQb6XOBxHwiL29WxDgunq5IGK0Lz
         U2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WnWs5M+4neEOa//6tNo473Dr58NPVdqL+IgjOZRAt7Q=;
        b=bgMJXGlwOSAxKjdZeFvk/eDx+pr03EreSh7cWvl1hpbhQ4yzWHGk0PvDaabeD+RhE4
         OWKlYrKPoxmIpaHYosFoiro3UT6v4wiJJRZM4GMepLOq6MCb/DkR1r9GECnSw1mtTENS
         hn58qIbfcNeUzrPSsE12JJpS+CrVBGfSUzaaLIJ0tjlOdGP43euXSM+lt2X9oCkcgrmv
         ZyhOr1TDVcs69+c2hH48/YM+mZb8GE1kOK5DsRPJHTw1O5AECEgmVpErYdVUVqqegHod
         v3Zlq3lQWNAz6sOdrHSNaeA529CH5ndLzqK2xSzvWASNMlhvd8DwH7AJDfa2q0Xm2svW
         3/hw==
X-Gm-Message-State: AOAM5329zSX3wBJhPkzssnNXuXG98UoVckHLF87HS8CNs/GddhRkBlRI
        K25lEvXK+fCtsIqAyfE0Avw=
X-Google-Smtp-Source: ABdhPJxa0aMMJ9WjpM6cZsVNuFBSjPPpwwEVM849hHJ4atS/Jfcll8GW/98fCBU93rsW7jBxx1UJDA==
X-Received: by 2002:a37:5d3:: with SMTP id 202mr19428073qkf.498.1597790722920;
        Tue, 18 Aug 2020 15:45:22 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:482:4fb::1000])
        by smtp.gmail.com with ESMTPSA id o21sm21791564qkk.94.2020.08.18.15.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 15:45:22 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] serial: fsl_lpuart: Fix typo in "transfer"
Date:   Tue, 18 Aug 2020 19:44:57 -0300
Message-Id: <20200818224457.16507-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Fix two occurrences where "transfer" is spelled incorrectly.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/tty/serial/fsl_lpuart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 90298c403042..77a1a0b64ddd 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1260,7 +1260,7 @@ static int lpuart_config_rs485(struct uart_port *port,
 		modem |= UARTMODEM_TXRTSE;
 
 		/*
-		 * RTS needs to be logic HIGH either during transer _or_ after
+		 * RTS needs to be logic HIGH either during transfer _or_ after
 		 * transfer, other variants are not supported by the hardware.
 		 */
 
@@ -1311,7 +1311,7 @@ static int lpuart32_config_rs485(struct uart_port *port,
 		modem |= UARTMODEM_TXRTSE;
 
 		/*
-		 * RTS needs to be logic HIGH either during transer _or_ after
+		 * RTS needs to be logic HIGH either during transfer _or_ after
 		 * transfer, other variants are not supported by the hardware.
 		 */
 
-- 
2.17.1

