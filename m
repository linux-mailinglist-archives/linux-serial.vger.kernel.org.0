Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE46423C4
	for <lists+linux-serial@lfdr.de>; Wed, 12 Jun 2019 13:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438336AbfFLLPK (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 12 Jun 2019 07:15:10 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56007 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438324AbfFLLPA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 12 Jun 2019 07:15:00 -0400
Received: by mail-wm1-f66.google.com with SMTP id a15so6118181wmj.5
        for <linux-serial@vger.kernel.org>; Wed, 12 Jun 2019 04:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=N7TfMirow0WLkJ8Qk5sTGDNuiXjkVvo5PhKfS+WN4/0=;
        b=TvHkcos3aVvBmtDnRVLiF8pREYuprtIOehZYrLYdAyjZP7EdbPz6anRT6UL2bn+1lt
         iRSNcVbOmYQ+kkQ3JbVs1+N1QXgzSkLX7YOg4L2t2XY70f8q+rjIVRsJ4twJwhJN5UVZ
         5vJXv8Lim0Z9xob8xQk0ZvGfB+Z70kXkXVtj9Vo9sPNZX6nj6jRDgEYn1CZRGWviaBdS
         8d2kZlRPWm/+iACF30dR/3uZm/5FVD9NxZ0mvNShAZQiO33Rxhr5EDslpWhYAWS2n20q
         sZ86aP63QHnIW66uQRUQxsSNaaLrpUhja+T3uqyEQLfK6EbRGrP9SJ6Yvc6TpIiuxChN
         7asQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=N7TfMirow0WLkJ8Qk5sTGDNuiXjkVvo5PhKfS+WN4/0=;
        b=a9n0T6c//80VTBxV8fyPoSfkTt4pqVLEL2N+fpcZ1GESvlJKyYphtNqh8n8KEUfWY8
         fV5iD0LfWGsNze1re1RISoaR1RROsJeI/yAOsS0vn4L0nIPB9w0ep93VrwPnt9Wx5Kly
         qxRcLaSE8vNhD3jElPDbAW6quD9iXdvF4u7SKjRL1va79yjZtvcyDQRFSUzZcu+mCH20
         VpvPuafJvriEgRJxlB6fvQYox3mjqAmw/nxAPGqD9BlQfjUIXcTPpyjIGcmYPcU1oKx0
         uOr6bYvnFqDmD3ksEr5V/43A01aNBbqmVrVRUvtKuWB0UkC39bfkIri651Mxrgqr7IH5
         MGAA==
X-Gm-Message-State: APjAAAX4bqX8Q/Zwt5cFLfjwbiQSyReFhn5xxiCkdsygK5bCyvcNZZCQ
        dNjboywYBxFX5BWhUcKa16HX/stlCsaX8A==
X-Google-Smtp-Source: APXvYqxDqteBduXIGovJOsGxQCU7BEXqUQmBQgzI25tvhIXaofsgXxbwQoEvBU7rTYV1bD0qZFpatw==
X-Received: by 2002:a1c:1b81:: with SMTP id b123mr21041986wmb.144.1560338098580;
        Wed, 12 Jun 2019 04:14:58 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id g19sm6514083wmg.10.2019.06.12.04.14.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2019 04:14:58 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com
Cc:     Nava kishore Manne <nava.manne@xilinx.com>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 6/6] serial: uartps: Remove useless return from cdns_uart_poll_put_char
Date:   Wed, 12 Jun 2019 13:14:43 +0200
Message-Id: <19a9f67770e1896dde57d94b093273b503610eef.1560338079.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1560338079.git.michal.simek@xilinx.com>
References: <cover.1560338079.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1560338079.git.michal.simek@xilinx.com>
References: <cover.1560338079.git.michal.simek@xilinx.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Nava kishore Manne <nava.manne@xilinx.com>

There is no reason to call return at the end of function which should
return void.

The patch is also remove one checkpatch warning:
WARNING: void function return statements are not generally useful
+	return;
+}

Fixes: 6ee04c6c5488 ("tty: xuartps: Add polled mode support for xuartps")
Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2:
- Split patch from v1
- Add Fixes tag

 drivers/tty/serial/xilinx_uartps.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index d4c1ae2ffca6..bcef254fa03c 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1074,8 +1074,6 @@ static void cdns_uart_poll_put_char(struct uart_port *port, unsigned char c)
 		cpu_relax();
 
 	spin_unlock_irqrestore(&port->lock, flags);
-
-	return;
 }
 #endif
 
-- 
2.17.1

