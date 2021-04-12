Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6499E35B915
	for <lists+linux-serial@lfdr.de>; Mon, 12 Apr 2021 05:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236249AbhDLDrs (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sun, 11 Apr 2021 23:47:48 -0400
Received: from thorn.bewilderbeest.net ([71.19.156.171]:50343 "EHLO
        thorn.bewilderbeest.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235261AbhDLDrs (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 11 Apr 2021 23:47:48 -0400
Received: from hatter.bewilderbeest.net (unknown [IPv6:2600:6c44:7f:ba20::7c6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id E434A685;
        Sun, 11 Apr 2021 20:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1618199250;
        bh=8nVxQe2nbHeXEJoGmKtLcyMdKnjX2BS4q8oiouaC58Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J328HRcJLqLeoStQyZNLZ5aTD2RQ7uQRbFy5xoz/KYh0i8y81OyPVX3D0y/P9iSxD
         p5CP+ed8vrgOitA3s8IA9FzLAdj1mngLZzlRCK8DaLDstmx7fG49SUlwKgVh0uOL7j
         0Vf5VdcwSof20Klhk31mW8XvHBz0G7BuAx7qok6k=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Joel Stanley <joel@jms.id.au>
Cc:     openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Andrew Jeffery <andrew@aj.id.au>,
        Zev Weiss <zev@bewilderbeest.net>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        - <devicetree@vger.kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH v6 1/4] dt-bindings: serial: 8250: deprecate aspeed,sirq-polarity-sense
Date:   Sun, 11 Apr 2021 22:47:09 -0500
Message-Id: <20210412034712.16778-2-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210412034712.16778-1-zev@bewilderbeest.net>
References: <20210412034712.16778-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This property ties SIRQ polarity to SCU register bits that don't
necessarily have any direct relationship to it; the only use of it was
removed in commit c82bf6e133d3 ("ARM: aspeed: g5: Do not set sirq
polarity").

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/serial/8250.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index f54cae9ff7b2..491b9297432d 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -188,6 +188,7 @@ properties:
       offset and bit number to identify how the SIRQ polarity should be
       configured. One possible data source is the LPC/eSPI mode bit. Only
       applicable to aspeed,ast2500-vuart.
+    deprecated: true
 
 required:
   - reg
-- 
2.31.1

