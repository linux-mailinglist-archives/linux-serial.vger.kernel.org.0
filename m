Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEEE7D7596
	for <lists+linux-serial@lfdr.de>; Wed, 25 Oct 2023 22:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235050AbjJYU0J (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 25 Oct 2023 16:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235044AbjJYUZm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 25 Oct 2023 16:25:42 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C9019A9
        for <linux-serial@vger.kernel.org>; Wed, 25 Oct 2023 13:25:19 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6934202b8bdso143406b3a.1
        for <linux-serial@vger.kernel.org>; Wed, 25 Oct 2023 13:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698265519; x=1698870319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5kojFGf2ZSJMlibBdobzZmgsjyx4Ywkx3WkwDcrmlX4=;
        b=bc4o5R2uRaA6wRDr326evH2qCIY9KhXBqmOap9Rh/as79Qpcg2Qicy4H+VVxFUknNu
         k4xMf/iXntL0KNo4tITE354JEJ95D9q2fdE+TV7dvjkBac+pd2TI2xoPHFgeP5bmWlsy
         u5bWElwny2aXk+K/OT1ttCkjs8jSk4H36BTZQrgZQ77cvpSmHm+va+WOAchlKFhdBxMa
         d4aK1Bu9VaQt6GGDiueX/nis1P4GNpLukPI6x6P7cKWUz8xPut3EL/m9G1kNkWIniLXN
         ylixWR1+htq/nm9vivn5WMHaHVBkEPwLuqJQfdIuoI6+ko3baX8+AqmTB0gvpHsd9pi1
         Ddow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698265519; x=1698870319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5kojFGf2ZSJMlibBdobzZmgsjyx4Ywkx3WkwDcrmlX4=;
        b=E9JS4ey1nqay7kp1aHljdZ98QxPIusW9s37ZEhzRvrrBit4lcOhBGkME8UFLMs0di8
         QFsv5mUp4V/gG3velz2FjuMexD2i8L/kRVpJWfYUsmBiefeLA3mJTGuPBVzN1K2gBTMF
         Vgmr5QP3+xihBj48oeeJrCfLha7VgtWVcFuOjfy4HfZFV1P6CFOUSRXIiVenVNNst/Yn
         /FjSCsPBglrLwirSfzaTGCrXnX20UY9BvG35hiZ91QbLTALUHd9GbsONvX4PardxLC28
         CVZeQmd7ctHYDrqoz+hJ6jHOOTkJVBEeFOxKgr5a3K7KWP+uIz6pauIU2N/YRGtvpC0D
         +Ykg==
X-Gm-Message-State: AOJu0Yx5oaFt5hjKYUrKRNBNLCAfyqxW4Fpc7PZxILojFNWmWnwx/viw
        Ufj9Ra9kVpBcC5DD79OFSgCWaw==
X-Google-Smtp-Source: AGHT+IEA5VCpygjnJt29h1aUuFMuVqz64Qf8m3MJ6i95Ryf0OFy3qLoON8TOXsusky9X3JJetvXkcA==
X-Received: by 2002:aa7:888b:0:b0:6bd:9281:9446 with SMTP id z11-20020aa7888b000000b006bd92819446mr19186279pfe.10.1698265518840;
        Wed, 25 Oct 2023 13:25:18 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id y3-20020aa79423000000b006b84ed9371esm10079590pfo.177.2023.10.25.13.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 13:25:18 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Anup Patel <anup@brainfault.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Kumar Patra <atishp@rivosinc.com>,
        Haibo Xu <haibo1.xu@intel.com>,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [RFC PATCH v2 12/21] PCI: pci-acpi.c: Return correct value from pcibios_alloc_irq()
Date:   Thu, 26 Oct 2023 01:53:35 +0530
Message-Id: <20231025202344.581132-13-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231025202344.581132-1-sunilvl@ventanamicro.com>
References: <20231025202344.581132-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Return the correct value from pcibios_alloc_irq().

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/pci/pci-acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index c8c3369fd69f..80dc0b290544 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1528,7 +1528,7 @@ arch_initcall(acpi_pci_init);
 int pcibios_alloc_irq(struct pci_dev *dev)
 {
 	if (!acpi_disabled)
-		acpi_pci_irq_enable(dev);
+		return acpi_pci_irq_enable(dev);
 
 	return 0;
 }
-- 
2.39.2

