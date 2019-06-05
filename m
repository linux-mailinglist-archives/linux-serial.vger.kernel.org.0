Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9433F358FD
	for <lists+linux-serial@lfdr.de>; Wed,  5 Jun 2019 10:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfFEIvp (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 5 Jun 2019 04:51:45 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35906 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfFEIvp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 Jun 2019 04:51:45 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so15545680wrs.3;
        Wed, 05 Jun 2019 01:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+VyGoQKAdyot/bp5WLVhVb61YYYCRfPZnDleP6IdQm0=;
        b=RfpkbDC895FXS7xJlgZcd6hC3WMZgIiPYciHXCxhHHT8gWE5OiCQqqSi3U1SDBR6qc
         Jp8YYMB8W+35zcMix6DfyU4nANpOk6SQahXg6i9ggy139CjUGRyImDJvPfXOwfDVGo8a
         7N2qZJI0p7ugQdl6FRt0NW+9OK2fTVIHQLLG1tkHCaEp5cKvThUDqUJe51DeDE5lPW4y
         8y2l2jFO1AxYx3WSm+Yra0gBjLZfRz3QTrz9QEgU3FWP7DInzPGTLlOtNm8tW3l8wHvg
         gHMKdVJLx7QfrI0Iof4uMPiiuLB61eUK3o7gxI0jGQpmKz95FLfzghRW0t8SdrK+np08
         Sw4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+VyGoQKAdyot/bp5WLVhVb61YYYCRfPZnDleP6IdQm0=;
        b=SHIE6Gn1hEvVVWwoci6pvG15v6lvNDj8+YGqK5xkDSVUnA6y3eFEiqxczI3As24EvQ
         q2TR60+xBn63Etnpudmxm/Q2K5xPgtMWf7fNTBvHnTCVMg6wDvhCRjY0bMbCqdLtTofr
         3rqeZsLy4SwDzbQPQw/NoJu5G0AVloKNmZ5XQuw7O2k+WjBMU3OB+al4zEirdeXNZSHT
         YrkxIx9+5T1EUoEJUtK2VcPFmrv/2TaDClb1dBElAWxHMDHIa/EJKEPqqfeA33FUWNg7
         WIk+hcmoLxlxhTcm4o6Qn5t1Aug5OgQWhbHac2IwraZB4PDSjHS/9atBHhW7yK2Ww1l8
         hO9A==
X-Gm-Message-State: APjAAAWNt08SnCGHKaj2HTAreAfFhK6hVSproaji7ukzUVAmEiVXuVqR
        3cItPThIZz9QwMSyM765VLehVPS6
X-Google-Smtp-Source: APXvYqzyrs1WhkBjaZPt4CV8cTLH6XNq1VlTmcKT2R9y1TgYDgkoLqw2DyfROjGjTilwZKAPxwYl5Q==
X-Received: by 2002:adf:8183:: with SMTP id 3mr10348617wra.181.1559724703736;
        Wed, 05 Jun 2019 01:51:43 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id j15sm9561477wrn.50.2019.06.05.01.51.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 05 Jun 2019 01:51:43 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH] tty: serial: 8250-of: Do not warn on deferred probe
Date:   Wed,  5 Jun 2019 10:51:42 +0200
Message-Id: <20190605085142.13292-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Deferred probe is an expected return value for clk_get() on many
platforms. The driver deals with it properly, so there's no need
to output a warning that may potentially confuse users.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/tty/serial/8250/8250_of.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index 1308b3d1e17a..0826cfdbd406 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -70,9 +70,10 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 		/* Get clk rate through clk driver if present */
 		info->clk = devm_clk_get(&ofdev->dev, NULL);
 		if (IS_ERR(info->clk)) {
-			dev_warn(&ofdev->dev,
-				"clk or clock-frequency not defined\n");
 			ret = PTR_ERR(info->clk);
+			if (ret != -EPROBE_DEFER)
+				dev_warn(&ofdev->dev,
+					 "failed to get clock: %d\n", ret);
 			goto err_pmruntime;
 		}
 
-- 
2.21.0

