Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0759A5960
	for <lists+linux-serial@lfdr.de>; Mon,  2 Sep 2019 16:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731509AbfIBO2E (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 2 Sep 2019 10:28:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33304 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731482AbfIBO2E (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 2 Sep 2019 10:28:04 -0400
Received: by mail-wr1-f68.google.com with SMTP id u16so14267486wrr.0
        for <linux-serial@vger.kernel.org>; Mon, 02 Sep 2019 07:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id;
        bh=kBVMTQuhk+T7Ukw/iH6Fv/Si0UxRiFoyQ0dMHE7QvtM=;
        b=L9WqNTw+lDeQxnmb4IBnSlhQIEjQQEHc41KpOvIKTg6KVy2yoNjjF0Nnh3im22NzGk
         B1poC8Zm7MmUme/s/QoCtqp0DafVLacWOZEh5oskcW/M7zO5kFYB6UxIHq70UbftB7Cc
         TEph3W3dL/+LRVqc2I8bppCzfEKyrw508B/tK1tYfnj9x2njqYPQgcc+pBV9dYyKbmc8
         OHjH6PIRyCmCv0FlRzLxz9mzECWspMpHzmY+XPxFfpyULlu5qe/H+oh3WzaOE+4XATKq
         t2x36xBsjphwNv1CWin4JiOBDvPgqEE/uB89obbyhs3POIn212EVTMEbej0ZRBfw4STQ
         Pj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=kBVMTQuhk+T7Ukw/iH6Fv/Si0UxRiFoyQ0dMHE7QvtM=;
        b=VuSLCo2JbKwp85omhyCszZeZ4lwPyv6EQ27ebqSfBj/oSmmobUVv1lPnNxLhbjrv8l
         Q9ZGoq5upSWxVR6EEUuHtA1JBQ3lSZhlDlh/tWxLfCflRglWXgpgP15wV4Kire+bje2o
         AjaVaF2HpSJ2GAwe2NV+dwgaUKEJT3uFf/ZNC+4WIxc0rLKWRoVqes04ulUVcvCNqV6B
         iiY90mqIlfHY9CPl03nc3gvYhyj4PlGTtFbuPwawO1MZwHRQJ4jhtzc0DKOU+jnhgk9e
         WQ6+xgNf60dRbWdZBQ4TU0om5SbyB5B+QDc2Dv7q9Uun9BThsjX7EBk2w5AxoEW2AGmU
         uDzw==
X-Gm-Message-State: APjAAAV6JJ5z4+jd8kv1gUHP3sskva7x2Rpz7VSxXvCRnqftw/9ioNXu
        UhPXlGBWxwp3nArnjgcX48YMEg==
X-Google-Smtp-Source: APXvYqyO397vHhfCskHh8cwMyoUd3jnZFHXaYs4K0biXoMFfjgiE/4hfNFZBtUyw7CEUYPc6j/Am4g==
X-Received: by 2002:a5d:4d81:: with SMTP id b1mr38731050wru.27.1567434481989;
        Mon, 02 Sep 2019 07:28:01 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id f18sm16202373wrx.85.2019.09.02.07.28.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Sep 2019 07:28:01 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] serial: core: Use cons->index for preferred console registration
Date:   Mon,  2 Sep 2019 16:27:59 +0200
Message-Id: <4a877f1c7189a7c45b59a6ebfc3de607e8758949.1567434470.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The reason for this patch is xilinx_uartps driver which create one dynamic
instance per IP with unique major and minor combinations. drv->nr is in
this case all the time setup to 1. That means that uport->line is all the
time setup to 0 and drv->tty_driver->name_base is doing shift in name to
for example ttyPS3.

register_console() is looping over console_cmdline array and looking for
proper name/index combination which is in our case ttyPS/3.
That's why every instance of driver needs to be registered with proper
combination of name/number (ttyPS/3). Using uport->line is doing
registration with ttyPS/0 which is wrong that's why proper console index
should be used which is in cons->index field.

Also it is visible that recording console should be done based on
information about console not about the port but in most cases numbers are
the same and xilinx_uartps is only one exception now.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/tty/serial/serial_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 4223cb496764..5ec447a4c5c3 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2825,7 +2825,8 @@ int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
 		lockdep_set_class(&uport->lock, &port_lock_key);
 	}
 	if (uport->cons && uport->dev)
-		of_console_check(uport->dev->of_node, uport->cons->name, uport->line);
+		of_console_check(uport->dev->of_node, uport->cons->name,
+				 uport->cons->index);
 
 	uart_configure_port(drv, state, uport);
 
-- 
2.17.1

