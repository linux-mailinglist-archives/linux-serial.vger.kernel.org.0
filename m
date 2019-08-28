Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1BB8A0C5A
	for <lists+linux-serial@lfdr.de>; Wed, 28 Aug 2019 23:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfH1V2C (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 28 Aug 2019 17:28:02 -0400
Received: from office2.cesnet.cz ([195.113.144.244]:40748 "EHLO
        office2.cesnet.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbfH1V2B (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 28 Aug 2019 17:28:01 -0400
X-Greylist: delayed 369 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Aug 2019 17:28:01 EDT
Received: from localhost (unknown [IPv6:2001:718:1:2c:a5b5:770:4491:af45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by office2.cesnet.cz (Postfix) with ESMTPSA id D93D340008C;
        Wed, 28 Aug 2019 23:21:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
        s=office2; t=1567027311;
        bh=uufdWz0aHKoN9omgaxI1skmGY5MdO4HBcERPlWSU5CQ=;
        h=Resent-Date:Resent-From:Resent-To:Resent-Cc:From:Date:Subject:To:
         Cc;
        b=e8S6T6WVb6Yq0PQ6Vv4YSSTMSDaqaOaINlwL4w46QZUP2VMIZbgFek5CwXWs7xJEH
         Cz2H4E4Kne/aXhCn78ScSx4l/PIcMqBaIHoRyrTavrFSkoVR0cAag5kGegkfaU6BVe
         D2xmtRpOehghtiwEyPkO7GjssAQ6Da5oPSlU/8OU=
Message-Id: <13ea227620aaad8a7231d42ed03a8508297d4eb3.1567027079.git.jan.kundrat@cesnet.cz>
From:   =?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>
Date:   Wed, 28 Aug 2019 19:56:26 +0200
Subject: [PATCH 1/2] tty: max310x: fix off-by-one buffer access when storing
 overrun
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     linux-serial@vger.kernel.org
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Joe Burmeister <joe.burmeister@devtank.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

A recent change split the insertion loop into two parts. The first part
accessed bytes 0, 1, ... (rxlen - 2), and the second part by mistake
took offset `rxlen` instead of the correct `rxlen - 1`. So one byte was
not stored, and the final access wrote past the end of the rx_buf.

Fixes: 9c12d739d69b (tty: max310x: Split uart characters insertion loop)
Signed-off-by: Jan Kundrát <jan.kundrat@cesnet.cz>
---
 drivers/tty/serial/max310x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index e6c48a99bd85..0e0c2740ec7e 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -689,7 +689,7 @@ static void max310x_handle_rx(struct uart_port *port, unsigned int rxlen)
 		 * tail.
 		 */
 		uart_insert_char(port, sts, MAX310X_LSR_RXOVR_BIT,
-				 one->rx_buf[rxlen], flag);
+				 one->rx_buf[rxlen-1], flag);
 
 	} else {
 		if (unlikely(rxlen >= port->fifosize)) {
-- 
2.21.0


