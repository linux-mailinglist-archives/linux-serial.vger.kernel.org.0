Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCACEC014
	for <lists+linux-serial@lfdr.de>; Fri,  1 Nov 2019 09:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfKAIyp (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 1 Nov 2019 04:54:45 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34239 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbfKAIyp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 1 Nov 2019 04:54:45 -0400
Received: by mail-qt1-f196.google.com with SMTP id e14so12122851qto.1;
        Fri, 01 Nov 2019 01:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=srb0ElFij+q7mw1HtNeJS8i5fDcmZ/1MfEVFElDzt2c=;
        b=Lq9f0u/xSxlvxrO/S71aPgUQwh24EXzIhA+gMr5czvAlrRfyIQoDQ3dTLYSQuWmaFG
         CsAdPQ17dtXVMq7jZefocrbcqigg8HSgYgl2mwaCHXi5QtBViD3mijCDBMIoZGc7Xtmv
         iWwVNNeC3rXkmtyw9a+5vIgCO7gAtX8wZAVTqIu9Ko3WMZOKHpUXuzQ4xA48NMg6i/0C
         bXVjqxOO5c0Q5meHbp/LxrWe1ukJ5bRYCibyudZxFbWKBAU+0Vmnc1SbbWgoTqAzVShP
         sJf/OsCp2aQFRdS9n2Q6Mpr02VDXDlU9SXXFOWctLmujz0/qxYOnco0ld2OdFzvYQwjC
         xUhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=srb0ElFij+q7mw1HtNeJS8i5fDcmZ/1MfEVFElDzt2c=;
        b=P5C2FfYgpIoMUzlUoTGQUUqIumu9r6ula8Lzl5SQFpp2P8M8yGp973b8lpgj9inYTq
         od8PMjMA/dAXLRN4rvqmq0aDuTQnPWNuujNaRgE7rUY5m/2SaAXX45Fix4sPHgKmAXmt
         JJkwizZFFERpyb6O2IgHE5NrQM/slGq4KzDZhJLy2MaOEH0uTZfYvOKTpsbVUF1zeL5A
         98tJaIz+WbqLDM6R3K1JiGq7iw84izhVpEOtiCKq8exzLqXeplzjrS4xlheA+DYcjbOs
         iisCvdDdCJGoGdZYdmCB+v8iHVjb+/dCYmAtX6CFu+nlJq6Ax3o5Ln17XvOm9vDbAT5z
         r/gA==
X-Gm-Message-State: APjAAAV24wfe7Wbbx16ycxWoguRWPcjkchczXYHRuL58Fj3wIwyy+WPj
        GKziH+jyWzSJUBfqwJqqVlM=
X-Google-Smtp-Source: APXvYqz8P1RrTcQd5eOO322Bx2fIad1nUPqIFw7IgU59KfITvdM5IolWxX1u7jTIyv4Q1bgXvpRiyw==
X-Received: by 2002:ac8:424d:: with SMTP id r13mr9924571qtm.111.1572598484318;
        Fri, 01 Nov 2019 01:54:44 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id a18sm3653517qkc.2.2019.11.01.01.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 01:54:43 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Peter Korsgaard <jacmet@sunsite.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] tty: serial: uartlite: use clk_disable_unprepare to match clk_prepare_enable
Date:   Fri,  1 Nov 2019 16:54:33 +0800
Message-Id: <20191101085433.10399-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The driver uses clk_prepare_enable in ulite_probe but uses clk_unprepare
in ulite_remove, which does not match.
Replace clk_unprepare with clk_disable_unprepare to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/tty/serial/uartlite.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 06e79c11141d..3d245827be27 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -862,7 +862,7 @@ static int ulite_remove(struct platform_device *pdev)
 	struct uartlite_data *pdata = port->private_data;
 	int rc;
 
-	clk_unprepare(pdata->clk);
+	clk_disable_unprepare(pdata->clk);
 	rc = ulite_release(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
-- 
2.23.0

