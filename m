Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB6EBD8E0E
	for <lists+linux-serial@lfdr.de>; Wed, 16 Oct 2019 12:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390476AbfJPKgt (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 16 Oct 2019 06:36:49 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35479 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388721AbfJPKgt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 16 Oct 2019 06:36:49 -0400
Received: by mail-wm1-f68.google.com with SMTP id y21so2200038wmi.0
        for <linux-serial@vger.kernel.org>; Wed, 16 Oct 2019 03:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id;
        bh=iyFzGkhYytDlDfd2Ka2FlJ4+IeaOKCE6rH++eUfX0Lo=;
        b=Iya8EfM6d7C/AVaYBC3OCDCDQ/tGr54I6EqSt1joq6mOWf3hksc3KJFf8mlacKFnd2
         lAgaVu8/vgo8sdADE8uwhmEo5064DB41/qwuotq8ZWLa1UPSzYBfG5e/jt6ZYbdbtfWN
         GzyM6tAKxWO7Y5xljlDcvaPRPtws/GGFfAXw2d02RUNOUn47uYSERigIJclYtldU61sD
         Kk0T+qrw/wz0Yjqe0EuNdW6ietoOsiofnwtDo8yFESTXbAKvdkdnVdU7359K/pqucA2e
         9WGOxp6f7HULQdWtaQjOJnHtR3U9QMiZ7UOOtfGk8vW9u58LnucnRqAmBsXikOQdmegG
         nOBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=iyFzGkhYytDlDfd2Ka2FlJ4+IeaOKCE6rH++eUfX0Lo=;
        b=qiwjiRR6ADZZZ+59AZYvket0G6zhTQT7fLUaKv5R88gE2iwlNRWTCoCgOVzOrjrERd
         aQjh/Fg3jDCAidswIm2RUVzs41W8WsFdPNfEHatfjj1EZmk9qFzTTNGdtqgupuSv+4pU
         75KoeV/8C75v3DdUO3MnG8xsXk0dvatiskjQcsJJ1GgZGkROPlkWti/wmZSEfdZlqNjs
         Aw+63btgc9rd229brOalMnqREoNlj8IM4cjm1+woWeSersbKmsfQcLSHsKKPvX0iv9B2
         KDhDTRpAV9zhAfz7yJoTyVqzP+nSsSnvwyjaG6QXWSK3toQDIWjAyxGJL2Wsz7RJq4Wr
         sGmg==
X-Gm-Message-State: APjAAAUse9AwifAFIdMJBTw8bCpx5+J4JAJqaaUPsAokJUxEdXEPjNRc
        wJOP09IOKrdNAVR68p3tlKPBqg==
X-Google-Smtp-Source: APXvYqzDLzB57RRdm1lisHXRSXtsJCXvfmzBNdYJeLXQ+ghhQqj9bPhoq83og3AjHSEt0T46t74pvw==
X-Received: by 2002:a05:600c:2207:: with SMTP id z7mr2880321wml.149.1571222206649;
        Wed, 16 Oct 2019 03:36:46 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id u68sm2627738wmu.12.2019.10.16.03.36.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Oct 2019 03:36:45 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
Subject: [PATCH] Revert "serial: core: Use cons->index for preferred console registration"
Date:   Wed, 16 Oct 2019 12:36:41 +0200
Message-Id: <59f51af6bb03fce823663764d17ad0291aa01ab2.1571222199.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This reverts commit 91daae03188e0dd1da3c1b599df4ce7539d5a69f.

The origin patch is causing an issue on r8a7791/koelsch and
r8a7795/salvator-xs platforms where cons->index is not initialized to
expected value.
It is safer to revert this patch for now till it is clear why this is
happening.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/tty/serial/serial_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index b64ae2ca8bf2..c4a414a46c7f 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2832,8 +2832,7 @@ int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
 		lockdep_set_class(&uport->lock, &port_lock_key);
 	}
 	if (uport->cons && uport->dev)
-		of_console_check(uport->dev->of_node, uport->cons->name,
-				 uport->cons->index);
+		of_console_check(uport->dev->of_node, uport->cons->name, uport->line);
 
 	uart_configure_port(drv, state, uport);
 
-- 
2.17.1

