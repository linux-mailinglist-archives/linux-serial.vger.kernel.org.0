Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCDAA36687D
	for <lists+linux-serial@lfdr.de>; Wed, 21 Apr 2021 11:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238732AbhDUJ4Q (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 21 Apr 2021 05:56:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:52426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238621AbhDUJ4K (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 21 Apr 2021 05:56:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D21FC61455;
        Wed, 21 Apr 2021 09:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618998936;
        bh=CKii/rpne4//E7v8yfodmMiYaYJL3AIV3vZJ95mp1Hg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BLw891L4tzuFVP0z+EKiE8m9R5X1YQYi0+CbJC83Um0feHv2Fc1VkQweZFE4WmijL
         KUwkZm9G6HkTTVlnBvnUlcsW+b6ueTaS1W5Il0ztXXzVSmP961/fX84/nt5uPfpSEw
         K+OIOHDuQPcl7p3o/nw/xsVE9OYZ9J5CvErRHo+fx5KZ+OHJsaqiUuZnkQgyynrbQq
         OPFDoto0GSicvoeo2ot2jFPK6TRSPn2X5hWNzxYgg4KVl5Xl7ydOqJWguQFyLBJrG7
         6PHaXaPJoE+g4Fewx8o7orCmPsRXfagkCDy1Ked32Yzlx0p/uo8YuW6yJoOjiwKi05
         GJ6ldV69/KW4A==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lZ9a8-0000p6-2w; Wed, 21 Apr 2021 11:55:40 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 16/26] serial: msm_serial: drop low-latency workaround
Date:   Wed, 21 Apr 2021 11:54:59 +0200
Message-Id: <20210421095509.3024-17-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210421095509.3024-1-johan@kernel.org>
References: <20210421095509.3024-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Commit f77232dab25b ("tty: serial: msm: drop uart_port->lock before
calling tty_flip_buffer_push()") claimed to address a locking
issue but only provided a dubious lockdep splat from an unrelated
driver, which in the end turned out to be due a broken local change
carried by the author.

Unfortunately these patches were merged before the issue had been
analysed properly so the commit messages makes no sense whatsoever.

The real issue was first seen on RT which at the time effectively always
set the low_latency flag for all serial drivers by patching
tty_flip_buffer_push(). This in turn revealed that many drivers did not
handle the infamous low_latency behaviour which meant that data was
pushed immediately to the line discipline instead of being deferred to a
work queue.

Since commit a9c3f68f3cd8 ("tty: Fix low_latency BUG"),
tty_flip_buffer_push() always schedules a work item to push data to the
line discipline and there's no need to keep any low_latency hacks
around.

Link: https://lore.kernel.org/linux-serial/cover.1376923198.git.viresh.kumar@linaro.org/
Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serial/msm_serial.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index 770c182e2208..fcef7a961430 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -757,9 +757,7 @@ static void msm_handle_rx_dm(struct uart_port *port, unsigned int misr)
 		count -= r_count;
 	}
 
-	spin_unlock(&port->lock);
 	tty_flip_buffer_push(tport);
-	spin_lock(&port->lock);
 
 	if (misr & (UART_IMR_RXSTALE))
 		msm_write(port, UART_CR_CMD_RESET_STALE_INT, UART_CR);
@@ -819,9 +817,7 @@ static void msm_handle_rx(struct uart_port *port)
 			tty_insert_flip_char(tport, c, flag);
 	}
 
-	spin_unlock(&port->lock);
 	tty_flip_buffer_push(tport);
-	spin_lock(&port->lock);
 }
 
 static void msm_handle_tx_pio(struct uart_port *port, unsigned int tx_count)
-- 
2.26.3

