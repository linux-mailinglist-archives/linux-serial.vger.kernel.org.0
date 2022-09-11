Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB15E5B4D0D
	for <lists+linux-serial@lfdr.de>; Sun, 11 Sep 2022 11:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbiIKJg6 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sun, 11 Sep 2022 05:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiIKJg5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 11 Sep 2022 05:36:57 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD9E2C641
        for <linux-serial@vger.kernel.org>; Sun, 11 Sep 2022 02:36:56 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MQPff0pTBzmVFZ;
        Sun, 11 Sep 2022 17:33:14 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 11 Sep 2022 17:36:54 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <cuigaosheng1@huawei.com>, <galak@kernel.crashing.org>
CC:     <linux-serial@vger.kernel.org>
Subject: [PATCH] tty: serial: cpm_uart: remove unused cpm_uart_nr declaration
Date:   Sun, 11 Sep 2022 17:36:54 +0800
Message-ID: <20220911093654.3222701-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

cpm_uart_nr has been removed since
commit 0b2a2e5b7747 ("cpm_uart: Remove !CONFIG_PPC_CPM_NEW_BINDING
code"), so remove it.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 drivers/tty/serial/cpm_uart/cpm_uart.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/cpm_uart/cpm_uart.h b/drivers/tty/serial/cpm_uart/cpm_uart.h
index 8c582779cf22..0577618e78c0 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart.h
+++ b/drivers/tty/serial/cpm_uart/cpm_uart.h
@@ -87,7 +87,6 @@ struct uart_cpm_port {
 	struct gpio_desc	*gpios[NUM_GPIOS];
 };
 
-extern int cpm_uart_nr;
 extern struct uart_cpm_port cpm_uart_ports[UART_NR];
 
 /* these are located in their respective files */
-- 
2.25.1

