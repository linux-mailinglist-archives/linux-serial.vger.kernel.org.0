Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F3859BF4A
	for <lists+linux-serial@lfdr.de>; Mon, 22 Aug 2022 14:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234943AbiHVMJw (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 22 Aug 2022 08:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234941AbiHVMJt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Aug 2022 08:09:49 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AACA3A485
        for <linux-serial@vger.kernel.org>; Mon, 22 Aug 2022 05:09:47 -0700 (PDT)
X-QQ-mid: bizesmtp77t1661170150tizb7q9p
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 22 Aug 2022 20:09:08 +0800 (CST)
X-QQ-SSF: 01000000002000C0D000B00A0000000
X-QQ-FEAT: J5JfekO1WsjqZ9Csd1xMP8RiLXNCg6N05x9timq6hi6m6FxQ7t81A1rQPp8mO
        pp0j2b89NGZLsTJsSEz2j+fbfVZ2IynUbhPo0xvT38blLo3I8iZWr/MPsuWMqtLKZs4kyqv
        mw/3+OULHPpVGQk2SHg6k0uS+8FE0ZCbgTZY3DMXoKYDmHSoCHIgru2RrPTPIKHoIb/wh2+
        FrD5pVGNwS9epJXtOvUF4aaEhLXd3EcU1vv0N7dNnCcfO+E56UFiLqhwnPk8AGmFcg91xk3
        vr7h/EUdFSx5L+P/v3OxBwVJKpH+KVTmhrHbFvO6Cszy6PXmdBY6Xi42u2A9XkCkdawHlsD
        /flw6msX6EyQi159wsGsxqj0mukGWbWOd4Y6XUYIyScYWEKGiEn5v7z5IAXqiZFZHPbxt2W
        jwZYAkypJPs=
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] tty/serial: fix repeated words in comments
Date:   Mon, 22 Aug 2022 20:09:01 +0800
Message-Id: <20220822120901.17913-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: Yes, score=6.5 required=5.0 tests=BAYES_00,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_MSPIKE_H2,RCVD_IN_PBL,RCVD_IN_SBL_CSS,
        RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  1.3 RCVD_IN_BL_SPAMCOP_NET RBL: Received via a relay in
        *      bl.spamcop.net
        *      [Blocked - see <https://www.spamcop.net/bl.shtml?43.154.54.12>]
        *  3.3 RCVD_IN_PBL RBL: Received via a relay in Spamhaus PBL
        *      [43.154.54.12 listed in zen.spamhaus.org]
        *  0.4 RCVD_IN_XBL RBL: Received via a relay in Spamhaus XBL
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        * -0.0 RCVD_IN_MSPIKE_H2 RBL: Average reputation (+2)
        *      [43.154.54.12 listed in wl.mailspike.net]
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

 Delete the redundant word 'power'.
 Delete the redundant word 'long'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/tty/serial/imx.c         | 2 +-
 drivers/tty/serial/samsung_tty.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 30edb35a6a15..c72e0dad3544 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2069,7 +2069,7 @@ imx_uart_console_get_options(struct imx_port *sport, int *baud,
 		{	/*
 			 * The next code provides exact computation of
 			 *   baud_raw = round(((uartclk/16) * (ubir + 1)) / (ubmr + 1))
-			 * without need of float support or long long division,
+			 * without need of float support or long division,
 			 * which would be required to prevent 32bit arithmetic overflow
 			 */
 			unsigned int mul = ubir + 1;
diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index d5ca904def34..af799b79ba25 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -1353,7 +1353,7 @@ static int apple_s5l_serial_startup(struct uart_port *port)
 	return ret;
 }
 
-/* power power management control */
+/* power management control */
 
 static void s3c24xx_serial_pm(struct uart_port *port, unsigned int level,
 			      unsigned int old)
-- 
2.36.1

