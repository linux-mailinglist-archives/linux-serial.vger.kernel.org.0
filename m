Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20D8133D84
	for <lists+linux-serial@lfdr.de>; Tue,  4 Jun 2019 05:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbfFDD1n (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 3 Jun 2019 23:27:43 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43057 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfFDD1n (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 3 Jun 2019 23:27:43 -0400
Received: by mail-qk1-f195.google.com with SMTP id m14so1914626qka.10
        for <linux-serial@vger.kernel.org>; Mon, 03 Jun 2019 20:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yBWyicZE1NcqvS/4F8eB32+kjIBGm128H4hPZZ0ocmM=;
        b=cHkYiWEw6TF3CMbMKjHOfWCZNbX0Tiklmgvs/3d/lRsNM1FcMN5hw5kyhE8iturcTU
         haDrNcq7BUdckmBu0JaYMSUHFJR/JmftWYrcfUB0i263U+r4YL7OubRrWaoSys4ZuiSw
         TZkno5OYunOqUDCblas9uybxPe7KKF36yhqXtqeyUvH8OLJ2Z3s3NyypfpZmx+cD7vuM
         4Zh9Cie4NRRLRwSifCBG81+3KiBnqz5peMW8xVYjibYD8zecOQ10G4UcfOeipkgZ3oaY
         z/YuOOBlqY5gul49j8eDO7HqZeqyikfcwKy06sD3aASnwTL/g2R83AZ0cSJnkGrzwpOi
         XXoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yBWyicZE1NcqvS/4F8eB32+kjIBGm128H4hPZZ0ocmM=;
        b=RHMB6ko3BkdLRVGpouUNkOquBb7Z6IAGwtDMZvdYFCmvg/DKj4TN9PkT8xi4LknTVs
         1Tcmn1ffvGxGDMaUaGvxdTW+tVYLH07r1fQLr4iltwQQ8ZLSl2W9mYP2CnKEMrAQ9fIX
         yONtjf5U9jECXvvRYj1xaXf4uPfPVkVrxSTJpiPchw+IgLtIzbYBjQTP9HTYyjK9Kwwi
         5P3c5wDnRWxic5QmzmYkCQPQGVhxk+jc5uNG4XM1G0deMnumOnQZy/NcEpoRSBhIdWQv
         d4D0oi8OCcxPJGQ5zI+RsoSkigurDKO6t1lJK5VQoabMaF1yyxc6J/KLmC18N4OnzOFf
         uV9g==
X-Gm-Message-State: APjAAAVq3iL3bzocP2KCWNhVoTrqPnrOPNb4jjvC9KA5hFZIc+SKBzYh
        n8M5Lam1HOrxrzmzg2GeAKw=
X-Google-Smtp-Source: APXvYqwflnXaVhrlj3Kmjb6HBnlUrmJ/CwdVB74HxHXDqtRSQ4TZj7Yycbgj8SP9Hqn2WQJZB6N3Jw==
X-Received: by 2002:a37:e506:: with SMTP id e6mr24619714qkg.229.1559618862205;
        Mon, 03 Jun 2019 20:27:42 -0700 (PDT)
Received: from fabio-Latitude-E5450.am.freescale.net ([2804:14c:482:3c8:56cb:1049:60d2:137b])
        by smtp.gmail.com with ESMTPSA id a16sm5213873qtj.9.2019.06.03.20.27.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 20:27:41 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     fugang.duan@nxp.com, linux-serial@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/2] serial: fsl_lpuart: Use dev_info() instead of printk()
Date:   Tue,  4 Jun 2019 00:27:26 -0300
Message-Id: <20190604032727.24688-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

dev_info() is more appropriate for printing messages inside drivers, so
switch to dev_info().

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/tty/serial/fsl_lpuart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index ea1c85e3b432..08b52cca650c 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2078,7 +2078,7 @@ lpuart_console_get_options(struct lpuart_port *sport, int *baud,
 	baud_raw = uartclk / (16 * (sbr + brfa / 32));
 
 	if (*baud != baud_raw)
-		printk(KERN_INFO "Serial: Console lpuart rounded baud rate"
+		dev_info(sport->port.dev, "Serial: Console lpuart rounded baud rate"
 				"from %d to %d\n", baud_raw, *baud);
 }
 
@@ -2121,7 +2121,7 @@ lpuart32_console_get_options(struct lpuart_port *sport, int *baud,
 	baud_raw = uartclk / (16 * sbr);
 
 	if (*baud != baud_raw)
-		printk(KERN_INFO "Serial: Console lpuart rounded baud rate"
+		dev_info(sport->port.dev, "Serial: Console lpuart rounded baud rate"
 				"from %d to %d\n", baud_raw, *baud);
 }
 
-- 
2.17.1

