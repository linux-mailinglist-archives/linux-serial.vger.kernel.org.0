Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7408A11DAE0
	for <lists+linux-serial@lfdr.de>; Fri, 13 Dec 2019 01:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731546AbfLMAKp (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 12 Dec 2019 19:10:45 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:43548 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731356AbfLMAIw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Dec 2019 19:08:52 -0500
Received: by mail-pj1-f67.google.com with SMTP id g4so335719pjs.10
        for <linux-serial@vger.kernel.org>; Thu, 12 Dec 2019 16:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x9C/3UrPTi7iWbqFHcoS3+5nMQuy/bFwKoTaGYkl7Pc=;
        b=fj8c5kjR5cQi7kvYtuHXNEflr3zJJhBuVt+yDwYGADRWyd4nLQd6Iey2KC6DMXr2u/
         P5s1SgjVhwKZ+eVE521RCNRLfpI23t3U3bSsqM2e08YiQolIfBpvvNrC0Nl8HjiJ1D4z
         L9me0nHaFw5Hihl6CnCysR/DNsQ5EbJFUEGLJUALy2T1rmZijtdr+9BkQeSERcbTvbq1
         HlhzZ78/vfEU8F7w+5+eKYFi1m1eo2i4vKaAiv8HMe2gGIps7fTxW0q3s1AjgUgfwXjK
         o/FS4iSbrcJynjDMCMiP+VXs1cpVT6TVegRSuzqkc761riXnSyvaITbgGwtu3Rnhh8Ek
         4nTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x9C/3UrPTi7iWbqFHcoS3+5nMQuy/bFwKoTaGYkl7Pc=;
        b=BPd6pGx8sqCN0HCHpeAIh010O5M+HTg7YPjrlUvieIwtlZgEw1ymPRf2DMGWZt44Hk
         /z/moBsXs//TwJvKUo99pfd6zeyTouRPydr43O3Cb3j730/LEDyt1CX+Rb1vjIxwb6FH
         U0GorGJAkC7U+FD5WSVKquIVmkRRM3GV+ojtZ97JMMfQHwnmsUYi7SzEvyveVaevFARB
         f8pArehJH/PeQtkD24XBZOTKEV5W2/3cSjh/bX47wW9cg13PvsHWHMggWYfQIhTx6qGn
         Cg5N/SnEKaZD7JpNJY0xnBh5ewi3qVTYxSHcj7xSwCoXVX2lrv+cGkm80wNfyRw3/FrF
         fTcw==
X-Gm-Message-State: APjAAAU+BkIcKxfgF5Is30L30eVKxc8aZENyCg7+AaT+EZQpM9Z2bV+c
        dBDL4B36BPVSp2KzbdQv7muM6g==
X-Google-Smtp-Source: APXvYqw5EvpKrjLM/n0OZgyqzg51LIAhf3gM/x9WZPkfP/ebRwRM7cpxOFJzmsRmfzBwk8rq4TB+Aw==
X-Received: by 2002:a17:902:a986:: with SMTP id bh6mr11969222plb.165.1576195731770;
        Thu, 12 Dec 2019 16:08:51 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:08:50 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: [PATCH 33/58] serial/f81534: Don't check port->sysrq
Date:   Fri, 13 Dec 2019 00:06:32 +0000
Message-Id: <20191213000657.931618-34-dima@arista.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191213000657.931618-1-dima@arista.com>
References: <20191213000657.931618-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

usb_serial_handle_sysrq_char() already checks it.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/usb/serial/f81534.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/serial/f81534.c b/drivers/usb/serial/f81534.c
index 2b39bda035c7..67a8e343eba1 100644
--- a/drivers/usb/serial/f81534.c
+++ b/drivers/usb/serial/f81534.c
@@ -1238,10 +1238,8 @@ static void f81534_process_per_serial_block(struct usb_serial_port *port,
 			schedule_work(&port_priv->lsr_work);
 		}
 
-		if (port->port.console && port->sysrq) {
-			if (usb_serial_handle_sysrq_char(port, data[i]))
-				continue;
-		}
+		if (usb_serial_handle_sysrq_char(port, data[i]))
+			continue;
 
 		tty_insert_flip_char(&port->port, data[i], tty_flag);
 	}
-- 
2.24.0

