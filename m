Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA92756B93
	for <lists+linux-serial@lfdr.de>; Wed, 26 Jun 2019 16:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfFZOOT (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 26 Jun 2019 10:14:19 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45396 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfFZOOS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 26 Jun 2019 10:14:18 -0400
Received: by mail-lj1-f194.google.com with SMTP id m23so2356413lje.12
        for <linux-serial@vger.kernel.org>; Wed, 26 Jun 2019 07:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SjpXSg531ioWOBzpBIFjjzIi5yRvk9QMHcPgjilDAr0=;
        b=qca4raonl1jkAymrg6nNDfK2OxZwaHqAPzBOVKKzmmIaGVOgkn9U5Sug8izqRqiEgq
         p9i945fgppbhD/Wxh3QoI+0pABdNgTcyf1KgEVPK4ZfK1k1DDgORdOn0QGmhVldkYpqE
         6xF7IvU8nPR8J2G7ZKBEncmu754DR6j1HNDntCiDM8TBaYuxCC1/1MeIKkknUmdHyMK7
         ifkg433l8teKUsPih39z12s1yxtg69E1kCzXyp//aXxCFI854XTxAEV+3M5axsFeMyS1
         ngyjdMVS7qCt9L7eBE/yGIo0wUQxtwFCqos7DKXUQHd+a7YRPMWqf6DKBOSiTFil0L93
         OsIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SjpXSg531ioWOBzpBIFjjzIi5yRvk9QMHcPgjilDAr0=;
        b=SixJNefpWn9+4GzgWoI4FHQWGS8YWrSukYZXisr/WReEWADE0wxOEq5vf7PoKiaGVm
         SruNceVQytGbHXiv1j2ixcM3xf2bXN+RtGmvVv4rtjLg5h84QhumfDrqE9x4+LHe9dV8
         Q+xUXwqgMqMk2+4Bb92wLVGfdDEmBg41vg79knbIeuJ3Q8lRWDChDQDWHzEQG06SxHCe
         st8LouyAkxdOZNjhwrkZS+UFAHZkUh0kBdCC1zUjViJxy7KQm4HUKrMS/QtFgU4/VYC7
         0QUCfe1Z5gl5FRNBZ2j8uIc26KHrGn8BlRVVNBnD0smgP4MoePHyfkXxU8+vB6Bx3HMW
         UJ8g==
X-Gm-Message-State: APjAAAX9kJ93AReo0aman+knf7mlTLNi2Fu75bZiTrSlSYHaGKB7lrH9
        b4NW+bK+PcIAUuMgl/e3LEU=
X-Google-Smtp-Source: APXvYqw5/oAtAzvXc7HUCNpUYYoZ2KlQOF8a5I/VNuxYuw3AuZvADuJi9KXokLYHddmUnp8SlU8Vgg==
X-Received: by 2002:a2e:8155:: with SMTP id t21mr3108879ljg.80.1561558456870;
        Wed, 26 Jun 2019 07:14:16 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 25sm2863825ljn.62.2019.06.26.07.14.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Jun 2019 07:14:16 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v2 2/7] serial: imx: set_termios(): factor-out 'ucr2' initial value
Date:   Wed, 26 Jun 2019 17:11:28 +0300
Message-Id: <1561558293-7683-3-git-send-email-sorganov@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1561558293-7683-1-git-send-email-sorganov@gmail.com>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1561558293-7683-1-git-send-email-sorganov@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Set common bits in a separate statement to make initialization
explicit and not repeat the common part.

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 drivers/tty/serial/imx.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 1055124..87802fd 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1563,10 +1563,9 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	spin_lock_irqsave(&sport->port.lock, flags);
 
+	ucr2 = UCR2_SRST | UCR2_IRTS;
 	if ((termios->c_cflag & CSIZE) == CS8)
-		ucr2 = UCR2_WS | UCR2_SRST | UCR2_IRTS;
-	else
-		ucr2 = UCR2_SRST | UCR2_IRTS;
+		ucr2 |= UCR2_WS;
 
 	if (termios->c_cflag & CRTSCTS) {
 		if (sport->have_rtscts) {
-- 
2.10.0.1.g57b01a3

