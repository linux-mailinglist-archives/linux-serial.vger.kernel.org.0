Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D57171B8638
	for <lists+linux-serial@lfdr.de>; Sat, 25 Apr 2020 13:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgDYLmR (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sat, 25 Apr 2020 07:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgDYLmP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 25 Apr 2020 07:42:15 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6ADC09B04D
        for <linux-serial@vger.kernel.org>; Sat, 25 Apr 2020 04:42:13 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id e25so12653669ljg.5
        for <linux-serial@vger.kernel.org>; Sat, 25 Apr 2020 04:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cE84pg0qBcCfB8HAZD9im0+Wtvcg3MGDJhl8go6e6QM=;
        b=Hjwl1eBcHTE4cGda7HNpfxS8GIQ/L6jjNqJXPDhr6/in+TtciWZ5efNSfrMgo2oDq0
         xm0ViEbp+lbDcCF7Y3gCF4YvyOdcBbg4rv+ml+b/sUKcVR7JoOACo+kdkA31Zrq70B5l
         mMVroA0nTTdG9fu0UDoLQiaZUzPgi4N+MKhh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cE84pg0qBcCfB8HAZD9im0+Wtvcg3MGDJhl8go6e6QM=;
        b=Pe9rhlIC68j3Osu7sYimJwMTFSxSk3G83T0eAQWj1amQIb0KtnrK3ENdoyU/kdLRK8
         fO68m3jOgiIx3Zpe5Q4UD0zETdBrIrDmTJQ29QUsO+AHQB6umyVlMDTpjHz28WfRKDo/
         egh23J/RVZ9SaNhn0zVtv6bpo3C3iDjRTUEVRNm4dbd+xx0zJ1leIJTRICyzhGYNaMkP
         S3Sjk6ZRB8JQ1IGH860hyZ3t/h5u64090oVDWHG3vLCu60iB82nHeaePLB0Hg0N2El2+
         q57QpUn9xK0yp0oP27RnmKKRihMj5Nr5fN2TJyYXc/hiBZibrfN4Cjr+6sB/rQZRIbfT
         YECg==
X-Gm-Message-State: AGi0PuaNian8UQ8va3PuGF7DSKj+OiqrLy6kTj3Yw65DXCW+JMwrtRVk
        3Mae1dogq0K9fcxZBnBlS6uBOQ==
X-Google-Smtp-Source: APiQypIHI1e7FaoMWuCK1Lvc7N2ru9caHRhM5vUUaOMqkQ0iW+WNfW+FV0bmKhREu72lcggZB3reRA==
X-Received: by 2002:a2e:8549:: with SMTP id u9mr8230428ljj.24.1587814931563;
        Sat, 25 Apr 2020 04:42:11 -0700 (PDT)
Received: from localhost.localdomain (d79-196.icpnet.pl. [77.65.79.196])
        by smtp.gmail.com with ESMTPSA id m20sm6060421ljj.94.2020.04.25.04.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2020 04:42:10 -0700 (PDT)
Date:   Sat, 25 Apr 2020 13:42:05 +0200
From:   Mateusz Holenko <mholenko@antmicro.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org
Cc:     Stafford Horne <shorne@gmail.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Filip Kokosinski <fkokosinski@antmicro.com>,
        Pawel Czarnecki <pczarnecki@internships.antmicro.com>,
        Joel Stanley <joel@jms.id.au>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/5] drivers/soc/litex: add LiteX SoC Controller driver
Message-ID: <20200425133939.3508912-3-mholenko@antmicro.com>
References: <20200425133939.3508912-0-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200425133939.3508912-0-mholenko@antmicro.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Pawel Czarnecki <pczarnecki@internships.antmicro.com>

This commit adds driver for the FPGA-based LiteX SoC
Controller from LiteX SoC builder.

Co-developed-by: Mateusz Holenko <mholenko@antmicro.com>
Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
Signed-off-by: Pawel Czarnecki <pczarnecki@internships.antmicro.com>
---

