Return-Path: <linux-serial+bounces-2871-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB18887F39
	for <lists+linux-serial@lfdr.de>; Sun, 24 Mar 2024 22:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C44D61F215D0
	for <lists+linux-serial@lfdr.de>; Sun, 24 Mar 2024 21:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64279171A2;
	Sun, 24 Mar 2024 21:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHRzJDtT"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08E91CF87;
	Sun, 24 Mar 2024 21:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711316650; cv=none; b=cEcI69J1z8fVNyd5KTCFsyjKLKisqiqTIc/Z4XKqJNne6sZjZpNWK2mz7V4wdPexuBWIY/UHHp9X41PYcSqdRvIXynTU114ri7OId5wG61z5fBjj3vRh93EztMJ8tmLp+PLDINNtHuBsVI45hKpr6AbfyaSHP8s0wHvO8tnNlIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711316650; c=relaxed/simple;
	bh=Y1ZH6sXEWgZE7mVR1DS58C2yS473lu4Tv/5Sh3lTIr0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LtXkpr9lU7XcGE4GlT22i7ih9RE3WBjNuOzxu8Hs34KGUOwTWBMLRcTX6bMgMO3oWQzIVT1kxD0wCuflWleo2AnNzEom1plA94mA7F62UlaOLA6zU4La//3PuSi+kuUYhj/sDU1g+VekroOmBOV8stZDnhufAuiYcvGBsmB/318=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OHRzJDtT; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56c0d1bddc1so406833a12.3;
        Sun, 24 Mar 2024 14:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711316647; x=1711921447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zkCO8Y+WHQnl+tvX3DzgjNq21YRogyxceoqEZu7+h94=;
        b=OHRzJDtTb/e9R8NDjCU93tpn3dM9TrzZuTO7uW/h3C1TDdUbls8H8KsU0vm3qR3pHz
         +H2RVZwa4Uc5Cz0XvKDa9psEd7HkJh0kaq7XGHMrq+2RkzmqsVUJYydem86GDuOvsraB
         TjCLyv/E5bh3hJt0mAk5jPyebLvTZUDFt3xd1EtH6q+x3ue70MnaxpAxJvC7CsqUiLOT
         Dh21ibfuQzznM4FL3dH93q9+uvWqBqFgZwV0NlTDPFLtKssIYy0zRU4UxfrlOyPN2ZC1
         VDAygBs8YR2hpDNt93HjhWONMVLznI3FRJJZsJ/bqTlt8B7IxUB3u5UbEryfZM5d5/Kd
         RL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711316647; x=1711921447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zkCO8Y+WHQnl+tvX3DzgjNq21YRogyxceoqEZu7+h94=;
        b=YrJ1yvaWhdNIMnwiDLbz5ms2G+JMSpHs+9MQN1zBxE2w9683p2xFaXjG+crHp4ESjA
         UzjBikHLXnZ4SU+tlHQWkcnJR5XS6I3NXRrkXw/PoftlFbk4Y8UdJcZ/dNQgV7dk1F6H
         5BACe2GoJc05B3UuqQcDmxY29Mz2KCjmkqsh/2M2dAWb79XBEOd6Gu6j+7P9EkJYHSWY
         +BkywFpUwQ+NQWetCPn+W8xEwby555qMjDZASoSZmTWPXb9flqrgU1Qf7otLXJNwBh0F
         GVVel4Ca0sht+K+bXcLs7YE/0oRq9XTmdeD69z/ngpzJ09YYXNcW2T6jE7XnEGqDMkLj
         S3LQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBJhe2jhjlh+yPNQIV01ptbBa60xA2X93ybSfC4E2dUbtvNEj+REwOUx32sFcrPuz3QYF6byRLPmDqcF8m/Lw7eHD7OQ5DucGOLR3umRLXXxhyVOCI11DdLM+Uv0mOUX+gDmuupUeE5L8doQ7rieIPfEXU/fDDly4YCY8EhcIYeRR/t46kTwDW+02MQOlE3+hcY4TwdhB53UnzXxIVfSmAlQ==
X-Gm-Message-State: AOJu0YzB/xn4TOruyz3Di3B+8yL2Ig8blrFIR+MfIg7D3e4Aeg5J/Tzq
	GJGOGqyzrOaHmzjKzVIcilAMwEFvksPkx0SeU0PENa+XlYc9zujM
X-Google-Smtp-Source: AGHT+IFFyizMvoL9NzRPRAQx/Lp+F9c0iktT8fr9Vh6GjvgooA64cmyXKDEGWTjfh+nJBNef+vQR4g==
X-Received: by 2002:a17:906:1515:b0:a46:ede0:2370 with SMTP id b21-20020a170906151500b00a46ede02370mr3761286ejd.57.1711316646538;
        Sun, 24 Mar 2024 14:44:06 -0700 (PDT)
Received: from bhlegrsu.conti.de ([2a02:908:2525:6ea0::2043])
        by smtp.googlemail.com with ESMTPSA id w17-20020a170906385100b00a46d8e5a031sm2327542ejc.209.2024.03.24.14.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 14:44:06 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: 
Cc: Wadim Mueller <wafgo01@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Chester Lin <chester62515@gmail.com>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Matthias Brugger <mbrugger@suse.com>,
	NXP S32 Linux Team <s32@nxp.com>,
	Tim Harvey <tharvey@gateworks.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Marek Vasut <marex@denx.de>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Matthias Schiffer <matthias.schiffer@tq-group.com>,
	Stefan Wahren <stefan.wahren@chargebyte.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philippe Schenker <philippe.schenker@toradex.com>,
	Josua Mayer <josua@solid-run.com>,
	Li Yang <leoyang.li@nxp.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v4 0/4] NXP S32G3 SoC initial bring-up
Date: Sun, 24 Mar 2024 22:43:22 +0100
Message-Id: <20240324214329.29988-1-wafgo01@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series brings up initial support for the NXP S32G3 SoC,
used on the S32G-VNP-RDB3 board [1].

The following features are supported in this initial port:

  * Devicetree for the S32G-VNP-RDB3 
  * UART (fsl-linflexuart) with earlycon support
  * SDHC: fsl-imx-esdhc (SD/eMMC)

== Changes since v3 ==:

  * changed dts license to dual license model (GPL-2.0+ OR BSD-3-Clause)
  * fixed wrong s32g3 schema binding for fsl-imx-esdhc
  * merged s32-linflexuart schema binding for s32g2 and s32g3 into one enum
  * sorted s32g3 dts nodes alpha-numerically by the node name
  * sorted s32g3 soc nodes by unit address
 

[1] https://www.nxp.com/design/design-center/designs/s32g3-vehicle-networking-reference-design:S32G-VNP-RDB3

Wadim Mueller (4):
  dt-bindings: arm: fsl: add NXP S32G3 board
  dt-bindings: serial: fsl-linflexuart: add compatible for S32G3
  dt-bindings: mmc: fsl-imx-esdhc: add NXP S32G3 support
  arm64: dts: S32G3: Introduce device tree for S32G-VNP-RDB3

 .../devicetree/bindings/arm/fsl.yaml          |   6 +
 .../bindings/mmc/fsl-imx-esdhc.yaml           |   3 +
 .../bindings/serial/fsl,s32-linflexuart.yaml  |   4 +-
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 arch/arm64/boot/dts/freescale/s32g3.dtsi      | 233 ++++++++++++++++++
 .../boot/dts/freescale/s32g399a-rdb3.dts      |  45 ++++
 6 files changed, 291 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/freescale/s32g3.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts

-- 
2.25.1


