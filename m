Return-Path: <linux-serial+bounces-196-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7F57F6C9B
	for <lists+linux-serial@lfdr.de>; Fri, 24 Nov 2023 08:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4009B20BD4
	for <lists+linux-serial@lfdr.de>; Fri, 24 Nov 2023 07:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863832598;
	Fri, 24 Nov 2023 07:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="KgA9XAS8"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F6C10F7
	for <linux-serial@vger.kernel.org>; Thu, 23 Nov 2023 23:10:41 -0800 (PST)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1f0f94943d9so806366fac.2
        for <linux-serial@vger.kernel.org>; Thu, 23 Nov 2023 23:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1700809841; x=1701414641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5e69UQ6T+Z7CNLXUZDcGOS0SOuMoPgQwIsqXvR77gEM=;
        b=KgA9XAS8b7ne4H2F86yT9mlby7sXhpU4oQ9fnCaHFw6aKqBDgbiJYw2LwBPCr9lMcT
         WU2D71DWa2/4i8sourHqU280RsyMYu2bj6i4rRD4ysNe9eWt5qzdYxM6rCqJ9ifD3jas
         smoimi5b5z2LjnMehSKbX9eDX2xNaqn6R5oc2bOYhHTihq85mRxtQ/w1CwLB20piSmTN
         YeLpZNueQPwMUAyJW5wBhFsDJTFAZNASVwN7Ay1Hjl/iYsowro22NZD2pVrIm5XZ2cJr
         pVxitvfAIZ/rqNBwZJkwd35kzkR15P35eW3krXB2Bd4BOG/g5f1wLMB/LflXalWAI7JI
         V+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700809841; x=1701414641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5e69UQ6T+Z7CNLXUZDcGOS0SOuMoPgQwIsqXvR77gEM=;
        b=ro/SOzhGZoRnP4eV2XcHcXXzZ6tniVJPxq88Y3wu/EbTlQv0fbixoxMxr2pUZrXISZ
         pY19X0FRSxzYUpsTbf/piZRv11TWGW1qllD8vUsv5WZX6kup03MFONHEmQhBLXZllLde
         gcefwmSBbVBTpDCxrgwU6xzcQgfxUZ6HqZ5AI5m5fCoEzPfoW7HlFRwpR7IASyV2LfX2
         zt/wdn1FtJUE5fl5rzGfa8rPgee+OsCOl37Cf6ia5xpuDUHA/bADM81smcMlDUyo5GWe
         +jwK6wXYcNMJMwgP5vIzDMnr60w7GkUenKFHWNuBkvCn0SDEjzkYP3QLVUtGFwDnAToz
         dFTg==
X-Gm-Message-State: AOJu0YwEk++ETWDKjBWTgoJRxGc4+iyianmuKF6LA1nC8WMxcqHrWi60
	AkJQJjEihKK/qk4SCo47RkdLug==
X-Google-Smtp-Source: AGHT+IGpCaOs051rva99tydJYiLxp2JmCAggGxrs3iHMIIeR5K0qZKOeN66AGmBC8Za809GQ8lm4oQ==
X-Received: by 2002:a05:6871:453:b0:1f4:dd99:b07 with SMTP id e19-20020a056871045300b001f4dd990b07mr2011442oag.49.1700809840700;
        Thu, 23 Nov 2023 23:10:40 -0800 (PST)
Received: from localhost.localdomain ([106.51.83.242])
        by smtp.gmail.com with ESMTPSA id e5-20020a9d7305000000b006c61c098d38sm435532otk.21.2023.11.23.23.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 23:10:40 -0800 (PST)
From: Anup Patel <apatel@ventanamicro.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Conor Dooley <conor@kernel.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	linux-riscv@lists.infradead.org,
	linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Atish Patra <atishp@rivosinc.com>,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v5 4/5] tty: Add SBI debug console support to HVC SBI driver
Date: Fri, 24 Nov 2023 12:39:04 +0530
Message-Id: <20231124070905.1043092-5-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231124070905.1043092-1-apatel@ventanamicro.com>
References: <20231124070905.1043092-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Atish Patra <atishp@rivosinc.com>

RISC-V SBI specification supports advanced debug console
support via SBI DBCN extension.

Extend the HVC SBI driver to support it.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/tty/hvc/Kconfig         |  2 +-
 drivers/tty/hvc/hvc_riscv_sbi.c | 37 ++++++++++++++++++++++++++-------
 2 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/hvc/Kconfig b/drivers/tty/hvc/Kconfig
index 4f9264d005c0..6e05c5c7bca1 100644
--- a/drivers/tty/hvc/Kconfig
+++ b/drivers/tty/hvc/Kconfig
@@ -108,7 +108,7 @@ config HVC_DCC_SERIALIZE_SMP
 
 config HVC_RISCV_SBI
 	bool "RISC-V SBI console support"
-	depends on RISCV_SBI_V01
+	depends on RISCV_SBI
 	select HVC_DRIVER
 	help
 	  This enables support for console output via RISC-V SBI calls, which
diff --git a/drivers/tty/hvc/hvc_riscv_sbi.c b/drivers/tty/hvc/hvc_riscv_sbi.c
index 31f53fa77e4a..2f3571f17ecd 100644
--- a/drivers/tty/hvc/hvc_riscv_sbi.c
+++ b/drivers/tty/hvc/hvc_riscv_sbi.c
@@ -39,21 +39,44 @@ static int hvc_sbi_tty_get(uint32_t vtermno, char *buf, int count)
 	return i;
 }
 
-static const struct hv_ops hvc_sbi_ops = {
+static const struct hv_ops hvc_sbi_v01_ops = {
 	.get_chars = hvc_sbi_tty_get,
 	.put_chars = hvc_sbi_tty_put,
 };
 
-static int __init hvc_sbi_init(void)
+static int hvc_sbi_dbcn_tty_put(uint32_t vtermno, const char *buf, int count)
 {
-	return PTR_ERR_OR_ZERO(hvc_alloc(0, 0, &hvc_sbi_ops, 16));
+	return sbi_debug_console_write(buf, count);
 }
-device_initcall(hvc_sbi_init);
 
-static int __init hvc_sbi_console_init(void)
+static int hvc_sbi_dbcn_tty_get(uint32_t vtermno, char *buf, int count)
 {
-	hvc_instantiate(0, 0, &hvc_sbi_ops);
+	return sbi_debug_console_read(buf, count);
+}
+
+static const struct hv_ops hvc_sbi_dbcn_ops = {
+	.put_chars = hvc_sbi_dbcn_tty_put,
+	.get_chars = hvc_sbi_dbcn_tty_get,
+};
+
+static int __init hvc_sbi_init(void)
+{
+	int err;
+
+	if (sbi_debug_console_available) {
+		err = PTR_ERR_OR_ZERO(hvc_alloc(0, 0, &hvc_sbi_dbcn_ops, 256));
+		if (err)
+			return err;
+		hvc_instantiate(0, 0, &hvc_sbi_dbcn_ops);
+	} else if (IS_ENABLED(CONFIG_RISCV_SBI_V01)) {
+		err = PTR_ERR_OR_ZERO(hvc_alloc(0, 0, &hvc_sbi_v01_ops, 256));
+		if (err)
+			return err;
+		hvc_instantiate(0, 0, &hvc_sbi_v01_ops);
+	} else {
+		return -ENODEV;
+	}
 
 	return 0;
 }
-console_initcall(hvc_sbi_console_init);
+device_initcall(hvc_sbi_init);
-- 
2.34.1


