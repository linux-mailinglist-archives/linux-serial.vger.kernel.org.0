Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB3CB393FCC
	for <lists+linux-serial@lfdr.de>; Fri, 28 May 2021 11:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbhE1JYc (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 28 May 2021 05:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbhE1JYb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 28 May 2021 05:24:31 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70618C061574
        for <linux-serial@vger.kernel.org>; Fri, 28 May 2021 02:22:56 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id k5so2188917pjj.1
        for <linux-serial@vger.kernel.org>; Fri, 28 May 2021 02:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MRhTbD9Q+W+KS5yVzyePik9ei2bFxXn1OtpOI9huKwI=;
        b=qGjOB/RJW0EH53uAs05vP5eWVLq00F/K8PHgGdAIC5kLbJJsTZzap5RilCnCeBXzP8
         6F43uv1oqacBoM9yyc/ctYa1QfGtC8+50O4EKbD4agJGAj8W0CwDESwJMt8TvYiDPIfj
         HoLAJ2YSwSafMzmNsBFr3cJKiWRa7lfsmM6oGQhEbNWp2YwN7BeFsuv101Ez3wKx9L24
         vTJSCI+BvsFQJZPVgRy8qERwbDZWK1pd1wH+NcDlLb/IZmPYbmJg044GRkh2nvaSQgDi
         xGU6IXgA4nx9wgdfCmvOVJkICud2kJlAp9m5sgqgJobN6UNRdwrpe4dYk2b3DgCruOdl
         5vow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MRhTbD9Q+W+KS5yVzyePik9ei2bFxXn1OtpOI9huKwI=;
        b=smiP3D8FO2qVQr6P0BKDKgEGVq1NQuZmhFJT232/KCogVcKnegxnepg/eM4tdCGB1S
         x7TPtLk9nwLvV7MR4s6fiBlCNE8z7X67Xhw7t02ODgd/9esEmY5yC/R7oaepM0aYSX5f
         iOuLMsw8OrlsjRsgZqGvLd6qTU0uEXVjITYJBcw6+I9gyFtSM/BYjKIn2Ss8zS7Lyy/H
         sYrJ6id3Tc9XB4wYLaldnZ0p+d4cfJRX21VYKesj6SJ9R+SJPvaNxDd/LocLZPRmqrAk
         XyeLHK2/TR/0EyRXZgnZGM1sD/qqPMy6hPKXNL6IzMZwC19gN8t25Ue7eC+WhiPyrvQ8
         Fl5w==
X-Gm-Message-State: AOAM532Km4wySDwQ0bymZCFhadDLNyHTS1CcKHRgKILQGEylaNSLpcWm
        knEDhn7eKOO/zGHI39pJRW8=
X-Google-Smtp-Source: ABdhPJyb9S5CCUYHTmrk38AAmSO7eg3e61uZN+B9A27ijzJK9f8GkUfDH5MDfKrYhkZLHuliy0fp6A==
X-Received: by 2002:a17:90a:7345:: with SMTP id j5mr3427953pjs.64.1622193775945;
        Fri, 28 May 2021 02:22:55 -0700 (PDT)
Received: from test-System-Product-Name.sunix.com.tw (61-220-142-250.HINET-IP.hinet.net. [61.220.142.250])
        by smtp.gmail.com with ESMTPSA id f17sm3887293pgm.37.2021.05.28.02.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:22:55 -0700 (PDT)
From:   Moriis Ku <saumah@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, jason_lee@sunix.com,
        taian.chen@sunix.com, Morris Ku <saumah@gmail.com>
Subject: [PATCH] Add supprt for SUNIX SDC serial port driver
Date:   Fri, 28 May 2021 17:22:40 +0800
Message-Id: <20210528092240.5896-1-saumah@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Morris Ku <saumah@gmail.com>

SUNIX SDC serial port driver.

Cc: Jason Lee <jason_lee@sunix.com>
Cc: Taian Chen <taian.chen@sunix.com>
Signed-off-by: Morris Ku <saumah@gmail.com>
---
 Kconfig  | 6 ++++++
 Makefile | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/tty/serial/8250/Kconfig b//drivers/tty/serial/8250/Kconfig
index d6d408c..3fcd4d3 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -479,6 +479,12 @@ config SERIAL_8250_PXA
 	  applicable to both devicetree and legacy boards, and early console is
 	  part of its support.
 
+config SERIAL_8250_SDC
+	tristate "SUNIX SDC serial port support"
+	depends on SERIAL_8250 && MFD_SUNIX_SDC
+	help
+	  Support for SUNIX SDC serial port
+
 config SERIAL_OF_PLATFORM
 	tristate "Devicetree based probing for 8250 ports"
 	depends on SERIAL_8250 && OF
diff --git a/Makefile b/Makefile
index 53d483d..df5cbb5 100644
--- a/Makefile
+++ b/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_SERIAL_8250_LPSS)		+= 8250_lpss.o
 obj-$(CONFIG_SERIAL_8250_MID)		+= 8250_mid.o
 obj-$(CONFIG_SERIAL_8250_PXA)		+= 8250_pxa.o
 obj-$(CONFIG_SERIAL_OF_PLATFORM)	+= 8250_of.o
+obj-$(CONFIG_SERIAL_8250_SDC)		+= 8250_sdc.o
 
 
 CFLAGS_8250_ingenic.o += -I$(srctree)/scripts/dtc/libfdt
-- 
2.20.1

