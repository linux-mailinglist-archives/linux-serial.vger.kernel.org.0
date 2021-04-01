Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D989350B6B
	for <lists+linux-serial@lfdr.de>; Thu,  1 Apr 2021 02:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbhDAA5q (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 31 Mar 2021 20:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbhDAA5p (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 31 Mar 2021 20:57:45 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C11C061574;
        Wed, 31 Mar 2021 17:57:45 -0700 (PDT)
Received: from hatter.bewilderbeest.net (unknown [IPv6:2600:6c44:7f:ba20::7c6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 2F984705;
        Wed, 31 Mar 2021 17:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1617238665;
        bh=PTKpsiq59YVCzDvb+a0Y+GyuK4KgA1bmlXXrXsWSgms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GVnld6BIBB3+yPy40DXDBGCzsu8mpRyugYH1GBA59wK8KRirWKUYc8HNcFuSGatch
         pR2sREfK2VUa3x4nmTdnzdYgT8pz4IH56qvpOxcBlUmdY2jjpMzpzZesXJnwgdPQ8J
         tWRj1NRlh5MOmZilmBzTFNJ0pWi5xQwcGHEDkQSY=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Joel Stanley <joel@jms.id.au>
Cc:     openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Andrew Jeffery <andrew@aj.id.au>,
        Zev Weiss <zev@bewilderbeest.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH v2 2/3] drivers/tty/serial/8250: add DT property for aspeed vuart sirq polarity
Date:   Wed, 31 Mar 2021 19:57:01 -0500
Message-Id: <20210401005702.28271-3-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210401005702.28271-1-zev@bewilderbeest.net>
References: <YGOuhjD19SmjmQou@hatter.bewilderbeest.net>
 <20210401005702.28271-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This provides a simple boolean to use instead of the deprecated
aspeed,sirq-polarity-sense property.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 drivers/tty/serial/8250/8250_aspeed_vuart.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
index c33e02cbde93..e5ef9f957f9a 100644
--- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
+++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
@@ -482,6 +482,9 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
 		of_node_put(sirq_polarity_sense_args.np);
 	}
 
+	if (of_property_read_bool(np, "aspeed,sirq-active-high"))
+		aspeed_vuart_set_sirq_polarity(vuart, 1);
+
 	aspeed_vuart_set_enabled(vuart, true);
 	aspeed_vuart_set_host_tx_discard(vuart, true);
 	platform_set_drvdata(pdev, vuart);
-- 
2.31.1

