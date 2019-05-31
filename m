Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC61130D22
	for <lists+linux-serial@lfdr.de>; Fri, 31 May 2019 13:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbfEaLOQ (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 31 May 2019 07:14:16 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:58750 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfEaLOP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 31 May 2019 07:14:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=F1CTo5X/x6JHGFM5zjAcKnm0WMnPjxHWthCYjvGa6gA=; b=dNLrrtOs1sngQVTKxp1xudNJRH
        tEGYix0zRZwGCZXoX16GnijgPNER1epkCZL3mhzwYtdR0kPFZifEBa4iSJPcYNVMjBN0Y6D72JhoA
        DodOGPnItiPrWmGy2Oro0qxrCwtDko2hKVJZSY0zvbvI6hwWJ53CNkwPfvhioy6rbClyVHnV6GiZp
        SpVSdVlofGiDwxiYWAjJttbNGdN8uPKyNsa2RXqgxSOWsUo7eiLPWsUYq0r8Kvurt6/+SOBgCF0du
        fWBVCmimcj3qLcey8ozUjA0bO3J8ygK+tbzjrurn/EvRS884sXdxF8NVTRimUSi5Nw5O9La78QveO
        1k7T2tjQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([2001:4d48:ad52:3201:222:68ff:fe15:37dd]:49574 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1hWfU5-0000P9-1b; Fri, 31 May 2019 12:14:05 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1hWfU3-0003fk-9R; Fri, 31 May 2019 12:14:03 +0100
In-Reply-To: <20190531111257.27hor6xgb3nsdghg@shell.armlinux.org.uk>
References: <20190531111257.27hor6xgb3nsdghg@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH 4/6] ARM: sa1100/badge4: remove commented out modem control
 initialisers
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1hWfU3-0003fk-9R@rmk-PC.armlinux.org.uk>
Date:   Fri, 31 May 2019 12:14:03 +0100
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Remove the commented out modem control initialisers.  These are doing
nothing useful.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-sa1100/badge4.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-sa1100/badge4.c b/arch/arm/mach-sa1100/badge4.c
index 63361b6d04e9..17d28b4dab5e 100644
--- a/arch/arm/mach-sa1100/badge4.c
+++ b/arch/arm/mach-sa1100/badge4.c
@@ -315,8 +315,6 @@ badge4_uart_pm(struct uart_port *port, u_int state, u_int oldstate)
 }
 
 static struct sa1100_port_fns badge4_port_fns __initdata = {
-	//.get_mctrl	= badge4_get_mctrl,
-	//.set_mctrl	= badge4_set_mctrl,
 	.pm		= badge4_uart_pm,
 };
 
-- 
2.7.4

