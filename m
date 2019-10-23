Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 725A1E168A
	for <lists+linux-serial@lfdr.de>; Wed, 23 Oct 2019 11:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404018AbfJWJrM (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 23 Oct 2019 05:47:12 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37152 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403909AbfJWJrM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 23 Oct 2019 05:47:12 -0400
Received: by mail-lj1-f193.google.com with SMTP id l21so20370066lje.4
        for <linux-serial@vger.kernel.org>; Wed, 23 Oct 2019 02:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z5E9vMdaflAYdOO0uDYnAuQqG7zXE5bnhgh3Hkb4fu0=;
        b=yRrrB+apvStxNdvUaxXg9aE730JEymnAhvMUsGXJjy3TwjuFQ9FFQTN2fYgXp4PAFX
         eBVIjkDzf6E+IyLm54Al8QTH/9f2hawJerDRFO42ezJtxURQEE1vqQzoAcqjrKOOva9+
         8Vlg78TnBuq9GdeZsxCo+OjnE6N/V0O5l1v39gWLwLZuNCv9rib1rZU5ZiXwZZF0iAi1
         QeYGqxET3M65AxqJ7FrtHpQWLAfCjFIlYVdL5SUosKtKYcjZwFkFYtluSxCrWOFbdtwQ
         CsciUfRVYfq/YgTJp0MAkBCRtYE4IJO9kGK7lrUT0dtOcyutP9s4XZLTTp6I1mAmEHJg
         vOUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z5E9vMdaflAYdOO0uDYnAuQqG7zXE5bnhgh3Hkb4fu0=;
        b=AcMvr6GjJDMnryLfio4+gEJ7+5j9a0FbBcZ6t+BTACpkR5yh6T3jqTZSanzbySTm8G
         6XSugMjMy1g0tv4udrkii6m1QWKrZB59w7wHXH1MPQORuW7NY7nTuz7eWreehjbANimY
         Ww/dLbC2d7tStbdzJjrxV43hhmaWAKynwdMUL3D2AnZw95u/jtIEguoo9SEqiTnYxosl
         6PNYbN1HJ0Ee8pO6dPleXCPt4uGmbCGpJPg68I+MGihebQuApaWHhWvfd8QlpSeSUOkH
         Dm8HQOdyrVkuZiciQT1jQrPHWN11k9gqtttdFXVu3qZdCghE5LI3bEvOZd+SBEophNUd
         GWnA==
X-Gm-Message-State: APjAAAWNJEDgaKIHRC/yjQqxRrq97ZqvZ00TCudt/lefeDyZSYcC8q8I
        o2Kq5CQyitDTwAX2/db3n8jmCQ==
X-Google-Smtp-Source: APXvYqwECn4TDrEhXArmXu+D/zcuw6cduoFSr/1s9scKUSiwBZz16Vub3aXs7nR21cECdA59IbUM0w==
X-Received: by 2002:a2e:1214:: with SMTP id t20mr22627690lje.240.1571824030217;
        Wed, 23 Oct 2019 02:47:10 -0700 (PDT)
Received: from localhost.localdomain (d79-196.icpnet.pl. [77.65.79.196])
        by smtp.gmail.com with ESMTPSA id y26sm9630753ljj.90.2019.10.23.02.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 02:47:09 -0700 (PDT)
Date:   Wed, 23 Oct 2019 11:47:04 +0200
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
        Filip Kokosinski <fkokosinski@internships.antmicro.com>,
        Joel Stanley <joel@jms.id.au>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] litex: add common LiteX header
Message-ID: <20191023114634.13657-2-mholenko@antmicro.com>
References: <20191023114634.13657-0-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023114634.13657-0-mholenko@antmicro.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

It provides helper CSR access functions used by all
LiteX drivers.

Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
---
This commit has been introduced in v2 of the patchset.

 MAINTAINERS           |  6 +++++
 include/linux/litex.h | 59 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)
 create mode 100644 include/linux/litex.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 296de2b51c83..eaa51209bfb2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9493,6 +9493,12 @@ F:	Documentation/misc-devices/lis3lv02d.rst
 F:	drivers/misc/lis3lv02d/
 F:	drivers/platform/x86/hp_accel.c
 
+LITEX PLATFORM
+M:	Karol Gugala <kgugala@antmicro.com>
+M:	Mateusz Holenko <mholenko@antmicro.com>
+S:	Maintained
+F:	include/linux/litex.h
+
 LIVE PATCHING
 M:	Josh Poimboeuf <jpoimboe@redhat.com>
 M:	Jiri Kosina <jikos@kernel.org>
diff --git a/include/linux/litex.h b/include/linux/litex.h
new file mode 100644
index 000000000000..e793d2d7c881
--- /dev/null
+++ b/include/linux/litex.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Common LiteX header providing
+ * helper functions for accessing CSRs.
+ *
+ * Copyright (C) 2019 Antmicro <www.antmicro.com>
+ */
+
+#ifndef _LINUX_LITEX_H
+#define _LINUX_LITEX_H
+
+#include <linux/io.h>
+#include <linux/types.h>
+#include <linux/compiler_types.h>
+
+#define LITEX_REG_SIZE             0x4
+#define LITEX_SUBREG_SIZE          0x1
+#define LITEX_SUBREG_SIZE_BIT      (LITEX_SUBREG_SIZE * 8)
+
+#ifdef __LITTLE_ENDIAN
+# define LITEX_READ_REG(addr)                  ioread32(addr)
+# define LITEX_READ_REG_OFF(addr, off)         ioread32(addr + off)
+# define LITEX_WRITE_REG(val, addr)            iowrite32(val, addr)
+# define LITEX_WRITE_REG_OFF(val, addr, off)   iowrite32(val, addr + off)
+#else
+# define LITEX_READ_REG(addr)                  ioread32be(addr)
+# define LITEX_READ_REG_OFF(addr, off)         ioread32be(addr + off)
+# define LITEX_WRITE_REG(val, addr)            iowrite32be(val, addr)
+# define LITEX_WRITE_REG_OFF(val, addr, off)   iowrite32be(val, addr + off)
+#endif
+
+/* Helper functions for manipulating LiteX registers */
+
+static inline void litex_set_reg(void __iomem *reg, u32 reg_size, u32 val)
+{
+	u32 shifted_data, shift, i;
+
+	for (i = 0; i < reg_size; ++i) {
+		shift = ((reg_size - i - 1) * LITEX_SUBREG_SIZE_BIT);
+		shifted_data = val >> shift;
+		LITEX_WRITE_REG(shifted_data, reg + (LITEX_REG_SIZE * i));
+	}
+}
+
+static inline u32 litex_get_reg(void __iomem *reg, u32 reg_size)
+{
+	u32 shifted_data, shift, i;
+	u32 result = 0;
+
+	for (i = 0; i < reg_size; ++i) {
+		shifted_data = LITEX_READ_REG(reg + (LITEX_REG_SIZE * i));
+		shift = ((reg_size - i - 1) * LITEX_SUBREG_SIZE_BIT);
+		result |= (shifted_data << shift);
+	}
+
+	return result;
+}
+
+#endif /* _LINUX_LITEX_H */
-- 
2.23.0
