Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF8533D85
	for <lists+linux-serial@lfdr.de>; Tue,  4 Jun 2019 05:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfFDD1q (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 3 Jun 2019 23:27:46 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38283 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfFDD1q (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 3 Jun 2019 23:27:46 -0400
Received: by mail-qk1-f196.google.com with SMTP id a27so1929452qkk.5
        for <linux-serial@vger.kernel.org>; Mon, 03 Jun 2019 20:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6U915PPIFN4xUEVWHdBe6I76tigiipOOAD+gYhARIzw=;
        b=pUl4XMNka0kB1LgWy72WwjQjm2AcUlk1+sLKrOW59ZR+kyfrmi3RMyG4AcRtveP7vA
         Z6kR/u72F5GW0BLiU/CBXoNROR7rsJlwWO6ox1dmeC4/V9/mjOWFw4cOmbJrTvyoANtS
         NHmZcc9HJr2SadLwfGGHbsqb8LPb5Z4GrqlLo6COrFd6hj6c0EHDEeLLZ6MFrHRYoTEJ
         c2zWS6+//FLxjCD5a6KR+JB656rjc1pwRKXKFbP2V9BQcVtOTL36X2GlPKueuFuWzHgO
         LW+UMyPOkjyvI1vGFWpV9cL/1+EGHbqDlTV0vdray088T2lc39f1M50XL7mPgi9ufkfF
         THyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6U915PPIFN4xUEVWHdBe6I76tigiipOOAD+gYhARIzw=;
        b=j+jOQleEvjldykd/tgjwk35mrDs5wznyXUI54D3NvdejnCVac3Vf93SwINaxWShLZR
         95jS1+KiwVfcDx0sho6xbg0V7duVUV5If79/tRr1gzYl7xV9mL0wj0bSehI8dUKxYInQ
         3trIyDMZcPQkE93djNfOlAdLs03seVEqXCumKj/Etd71DOsL4Odu74SCY1VjnB/w1X/M
         QSFf7DF0cKv4JOmLZ2cd/7Dr7fovywUx40OpmrPsA2TPtPu1V1L8wF/pADycoltiwq16
         OLS3HcGFzKrjcSyYr21UC93dCrnrHVxERyF+kJjyM8LQcPtjn2B92xwamMIGgcXWXrNT
         2O3Q==
X-Gm-Message-State: APjAAAUcc/1/9k+ezLgim3rvgKntFc33cTynM4bjU/ioikCo32F0bH/y
        8fw1UyTPn/YsTsvJ4bPfXDkTO0/n
X-Google-Smtp-Source: APXvYqxNGHDlLwXhOAqk+oFJ7kY2Qt8LUnbzFwFYbJCWOhulj/1aJEVHMB5FXVelAghjZWR8OgIjfg==
X-Received: by 2002:a37:6086:: with SMTP id u128mr6181326qkb.270.1559618865132;
        Mon, 03 Jun 2019 20:27:45 -0700 (PDT)
Received: from fabio-Latitude-E5450.am.freescale.net ([2804:14c:482:3c8:56cb:1049:60d2:137b])
        by smtp.gmail.com with ESMTPSA id a16sm5213873qtj.9.2019.06.03.20.27.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 20:27:44 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     fugang.duan@nxp.com, linux-serial@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/2] serial: imx: Use dev_info() instead of dev_info()
Date:   Tue,  4 Jun 2019 00:27:27 -0300
Message-Id: <20190604032727.24688-2-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604032727.24688-1-festevam@gmail.com>
References: <20190604032727.24688-1-festevam@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

dev_info() is more appropriate for printing messages inside drivers, so
switch to dev_info().

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/tty/serial/imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 8b752e895053..d8eadab02446 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2015,7 +2015,7 @@ imx_uart_console_get_options(struct imx_port *sport, int *baud,
 		}
 
 		if (*baud != baud_raw)
-			pr_info("Console IMX rounded baud rate from %d to %d\n",
+			dev_info(sport->port.dev, "Console IMX rounded baud rate from %d to %d\n",
 				baud_raw, *baud);
 	}
 }
-- 
2.17.1

