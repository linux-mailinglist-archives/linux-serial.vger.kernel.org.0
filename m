Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 298A6A6225
	for <lists+linux-serial@lfdr.de>; Tue,  3 Sep 2019 09:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfICHBz (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 3 Sep 2019 03:01:55 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45515 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbfICHBz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 3 Sep 2019 03:01:55 -0400
Received: by mail-pg1-f194.google.com with SMTP id 4so5045889pgm.12
        for <linux-serial@vger.kernel.org>; Tue, 03 Sep 2019 00:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ATcsitRpTyb5wI6PMkB6H6IJliZcFvf7R0g9NfFMg9A=;
        b=EHgBr9KfYik5R6FusPDhu53l+J3bX9l8zy+rd7KHjP5eJpWMJBDrvwknS9Pt9RsCsr
         1AhNQzcmCHH9hqmZxFEi9bKhZfz9UiEgVdHOCOBb26fxtUWMRm90Wpehtn/bqoHFE7bB
         goOWVwvsODaia2BAUb32k0QYR4cWSFXHHeaHp4RuK6nDFMiUZQTYFCPSUBW3MDWQApv+
         Y9SP5AXKkI1/kJsVfCFyEsbDGeymtrlHCMxAg8nB/8sVoLY/KFIw1Gm2GH7Q42O2mWqv
         I0cFnHbxAmjHo51uvaqpSr6CFedJhzS1ZJp8PYutClpWHQYPWbz8ASS6WgRUtQJyZchn
         SUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ATcsitRpTyb5wI6PMkB6H6IJliZcFvf7R0g9NfFMg9A=;
        b=OSv+urw4soTil/lV08IxoTaKdM6zSzaOSGXDkC2Eh/V66Gy/fqQJ8tnt/Ez91mhJGp
         z65oBIcJ1kdjuGAWihnqIFDzLICUIW7FFHIlihWNQYb3EDeonMIT2tFITZOFKzqx9EHC
         1NVi6KCAA3M2teo1YlBBhyU6Rxu2VSPZeC00GQtyJc991BViqCbqwiyhXUWPlfF0R+xl
         iaosBskb+GvjCk0Kk2hyz9eEFQpZFsspwkgywJh6WskMo4LTrnNLO35BXyOvTafycMSR
         JG11jHbzltubQmwUnL60fdSRC7D/w3dGZp68Senudzg3IhOai50MnDcSzpm4xrNfNvn3
         CxwA==
X-Gm-Message-State: APjAAAVH2yY9VGK5Mm5HbkP6TIjUcoKuWfW9j8WciMyCGns3xqVlEbjD
        Y9ZuXqFETBrLtAYd+5vN/dIZ6Q==
X-Google-Smtp-Source: APXvYqz7PqAPPuwHi9KNmY1wXWO+7XyHpi9GIfgIFWwbvr3Uy0dMS/qxpicDH9bsKAIcPc8znEA9iA==
X-Received: by 2002:a65:690f:: with SMTP id s15mr27939370pgq.432.1567494114841;
        Tue, 03 Sep 2019 00:01:54 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 19sm16471892pjc.25.2019.09.03.00.01.50
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Sep 2019 00:01:54 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     lanqing.liu@unisoc.com, linux-serial@vger.kernel.org,
        arnd@arndb.de, baolin.wang@linaro.org, orsonzhai@gmail.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org
Subject: [BACKPORT 4.14.y 8/8] serial: sprd: Modify the baud rate calculation formula
Date:   Tue,  3 Sep 2019 15:01:25 +0800
Message-Id: <b72268635867cb643912bd842f4980c5d24cb2df.1567492316.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1567492316.git.baolin.wang@linaro.org>
References: <cover.1567492316.git.baolin.wang@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Lanqing Liu <lanqing.liu@unisoc.com>

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

