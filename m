Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFBE35C9C
	for <lists+linux-serial@lfdr.de>; Wed,  5 Jun 2019 14:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfFEMWw (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 5 Jun 2019 08:22:52 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46472 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbfFEMWw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 Jun 2019 08:22:52 -0400
Received: by mail-pf1-f193.google.com with SMTP id y11so14715028pfm.13;
        Wed, 05 Jun 2019 05:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZMegKM8wWW12mRi+MHt1/qZvnpSW4OXC3WMf+x5ezYU=;
        b=nHh7huEudBGHGSGsoXcJZWNCEG8sqqMdqOdx41G7EdAa1ie0yElYinI077yIzI9dWj
         4nZq+6q6gMF9c6AevrkPCj4qo4vjl33pfqBSZ4rUzIoprPImkUmSOipVtndz9+7m3fQc
         Anv2Q6CEl6x1Jkp2E6vVLzIODq7Y2kg+/buXTcNGE+nwKBtFbUOjSCfEnUOEvsjKo1pl
         jpNoY/LMoUqm2DrkVPLjkM3jFTDN29Uu2AjVqmfTpzsdtvomdcxEt6o/hhs6fdMZU3mn
         rJ/Cjoo8nL2xpmztsLzyg9gbh9tTjEphlOwP1k/4dtYJdz2izUI6b9ZFef4Oy6BAB1jF
         bfhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZMegKM8wWW12mRi+MHt1/qZvnpSW4OXC3WMf+x5ezYU=;
        b=VQhev9BuGYtedxn6epXhlY35GSQFjD+dSNExxvkaVms0Q9A+V9ygkb4aIJT3RlWf9E
         B6WswGI0cWhpvUe65Fo0bPN3FuNfcEBhNL4j5rR3+Vlk/Z9Rg5C50o8O+wnKH0yp2x0q
         vLYo32MjIlt+rv3bJ3hkavNgjX3PyVPoNAxN0dghiJQPFxfRpai7i57SyGuZHso1lG8y
         IoNmJCh1m2G5aN4VWxOKqa+DI+pjapICzS/RqMmqR82IXputUmah57oBAyYWozKOArY9
         buu1ds0ySUVZqk67U2nl3DssDKrF16Xxzhi0Be3CnB0J9A0kiM0pedp1sA0KSCXVs7ZZ
         zxUw==
X-Gm-Message-State: APjAAAV1PN4qod47Aus9TzYi42UWGAhsmiDdcD9q6x7eqeu2qRmGIHkg
        qZkUAkasKb6L6fLHXHFVN9Q=
X-Google-Smtp-Source: APXvYqx3JLlETUC7Lz0qh6z/ky5aPPycE+3p8YvXay93Ps9ocB1UGX+LAEPMGJu4m+nDEZ9WaQLYUA==
X-Received: by 2002:a17:90a:2ec3:: with SMTP id h3mr43937862pjs.101.1559737371398;
        Wed, 05 Jun 2019 05:22:51 -0700 (PDT)
Received: from Pilot130.192.168.0.22 (211-20-114-70.HINET-IP.hinet.net. [211.20.114.70])
        by smtp.googlemail.com with ESMTPSA id q22sm3322094pff.63.2019.06.05.05.22.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Jun 2019 05:22:51 -0700 (PDT)
From:   "sudheer.v" <open.sudheer@gmail.com>
To:     gregkh@linuxfoundation.org, mchehab+samsung@kernel.org,
        jslaby@suse.com, joel@jms.id.au, andrew@aj.id.au,
        benh@kernel.crashing.org, robh+dt@kernel.org, mark.rutland@arm.com,
        shivahshankar.shankarnarayanrao@aspeedtech.com,
        sudheer.veliseti@aspeedtech.com
Cc:     sudheer Kumar veliseti <sudheer.open@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org
Subject: [patch 5/5] Documentation: DT bindings AST2500 DMA UART driver
Date:   Wed,  5 Jun 2019 17:53:15 +0530
Message-Id: <1559737395-28542-6-git-send-email-open.sudheer@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1559737395-28542-1-git-send-email-open.sudheer@gmail.com>
References: <1559737395-28542-1-git-send-email-open.sudheer@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: sudheer Kumar veliseti <sudheer.open@gmail.com>

Signed-off-by: sudheer veliseti <sudheer.open@gmail.com>
---
 .../bindings/serial/ast2500-dma-uart.txt      | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/ast2500-dma-uart.txt

diff --git a/Documentation/devicetree/bindings/serial/ast2500-dma-uart.txt b/Documentation/devicetree/bindings/serial/ast2500-dma-uart.txt
new file mode 100644
index 000000000000..ff9bb6146bd6
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/ast2500-dma-uart.txt
@@ -0,0 +1,40 @@
+
+node for DMA controller:
+                       ast_uart_sdma: uart_sdma@1e79e000 {
+                               compatible = "aspeed,ast-uart-sdma";
+                               reg = <0x1e79e000 0x400>;
+                               interrupts = <50>;
+                               status = "disabled";
+                       };
+this node  doesn't binds with any driver.
+DMA controller is handled as a separate SW layer,and is included in the same driver.
+This DMA controller node is included in DT just for Register and interrupt details
+
+
+
+node for DMA-UART :
+
+
+Required properties:
+
+- compatible: "aspeed,ast-sdma-uart"
+- reg: The base address of the UART register bank
+- interrupts: should contain interrupt specifier.
+- clocks: Clock driving the hardware;
+- pinctrl-0 : list of pinconfigurations
+- dma-channel: channel of DMA-controller which is used
+
+Example:
+
+                 dma_uart1: dma_uart1@1e783000{
+                          compatible = "aspeed,ast-sdma-uart";
+                          reg = <0x1e783000 0x1000>;
+                          reg-shift = <2>;
+                          interrupts = <9>;
+                          clocks = <&syscon ASPEED_CLK_GATE_UART1CLK>;
+                          dma-channel = <0>;
+                          no-loopback-test;
+                          pinctrl-names = "default";
+                          pinctrl-0 = <&pinctrl_txd1_default &pinctrl_rxd1_default>;
+                          status = "disabled";
+                       };
-- 
2.17.1

