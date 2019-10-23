Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54707E168F
	for <lists+linux-serial@lfdr.de>; Wed, 23 Oct 2019 11:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404100AbfJWJrW (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 23 Oct 2019 05:47:22 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:46115 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404065AbfJWJrW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 23 Oct 2019 05:47:22 -0400
Received: by mail-lj1-f179.google.com with SMTP id d1so20309546ljl.13
        for <linux-serial@vger.kernel.org>; Wed, 23 Oct 2019 02:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Pz3+DWB7oWbXAMad9r4Qc00otDyvGCAkqWlDBm/r8Ac=;
        b=2MqfhQSv6tqOpcuwa0h8Eybcz74sI3Tp4lryUBh2aIxUyOL64r/aYAZ3xTtYYfOYD9
         RCjJUFcTEtr4o8bEJvken2RukeojMYMklq7krPDQHaQy7KGL1EV9IExVVsSuqMVO/PIR
         m0FKEEOGcTXwEAe0SqBnPDdnQ4wLmuQ94SUz2V2NjCKXoCKfaxg7aQKkWn950vzAyMMX
         75GH/398Bg9tQCH8zTq2yUHm4ycjSu8XNl4rc3x50aDe2MkItq8XG1GuALqket7QJdEs
         8DC/IDi2buxlt9pVwoVNo7poUOkbntuMC9O3BYd3pcwdhT4u94L6umoijY8dFgXZ0s6Y
         D9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pz3+DWB7oWbXAMad9r4Qc00otDyvGCAkqWlDBm/r8Ac=;
        b=NI57wL6sOB5uA9Vf8zXRiha3+iyRTJ99XvVqHO4sIbVLFbtDVhz8oevaxJEA3rqbIP
         GiF4TbfJW2uGmquRftzBDSvksmeA+tmN4yVsabLNmiId7JN6mdP9UPjfO1XXnNeZBdXj
         6DgyRncHoJAiUodJ60oqpZRCIt2JMJBxPTcAChhISVle+GGpQtG2KGvzSQ7VcHEykO+p
         HXwnOn/Dl6J3qaDCH2sKyk9j7iP7WGcvnWe9nSZqSQN14sMULHPdtun5K1CJWChMdD0E
         6S1n9AWl3ZT069phSYp5TRbPi/LjzZZbjtMNwajaYXjZxzjkH/YGNlObgOyitPcMV/AB
         /Bqg==
X-Gm-Message-State: APjAAAXnJtltrP/ob9BysCeazNU0ujW0296R9A7J+C+w6TQQp5XaLQNi
        7G0UuWAEEXy4EdTK0JKVpSQImA==
X-Google-Smtp-Source: APXvYqwTsLR1aQcC2X8hJihtXbTlmk+xv35POn0v1gmzDTjGJMP1rJO0MPxSfZjDSJsHzoSASfGjrg==
X-Received: by 2002:a2e:575c:: with SMTP id r28mr1321715ljd.245.1571824039306;
        Wed, 23 Oct 2019 02:47:19 -0700 (PDT)
Received: from localhost.localdomain (d79-196.icpnet.pl. [77.65.79.196])
        by smtp.gmail.com with ESMTPSA id t6sm9602971ljd.102.2019.10.23.02.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 02:47:18 -0700 (PDT)
Date:   Wed, 23 Oct 2019 11:47:14 +0200
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
Subject: [PATCH v2 3/4] dt-bindings: serial: document LiteUART bindings
Message-ID: <20191023114634.13657-3-mholenko@antmicro.com>
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

From: Filip Kokosinski <fkokosinski@internships.antmicro.com>

Add documentation for LiteUART devicetree bindings.

Signed-off-by: Filip Kokosinski <fkokosinski@internships.antmicro.com>
Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
---
Changes in v2:
- binding description rewritten to a yaml schema file
- added interrupt line
- fixed unit address
- patch number changed from 2 to 3

 .../bindings/serial/litex,liteuart.yaml       | 38 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/litex,liteuart.yaml

diff --git a/Documentation/devicetree/bindings/serial/litex,liteuart.yaml b/Documentation/devicetree/bindings/serial/litex,liteuart.yaml
new file mode 100644
index 000000000000..87bf846b170a
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/litex,liteuart.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: GPL-2.0
+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/litex,liteuart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LiteUART serial controller
+
+maintainers:
+  - Karol Gugala <kgugala@antmicro.com>
+  - Mateusz Holenko <mholenko@antmicro.com>
+
+description: |
+  LiteUART serial controller is a part of LiteX FPGA SoC builder. It supports
+  multiple CPU architectures, currently including e.g. OpenRISC and RISC-V.
+
+properties:
+  compatible:
+    const: litex,liteuart
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    uart0: serial@e0001800 {
+      compatible = "litex,liteuart";
+      reg = <0xe0001800 0x100>;
+      interrupts = <2>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index eaa51209bfb2..1dc783c9edb7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9498,6 +9498,7 @@ M:	Karol Gugala <kgugala@antmicro.com>
 M:	Mateusz Holenko <mholenko@antmicro.com>
 S:	Maintained
 F:	include/linux/litex.h
+F:	Documentation/devicetree/bindings/*/litex,*.yaml
 
 LIVE PATCHING
 M:	Josh Poimboeuf <jpoimboe@redhat.com>
-- 
2.23.0

