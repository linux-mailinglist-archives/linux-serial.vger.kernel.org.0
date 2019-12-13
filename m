Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F017511DACE
	for <lists+linux-serial@lfdr.de>; Fri, 13 Dec 2019 01:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731461AbfLMAKW (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 12 Dec 2019 19:10:22 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36665 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731496AbfLMAJk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Dec 2019 19:09:40 -0500
Received: by mail-pl1-f195.google.com with SMTP id d15so395659pll.3
        for <linux-serial@vger.kernel.org>; Thu, 12 Dec 2019 16:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hompvs4TzHM6s+1/5TyS4xDRIwWIj/44vZj5QlCvckg=;
        b=aIUYOHntjzAwxd3L5BARNwmmEk6JQIP8acefncyZcp2QiHgm5HQZv+zhKNU/xkJ16s
         sPSrprQUm6NWIX3lQSCvjJRnLZCZygrbhvclb/9KRyJwACumT/xx48RI6QMCdcT5Bioj
         ZyMWZpiYgt4Awz4x0KzQTwlOAje8OnkoaLxXVxnJJP68wyH1RTYYtSpN6Ha54GhfC16Y
         WL3GMHzTrOEg7UEYYLonxEEz+lA3YcYBkfqQJuctAaOE1C4401OHGK1MPSKzUNnoM8Ig
         AU6McbGVMmCeb4Jeyawvqr++ESFWk0oJ+iKBM9fCWRvGDyfrpAz+3WNSfAEih82sdmeQ
         ki7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hompvs4TzHM6s+1/5TyS4xDRIwWIj/44vZj5QlCvckg=;
        b=mD5nGJGf557k82SrUGd4W6fDYKL9a4ipmukNaJ0jnSDFoHyW/vEPp4Fo8PyT4nSflB
         7J84v5vXKJIlwpZs7NfhRT50YUG/2RMm0wKWieJERVOfnvB6rIn2K5eMzmIOqKfhNPYX
         /Yg6zV2KYvD/NHLQ86iK5Qn3ypmplrDWsviNIYue80zQe4W1T6SF+fuc9cgCDHiNVgUc
         AlgV1fgPP5cBfpj52IboCSBdKwxYkMFqzyVjrk3LJDaLnKBdEvAytPMY94Yu3jCBBG0M
         vtIpI1ZHNTCBZFnezIFsBLn8s5w1h6FR0cU18NRbFFr67Y6Mno1IdEbtW9c/41PGl6Tk
         S10w==
X-Gm-Message-State: APjAAAUc3QSRc24TOqMrlSKNiycZOGYxcHZoyHvG7RQhs24pP3qZ/ddA
        GnYAwH3w59eRNT1mGWKr840LBg==
X-Google-Smtp-Source: APXvYqwbjk8eQ60HCsyGrINj/6WOIvDOU0q5FM1bdjC6TvtdYoMStt8wLyL1RMXEwsRxfaqNgqVesQ==
X-Received: by 2002:a17:90a:d986:: with SMTP id d6mr13291140pjv.78.1576195780272;
        Thu, 12 Dec 2019 16:09:40 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:09:39 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org, Timur Tabi <timur@kernel.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 49/58] serial/ucc_uart: Remove ifdef SUPPORT_SYSRQ
Date:   Fri, 13 Dec 2019 00:06:48 +0000
Message-Id: <20191213000657.931618-50-dima@arista.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191213000657.931618-1-dima@arista.com>
References: <20191213000657.931618-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

ucc_uart doesn't seem to support console over itself, so maybe it can
be deleted with uart_handle_sysrq_char() from the file.

Cc: Timur Tabi <timur@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/serial/ucc_uart.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index a0555ae2b1ef..ff7784047156 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -551,9 +551,7 @@ static void qe_uart_int_rx(struct uart_qe_port *qe_port)
 	/* Overrun does not affect the current character ! */
 	if (status & BD_SC_OV)
 		tty_insert_flip_char(tport, 0, TTY_OVERRUN);
-#ifdef SUPPORT_SYSRQ
 	port->sysrq = 0;
-#endif
 	goto error_return;
 }
 
-- 
2.24.0

