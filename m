Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03FE7600631
	for <lists+linux-serial@lfdr.de>; Mon, 17 Oct 2022 07:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbiJQFRt (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 17 Oct 2022 01:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiJQFRr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 Oct 2022 01:17:47 -0400
Received: from gw.atmark-techno.com (gw.atmark-techno.com [13.115.124.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5791352E68
        for <linux-serial@vger.kernel.org>; Sun, 16 Oct 2022 22:17:46 -0700 (PDT)
Received: from gw.atmark-techno.com (localhost [127.0.0.1])
        by gw.atmark-techno.com (Postfix) with ESMTP id C3E6E60110
        for <linux-serial@vger.kernel.org>; Mon, 17 Oct 2022 14:17:44 +0900 (JST)
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
        by gw.atmark-techno.com (Postfix) with ESMTPS id CAFDA6010E
        for <linux-serial@vger.kernel.org>; Mon, 17 Oct 2022 14:17:43 +0900 (JST)
Received: by mail-pj1-f69.google.com with SMTP id gz13-20020a17090b0ecd00b0020d67a4e6e5so3907504pjb.3
        for <linux-serial@vger.kernel.org>; Sun, 16 Oct 2022 22:17:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Pp3mv5zEECPTh+XggQnmSxFUiRE4VZhQ0bJwEeH+zE=;
        b=UBJGhCRMAIEZ1Ypq4yHn3Hz5J+5HXeyolC573tbfS5MjnnHn5nbGLdVVkUBk363WAR
         peWIlaLA957gQjKyIXQ58WXvI96hVz0quJhtFlHrgS/I8TEp794BvgWaWPbAMtx04FaC
         XSVww6l6VriV8dkSpqfKZikFvjmOWR9L2NlbPk7XI2UGx9WAF9Uo955L7d/p8TXsIXmo
         GjdaiHfTszXSPuxBInEKpLBdBnwaJjO5hcZtQjsMKqQVvToo5MuXPQUiI6Sx2Zah37tZ
         Qd3Rv1xr7jaHAJF3o/eIkeEa92ly0ZGeifKbgt6+fyOEAUDwz887tyfAdUYtWO8gXctd
         aQwA==
X-Gm-Message-State: ACrzQf09s1TQ69F8m7u/t4WLb6JgSIuIj5nekH7CvZ6sX7KSoJy/B6Kj
        G7Uuu7ghV7d3EGMHcbq//bUx3s595qIgu9E6uXOuJoz7YfnBDfzP31BixYowl4kTTXP4IJoPox8
        gau5FHOAC6V9KIpCMxXt+RFi8DJW+
X-Received: by 2002:a17:902:b78c:b0:17a:ec9:51da with SMTP id e12-20020a170902b78c00b0017a0ec951damr10230471pls.159.1665983862815;
        Sun, 16 Oct 2022 22:17:42 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6at85qqdvWs7B6wyWG22HBq2KBhv6R7Z7rNB5rXnoxJl/PzWu9RMkB0FIMg7o4sXMWGxJOXA==
X-Received: by 2002:a17:902:b78c:b0:17a:ec9:51da with SMTP id e12-20020a170902b78c00b0017a0ec951damr10230458pls.159.1665983862538;
        Sun, 16 Oct 2022 22:17:42 -0700 (PDT)
Received: from pc-0115 (145.82.198.104.bc.googleusercontent.com. [104.198.82.145])
        by smtp.gmail.com with ESMTPSA id m14-20020a17090a668e00b00203ab277966sm8787591pjj.7.2022.10.16.22.17.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Oct 2022 22:17:42 -0700 (PDT)
Received: from martinet by pc-0115 with local (Exim 4.96)
        (envelope-from <martinet@pc-0115>)
        id 1okIVP-000DSY-2W;
        Mon, 17 Oct 2022 14:17:39 +0900
From:   Dominique Martinet <dominique.martinet@atmark-techno.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Wunner <lukas@wunner.de>, stable@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Roosen Henri <Henri.Roosen@ginzinger.com>,
        linux-serial@vger.kernel.org,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Daisuke Mizobuchi <mizo@atmark-techno.com>,
        Dominique Martinet <dominique.martinet@atmark-techno.com>
Subject: [PATCH 5.10 v2 1/2] serial: core: move RS485 configuration tasks from drivers into core
Date:   Mon, 17 Oct 2022 14:17:36 +0900
Message-Id: <20221017051737.51727-1-dominique.martinet@atmark-techno.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Lino Sanfilippo <LinoSanfilippo@gmx.de>

Several drivers that support setting the RS485 configuration via userspace
implement one or more of the following tasks:

- in case of an invalid RTS configuration (both RTS after send and RTS on
  send set or both unset) fall back to enable RTS on send and disable RTS
  after send

- nullify the padding field of the returned serial_rs485 struct

- copy the configuration into the uart port struct

- limit RTS delays to 100 ms

Move these tasks into the serial core to make them generic and to provide
a consistent behaviour among all drivers.

Signed-off-by: Lino Sanfilippo <LinoSanfilippo@gmx.de>
Link: https://lore.kernel.org/r/20220410104642.32195-2-LinoSanfilippo@gmx.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ Upstream commit 0ed12afa5655512ee418047fb3546d229df20aa1 ]
Signed-off-by: Daisuke Mizobuchi <mizo@atmark-techno.com>
Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
---
Follow-up of https://lkml.kernel.org/r/20221017013807.34614-1-dominique.martinet@atmark-techno.com

v2: identical to v1

 drivers/tty/serial/serial_core.c | 33 ++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index b578f7090b63..6cc909d44a81 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -42,6 +42,11 @@ static struct lock_class_key port_lock_key;
 
 #define HIGH_BITS_OFFSET	((sizeof(long)-sizeof(int))*8)
 
+/*
+ * Max time with active RTS before/after data is sent.
+ */
+#define RS485_MAX_RTS_DELAY	100 /* msecs */
+
 static void uart_change_speed(struct tty_struct *tty, struct uart_state *state,
 					struct ktermios *old_termios);
 static void uart_wait_until_sent(struct tty_struct *tty, int timeout);
@@ -1326,8 +1331,36 @@ static int uart_set_rs485_config(struct uart_port *port,
 	if (copy_from_user(&rs485, rs485_user, sizeof(*rs485_user)))
 		return -EFAULT;
 
+	/* pick sane settings if the user hasn't */
+	if (!(rs485.flags & SER_RS485_RTS_ON_SEND) ==
+	    !(rs485.flags & SER_RS485_RTS_AFTER_SEND)) {
+		dev_warn_ratelimited(port->dev,
+			"%s (%d): invalid RTS setting, using RTS_ON_SEND instead\n",
+			port->name, port->line);
+		rs485.flags |= SER_RS485_RTS_ON_SEND;
+		rs485.flags &= ~SER_RS485_RTS_AFTER_SEND;
+	}
+
+	if (rs485.delay_rts_before_send > RS485_MAX_RTS_DELAY) {
+		rs485.delay_rts_before_send = RS485_MAX_RTS_DELAY;
+		dev_warn_ratelimited(port->dev,
+			"%s (%d): RTS delay before sending clamped to %u ms\n",
+			port->name, port->line, rs485.delay_rts_before_send);
+	}
+
+	if (rs485.delay_rts_after_send > RS485_MAX_RTS_DELAY) {
+		rs485.delay_rts_after_send = RS485_MAX_RTS_DELAY;
+		dev_warn_ratelimited(port->dev,
+			"%s (%d): RTS delay after sending clamped to %u ms\n",
+			port->name, port->line, rs485.delay_rts_after_send);
+	}
+	/* Return clean padding area to userspace */
+	memset(rs485.padding, 0, sizeof(rs485.padding));
+
 	spin_lock_irqsave(&port->lock, flags);
 	ret = port->rs485_config(port, &rs485);
+	if (!ret)
+		port->rs485 = rs485;
 	spin_unlock_irqrestore(&port->lock, flags);
 	if (ret)
 		return ret;
-- 
2.35.1


