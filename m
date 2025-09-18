Return-Path: <linux-serial+bounces-10417-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A48CB20D56
	for <lists+linux-serial@lfdr.de>; Mon, 11 Aug 2025 17:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9378E18876BE
	for <lists+linux-serial@lfdr.de>; Mon, 11 Aug 2025 15:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D491B2E0412;
	Mon, 11 Aug 2025 15:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PTz32NZK"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FC118EB0
	for <linux-serial@vger.kernel.org>; Mon, 11 Aug 2025 15:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754925487; cv=none; b=LntcuRPfjomO0nx1nxzE5Jp08kLqz4yHkS/XG1anMzrx0c9cla8Q01OwK2ijM2b0jDyLLim4+J9UDEOvmnYIMfQ3tsGSszRihO5iAiiCKRp9CnBoTmzXpv308z8rAdgK++Y6meOtNhlSHXc/FaQtaDeHhtltkZmR+8UOo6IV+yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754925487; c=relaxed/simple;
	bh=6a2jpr8RqbOo+9g1f65WPhHWahy1fmVBwuuQHvaAios=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tp3jktmhdWevN/5prDFYeVeDKAc3WJj8NdvgHtLPMHw5xR+nHvVBdUNZdvq1WpnwNbnlz46dyZgr12y67J0Gg/H1+GExKo5CSmA2SKT17NmhhKZlS9TMnGx5vw7zM0Zerayo/NCjzaebPaz+dkp1E0y2NE68HSgIRAy4Kjdnx88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PTz32NZK; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-af95ecfbd5bso749961666b.1
        for <linux-serial@vger.kernel.org>; Mon, 11 Aug 2025 08:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754925484; x=1755530284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ihP/wnPXyZhWgHPlteto2ft6qT692i4bL35PGC7Kwgs=;
        b=PTz32NZKUVFpakySMNj8LpNGl769jNxKtf2Wy2ymGDpQ1rdL34X1N0i6Iw8o+o2MM/
         YgToy6bi3CvB09Thb9NkMbRZgGzIPfjFqW8Tym+y3F2q/UqbFF+c9n1Gce2zRoHdbyqA
         if5T7ME6CpfQHdBtTWcFmjSFbhz48aK87tXccE6m0GR3KIsthGXl+b+Gma3jOJETjc6i
         p+y04GYSnB6IuQUMzz0DePBr8f6NK4PzxfEfBOQJ9IXVwqA5p3fBB4uP/CKQkKhRZAt6
         8yFUS+C1VkvuYKAu9T3zmnUcwVJbSvFpuout3mjbyjYwA3bwoPafqymJZP7KrTEOWrGQ
         ayYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754925484; x=1755530284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ihP/wnPXyZhWgHPlteto2ft6qT692i4bL35PGC7Kwgs=;
        b=sHab/YnVCqnFin7XEoMcvqmEr7Mn9Izr6BaQLI8TCUAnHuFQG88iuWmbSoqf0185Y9
         AHfQaXiHwunthfMS+a8uFarntuFoVqmk3nmQIfdRxXbTwXMcCFWB3NzeYiYArQGUDVmc
         aHv4eHtfgzbgZESbVY/QADHBfXtx78OlSUf0cDF+dE6xUBi8yn9Nxy8JFbJ3ajkmjxLT
         LgquYt9cKYAiPa0qUNB5eZ60ic+3SpqHHSg/gTaJo6icHm4wXbX2faHwxntapa0YndVV
         BOthdzQz2aMe0em/WTAxtVqWR5QwYtnILjQ+B10K3sVbPGd14ri9JX/2Wd65LzBReM25
         29LQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpcsL7pTNkHa8BokOglU0zZSwjFafjTMZISxlFhfyACJZ+oilJhFI7l+J3J5QTUx+Iql7ZVPeJB8GqKh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfJ2edYsAql1kmEdnfWSfHsCkpVhwK4wj8MZa95SkmR78bCULo
	4EB0Msc6ZKgVxq5etMVbqiZqE5fTu78LuKYrQK9yvLQIbf0ZFhPOtN6uIt91lybcTDI=
