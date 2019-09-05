Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB1D1A98C9
	for <lists+linux-serial@lfdr.de>; Thu,  5 Sep 2019 05:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730780AbfIEDL5 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 4 Sep 2019 23:11:57 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36491 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730651AbfIEDL5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 4 Sep 2019 23:11:57 -0400
Received: by mail-pl1-f195.google.com with SMTP id f19so585576plr.3
        for <linux-serial@vger.kernel.org>; Wed, 04 Sep 2019 20:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MfYJlRyMu0jxdb95Tor8jXonvcKSRTtOHygj9lvQK5Q=;
        b=V/XN2SYWaXgG95UKQOBazHPQNX4yF9rbsyhWfaiJO99o1PFJCJ5ExV+iHPhe9gWcfb
         d+gnfF/jUCXjFp++dpHXIT9atOwaB+ufdY+uF7aCm8FKCGoI+yC0EHbmB5Fh2Mx4+lvl
         T245rf0maHvVK/nbjVWbI/P61i52O+QMwd1i74b1ymoo7taCm2Wy9r3OxWAV30aSZ57+
         GeVWWE/l3GcqdCpnQVsvvWGWdOValI6PD020pKQJUTLQH002e2khBy7i2qALZlHCFbOe
         Pnj4lckDukWO/UZusJMceMmP8zxrnw1e3V6kcUtpQQCsojsREAuChcgA5w5GJOmbOhy/
         HceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MfYJlRyMu0jxdb95Tor8jXonvcKSRTtOHygj9lvQK5Q=;
        b=TYCX3FbiCzjgKqRGL30sGczzLPROKMIhIEHf8HiYLP3p/AKymcgelOK9u4sihRVPIO
         LBprQU1DcAG8fwWc3ng1PY/TyO5BUt8hqTPKTvILcc8gmm+nIY4bu5bTNtwzhigTMOJc
         5S4vGCQRoOejxZAALe7hB20cTkjikS54EJq7v5aQxpzW19dRbqrafr2YbsXa2lTregTS
         jV6p9ZtoJsn2v13Hkf0KGp3IVKF/Tdpkfdn+G/Gb072gp8RmsXKFKo0lnk8aP5mfeBGb
         OdbAW8/B5dYU19HU/sd6NXXG+Tl4NRxCXD0trvBQZeeIyvRjWPxzNOSd6cuG0taRd6In
         DsAA==
X-Gm-Message-State: APjAAAUHk+sr4dn4mSaGYj+mRshW1DEkm9yow4IyzDQ1ml9hJxl6YTCB
        aaDSLyi+IycPO25i4eiZ9wDbdQ==
X-Google-Smtp-Source: APXvYqx8CvoNCXmIQapd4vaSC1RjBFGwshNhzXClze6ABO47k+de81CYFeVSeXYgKCLX/qJs1PjfPg==
X-Received: by 2002:a17:902:33c1:: with SMTP id b59mr1094665plc.104.1567653116718;
        Wed, 04 Sep 2019 20:11:56 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 15sm530957pfh.188.2019.09.04.20.11.53
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Sep 2019 20:11:56 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     lanqing.liu@unisoc.com, linux-serial@vger.kernel.org,
        arnd@arndb.de, baolin.wang@linaro.org, orsonzhai@gmail.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org
Subject: [BACKPORT 4.14.y v2 6/6] serial: sprd: Modify the baud rate calculation formula
Date:   Thu,  5 Sep 2019 11:11:26 +0800
Message-Id: <4fe6ec82960301126b9f4be52dd6083c30e17420.1567649729.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1567649728.git.baolin.wang@linaro.org>
References: <cover.1567649728.git.baolin.wang@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Lanqing Liu <lanqing.liu@unisoc.com>

[Upstream commit 5b9cea15a3de5d65000d49f626b71b00d42a0577]

When the source clock is not divisible by the expected baud rate and
the remainder is not less than half of the expected baud rate, the old
formular will round up the frequency division coefficient. This will
make the actual baud rate less than the expected value and can not meet
the external transmission requirements.

Thus this patch modifies the baud rate calculation formula to support
the serial controller output the maximum baud rate.

Signed-off-by: Lanqing Liu <lanqing.liu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/tty/serial/sprd_serial.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index e902494..72e96ab8 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -380,7 +380,7 @@ static void sprd_set_termios(struct uart_port *port,
 	/* ask the core to calculate the divisor for us */
 	baud = uart_get_baud_rate(port, termios, old, 0, SPRD_BAUD_IO_LIMIT);
 
-	quot = (unsigned int)((port->uartclk + baud / 2) / baud);
+	quot = port->uartclk / baud;
 
 	/* set data length */
 	switch (termios->c_cflag & CSIZE) {
-- 
1.7.9.5

