Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDE95771A6
	for <lists+linux-serial@lfdr.de>; Fri, 26 Jul 2019 20:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387763AbfGZSxV (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 26 Jul 2019 14:53:21 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41766 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387854AbfGZSxV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Jul 2019 14:53:21 -0400
Received: by mail-lf1-f66.google.com with SMTP id 62so32877984lfa.8
        for <linux-serial@vger.kernel.org>; Fri, 26 Jul 2019 11:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hlO4j1hJuCOJd1h1Hw9Dr7/Fw6jxqbEeyEo5OnuF750=;
        b=E11A35JTqUGpf4NcDswflSPTMqH1wKUo6F85Dt+BpKH7fAYIyjF8Sa4+YR0f7rv1K9
         ib8/bOdc1Xc/Z7GtXBwOcd08XODaU2FiWa8pIx8sADZsDOvRQx6VX3sTTNK1EP1FkxUG
         LHZm73i0+b8QoCt0RtCOmpf2nVjViGLe23SwmpVgf5lsBpiz1VzjmMHCJPHg9FNZ/whY
         IzW8yLWqbBPJoAt/boN1JsfCOvSdBkdwVfo+UHmQvJjh/RvGrLnP6fO99NzFFs5ENPov
         gtU2IgZe2wgNGLPwDTl9uiVn+ZcFQh3gvuHegKWVxr35SxE1ullWi3tuqYQUNA0MaiR2
         Q3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hlO4j1hJuCOJd1h1Hw9Dr7/Fw6jxqbEeyEo5OnuF750=;
        b=iI2395TGpnh/A+9vQslbZ7S5uJUjQKO5GsOh7LLxxRpwqbkBMYnqH3bquUFtZ9/bO0
         JZ8FWr1QYMTsOwWs++VKIcJOijvA+JTMYMUhgCbV4bmfmcA8ZufqcrQkvlBTYFfxDzbR
         J/1WjKvLCDBnwf5bshBpgVAlaaURK4kE5xfqJUzzlQb6T4ixY0k7BWRaMVrY4Y7XS3DU
         hiyJoiE2VUgVc9TMBydovlBpYuRgj8P7RIVDj05UntMDoEShEzBItfWbf/ijpyRVsNvM
         E6rcadfa8rdZk7SbuGPqRGMlfRePPT/DrPYgjiXpmas4GsmXXR7qlaY9J3xgBW2i/e9L
         YEHA==
X-Gm-Message-State: APjAAAUVxPMJeKZjOruR/A4drSs25Vdgck2SZidfGytoVV4lXNXWZP0L
        q/vm8nn3fd5uin0MrNiCPMpSWNBM
X-Google-Smtp-Source: APXvYqylyhgwhQzIZbM8sF6YYj/UW0wfnrPMmm+VrH6WhYCCqZA9ezpHdKMq03NlQv0gUDOJ8STjXw==
X-Received: by 2002:a19:c887:: with SMTP id y129mr45791747lff.73.1564167198917;
        Fri, 26 Jul 2019 11:53:18 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id u15sm10254810lji.61.2019.07.26.11.53.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jul 2019 11:53:18 -0700 (PDT)
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
Subject: [PATCH v7 1/3] serial: imx: set_termios(): do not enable autoRTS if RTS is unset
Date:   Fri, 26 Jul 2019 21:52:39 +0300
Message-Id: <1564167161-3972-2-git-send-email-sorganov@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1564167161-3972-1-git-send-email-sorganov@gmail.com>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1564167161-3972-1-git-send-email-sorganov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Don't let receiver hardware automatically control RTS output if it
was requested to be inactive.

To ensure this, set_termios() shouldn't set UCR2_CTSC bit if UCR2_CTS
(=TIOCM_RTS) is cleared. Added corresponding check in imx_uart_rts_auto()
to fix this.

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 drivers/tty/serial/imx.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 57d6e6b..32f36d8 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -405,7 +405,12 @@ static void imx_uart_rts_inactive(struct imx_port *sport, u32 *ucr2)
 /* called with port.lock taken and irqs caller dependent */
 static void imx_uart_rts_auto(struct imx_port *sport, u32 *ucr2)
 {
-	*ucr2 |= UCR2_CTSC;
+	/*
+	 * Only let receiver control RTS output if we were not requested to have
+	 * RTS inactive (which then should take precedence).
+	 */
+	if (*ucr2 & UCR2_CTS)
+		*ucr2 |= UCR2_CTSC;
 }
 
 /* called with port.lock taken and irqs off */
-- 
2.10.0.1.g57b01a3

