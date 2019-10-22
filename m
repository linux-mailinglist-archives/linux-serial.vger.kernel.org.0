Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A72EADFCD9
	for <lists+linux-serial@lfdr.de>; Tue, 22 Oct 2019 06:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730635AbfJVEt4 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 22 Oct 2019 00:49:56 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41927 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfJVEt4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 22 Oct 2019 00:49:56 -0400
Received: by mail-pg1-f194.google.com with SMTP id t3so9161937pga.8;
        Mon, 21 Oct 2019 21:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dwPVVSsRTIc/vGUwpb/molMO8vR63ypSqF4q/acUgcE=;
        b=p/6oRtIkFlylz8XixsHNiYW01JXqb8njxHlTCNkha+r39X0SYaxuqrLiNi2e4xfO8P
         XqHqgkFt2pXAdVGbspK25AmOaI2wrj30SIRL9UqoN1T0iV7muaCYXz6ybbQBA4DBJ0NQ
         YqeFA0hDEAdSryLxNPPhlvdC+SmeCkLUh3xvJ0pjGvCEalJ+fe5viGI18rK2v5P4tkJ2
         M8HfmUqElpmnFVhYgOua21De6F+n2mC4jgTvxGOKsYM2UOnJxv56QeU9DWU+dbrwhWN4
         NpxcOMQxbkzNniJirlI2QLAm3HrtuzoK/Ywd0cEIfy5yKSfyFJbqH1YT2Fx+sMiEELTE
         HISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dwPVVSsRTIc/vGUwpb/molMO8vR63ypSqF4q/acUgcE=;
        b=AnjPcXqmDm3OBKrKZXPMwrLORb3kKm7kihHmzWrHmsZgxy5jEUalaVY65D1AkWmQZy
         NWD7BtfW63Tg6CUy95fLsuKJI9D8+h3zoC566lxiOjb7N04TSM+4WHEpiLjpra0QOB9y
         IM8ZZ9pJnoajoZQWYRxr/Q1XnCNm31u5iQ6qpcPAnfw9sjEU1x6O8g/Hkm/w3Q5abEGL
         c8If/kgWMDSxbYAmLmjHYk4Vi9vFji3rBgyz7myx8EqqaYcofGyFD5sFQks8iuOZTsXY
         Fwh4B6JkeVexyGDQ7tXzUZSDblon5zz8h0SOmDIzv0BpSpucrDdT6aUZWflD1PD/0BzR
         ZuWw==
X-Gm-Message-State: APjAAAVJeQO+BHbIS35uchAhofPlyPPnBrNDTbEfM+oneLrAiFkoKYJi
        ZRM145oQ6PqykvprMREp0AiFVUpv
X-Google-Smtp-Source: APXvYqxoaVzMPiuNWEwDVDMKBsqiOeRSQai7ps9e7JknsUcYsVtioY1GmYEn+0AFVkJCw/jrWD0Kjg==
X-Received: by 2002:a17:90a:cf84:: with SMTP id i4mr2161337pju.66.1571719793363;
        Mon, 21 Oct 2019 21:49:53 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id l24sm17810727pff.151.2019.10.21.21.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 21:49:52 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-serial@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Stefan Agner <stefan@agner.ch>,
        Chris Healy <cphealy@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: serial: lpuart: Drop unsupported RS485 bindings
Date:   Mon, 21 Oct 2019 21:49:40 -0700
Message-Id: <20191022044940.15119-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

LPUART driver does not support 'rs485-rts-delay' or
'rs485-rx-during-tx' properties. Remove them.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-imx@nxp.com
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 Documentation/devicetree/bindings/serial/fsl-lpuart.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.txt b/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
index 3495eee81d53..f5f5ab0fd14e 100644
--- a/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
+++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
@@ -21,8 +21,7 @@ Required properties:
 Optional properties:
 - dmas: A list of two dma specifiers, one for each entry in dma-names.
 - dma-names: should contain "tx" and "rx".
-- rs485-rts-delay, rs485-rts-active-low, rs485-rx-during-tx,
-  linux,rs485-enabled-at-boot-time: see rs485.txt
+- rs485-rts-active-low, linux,rs485-enabled-at-boot-time: see rs485.txt
 
 Note: Optional properties for DMA support. Write them both or both not.
 
-- 
2.21.0

