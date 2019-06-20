Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 607714D0B4
	for <lists+linux-serial@lfdr.de>; Thu, 20 Jun 2019 16:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731802AbfFTOsO (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 20 Jun 2019 10:48:14 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34041 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfFTOsN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 20 Jun 2019 10:48:13 -0400
Received: by mail-lf1-f67.google.com with SMTP id y198so2670673lfa.1
        for <linux-serial@vger.kernel.org>; Thu, 20 Jun 2019 07:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6Nm3aMeYvpczSE39H4ZCdrCAyxxKPyaKxXuOXw8nA9E=;
        b=Ss5CQNRQyqAxUrx+3rTrr1Rso/LJZB+pJ5PVygl4RrOFXbA+QP2U8nVgNZ7aj7rzLl
         hxtPA9icuOeZjltVtquglSqmBtdUeF4iNI/364v3Sa6iqLOH3K7imWi8ZJCeBtNRa3eB
         ZGrLttd0NFhg/g+jlYkqDv0vR4u0F1NYIvOZSBmX/wBIa0mrEzG1UPqlljq9B9k4uvk8
         azK6xmvKsieyTiZ1VBQj2O9a0qnpx+KSFQKyl8Rz8Spb9v9YxJr6RCJAdDJEm3Y5KFQX
         Bc2BlSAA0X+1VvFfjcZKYL1zFVTpVRwHm6W5cmxHc08TMe+qvXO5wixzst+FRnV00M97
         VPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6Nm3aMeYvpczSE39H4ZCdrCAyxxKPyaKxXuOXw8nA9E=;
        b=F8xu9dYg18qDhwTR/pCbD6J8ZSJASVh/lR0oUNItT6kMoZT94Qbo6PzdKIUb7l/5qM
         j1JyIjKmyJW3M2smgO/NgDrm7IWqvsBQ6SSVIqSUfrc+hThZ7UpZ+UnuHVTF6YOVC/dm
         oEdyd49Lr7t1YsJA7PLO8SJXhxqrXbXdKIRzFPBIj1+nkdAhGc9yDh3Z8SytQZQGiGD2
         DSja/ZRdfQI66yU8g9IbwZd56IFXGLZa4ewvatI3WJIIa+mr8b8kuHAF553eTyZFXe6/
         JREUqc0bpKF42t1u/DRWfYrAHw9/aEIcBVJwj+5x1+bzkXli9sdRYlN4SvKrVLDsPyi5
         /nyw==
X-Gm-Message-State: APjAAAXILNdayUkXmfPtytrsOgl5RYoH2ycz816BKNm19rJ6my4FwM1x
        vwK3/+Q0V3qj2U4ydLvBmZg=
X-Google-Smtp-Source: APXvYqzEDgPvzuA9agr831Q9g4K+XHoTDD6hI1abVBYqhLYa0eXYg8rTd9FJ+1G12eq6tprD+I3D5w==
X-Received: by 2002:a19:2d55:: with SMTP id t21mr1839970lft.94.1561042091891;
        Thu, 20 Jun 2019 07:48:11 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id f10sm3577768ljk.95.2019.06.20.07.48.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Jun 2019 07:48:11 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH RFC v1 5/7] serial: imx: set_termios(): do not enable autoRTS if RTS is unset
Date:   Thu, 20 Jun 2019 17:47:51 +0300
Message-Id: <1561042073-617-6-git-send-email-sorganov@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1561042073-617-1-git-send-email-sorganov@gmail.com>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1561042073-617-1-git-send-email-sorganov@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

set_termios() shouldn't set UCR2_CTSC bit if UCR2_CTS (=TIOCM_RTS) is
cleared. Added corresponding check in imx_uart_rts_auto() to fix this.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 drivers/tty/serial/imx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index e0f5365..4867f80 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -405,7 +405,8 @@ static void imx_uart_rts_inactive(struct imx_port *sport, u32 *ucr2)
 /* called with port.lock taken and irqs caller dependent */
 static void imx_uart_rts_auto(struct imx_port *sport, u32 *ucr2)
 {
-	*ucr2 |= UCR2_CTSC;
+	if (*ucr2 & UCR2_CTS)
+		*ucr2 |= UCR2_CTSC;
 }
 
 /* called with port.lock taken and irqs off */
-- 
2.10.0.1.g57b01a3