X-Gm-Gg: ASbGncuL2iGP9J9MHyimDAefPd4WnCLhvAtXMDLuwFwOm6h+l9zXnVHg/6/LIROfSbk
	vy8hEqMldXYMdZ7mDSuqKmFVBZ2RlGqkczwpbUr+8kmrEZr0r4L07e9BJKMATWiVlzNRXHimPgW
	fbkw0q9aAuHWd/FUlP8wp5iULvUFtYn/Leuz2aoYAvrFpRhlkxCuDpWC+FnlLGi2uDgaVqciBJ4
	kzP+F/3YZ4T8ugKNWmcT6n2VPW+Q6XucoJ5/ldoRnsXLyqIrRmV90iJKCb27QGWpj2+fH1b7Om0
	9qjKB683XGUXwLdPWWs9hVZUcg0ClujU8Scm7DOJR0JmKMRqZyt8zbjtYitKVgxQF/HZ9aAfmKq
	wFqGB+qN176+CZaqvyv26OV1Awg8l1oo6kt0sG5LP5nW52bkLTQQEUlXtH/McFXcykQ==
X-Google-Smtp-Source: AGHT+IGvJ3ayAmkrGkViVLnbNoPZ1sMap6TBv2tr1d6iu6pDDVV5j4fRLfmHXE5vLfntRBsHIUMHNQ==
X-Received: by 2002:a17:907:608b:b0:af9:5b1f:b87a with SMTP id a640c23a62f3a-af9c64791a2mr1210151866b.20.1754925484035;
        Mon, 11 Aug 2025 08:18:04 -0700 (PDT)
Received: from localhost (host-79-44-170-80.retail.telecomitalia.it. [79.44.170.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c081sm2014946666b.97.2025.08.11.08.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 08:18:03 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: linus.walleij@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	florian.fainelli@broadcom.com,
	wahrenst@gmx.net,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	iivanov@suse.de,
	svarbanov@suse.de,
	mbrugger@suse.com,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	linux-mmc@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org
Cc: Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH 0/6] Add peripheral nodes to RaspberryPi 5 DT
Date: Mon, 11 Aug 2025 17:19:44 +0200
Message-ID: <cover.1754924348.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

The following patches add a few peripheral DT nodes and related pin/gpio
nodes for Raspberry Pi 5.

This brand new patchset (hence it's a V1) is the second part of the split-up
of the patchset [1]. It tooks patches 3 to 6 from there and adds a couple
of new patches that amend the DT bindings.
As a result, patchset [2] is a prerequisite for this patchset.

- Patch 1 and 2: Amend the bindings to avoid DT compiler warnings.

- Patch 3: Adds core pinctrl nodes and defines SD pins as a first appliance
  for the pinctrl.  

- Patch 4: Wires the gpio-key for power button and related gpio controller.

- Patch 5: Adds DT node for WiFi.

- Patch 6: Adds Bluetooth DT node.

All comments and suggestions are welcome!

Happy hacking!
Ivan and Andrea

Links:
[1] - https://lore.kernel.org/all/cover.1752584387.git.andrea.porta@suse.com/
[2] - https://lore.kernel.org/all/cover.1754922935.git.andrea.porta@suse.com/


CHANGES since [1]:

--- PATCHES ---

- Add two new patches (1 and 2) that amend the DT bindings.


--- DTS ---

- bcm2712.dtsi: Added 'interrupt-names' and dropped 'reg-shift' and
  'reg-io-width' properties in uarta DT node. The latter two are
  just overridden by driver code so setting them in DT is useless.

- bcm2712-rpi-5-b-ovl-rp1.dts: dropped 'auto-flow-control' property
  since it's not parsed in driver code.


--- DT BINDINGS ---

- brcm,sdhci-brcmstb.yaml: added SDHCI capabilities by including
  sdhci-common.yaml.

- serial/brcm,bcm7271-uart.yaml: let clock-frequency be an alternative way
  to specify the clock speed instead of clocks/clock-names.


Andrea della Porta (2):
  dt-bindings: mmc: Add support for capabilities to Broadcom SDHCI
    controller
  dt-bindings: serial: Add clock-frequency property as an alternative to
    clocks

Ivan T. Ivanov (4):
  arm64: dts: broadcom: bcm2712: Add pin controller nodes
  arm64: dts: broadcom: bcm2712: Add one more GPIO node
  arm64: dts: broadcom: bcm2712: Add second SDHCI controller node
  arm64: dts: broadcom: bcm2712: Add UARTA controller node

 .../bindings/mmc/brcm,sdhci-brcmstb.yaml      |   2 +-
 .../bindings/serial/brcm,bcm7271-uart.yaml    |  19 ++-
 .../dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dts  | 133 ++++++++++++++++++
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi     |  47 +++++++
 4 files changed, 198 insertions(+), 3 deletions(-)

-- 
2.35.3


