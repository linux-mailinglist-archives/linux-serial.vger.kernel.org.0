Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18D84D0257
	for <lists+linux-serial@lfdr.de>; Tue,  8 Oct 2019 22:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730720AbfJHUqz (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 8 Oct 2019 16:46:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57462 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730523AbfJHUqz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 8 Oct 2019 16:46:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LKj/7Fff1CfpZBnq21VwwwS/cCFdn8vI3qeat/yQhkQ=; b=h3ds8DwrjR8pC8djYU7u6u5ry
        RGpLR1VdaW3vUz4bWpHmdEuekoZM4OBGPGui3MwcCYcgX2d+zd47Ypqc1eRkeCBEdbq1GrFN5c9ww
        mt9IEZcBaBng03XjMcPtOunGHtMu6j98wEwQ86dv606XbUjKqw6h5X35Mon3SY9+k1wnIA+MbbE7D
        zKYChpFJikxDtSpf06eULy37EwIT8sODU61JhiipTropkiV7/M0U15+ma5bRL2aZQq6j61VaHo/Z8
        JcL7zmxXIG7Hm0I7rSIX6MP/4k5q8XXiDJLah5RDXqqUEdMoGdgxPxBR9TbOCJdGJQoBWIDR7HoxT
        t2bmNVVtQ==;
Received: from [2601:1c0:6280:3f0::9ef4]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHwNh-0006Gq-Qv; Tue, 08 Oct 2019 20:46:54 +0000
To:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Peter Hurley <peter@hurleysoftware.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] serial: fix kernel-doc warning in comments
Message-ID: <e989641c-224a-1090-e596-e7cc800bed44@infradead.org>
Date:   Tue, 8 Oct 2019 13:46:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix Sphinx warning in serial_core.c:

../drivers/tty/serial/serial_core.c:1969: WARNING: Definition list ends without a blank line; unexpected unindent.

Fixes: 73abaf87f01b ("serial: earlycon: Refactor parse_options into serial core")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/serial_core.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-next-20191008.orig/drivers/tty/serial/serial_core.c
+++ linux-next-20191008/drivers/tty/serial/serial_core.c
@@ -1964,8 +1964,10 @@ uart_get_console(struct uart_port *ports
  *	   console=<name>,io|mmio|mmio16|mmio32|mmio32be|mmio32native,<addr>,<options>
  *
  *	The optional form
+ *
  *	   earlycon=<name>,0x<addr>,<options>
  *	   console=<name>,0x<addr>,<options>
+ *
  *	is also accepted; the returned @iotype will be UPIO_MEM.
  *
  *	Returns 0 on success or -EINVAL on failure

