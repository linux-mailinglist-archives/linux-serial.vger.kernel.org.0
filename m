Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C019A185089
	for <lists+linux-serial@lfdr.de>; Fri, 13 Mar 2020 21:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbgCMUrX (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 13 Mar 2020 16:47:23 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:35701 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbgCMUrX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 13 Mar 2020 16:47:23 -0400
Received: by mail-pj1-f68.google.com with SMTP id mq3so4964771pjb.0
        for <linux-serial@vger.kernel.org>; Fri, 13 Mar 2020 13:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WmR0Zy/INv8T8Q5kpQokwP6/VvkYAWeVeStzwjBb3QQ=;
        b=OsR77xO6S3/Q0dciqM0G3rlzGynb1g8GBeeGYt0oyJ2X9+/Yt1IVFN2292US9JwJ3I
         m4gWfpLKPMMVfqbtGJzfzOdmZgnRQqxn05Eoc61EAhZQLc44M2ZHEjGuxdb7lXvQIfot
         YNSbpQjw4kgzI//8hMEzKSiXnvuIlCFUfSj5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WmR0Zy/INv8T8Q5kpQokwP6/VvkYAWeVeStzwjBb3QQ=;
        b=ATAIS3QThzWbQSo13Y3s/pbNQWcbZqSFM2zH9biRG3iAGUKR5GRoBVMWNPfPA+N6Sb
         WMEbYIInc/3dua8YewkAsSMbkwnK7363ej0RjUewFVjfsUP4Kw3/5U91lmXJY4KsmSmD
         P9JHvOACmnWA+AUaImsC6JD2lexhgACDQ6y3/BIxdb3sW0VG7u8wd2TcTuwqynrKy1eb
         2gixOplAkA4nJVdFnt+C19nBpq65jLIu1d0ugTIN0D2aaFWAJby6qahSmXbxITTkRVtV
         1LTrKkamZyIQhGcQ85xvwDuxVBjNaxOl2K0iQb+ET6nZY/+LkGBoBgVHzUanfXDlKuTa
         0rNQ==
X-Gm-Message-State: ANhLgQ1rI26V84hu/5E0aU1aKOLOv3H8aSICGfWmzoutlvXGbEPcKnWK
        aCwfjoPQqkEjgulh1jJbDgGHUw==
X-Google-Smtp-Source: ADFU+vueocNRDiEDaoc5lL0rcsBqaOHG/wMpUZqEnr6mvREDuEKQvFR/4jeFV7cx64SuqEFaTFBMlA==
X-Received: by 2002:a17:90a:da01:: with SMTP id e1mr12067723pjv.100.1584132442065;
        Fri, 13 Mar 2020 13:47:22 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id a13sm26532278pfc.24.2020.03.13.13.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 13:47:21 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     gregkh@linuxfoundation.org
Cc:     mka@chromium.org, swboyd@chromium.org, ryandcase@chromium.org,
        bjorn.andersson@linaro.org, akashast@codeaurora.org,
        skakit@codeaurora.org, rojay@codeaurora.org,
        mgautam@codeaurora.org, Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Doug Anderson <dianders@google.com>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Jiri Slaby <jslaby@suse.com>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH 2/2] tty: serial: qcom_geni_serial: Don't try to manually disable the console
Date:   Fri, 13 Mar 2020 13:46:52 -0700
Message-Id: <20200313134635.2.I3648fac6c98b887742934146ac2729ecb7232eb1@changeid>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200313134635.1.Icf54c533065306b02b880c46dfd401d8db34e213@changeid>
References: <20200313134635.1.Icf54c533065306b02b880c46dfd401d8db34e213@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The geni serial driver's shutdown code had a special case to call
console_stop().  Grepping through the code, it was the only serial
driver doing something like this (the only other caller of
console_stop() was in serial_core.c).

As far as I can tell there's no reason to call console_stop() in the
geni code.  ...and a good reason _not_ to call it.  Specifically if
you have an agetty running on the same serial port as the console then
killing the agetty kills your console and if you start the agetty
again the console doesn't come back.

Fixes: c4f528795d1a ("tty: serial: msm_geni_serial: Add serial driver support for GENI based QUP")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/tty/serial/qcom_geni_serial.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 09d8612517aa..69a0072e0c53 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -827,10 +827,6 @@ static void get_tx_fifo_size(struct qcom_geni_serial_port *port)
 
 static void qcom_geni_serial_shutdown(struct uart_port *uport)
 {
-	/* Stop the console before stopping the current tx */
-	if (uart_console(uport))
-		console_stop(uport->cons);
-
 	disable_irq(uport->irq);
 }
 
-- 
2.25.1.481.gfbce0eb801-goog

