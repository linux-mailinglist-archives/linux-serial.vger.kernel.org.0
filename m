Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3211B3F0
	for <lists+linux-serial@lfdr.de>; Mon, 13 May 2019 12:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfEMKYQ (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 13 May 2019 06:24:16 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54142 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbfEMKYQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 13 May 2019 06:24:16 -0400
Received: by mail-wm1-f67.google.com with SMTP id 198so13233745wme.3
        for <linux-serial@vger.kernel.org>; Mon, 13 May 2019 03:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=devtank-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6vu7VsLAB6EZfKQ3E20kQzIp4QMTEp3WsIjFBe4Pj9U=;
        b=Tfu4ZAS+C3GDszdlHRUAbXDrEddrT8zLcHfMSsY4tOy7YD/Tue03kaZCMEVWiupTMa
         LO7dT5qveb5feK4pU3SyeieciIuiEi5cbDLdbC/K9quKDvCljQXF2IVxsE+uAkUSzLgA
         9199urvnRbr6Zy6FCkvJZ6C5xhP9duq7GbVu6VMuF0mP1b46rha+vayjdPqovVo4PdnN
         R3wUxHHxI3tMtlWyWCkG0xdRw7lZXtzDFL12mQWJIfJGChKR5Ku9n/0BgSrurlsC1Pes
         O1OYwoT+QVJo63ltBiybydkiE7bekY+W4EeYoghAfJnS+Cs7jELn/QbTxyaotFbDSCxv
         fS9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6vu7VsLAB6EZfKQ3E20kQzIp4QMTEp3WsIjFBe4Pj9U=;
        b=WdwIlzDuGs5GfdmD4n53lrwT3wfNvyKMMIp8/tuVy4COLmkycrzcScyzhClVfu2xrw
         lcOJiTYzoGpRKEcOePrbcT1si9KeP61qWlDIds2zNg+YjERqNd54hCmH5zqEMEYNzRmg
         QsxMh6z4ySSWn+EdI+Sq8TBzTNGAlDNm8Is+PsdRFVx6h/GFVdAtcaw1TdkMRZbUc3QJ
         6fZhYGo3YC/dYySzgCfD97Tgsa6hNwMbbWc9h8WZJNjnKtj3Y8uIpzaAKuBjfhAIBGII
         iojLXrcVfcIhP2OTP9+2/NtkZP05oDdpRj9cz+NgBJeQt67i4guMoTwMdz0n96UXy8XJ
         IwmA==
X-Gm-Message-State: APjAAAVwYeKQb3Zl1fVQPcgG/QvIL/pqGi7z1Pkp4vGItNi+f2Vc7iXJ
        Sm4+2boQPz650ob3hbTiX7K/jXVy3Lg=
X-Google-Smtp-Source: APXvYqwRd9X7EA7L/4fX3+C9wzCg3OpAPxddyE8AQwLYcVb2xDR3LTXqs5xZO8m1Ej/hGeBEUcKxyg==
X-Received: by 2002:a1c:7e08:: with SMTP id z8mr15695093wmc.36.1557743053784;
        Mon, 13 May 2019 03:24:13 -0700 (PDT)
Received: from jabjoe-thinkpad.lan ([141.105.200.141])
        by smtp.googlemail.com with ESMTPSA id f3sm18779147wmb.1.2019.05.13.03.24.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 03:24:12 -0700 (PDT)
From:   Joe Burmeister <joe.burmeister@devtank.co.uk>
To:     linux-serial@vger.kernel.org
Cc:     Joe Burmeister <joe.burmeister@devtank.co.uk>
Subject: [PATCH] Fix external crystal register setup in max310x.
Date:   Mon, 13 May 2019 11:23:57 +0100
Message-Id: <20190513102357.13272-1-joe.burmeister@devtank.co.uk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The datasheet states:

  Bit 4: ClockEnSet the ClockEn bit high to enable an external clocking
(crystal or clock generator at XIN). Set the ClockEn bit to 0 to disable
clocking
  Bit 1: CrystalEnSet the CrystalEn bit high to enable the crystal
oscillator. When using an external clock source at XIN, CrystalEn must
be set low.

The bit 4, MAX310X_CLKSRC_EXTCLK_BIT, should be set and was not.

This was required to make the MAX3107 with an external crystal on our
board able to send or receive data.

Signed-off-by: Joe Burmeister <joe.burmeister@devtank.co.uk>
---
 drivers/tty/serial/max310x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 0fdf3a760aa0..190906ede94a 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -576,7 +576,7 @@ static int max310x_set_ref_clk(struct device *dev, struct max310x_port *s,
 	}
 
 	/* Configure clock source */
-	clksrc = xtal ? MAX310X_CLKSRC_CRYST_BIT : MAX310X_CLKSRC_EXTCLK_BIT;
+	clksrc = MAX310X_CLKSRC_EXTCLK_BIT | (xtal ? MAX310X_CLKSRC_CRYST_BIT : 0);
 
 	/* Configure PLL */
 	if (pllcfg) {
-- 
2.20.1

