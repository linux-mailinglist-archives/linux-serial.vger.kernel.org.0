Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A6644FD2B
	for <lists+linux-serial@lfdr.de>; Mon, 15 Nov 2021 03:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhKOCgs (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sun, 14 Nov 2021 21:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhKOCgb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 14 Nov 2021 21:36:31 -0500
X-Greylist: delayed 904 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 14 Nov 2021 18:33:21 PST
Received: from mailg110.ethz.ch (mailg110.ethz.ch [IPv6:2001:67c:10ec:5605::21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9E1C061746
        for <linux-serial@vger.kernel.org>; Sun, 14 Nov 2021 18:33:17 -0800 (PST)
Received: from mailm113.d.ethz.ch (2001:67c:10ec:5602::25) by mailg110.ethz.ch
 (2001:67c:10ec:5605::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 15 Nov
 2021 03:18:06 +0100
Received: from dtkw (213.55.225.240) by mailm113.d.ethz.ch
 (2001:67c:10ec:5602::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 15 Nov
 2021 03:18:09 +0100
Date:   Mon, 15 Nov 2021 03:18:08 +0100
From:   Ilia Sergachev <silia@ethz.ch>
To:     <linux-serial@vger.kernel.org>
CC:     Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Ilia Sergachev <silia@ethz.ch>
Subject: [PATCH] serial: liteuart: fix missing drvdata
Message-ID: <20211115031808.7ab632ef@dtkw>
Organization: ETH Zurich
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [213.55.225.240]
X-ClientProxiedBy: mailm110.d.ethz.ch (2001:67c:10ec:5602::22) To
 mailm113.d.ethz.ch (2001:67c:10ec:5602::25)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

drvdata has to be set in _probe() - otherwise platform_get_drvdata()
causes null pointer dereference BUG in _remove()

Signed-off-by: Ilia Sergachev <silia@ethz.ch>
---
 drivers/tty/serial/liteuart.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index dbc0559a9157..f075f4ff5fcf 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -285,6 +285,8 @@ static int liteuart_probe(struct platform_device *pdev)
 	port->line = dev_id;
 	spin_lock_init(&port->lock);
 
+	platform_set_drvdata(pdev, port);
+
 	return uart_add_one_port(&liteuart_driver, &uart->port);
 }
 
-- 
2.25.1
