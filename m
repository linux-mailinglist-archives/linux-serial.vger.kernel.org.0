Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF33E3B006
	for <lists+linux-serial@lfdr.de>; Mon, 10 Jun 2019 09:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388015AbfFJH4A (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 10 Jun 2019 03:56:00 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43206 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387879AbfFJHz7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 10 Jun 2019 03:55:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id r18so8095919wrm.10
        for <linux-serial@vger.kernel.org>; Mon, 10 Jun 2019 00:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=59OBAj0fI25tEYttQXITetWvFu8mb0M8xC0iXb+r1/Q=;
        b=ac55uDWvwtnRMO4dwo2jOwokokoGQqChSr8nLRQkch3cqmntcsHmIs5Enlxes4BMmD
         whsoQL32Phf74kG9p3ykb4BQpVNP5cJqt+cKlIDj4Zdm24Diem/ePySIdftWtIgPyWvy
         5p0cqzqB9FFQq+TYlniqybtJAIfZ4NAgd1YaG7zkhbQvdpOCxk7J5mc279Hc2osCt1vd
         Yl1fUWZqlbXJ/w97BoASau/j4/JSf2CTqRYtgMXw2CLCv729XFXLUeFukUuYvVJ5gmQM
         G4SPTb4u2rAhJ5Y4dX5clBzE9vGyNBmO2HARalYO+9+qToitJnp5HTEtK2qpmoVHbXQM
         nsaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=59OBAj0fI25tEYttQXITetWvFu8mb0M8xC0iXb+r1/Q=;
        b=epaPr0gf43oU0GBx73PDMnCBAt0+C609OskilXH2HPa/l5Weo5TUX8WpWa84BKK/eI
         nBIETX3zKwxNLHfGlEUBasItdkk6VZovTIGir/TJKeWmyO5t8W3apRiQjPxJaWsbnbih
         IvTkgEa+Z8J4GzRaxEryLsThKmbtpeIEq9iQiFCuL4NY+r9nkCFZLVfai/WshQTFxMuv
         l88nxH78gIPP8uzvdYATrjLgsWmed6EZmATXHEoVnS1/r92aJW0CB8fw3VsBvmUT5ldP
         zMfrJpisp3TgeftODeuYN4RS22Dhim9MZHCqb66bT1/pZF0sMN78xqWIjpCphmVsKdo0
         KABg==
X-Gm-Message-State: APjAAAUzRHI3kqTgE30AF8U5u8jc6p20CmfB5qHQ5BXdsVkE8XImB4tr
        Jd3g1DiSCW5dpFTnm96tplBjGw==
X-Google-Smtp-Source: APXvYqxbn9YaeW8aGMKMh2aP+dx2pUtvPkFwVo6Ly0icmWY5OKpn9BPA1ZwRVm/Nm5h9j9ZfLAU01g==
X-Received: by 2002:adf:9ed3:: with SMTP id b19mr21441431wrf.292.1560153358334;
        Mon, 10 Jun 2019 00:55:58 -0700 (PDT)
Received: from localhost.localdomain (233.red-79-146-84.dynamicip.rima-tde.net. [79.146.84.233])
        by smtp.gmail.com with ESMTPSA id e13sm22627166wra.16.2019.06.10.00.55.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Jun 2019 00:55:57 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, agross@kernel.org,
        david.brown@linaro.org, gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, khasim.mohammed@linaro.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v2] tty: serial: msm_serial: avoid system lockup condition
Date:   Mon, 10 Jun 2019 09:55:54 +0200
Message-Id: <20190610075554.24979-1-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The function msm_wait_for_xmitr can be taken with interrupts
disabled. In order to avoid a potential system lockup - demonstrated
under stress testing conditions on SoC QCS404/5 - make sure we wait
for a bounded amount of time.

Tested on SoC QCS404.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 drivers/tty/serial/msm_serial.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index 23833ad952ba..3657a24913fc 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -383,10 +383,14 @@ static void msm_request_rx_dma(struct msm_port *msm_port, resource_size_t base)
 
 static inline void msm_wait_for_xmitr(struct uart_port *port)
 {
+	unsigned int timeout = 500000;
+
 	while (!(msm_read(port, UART_SR) & UART_SR_TX_EMPTY)) {
 		if (msm_read(port, UART_ISR) & UART_ISR_TX_READY)
 			break;
 		udelay(1);
+		if (!timeout--)
+			break;
 	}
 	msm_write(port, UART_CR_CMD_RESET_TX_READY, UART_CR);
 }
-- 
2.21.0

