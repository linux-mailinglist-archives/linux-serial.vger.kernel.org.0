Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA5A12FB5F
	for <lists+linux-serial@lfdr.de>; Fri,  3 Jan 2020 18:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbgACRNR (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 3 Jan 2020 12:13:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:48566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728344AbgACRM5 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 3 Jan 2020 12:12:57 -0500
Received: from localhost.localdomain (unknown [194.230.155.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CECFA22522;
        Fri,  3 Jan 2020 17:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578071576;
        bh=dFWlPdvaj+HyEUx1AlXxNrrcbYfk6tTvTj6iCncs5hE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vYEVh82ouqc43hnKtYs0K9dsD65KilrWNTEVR5RgV2F/cBRMSzT1O/LogQv4Dasgc
         9NoK7/DOmU/VsIp2I1k+xmTheuxOu5mnW3cbCjl3NGXp4TbVfygkM8BKxuqqk8C2bx
         t2KG3WHx9w2bqgG/83b6XOhcH04eaTUxRAm/FYeg=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH 16/19] serial: samsung: Rename Exynos to lowercase
Date:   Fri,  3 Jan 2020 18:11:28 +0100
Message-Id: <20200103171131.9900-17-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200103171131.9900-1-krzk@kernel.org>
References: <20200103171131.9900-1-krzk@kernel.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Fix up inconsistent usage of upper and lowercase letters in "Exynos"
name.

"EXYNOS" is not an abbreviation but a regular trademarked name.
Therefore it should be written with lowercase letters starting with
capital letter.

The lowercase "Exynos" name is promoted by its manufacturer Samsung
Electronics Co., Ltd., in advertisement materials and on website.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/tty/serial/samsung_tty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 4762c74dbc35..73f951d65b93 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -2665,7 +2665,7 @@ OF_EARLYCON_DECLARE(s3c2440, "samsung,s3c2440-uart",
 OF_EARLYCON_DECLARE(s3c6400, "samsung,s3c6400-uart",
 			s3c2440_early_console_setup);
 
-/* S5PV210, EXYNOS */
+/* S5PV210, Exynos */
 static struct samsung_early_console_data s5pv210_early_console_data = {
 	.txfull_mask = S5PV210_UFSTAT_TXFULL,
 };
-- 
2.17.1

