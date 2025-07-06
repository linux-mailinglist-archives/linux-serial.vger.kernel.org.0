Return-Path: <linux-serial+bounces-10092-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA29AF619C
	for <lists+linux-serial@lfdr.de>; Wed,  2 Jul 2025 20:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6A941C2862A
	for <lists+linux-serial@lfdr.de>; Wed,  2 Jul 2025 18:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5032F6F86;
	Wed,  2 Jul 2025 18:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="WgWn0EPl"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B75E315523
	for <linux-serial@vger.kernel.org>; Wed,  2 Jul 2025 18:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751481602; cv=none; b=In1sVV0+/D+gOmxi2sRG4PY7QF3ynqPFAKj12eZkl5Hj4WzsumswJZaM+2l75zaFB+Ey5/bgrQE/6crbFXNw0vro13B97emEk2skwcbMjiQyZRNTeG0BTg1gZ1QyFqJVviyIYcZd8f4uGPXohIyJd9Oi1jOoLUdbLMF6y8ziuR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751481602; c=relaxed/simple;
	bh=ufOVlqAt3uI1zr6bmRH+USzQKY4G3SQiQndGTVQ2HBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qmHOnLCsALy8tPpN/9/JOh0rzEEpQc2DyWkE5AS4ZimpTH+zbjB/3qF2otFdIfnZPEUzg6VYMznquWQa/BvHz+28nM09+gl5k6D5uIIL1jsbnB27QKWiZdnEvi8mCcVVJGUWrY3wEdSV0NPcVse34iYjtqMZm87ItBW6+BbZby8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=WgWn0EPl; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-23636167b30so45081445ad.1
        for <linux-serial@vger.kernel.org>; Wed, 02 Jul 2025 11:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1751481600; x=1752086400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7JBF3cwldevDNRr7SqXWBuHyX5mq5fUVy8++B9pNBuc=;
        b=WgWn0EPl4z9gSviEI9KEWNs4eztRqIE0YqYE8ajxkBtXvP3Wf0dGq6hnqL2G95//LY
         cpis32hI+BvVHFzMxWYvFqxhCvm90IA8ceAUBEEStj8fr0Qhoh5E2owuvpCeulrgCmAS
         zwsRsqtxi2kOVnTXmZgN53Tvei9GjOh6QYSOTjOK5pUOYU2jLGZujsXZBio26anN4Bhr
         1GwyzQwQ0vymmFyzaOD6AFnYJjpPd5iTduf6u68XBY8J1c8HJM55khjJ1ysW+AgV6bCk
         Jq9QFyMIeyC8mDdL2TgAzuq7Jb948wUtdxvyxN838xnWYYVx82Ru1LT4jHiJsYd1q0AZ
         zAiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751481600; x=1752086400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7JBF3cwldevDNRr7SqXWBuHyX5mq5fUVy8++B9pNBuc=;
        b=HcKndC+vspjeA14eKzodljjiCZroIHRCS4o3jvEvuC+eQWxGuOYh8t5f+eNaPQd3XX
         WXsS5/zOMsFboAkif3lSS7CgOodYx5+hJzo0/XFQ1kzNu9ZkaMDmOLumausbl9vpyjI7
         1yk0IztpM3tD+MunxBT31JTA57iE9RtZFSK2O+5DEhyzu4yrcoX1JCofG5fHzxLYYkqE
         GrLswxAFTTudxfIeXBWfPWPffSVJU7saXE7xM4sL+YqNKZabpVoHSyUFwzTMqX6Kxwkv
         3pnf57y9BBXIEmD1w7nJeBimp8paiO6M4LO+R7GZTXpu7P+LckF1BunUUzZm+28ElWkC
         kquw==
X-Forwarded-Encrypted: i=1; AJvYcCXiQHNbB3InWMHdUC57fxwaDXNfceAJ6tlNa2lOxPhPZ79GZENJ39YXhlY7SX7VIL4+goikeLdjLpwFB1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YygpxMNQVhkknRlg6Rtyrg3hR2EEq9tzR10O5eEIhXuCetQLx7j
	wpY63cAgp1/YiKfJF2CCJ4D0e1VFwFVjORxnAvwI0s5bMyW41k3D3PAhs5uTfcGPUeY=
X-Gm-Gg: ASbGncvo/r0SVz52Ilu85lY2jMCJdTItaGxM/4SarTARYwaR2bLpCeVEtRx3E5+G0/b
	Zmr2zEDyQAsO0je4ztpdAKkqfOOS0wu91qosNizLsW3loOUyXkUjRxecJf3bNI7jMbfSS6JPlwP
	YtAITQ72yDOl9WMMMkDnlDDB3vODf1gIMbMpxz9eMbEXXlzCTKmMw246WRfYS/d4pLYzA6lpZP+
	a2HpiQul+0tBEDNnXKyTTiRbTRgPs461NGmMhDbfc/u/uCO5BfKqJBGWtNBnF9gXdQ9l8cSQl3/
	dqSYxRIgno1eu2NIvJpZaL7oIOYuH2g8Wp3QQBuge/RAluKjbRpftQgrr10Zuux8XFpNaYYwnk0
	sb0W0/JpQpD2qm2UmBBKONZTKVTRqOFS+9Q==
X-Google-Smtp-Source: AGHT+IHb5I71nz8YJIIhY789TZ8DXVSueuTS+Cp9Lta7fg4qamQr3ZvWLBc2y6VdIoWci5wbIzzqcQ==
X-Received: by 2002:a17:903:3204:b0:235:c9a7:d5fb with SMTP id d9443c01a7336-23c7965da40mr5474425ad.16.1751481599876;
        Wed, 02 Jul 2025 11:39:59 -0700 (PDT)
Received: from fedora (cpe-94-253-164-144.zg.cable.xnet.hr. [94.253.164.144])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23acb2f39bdsm143034195ad.80.2025.07.02.11.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 11:39:59 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: linux@armlinux.org.uk,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	catalin.marinas@arm.com,
	will@kernel.org,
	olivia@selenic.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	vkoul@kernel.org,
	andi.shyti@kernel.org,
	lee@kernel.org,
	broonie@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	arnd@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	o.rempel@pengutronix.de,
	daniel.machon@microchip.com
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v8 07/10] i2c: at91: make it selectable for ARCH_MICROCHIP
Date: Wed,  2 Jul 2025 20:36:05 +0200
Message-ID: <20250702183856.1727275-8-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250702183856.1727275-1-robert.marko@sartura.hr>
References: <20250702183856.1727275-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LAN969x uses the Atmel TWI I2C, so make it selectable for ARCH_MICROCHIP to
avoid needing to update depends in future if other Microchip SoC-s use it
as well.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v8:
* Use ARCH_MICROCHIP for depends as its now selected by both ARM and ARM64
Microchip SoC-s

 drivers/i2c/busses/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 0a4ecccd1851..0101529c80a9 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -414,7 +414,7 @@ config I2C_ASPEED
 
 config I2C_AT91
 	tristate "Atmel AT91 I2C Two-Wire interface (TWI)"
-	depends on ARCH_AT91 || COMPILE_TEST
+	depends on ARCH_MICROCHIP || COMPILE_TEST
 	help
 	  This supports the use of the I2C interface on Atmel AT91
 	  processors.
-- 
2.50.0


