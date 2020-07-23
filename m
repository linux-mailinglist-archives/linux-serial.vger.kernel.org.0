Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB6822AF6F
	for <lists+linux-serial@lfdr.de>; Thu, 23 Jul 2020 14:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgGWMdo (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 23 Jul 2020 08:33:44 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45542 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728618AbgGWMdm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 23 Jul 2020 08:33:42 -0400
Received: by mail-lj1-f194.google.com with SMTP id r19so6098685ljn.12;
        Thu, 23 Jul 2020 05:33:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bvFvMUgB8630ef2EirnBQztrZ72fZD4OOkgLMUGoJE8=;
        b=V3KLv8xn9CmKZz8gmsINSi1XhxBb+BiNIyRqjmVl7IyeAH+IY8k44t1qsxCwH2/+XH
         v/7q4ynoL8nwGs0mMkNDnhUx995g6X+DPWg3teuLuo8uyOB4Xx8DGEMPFht4JfppYy0F
         vTohmMfDZOq+8oS8/nqdj3nDudlj6InsOry091n5ne4BRRUhPuaQQBZwoJXjDqVsEAqI
         LXw9Oxt6ptyI8v1eydR1O7ZAwrsnvy67DXbE7caPLYM9iHGz4/kVCTx1o+fx/zogJSgE
         1HretlomONSf7lH3JmDau/pWXsYis4FPwaOCPm7c/RBH9Kle1UJyYhDW/NGu/8P7kw5U
         a1Tg==
X-Gm-Message-State: AOAM533JSrsf8zWktZakPowVX01nixJQPRQFQLbxShyZEyihAlmLpAC3
        DKGh1IrboNH7WW1Lj4zdqq9ZL7pu
X-Google-Smtp-Source: ABdhPJzTjBbqQ7Pyt4zsnbVF08/mGFXFA4DmFPZwXEuRF7DZ5yW/OQVW+C2E1c5yq3xjwLIfM4QKFg==
X-Received: by 2002:a2e:9f4c:: with SMTP id v12mr1821603ljk.327.1595507619899;
        Thu, 23 Jul 2020 05:33:39 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id k12sm2700069lfe.68.2020.07.23.05.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 05:33:38 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1jyaPk-0001X8-PS; Thu, 23 Jul 2020 14:33:32 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 2/2] serial: msm_serial: add sparse context annotation
Date:   Thu, 23 Jul 2020 14:33:27 +0200
Message-Id: <20200723123327.5843-3-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200723123327.5843-1-johan@kernel.org>
References: <20200723123327.5843-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add sparse context annotation to the receive handlers, which release and
reacquire the port lock, to silence sparse warnings:

	drivers/tty/serial/msm_serial.c:748:25: warning: context imbalance in 'msm_handle_rx_dm' - unexpected unlock
	drivers/tty/serial/msm_serial.c:814:28: warning: context imbalance in 'msm_handle_rx' - unexpected unlock

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serial/msm_serial.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index 60a9c53fa7cb..87f005e5d2af 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -696,6 +696,7 @@ static void msm_enable_ms(struct uart_port *port)
 }
 
 static void msm_handle_rx_dm(struct uart_port *port, unsigned int misr)
+	__must_hold(&port->lock)
 {
 	struct tty_port *tport = &port->state->port;
 	unsigned int sr;
@@ -771,6 +772,7 @@ static void msm_handle_rx_dm(struct uart_port *port, unsigned int misr)
 }
 
 static void msm_handle_rx(struct uart_port *port)
+	__must_hold(&port->lock)
 {
 	struct tty_port *tport = &port->state->port;
 	unsigned int sr;
-- 
2.26.2

