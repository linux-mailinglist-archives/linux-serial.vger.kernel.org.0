Return-Path: <linux-serial+bounces-6710-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2009BE694
	for <lists+linux-serial@lfdr.de>; Wed,  6 Nov 2024 13:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DF691F25CB8
	for <lists+linux-serial@lfdr.de>; Wed,  6 Nov 2024 12:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC511DFE37;
	Wed,  6 Nov 2024 12:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="cJIW0mLq"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946BB1DF74E
	for <linux-serial@vger.kernel.org>; Wed,  6 Nov 2024 12:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730894499; cv=none; b=cvmaP4Oyo5TRmlqOxEB0a3h5z0jNiOqP7jXhtSVDaeHiKkOx83tfcxYLDwxG7b4RDTl4PVXzN6yXr2z2aEQ7m7GuwkrQt4QTdraOUrZjVgPSOFJklGgZIUSYgICb8yE0NDJmnespU8hqHDoPZdVG6xVlw27iJ0YDpxkF+7/I/WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730894499; c=relaxed/simple;
	bh=15y5NJJUa1+Ljo2j6VmXklAxf4e4qGswvP0p5ryi2jQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dO1QYUstrXbMUQSjuCUdAf2XKg6OZJci/ME944XWcSEkBdthtPqTY/cu5xzOd31u5ekb3f3vQpvxnhUXS9BYQXd0u2IsMNQfAFvIgOwBWAIdrqioUgsD535iTmV/nni8XZy3FjKVbx0FEnY4uKALqIu7sBzS0mU2++dj9dmj510=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=cJIW0mLq; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f75c56f16aso60677721fa.0
        for <linux-serial@vger.kernel.org>; Wed, 06 Nov 2024 04:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1730894495; x=1731499295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+mBCBo66bw/9iI5Hy/6whocckJK37iPQ5dEvf3mSi0=;
        b=cJIW0mLqg4VGo4VfL6i3wInJku4RcrOt1JZa/Kkb6XA0ZMPCwDAkZuqbaMGmtGStq7
         jTOFCRdVBttT0knJQ75XBJ/1GjJb4lf5zRDfUpfWlFFhcVOTRXTgHZgab6LlHB6OpWG9
         bqBqAHBy+Hqo3ZT15NbsS+lgA/rPSOGVX9YkdQNHRoLmxs/wqkM2yPFwxAWT0njIQXj+
         MUb12lNSO5UAmp9TknUQjYTmwEmhEsG6+d3VV45NelGV0lrYdU0RTCDuTSxFPct1LD3i
         mxYPPxnFoAxJGrVpp7WmrhXWnioaGwk9efnB+zPFnk5q4l7F6Cq92PJSa3JowOtGZMW9
         Gxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730894495; x=1731499295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s+mBCBo66bw/9iI5Hy/6whocckJK37iPQ5dEvf3mSi0=;
        b=qNb9GXIf5jIq2kq4d2TiStkjvSiqx9TFGVzgoA+NBtKQJ+VoXaAClchAL/JzfmLSZ7
         IXre3GjZXX8nw7w8uUFqNxIAeDCvZCxa0bulYF6uluhqW4PAu1KewRzPowH9Iu+CBGax
         V95nqhyE4t92ojwQq4obsaD+FeEXQ/JNPEvk6j5Ros1TCZFd8yGX/lqfg95/fgv8cERC
         J1PJdUIxQl4Zy1xPPsQzplZ22cQbwjLbqGgrUNc/KNg2zYOAplVvtEs/oYvY3CDWLd9K
         gu0TQtlkNyx33yJCRBQ91nhm2NpZSJvNpwSxfKMKYQTN06q96cZY/NhqBIJtRJwnIA0X
         Zb8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXzTHXsrcv9m/w61WR/VLxXeiWFx6fzv3ZJouWoWLB6DI8mrltawWEXN33qnhOyLUYXyocSNWX23r3U0bw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF1dEDa9JEYiKtKtS4PWrN5tpr82PFRuuoztrbuqj+it4eGl+U
	IeJcuBBUZyBWyyInfNB8/7vdXNF82Xj3OGyiHGzMZSCRxNVPLufTJKPwTuJfNRo=
X-Google-Smtp-Source: AGHT+IEgZNw14uc4vk+ZnHTPI7ALllPV0JWZSlCJwgecPv++T4OGVwPAYuvtTxG35blsJlYuNeZV3A==
X-Received: by 2002:a05:651c:154b:b0:2fb:6394:d6bd with SMTP id 38308e7fff4ca-2fdec4e750emr94353991fa.12.1730894495197;
        Wed, 06 Nov 2024 04:01:35 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cee6afe528sm2697984a12.55.2024.11.06.04.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 04:01:34 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	magnus.damm@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	p.zabel@pengutronix.de,
	lethal@linux-sh.org,
	g.liakhovetski@gmx.de,
	ysato@users.sourceforge.jp,
	ulrich.hecht+renesas@gmail.com
Cc: claudiu.beznea@tuxon.dev,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/9] serial: sh-sci: Clean sci_ports[0] after at earlycon exit
Date: Wed,  6 Nov 2024 14:01:12 +0200
Message-Id: <20241106120118.1719888-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241106120118.1719888-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241106120118.1719888-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The early_console_setup() function initializes the sci_ports[0].port with
an object of type struct uart_port obtained from the object of type
struct earlycon_device received as argument by the early_console_setup().

It may happen that later, when the rest of the serial ports are probed,
the serial port that was used as earlycon (e.g., port A) to be mapped to a
different position in sci_ports[] and the slot 0 to be used by a different
serial port (e.g., port B), as follows:

sci_ports[0] = port A
sci_ports[X] = port B

In this case, the new port mapped at index zero will have associated data
that was used for earlycon.

In case this happens, after Linux boot, any access to the serial port that
maps on sci_ports[0] (port A) will block the serial port that was used as
earlycon (port B).

To fix this, add early_console_exit() that clean the sci_ports[0] at
earlycon exit time.

Fixes: 0b0cced19ab1 ("serial: sh-sci: Add CONFIG_SERIAL_EARLYCON support")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 8e2d534401fa..2f8188bdb251 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3546,6 +3546,32 @@ sh_early_platform_init_buffer("earlyprintk", &sci_driver,
 #ifdef CONFIG_SERIAL_SH_SCI_EARLYCON
 static struct plat_sci_port port_cfg __initdata;
 
+static int early_console_exit(struct console *co)
+{
+	struct sci_port *sci_port = &sci_ports[0];
+	struct uart_port *port = &sci_port->port;
+	unsigned long flags;
+	int locked = 1;
+
+	if (port->sysrq)
+		locked = 0;
+	else if (oops_in_progress)
+		locked = uart_port_trylock_irqsave(port, &flags);
+	else
+		uart_port_lock_irqsave(port, &flags);
+
+	/*
+	 * Clean the slot used by earlycon. A new SCI device might
+	 * map to this slot.
+	 */
+	memset(sci_ports, 0, sizeof(*sci_port));
+
+	if (locked)
+		uart_port_unlock_irqrestore(port, flags);
+
+	return 0;
+}
+
 static int __init early_console_setup(struct earlycon_device *device,
 				      int type)
 {
@@ -3562,6 +3588,8 @@ static int __init early_console_setup(struct earlycon_device *device,
 		       SCSCR_RE | SCSCR_TE | port_cfg.scscr);
 
 	device->con->write = serial_console_write;
+	device->con->exit = early_console_exit;
+
 	return 0;
 }
 static int __init sci_early_console_setup(struct earlycon_device *device,
-- 
2.39.2


