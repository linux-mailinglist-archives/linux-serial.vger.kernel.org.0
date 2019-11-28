Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9CDD10CAED
	for <lists+linux-serial@lfdr.de>; Thu, 28 Nov 2019 15:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfK1O5w (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 28 Nov 2019 09:57:52 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36562 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbfK1O5v (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 28 Nov 2019 09:57:51 -0500
Received: by mail-lj1-f196.google.com with SMTP id k15so28858258lja.3
        for <linux-serial@vger.kernel.org>; Thu, 28 Nov 2019 06:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QBhz5rvCw4g2Ox9AwtLP/2ydNw3vwlfo4gXSav3FB44=;
        b=Fs4SgS4/1psPKfkuhI4Ny+x/2oJrTK7HBfKE4/RCaNwwy+uA8dMiNwd3beo5/zLTHw
         62oVxo+n4p+sA9/H9nbzmMU2pfSe0i3IY9PDEKXtA5Y16gW6pwQTd4R0Uiu6nNqFDpUH
         SzXhTou8vQGjVBBwFvDic+ydbfn1zpUpRjhKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QBhz5rvCw4g2Ox9AwtLP/2ydNw3vwlfo4gXSav3FB44=;
        b=qSlgndZ+SLL2B6YvstF9LoGVu107bmonL/jfnqpqYDiLs6VKdG3ZFsBfrI0oeo0ToW
         Ix/jRWkY60eW2v3F1QiP98dC61rR9+VEQ41GDWBdnHvI1gpQmImjUuLf74sdMOqhVXnM
         h2tGLWRVEbk8F0h6dwR2Sx9sN1H5ZQT4+ZZ/8SYp8F7pDmge47w2hva6a+r5T5RX3+t2
         OUt/ab5PTxG/BkIkKfZ7kGs5d7PdhvlOaa6H8Aq9NMkrAwNvizuxLUZzMfLDnMtr9/t1
         3/3gvKoCdTxzs2MCPpkVo2nPXn+EBW5yxwS58kA4gS+SY3VuKe/8S/4g04AnhgoP1MIR
         A2RA==
X-Gm-Message-State: APjAAAVLz0DxevNkkZuExMGKHmBgdKHaLec7+PYp/x6TU3bGKirRZppG
        za0hcu+MMGO3GUPdbXaVXr5yJQ==
X-Google-Smtp-Source: APXvYqx99pjU5nTC/rq9MmsMvdS7IjR/57AJ+W7tuU3iN95pO3rx6CAJcCzrdDDJbnd7jwEkPdc8CQ==
X-Received: by 2002:a2e:888b:: with SMTP id k11mr10315128lji.87.1574953068992;
        Thu, 28 Nov 2019 06:57:48 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id u2sm2456803lfl.18.2019.11.28.06.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 06:57:48 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-serial@vger.kernel.org
Subject: [PATCH v6 33/49] serial: ucc_uart: limit brg-frequency workaround to PPC32
Date:   Thu, 28 Nov 2019 15:55:38 +0100
Message-Id: <20191128145554.1297-34-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
References: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

According to Timur Tabi

    This bug in older U-Boots is definitely PowerPC-specific

So before allowing this driver to be built for platforms other than
PPC32, make sure that we don't accept malformed device trees on those
other platforms.

Suggested-by: Timur Tabi <timur@kernel.org>
Reviewed-by: Timur Tabi <timur@kernel.org>
Acked-by: Timur Tabi <timur@kernel.org>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/tty/serial/ucc_uart.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index c055abf4c919..9436b93d5cfa 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -1392,6 +1392,13 @@ static int ucc_uart_probe(struct platform_device *ofdev)
 	if (val)
 		qe_port->port.uartclk = val;
 	else {
+		if (!IS_ENABLED(CONFIG_PPC32)) {
+			dev_err(&ofdev->dev,
+				"invalid brg-frequency in device tree\n");
+			ret = -EINVAL;
+			goto out_np;
+		}
+
 		/*
 		 * Older versions of U-Boot do not initialize the brg-frequency
 		 * property, so in this case we assume the BRG frequency is
-- 
2.23.0

