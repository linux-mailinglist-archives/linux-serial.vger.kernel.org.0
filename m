Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D72F833D8C
	for <lists+linux-serial@lfdr.de>; Tue,  4 Jun 2019 05:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfFDDbx (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 3 Jun 2019 23:31:53 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36999 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfFDDbx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 3 Jun 2019 23:31:53 -0400
Received: by mail-qt1-f194.google.com with SMTP id y57so12153858qtk.4
        for <linux-serial@vger.kernel.org>; Mon, 03 Jun 2019 20:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QkMM4hUAHrHIHhKXRuwzA8YMI34OKTvKAwlVaFjteUU=;
        b=pHD9GlJD9X9ysqkmdcDDyMVtvpqtBi+4IRuPTC7IsfSKPCIVDdG30g87J8/g3I2G6U
         LEVrzFXhniFgK7nLyJz2r8+XP++F1vsQAzqCtOpNWOu2u0vuoxkzvlU9tbxGkQAQ+pD5
         ymqeM5Ht2K7vw3FuutdWu1Vk0k8JyHsDQRLKSYrHO5DKpsOJUI99qM7p8X3PD8/ixOUd
         2A5+VkPbZVmNHr03s8wQBRroxrX+ZQbQbCrDkvJuF8Rb5t3k0xMbFHabh8j885CI7zY4
         1RNKm3suqhzR7bYfx7r2l1022Hx6NYLZfEXWgRlNOq54/DIDeTWxjULk3YVFrOQVi8ju
         Li8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QkMM4hUAHrHIHhKXRuwzA8YMI34OKTvKAwlVaFjteUU=;
        b=OUIjZfatvaJw1qehfiAMr4zcTmYFMBZX/ptwlEhfRKJjWdk7qBkj0bxF5QgPoYj1RO
         zmLWT/ipRDrFneEneV78I+GJGxXJyX0xofaTyBxSCL2tJMdTX/pZnS1DglcNJCOYYr+G
         fCELJ2l+gJwwx8og1T87/bwgQWMFPAhO3PljnTqX6V87J45JGkEZ6ACjMnVfhR7Vzmvx
         UYQn6JbEmNIFIFIwG0E0dEcvGbPaInOX+0HdSR5hRexFP+QWzYfXPB5Hkv5iWuKeQT5X
         5xlSlMz8oiL3LY384kXvwH11UhWvWIcfvQeKlpd3GvxJbhmCsvKHr6KnNH9AVcdJnxYi
         m25A==
X-Gm-Message-State: APjAAAWS/Xn8EJh7D0VUefRZJr6oFf2p3noAsgbQiWrmheRZ6UW8qM7E
        oay5qLPCxiMLJmCczjUs9EE=
X-Google-Smtp-Source: APXvYqyuRwUcWQPHBzLUwLv8WBfPCDfK9EjN5kNUgD+kX9C9mQpriXBFefKRDYg/vtrNR6R3PxmOKQ==
X-Received: by 2002:ac8:444c:: with SMTP id m12mr26896534qtn.306.1559619112108;
        Mon, 03 Jun 2019 20:31:52 -0700 (PDT)
Received: from fabio-Latitude-E5450.am.freescale.net ([2804:14c:482:3c8:56cb:1049:60d2:137b])
        by smtp.gmail.com with ESMTPSA id v41sm5189310qta.78.2019.06.03.20.31.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 20:31:51 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     fugang.duan@nxp.com, linux-serial@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2 2/2] serial: imx: Use dev_info() instead of pr_info()
Date:   Tue,  4 Jun 2019 00:31:39 -0300
Message-Id: <20190604033139.25546-2-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604033139.25546-1-festevam@gmail.com>
References: <20190604033139.25546-1-festevam@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

dev_info() is more appropriate for printing messages inside drivers, so
switch to dev_info().

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v1:
- Fix typo in Subject

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

