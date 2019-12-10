Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78601118B09
	for <lists+linux-serial@lfdr.de>; Tue, 10 Dec 2019 15:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfLJOhQ (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 10 Dec 2019 09:37:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:51996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727345AbfLJOhQ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 Dec 2019 09:37:16 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4820520637;
        Tue, 10 Dec 2019 14:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575988635;
        bh=Htiw4KHrUr8tUURx+VNiZ7ZXYqZqdNLrXH1hUZlmBvw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j9+R5XOzhrVdFcS0cua2tqkoQtmc/F4BwJbaSD8veBmF+iaa5GGPxlbzQzXNr7pyI
         OGnjYDUBaDauVTIPjqxPY3ogsvFBrXdgG/tO1dNPAOFdzIGGvqog6qLJ/XI4LjMkpP
         Ae1GLD0gAZqsUW7ELcNcnjAJcGU9Lr+E+m0Tp5hM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Hyunki Koo <kkoos00@naver.com>,
        HYUN-KI KOO <hyunki00.koo@samsung.com>,
        Shinbeom Choi <sbeom.choi@samsung.com>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/10] tty: serial: samsung_tty: fix build warning
Date:   Tue, 10 Dec 2019 15:36:58 +0100
Message-Id: <20191210143706.3928480-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191210143706.3928480-1-gregkh@linuxfoundation.org>
References: <20191210143706.3928480-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Fix a build warning on systems that do not have CONFIG_OF enabled.

Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Hyunki Koo <kkoos00@naver.com>
Cc: HYUN-KI KOO <hyunki00.koo@samsung.com>
Cc: Shinbeom Choi <sbeom.choi@samsung.com>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/samsung_tty.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 83fd51607741..67c5a84d0a26 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -1851,7 +1851,10 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
 
 /* Device driver serial port probe */
 
+#ifdef CONFIG_OF
 static const struct of_device_id s3c24xx_uart_dt_match[];
+#endif
+
 static int probe_index;
 
 static inline struct s3c24xx_serial_drv_data *s3c24xx_get_driver_data(
-- 
2.24.0

