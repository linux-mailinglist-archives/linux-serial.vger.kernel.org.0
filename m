Return-Path: <linux-serial+bounces-8705-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F253A7797E
	for <lists+linux-serial@lfdr.de>; Tue,  1 Apr 2025 13:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76BF53ABBAB
	for <lists+linux-serial@lfdr.de>; Tue,  1 Apr 2025 11:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531C11F1539;
	Tue,  1 Apr 2025 11:24:33 +0000 (UTC)
X-Original-To: linux-serial@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83ADA1E5B7E;
	Tue,  1 Apr 2025 11:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743506673; cv=none; b=VQhFcM2ST+2gzh8PpduLU82B6hRKOdDtHvD3psbEnzx1owpsQJwA+bw8zGwKzjVpXBDdOKW2veza4IFmLtlItQjxsgayHUCuqvvOIt2z5dAKj+R4pL6EWn7M4MFA1KqyFGGt2g21Pdma0vzot2edpkoXVlY3DyHF5fPueWel5YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743506673; c=relaxed/simple;
	bh=UsD9qWNxIgPqDQS0c3HOUGKchbkKSEF4HqzGD+V6Zvk=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=NtG3Xk3iRWt7escbQ9PTcY8fXG7tySPIp/IwAls1vwN+FcphiyzG9WvJbjdxviy0uk4Us3t0oYg/0uf/htI66irC7EVZMs3MSiiQnmxz0nLoLv7pxnoRCwrsfm/eHCOd/GBqO3M6z3v0zdQCHIFsJvPo6g5uFXamAKLNgF0cb1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ZRlyC1683z8R040;
	Tue,  1 Apr 2025 19:24:19 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 531BOGUt076517;
	Tue, 1 Apr 2025 19:24:16 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 1 Apr 2025 19:24:20 +0800 (CST)
Date: Tue, 1 Apr 2025 19:24:20 +0800 (CST)
X-Zmail-TransId: 2af967ebcce402b-8dfac
X-Mailer: Zmail v1.0
Message-ID: <20250401192420169tLRsDis5R0RrVmdFnFuS9@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <alim.akhtar@samsung.com>
Cc: <yang.yang29@zte.com.cn>, <xu.xin16@zte.com.cn>, <ye.xingchen@zte.com.cn>,
        <krzk@kernel.org>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <jiang.peng9@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIXSB0dHk6IHNlcmlhbDogc2Ftc3VuZzogRml4IHBvdGVudGlhbCBidWZmZXIgb3ZlcmZsb3cgaW7CoGNsa25hbWU=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 531BOGUt076517
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67EBCCE3.000/4ZRlyC1683z8R040

From: Peng Jiang <jiang.peng9@zte.com.cn>

Compiling the kernel with gcc12.3 W=1 produces a warning:
/drivers/tty/serial/samsung_tty.c: In function
's3c24xx_serial_set_termios':

/drivers/tty/serial/samsung_tty.c:1392:48:
warning: '%d' directive writing between 1 and 3 bytes
into a region of size 2 [-Wformat-overflow=]
 1392 |  sprintf(clkname, "clk_uart_baud%d", cnt);
      |                    ^~

In function 's3c24xx_serial_getclk',
    inlined from 's3c24xx_serial_set_termios'
at ./drivers/tty/serial/samsung_tty.c:1493:9:

/drivers/tty/serial/samsung_tty.c:1392:34:
note: directive argument in the range [0, 254]
 1392 |  sprintf(clkname, "clk_uart_baud%d", cnt);
      |                    ^~~~~~~~~~~~~~~~~

/drivers/tty/serial/samsung_tty.c:1392:17:
note: 'sprintf' output between 15 and 17 bytes
into a destination of size 15

 1392 |  sprintf(clkname, "clk_uart_baud%d", cnt);
      |                   ^~~~~~~~~~~~~~~~~

The compiler warned about a potential buffer overflow in the
`s3c24xx_serial_set_termios` function due to the use of `sprintf` which
could write more bytes than the allocated size of the `clkname` buffer.
This could lead to undefined behavior and potential security risks.

To reproduce the issue before applying the patch:
CONFIG_SERIAL_SAMSUNG=y
make vmlinux ARCH=arm64 CROSS_COMPILE=aarch64-linux- W=1

To resolve this issue, we have increased the buffer size for `clkname`
to ensure it can accommodate the longest possible string generated by
the formatting operation. Additionally, we have replaced `sprintf` with
`snprintf` to ensure that the function does not write beyond the end of
the buffer, thus preventing any potential overflow.

Signed-off-by: Peng Jiang <jiang.peng9@zte.com.cn>
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
 drivers/tty/serial/samsung_tty.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 210fff7164c1..5a0005033afa 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -1339,7 +1339,7 @@ static void s3c24xx_serial_pm(struct uart_port *port, unsigned int level,
  *
  */

-#define MAX_CLK_NAME_LENGTH 15
+#define MAX_CLK_NAME_LENGTH 18

 static inline u8 s3c24xx_serial_getsource(struct uart_port *port)
 {
@@ -1389,7 +1389,7 @@ static unsigned int s3c24xx_serial_getclk(struct s3c24xx_uart_port *ourport,
 			!(ourport->cfg->clk_sel & (1 << cnt)))
 			continue;

-		sprintf(clkname, "clk_uart_baud%d", cnt);
+		snprintf(clkname, sizeof(clkname), "clk_uart_baud%d", cnt);
 		clk = clk_get(ourport->port.dev, clkname);
 		if (IS_ERR(clk))
 			continue;
@@ -1787,7 +1787,7 @@ static int s3c24xx_serial_enable_baudclk(struct s3c24xx_uart_port *ourport)
 		if (!(clk_sel & (1 << clk_num)))
 			continue;

-		sprintf(clk_name, "clk_uart_baud%d", clk_num);
+		snprintf(clk_name, sizeof(clk_name), "clk_uart_baud%d", clk_num);
 		clk = clk_get(dev, clk_name);
 		if (IS_ERR(clk))
 			continue;
@@ -2335,7 +2335,7 @@ s3c24xx_serial_get_options(struct uart_port *port, int *baud,
 		/* now calculate the baud rate */

 		clk_sel = s3c24xx_serial_getsource(port);
-		sprintf(clk_name, "clk_uart_baud%d", clk_sel);
+		snprintf(clk_name, sizeof(clk_name), "clk_uart_baud%d", clk_sel);

 		clk = clk_get(port->dev, clk_name);
 		if (!IS_ERR(clk))
-- 
2.25.1

