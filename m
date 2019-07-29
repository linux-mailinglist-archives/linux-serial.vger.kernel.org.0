Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 314AD7968B
	for <lists+linux-serial@lfdr.de>; Mon, 29 Jul 2019 21:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403814AbfG2Tw4 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 29 Jul 2019 15:52:56 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42562 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390072AbfG2Twz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 29 Jul 2019 15:52:55 -0400
Received: by mail-pg1-f195.google.com with SMTP id t132so28763676pgb.9;
        Mon, 29 Jul 2019 12:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xtSi5hMWCu8JmvkiHqNyb+90M3Uuthpu/boJgJFrMS8=;
        b=XAOt2i5iNbNF5eecoaE500/fo2HxMdtBQqKYZ+L9aYfSEx2WcbVxHD7I2bJm0Ude2T
         Gp/OJfYydHnCaIrDEk6aZfoiJXOPv/KK0pD4yWBERUc2dlsX3DjHQLi4AJ1Ce66nKacM
         vlJaSkvNg/qJW6oOqeLDYwBp5xy7+O4sytvurgh+iPGzTy52I44L0E/kubboGh/euroy
         e6UWfHpo7dE4lZC7isJd11/HnPWqySa9V+CZngahHQrEyzHWqIL8cv+GBDUywjUYNN+9
         +U9pALSWkZ4TAvjFimWfhFNd9NrWXKLRbYLlduU0rkZkLTdFMwB8OQYH9qEXVYrJU2ZJ
         qyKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xtSi5hMWCu8JmvkiHqNyb+90M3Uuthpu/boJgJFrMS8=;
        b=MzsAUOh8UoQXkI28xublwdPMpgik58Isv3YfGMrg/QKDzLDTOwHvIEk6Oz25OE0At2
         OKKC2zZt7cuRV0SKmsfASjwo9a7N8CJxMCtN7CaIepmolXvMvKTrE+kXt4sTwEfj+KHc
         flFUadF4TIY0bFu3gMAxuVuXlMmNlafXqO5/77bwxGBJN/oig3AUyT6ggzccONTSTzZy
         GvMbHhZWv6gdUvnunwzq5+bzer5dakRLrUW8Nb42s4bbxyO3C1tXyI/2J7e4as1A/BTu
         V0+d+/v6tRok/Zl434IqAyASA0ljfT37IHUMeo1mRscIFJ86i0bdTUx/DX+ASk6Zj4eI
         KlYQ==
X-Gm-Message-State: APjAAAVAjXLaWYchWEtsw7qfHyzo4b8FTim7Fdmk0W6AdUQBEnLwtdSZ
        BjfjikCK1vGlUYKWTyZT/crkD2GI
X-Google-Smtp-Source: APXvYqzGx/LDBvhX6noBNGjlI/f+61wd2oA06XDK9QEc36Z30+fSnrspzeDUJW1EX6YaRurOpptVaA==
X-Received: by 2002:a17:90a:ac13:: with SMTP id o19mr114010053pjq.143.1564429973604;
        Mon, 29 Jul 2019 12:52:53 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id z12sm43983750pfn.29.2019.07.29.12.52.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 12:52:52 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-serial@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Stefan Agner <stefan@agner.ch>,
        Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>,
        Chris Healy <cphealy@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Lucas Stach <l.stach@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/24] tty: serial: fsl_lpuart: Drop unnecessary sg_set_buf() call
Date:   Mon, 29 Jul 2019 12:52:08 -0700
Message-Id: <20190729195226.8862-7-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190729195226.8862-1-andrew.smirnov@gmail.com>
References: <20190729195226.8862-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Sg_init_one() will already call sg_set_buf(), so another explicit call
right after it is unnecessary. Drop it.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Cory Tusar <cory.tusar@zii.aero>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-imx@nxp.com
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/tty/serial/fsl_lpuart.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 1b3f2a87e558..b600f591c8c2 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1144,7 +1144,6 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
 		return -ENOMEM;
 
 	sg_init_one(&sport->rx_sgl, ring->buf, sport->rx_dma_rng_buf_len);
-	sg_set_buf(&sport->rx_sgl, ring->buf, sport->rx_dma_rng_buf_len);
 	nent = dma_map_sg(sport->port.dev, &sport->rx_sgl, 1, DMA_FROM_DEVICE);
 
 	if (!nent) {
-- 
2.21.0

