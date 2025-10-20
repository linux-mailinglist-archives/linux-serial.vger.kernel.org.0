Return-Path: <linux-serial+bounces-11110-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 283B5BF357C
	for <lists+linux-serial@lfdr.de>; Mon, 20 Oct 2025 22:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E69F94E5474
	for <lists+linux-serial@lfdr.de>; Mon, 20 Oct 2025 20:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9488B2517B9;
	Mon, 20 Oct 2025 20:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="HLOdqmeH"
X-Original-To: linux-serial@vger.kernel.org
Received: from mx02lb.world4you.com (mx02lb.world4you.com [81.19.149.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1192D9482
	for <linux-serial@vger.kernel.org>; Mon, 20 Oct 2025 20:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760991135; cv=none; b=SpuNvy/jCLAW5Lx98QxPg4DxnK0u7qNrHgNkWddIrYmCq0KFRKqp4eSqC+crBzzQVG7O8UqoswYInpoDmy56Qy+hTsU14P92yT9MUJ83ZvP9Quq9WzSaOYJ6l9v6aEOQGdNM7dHu9TM/R6dTeMjHVhkhgAGpSNKD2Wqzfz0RsJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760991135; c=relaxed/simple;
	bh=HbsPIzjkiTIf8/piF5FfzuVL5dqe3mkR9Bw5DhgVHFA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vx27mcRILswy2go3EgR73BxBKSq2pdaSZvgXe9WcqAoun5kLbLHg2gWWsTysxaXqF1wp43PK/fc6DMdNxjj7sBCw78hypZ+VXD96xqlrWMsPO/Vjtsfuz2ykqv2OCQyOur2HHAGLp+JE9baEUYzUaoCyreolQIusCA8VHafs/Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=HLOdqmeH; arc=none smtp.client-ip=81.19.149.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/yv+3NzNHvHLB+0mhrexYu7JAXxkGMkteRLzDBkkLqo=; b=HLOdqmeHQZ21/v+CFGg9k0EEkT
	Ms0Lvw5RK/vZmFcod6IcsPj5A6B+ZHcrVif0EV3A0G7K49UtrC7D9DzA+UNpMo4FNMEqw32N5mKeJ
	FmFAfIFTZFppkIhlp+pyUWWEk5Vb3xvO+zbFLIXX+D5vby63/EJi0EHXVQDbqtavTODY=;
Received: from 178-191-104-35.adsl.highway.telekom.at ([178.191.104.35] helo=hornet.engleder.at)
	by mx02lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1vAvDl-000000004Ir-35Vv;
	Mon, 20 Oct 2025 21:07:05 +0200
From: Gerhard Engleder <gerhard@engleder-embedded.com>
To: linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	lukas@wunner.de,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	Gerhard Engleder <eg@keba.com>
Subject: [PATCH v3 1/2] serial: Keep rs485 settings for devices without firmware node
Date: Mon, 20 Oct 2025 21:06:57 +0200
Message-Id: <20251020190658.30655-2-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251020190658.30655-1-gerhard@engleder-embedded.com>
References: <20251020190658.30655-1-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes
X-ACL-Warn: X-W4Y-Internal

From: Gerhard Engleder <eg@keba.com>

Commit fe7f0fa43cef ("serial: 8250: Support rs485 devicetree properties")
retrieves rs485 properties for 8250 drivers. These properties are read
from the firmware node of the device within uart_get_rs485_mode(). If the
firmware node does not exist, then the rs485 flags are still reset. Thus,
8250 driver cannot set rs485 flags to enable a defined rs485 mode during
driver loading. This is no problem so far, as no 8250 driver sets the
rs485 flags.

The default rs485 mode can also be set by firmware nodes. But for some
devices a firmware node does not exist. E.g., for a PCIe based serial
interface on x86 no device tree is available and the ACPI information of
the BIOS often cannot by modified. In this case it shall be possible,
that a driver works out of the box by setting a reasonable default rs485
mode.

If no firmware node exist, then it should be possible for the driver to
set a reasonable default rs485 mode. Therefore, reset rs485 flags only
if a firmware node exists.

Signed-off-by: Gerhard Engleder <eg@keba.com>
Cc: Lukas Wunner <lukas@wunner.de>
---
 drivers/tty/serial/serial_core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 4757293ece8c..9c476d9667a3 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3536,6 +3536,14 @@ int uart_get_rs485_mode(struct uart_port *port)
 	if (!(port->rs485_supported.flags & SER_RS485_ENABLED))
 		return 0;
 
+	/*
+	 * Retrieve properties only if a firmware node exist. If no firmware
+	 * node exist, then don't touch rs485 config and keep initial rs485
+	 * properties set by driver.
+	 */
+	if (!dev_fwnode(dev))
+		return 0;
+
 	ret = device_property_read_u32_array(dev, "rs485-rts-delay",
 					     rs485_delay, 2);
 	if (!ret) {
-- 
2.39.5


