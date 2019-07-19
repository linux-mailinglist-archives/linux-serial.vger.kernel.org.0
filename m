Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49DF36E2D1
	for <lists+linux-serial@lfdr.de>; Fri, 19 Jul 2019 10:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfGSIsO (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 19 Jul 2019 04:48:14 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36889 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfGSIsO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 19 Jul 2019 04:48:14 -0400
Received: by mail-lf1-f68.google.com with SMTP id c9so21165854lfh.4
        for <linux-serial@vger.kernel.org>; Fri, 19 Jul 2019 01:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h/OUL4kuYmZg/t1vj3NY/URHnlsp76VVod3OP2DKJZU=;
        b=QndROAkecH/l1lYhw2nvmBaU7QY8yNn758ILO45/PJ4uS9g0QewPkhfBpMoUVoj9U+
         yeRGHu3K2TbsqGhOUU6XXXPoepN+U6JkClsMDar9/vaa58MT6px88zCwtHZRVconnIoE
         PfAfmkGx5UYfQ6BPArOT9fWEsAEQBkQi5227rRVPNEcHoHbIxJg4W+iOI560jXHWidXV
         tCo4Eo5QE2V3lfxu7uAzHfAT9n9LRmO5kC645r1vYH1TOCItG5E4BQgJ0nnLDKygmPEB
         YaEBOb9uYkEked4bxRSSRPFJW9q4k78C80UdoW3b7hgFGJ3p8r7CmXehm3yPn2n36IeR
         +AAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h/OUL4kuYmZg/t1vj3NY/URHnlsp76VVod3OP2DKJZU=;
        b=i3Dp/kNG/0gT3ogFDYPJFsRq9mS/FVB/TnMxrrvtKtqL12rotLnriZ/4PEb1bAAVn4
         MV6C7LnT7XdORxlaDMmM/425HaabENiYfMx5DZeqEKxaZUUUjsoPvVzFiAVvU+ANyx0z
         U5MGEZay7ffO57WiedFPqIVbE76X5P73fzrHAxW3o9dcWgEIX4Hz/dNUrvtU3ZA/SALH
         FFiiI5o8Zqxsd4kfIlOxwWbGrWKGInbv5HxF/rv3pyJw951kbbCdpnnUATGQsFiHiQ+P
         eCzg+UxeLvTZ8t8qLCr1Vy2Cs1YWVGQdA0I/ZxhnMTG7xTNhdlDf3Y0G+MRyl2eDZoZR
         Ztlg==
X-Gm-Message-State: APjAAAW65xETypFRuJy6DYpdSJw5yk31przUuxiS9l0ilrhOZiUsXlXO
        zvdC7KFT0dtKQd/pekzU76wX2Sb6
X-Google-Smtp-Source: APXvYqy2FGfehFLmTie61L9InK30ezOeOYYqY8rcpDD7bfUOabGgWkAgoF1dGxfMnlyLLGe5rqoPkw==
X-Received: by 2002:ac2:5337:: with SMTP id f23mr23972581lfh.15.1563526092493;
        Fri, 19 Jul 2019 01:48:12 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id s21sm5588742ljm.28.2019.07.19.01.48.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Jul 2019 01:48:12 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v4 1/3] serial: imx: set_termios(): do not enable autoRTS if RTS is unset
Date:   Fri, 19 Jul 2019 11:47:52 +0300
Message-Id: <1563526074-20399-2-git-send-email-sorganov@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1563526074-20399-1-git-send-email-sorganov@gmail.com>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1563526074-20399-1-git-send-email-sorganov@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

set_termios() shouldn't set UCR2_CTSC bit if UCR2_CTS (=TIOCM_RTS) is
cleared. Added corresponding check in imx_uart_rts_auto() to fix this.

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 drivers/tty/serial/imx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 57d6e6b..95d7984 100644
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