Notes:
    Changes in v5:
    - removed helper accessors and used __raw_readl/__raw_writel instead
    - fixed checking for errors in litex_soc_ctrl_probe

    Changes in v4:
    - fixed indent in Kconfig's help section
    - fixed copyright header
    - changed compatible to "litex,soc-controller"
    - simplified litex_soc_ctrl_probe
    - removed unnecessary litex_soc_ctrl_remove
   
    This commit has been introduced in v3 of the patchset.
    
    It includes a simplified version of common 'litex.h'
    header introduced in v2 of the patchset.

 MAINTAINERS                        |   2 +
 drivers/soc/Kconfig                |   1 +
 drivers/soc/Makefile               |   1 +
 drivers/soc/litex/Kconfig          |  14 ++
 drivers/soc/litex/Makefile         |   3 +
 drivers/soc/litex/litex_soc_ctrl.c | 197 +++++++++++++++++++++++++++++
 include/linux/litex.h              |  45 +++++++
 7 files changed, 263 insertions(+)
 create mode 100644 drivers/soc/litex/Kconfig
 create mode 100644 drivers/soc/litex/Makefile
 create mode 100644 drivers/soc/litex/litex_soc_ctrl.c
 create mode 100644 include/linux/litex.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 421ede6c4f71..1afe7348353b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9820,6 +9820,8 @@ M:	Karol Gugala <kgugala@antmicro.com>
 M:	Mateusz Holenko <mholenko@antmicro.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/*/litex,*.yaml
+F:	drivers/soc/litex/litex_soc_ctrl.c
+F:	include/linux/litex.h
 
 LIVE PATCHING
 M:	Josh Poimboeuf <jpoimboe@redhat.com>
diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index 1778f8c62861..78add2a163be 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -9,6 +9,7 @@ source "drivers/soc/bcm/Kconfig"
 source "drivers/soc/fsl/Kconfig"
 source "drivers/soc/imx/Kconfig"
 source "drivers/soc/ixp4xx/Kconfig"
+source "drivers/soc/litex/Kconfig"
 source "drivers/soc/mediatek/Kconfig"
 source "drivers/soc/qcom/Kconfig"
 source "drivers/soc/renesas/Kconfig"
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index a39f17cea376..49bbb6ca6d95 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_ARCH_GEMINI)	+= gemini/
 obj-y				+= imx/
 obj-$(CONFIG_ARCH_IXP4XX)	+= ixp4xx/
 obj-$(CONFIG_SOC_XWAY)		+= lantiq/
+obj-$(CONFIG_LITEX_SOC_CONTROLLER) += litex/
 obj-y				+= mediatek/
 obj-y				+= amlogic/
 obj-y				+= qcom/
diff --git a/drivers/soc/litex/Kconfig b/drivers/soc/litex/Kconfig
new file mode 100644
index 000000000000..71264c0e1d6c
--- /dev/null
+++ b/drivers/soc/litex/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License_Identifier: GPL-2.0
+
+menu "Enable LiteX SoC Builder specific drivers"
+
+config LITEX_SOC_CONTROLLER
+	tristate "Enable LiteX SoC Controller driver"
+	help
+	  This option enables the SoC Controller Driver which verifies
+	  LiteX CSR access and provides common litex_get_reg/litex_set_reg
+	  accessors.
+	  All drivers that use functions from litex.h must depend on
+	  LITEX_SOC_CONTROLLER.
+
+endmenu
diff --git a/drivers/soc/litex/Makefile b/drivers/soc/litex/Makefile
new file mode 100644
index 000000000000..98ff7325b1c0
--- /dev/null
+++ b/drivers/soc/litex/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License_Identifier: GPL-2.0
+
+obj-$(CONFIG_LITEX_SOC_CONTROLLER)	+= litex_soc_ctrl.o
diff --git a/drivers/soc/litex/litex_soc_ctrl.c b/drivers/soc/litex/litex_soc_ctrl.c
new file mode 100644
index 000000000000..16f1625836a5
--- /dev/null
+++ b/drivers/soc/litex/litex_soc_ctrl.c
@@ -0,0 +1,197 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * LiteX SoC Controller Driver
+ *
+ * Copyright (C) 2020 Antmicro <www.antmicro.com>
+ *
+ */
+
+#include <linux/litex.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/printk.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/io.h>
+
+/*
+ * The parameters below are true for LiteX SoC
+ * configured for 8-bit CSR Bus, 32-bit aligned.
+ *
+ * Supporting other configurations will require
+ * extending the logic in this header.
+ */
+#define LITEX_REG_SIZE             0x4
+#define LITEX_SUBREG_SIZE          0x1
+#define LITEX_SUBREG_SIZE_BIT      (LITEX_SUBREG_SIZE * 8)
+
+static DEFINE_SPINLOCK(csr_lock);
+
+/*
+ * LiteX SoC Generator, depending on the configuration,
+ * can split a single logical CSR (Control & Status Register)
+ * into a series of consecutive physical registers.
+ *
+ * For example, in the configuration with 8-bit CSR Bus,
+ * 32-bit aligned (the default one for 32-bit CPUs) a 32-bit
+ * logical CSR will be generated as four 32-bit physical registers,
+ * each one containing one byte of meaningful data.
+ *
+ * For details see: https://github.com/enjoy-digital/litex/issues/314
+ *
+ * The purpose of `litex_set_reg`/`litex_get_reg` is to implement
+ * the logic of writing to/reading from the LiteX CSR in a single
+ * place that can be then reused by all LiteX drivers.
+ */
+void litex_set_reg(void __iomem *reg, unsigned long reg_size,
+		    unsigned long val)
+{
+	unsigned long shifted_data, shift, i;
+	unsigned long flags;
+
+	spin_lock_irqsave(&csr_lock, flags);
+
+	for (i = 0; i < reg_size; ++i) {
+		shift = ((reg_size - i - 1) * LITEX_SUBREG_SIZE_BIT);
+		shifted_data = val >> shift;
+
+		__raw_writel(shifted_data, reg + (LITEX_REG_SIZE * i));
+	}
+
+	spin_unlock_irqrestore(&csr_lock, flags);
+}
+
+unsigned long litex_get_reg(void __iomem *reg, unsigned long reg_size)
+{
+	unsigned long shifted_data, shift, i;
+	unsigned long result = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&csr_lock, flags);
+
+	for (i = 0; i < reg_size; ++i) {
+		shifted_data = __raw_readl(reg + (LITEX_REG_SIZE * i));
+
+		shift = ((reg_size - i - 1) * LITEX_SUBREG_SIZE_BIT);
+		result |= (shifted_data << shift);
+	}
+
+	spin_unlock_irqrestore(&csr_lock, flags);
+
+	return result;
+}
+
+static int accessors_ok;
+
+/*
+ * Check if accessors are safe to be used by other drivers
+ * returns true if yes - false if not
+ */
+int litex_check_accessors(void)
+{
+	return accessors_ok;
+}
+
+#define SCRATCH_REG_OFF         0x04
+#define SCRATCH_REG_SIZE        4
+#define SCRATCH_REG_VALUE       0x12345678
+#define SCRATCH_TEST_VALUE      0xdeadbeef
+
+/*
+ * Check LiteX CSR read/write access
+ *
+ * This function reads and writes a scratch register in order
+ * to verify if CSR access works.
+ *
+ * In case any problems are detected, the driver should panic
+ * and not set `accessors_ok` flag. As a result no other
+ * LiteX driver should access CSR bus.
+ *
+ * Access to the LiteX CSR is, by design, done in CPU native
+ * endianness. The driver should not dynamically configure
+ * access functions when the endianness mismatch is detected.
+ * Such situation indicates problems in the soft SoC design
+ * and should be solved at the LiteX generator level,
+ * not in the software.
+ */
+static int litex_check_csr_access(void __iomem *reg_addr)
+{
+	unsigned long reg;
+
+	reg = litex_get_reg(reg_addr + SCRATCH_REG_OFF, SCRATCH_REG_SIZE);
+
+	if (reg != SCRATCH_REG_VALUE) {
+		panic("Scratch register read error! Expected: 0x%x but got: 0x%lx",
+			SCRATCH_REG_VALUE, reg);
+		return -EINVAL;
+	}
+
+	litex_set_reg(reg_addr + SCRATCH_REG_OFF,
+		SCRATCH_REG_SIZE, SCRATCH_TEST_VALUE);
+	reg = litex_get_reg(reg_addr + SCRATCH_REG_OFF, SCRATCH_REG_SIZE);
+
+	if (reg != SCRATCH_TEST_VALUE) {
+		panic("Scratch register write error! Expected: 0x%x but got: 0x%lx",
+			SCRATCH_TEST_VALUE, reg);
+		return -EINVAL;
+	}
+
+	/* restore original value of the SCRATCH register */
+	litex_set_reg(reg_addr + SCRATCH_REG_OFF,
+		SCRATCH_REG_SIZE, SCRATCH_REG_VALUE);
+
+	/* Set flag for other drivers */
+	accessors_ok = 1;
+	pr_info("LiteX SoC Controller driver initialized");
+
+	return 0;
+}
+
+struct litex_soc_ctrl_device {
+	void __iomem *base;
+};
+
+static const struct of_device_id litex_soc_ctrl_of_match[] = {
+	{.compatible = "litex,soc-controller"},
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, litex_soc_ctrl_of_match);
+
+static int litex_soc_ctrl_probe(struct platform_device *pdev)
+{
+	struct device *dev;
+	struct device_node *node;
+	struct litex_soc_ctrl_device *soc_ctrl_dev;
+
+	dev = &pdev->dev;
+	node = dev->of_node;
+	if (!node)
+		return -ENODEV;
+
+	soc_ctrl_dev = devm_kzalloc(dev, sizeof(*soc_ctrl_dev), GFP_KERNEL);
+	if (!soc_ctrl_dev)
+		return -ENOMEM;
+
+	soc_ctrl_dev->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(soc_ctrl_dev->base))
+		return PTR_ERR(soc_ctrl_dev->base);
+
+	return litex_check_csr_access(soc_ctrl_dev->base);
+}
+
+static struct platform_driver litex_soc_ctrl_driver = {
+	.driver = {
+		.name = "litex-soc-controller",
+		.of_match_table = of_match_ptr(litex_soc_ctrl_of_match)
+	},
+	.probe = litex_soc_ctrl_probe,
+};
+
+module_platform_driver(litex_soc_ctrl_driver);
+MODULE_DESCRIPTION("LiteX SoC Controller driver");
+MODULE_AUTHOR("Antmicro <www.antmicro.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/litex.h b/include/linux/litex.h
new file mode 100644
index 000000000000..f31062436273
--- /dev/null
+++ b/include/linux/litex.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Common LiteX header providing
+ * helper functions for accessing CSRs.
+ *
+ * Implementation of the functions is provided by
+ * the LiteX SoC Controller driver.
+ *
+ * Copyright (C) 2019-2020 Antmicro <www.antmicro.com>
+ */
+
+#ifndef _LINUX_LITEX_H
+#define _LINUX_LITEX_H
+
+#include <linux/io.h>
+#include <linux/types.h>
+#include <linux/compiler_types.h>
+
+/*
+ * litex_check_accessors is a function implemented in
+ * drivers/soc/litex/litex_soc_controller.c
+ * checking if the common LiteX CSR accessors
+ * are safe to be used by the drivers;
+ * returns true (1) if yes - false (0) if not
+ *
+ * Important: All drivers that use litex_set_reg/litex_get_reg
+ * functions should make sure that LiteX SoC Controller driver
+ * has verified LiteX CSRs read and write operations before
+ * issuing any read/writes to the LiteX peripherals.
+ *
+ * Exemplary snippet that can be used at the beginning
+ * of the driver's probe() function to ensure that LiteX
+ * SoC Controller driver is properely initialized:
+ *
+ * if (!litex_check_accessors())
+ *     return -EPROBE_DEFER;
+ */
+int litex_check_accessors(void);
+
+void litex_set_reg(void __iomem *reg, unsigned long reg_sz, unsigned long val);
+
+unsigned long litex_get_reg(void __iomem *reg, unsigned long reg_sz);
+
+
+#endif /* _LINUX_LITEX_H */
-- 
2.25.1

