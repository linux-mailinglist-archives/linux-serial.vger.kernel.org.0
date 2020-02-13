Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEB2515B660
	for <lists+linux-serial@lfdr.de>; Thu, 13 Feb 2020 02:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbgBMBHU (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 12 Feb 2020 20:07:20 -0500
Received: from gateway22.websitewelcome.com ([192.185.46.224]:48538 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729185AbgBMBHT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 12 Feb 2020 20:07:19 -0500
X-Greylist: delayed 1368 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Feb 2020 20:07:18 EST
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 8215C128B
        for <linux-serial@vger.kernel.org>; Wed, 12 Feb 2020 18:44:30 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 22cIj78LUvBMd22cIj5kYT; Wed, 12 Feb 2020 18:44:30 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nAVrME3jdk2U+h1Uo0cXDIxJq+JDl6p8marnSwhWtzU=; b=jiL7Ay02nwKzHTQ+GYESXgdNC8
        y42tmFVVv2EFr8Rdaqwm/y7XoNgVl3P8KKj8J+hOtTs3/jwPCDRJrk7lfKq9Tk38ct7kAL057Q2+V
        daN2eajzGtkMQrQuNp3gKd0sQd6019iRF7DqqP1KUFhzuN2Q4tkJHqLYPtATQomnCp1Kv1BRI0lXX
        f+9DaOo8TJf8gIMuY+cLXVx+pLAbbjgnwKRkLqetf73DsJ2iL1hyoTzrjfGjq9I1aRyhrVtRYoQxo
        CZRGm4Mb376ere/O+dYwUzaIWBiYYg0sqxzx4lqc06EKgWaV8f1S4gQsiO6FhPkSynHj7tYZDPqM0
        iV6in4hA==;
Received: from [200.68.141.42] (port=1177 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j22cG-003j8p-Kx; Wed, 12 Feb 2020 18:44:29 -0600
Date:   Wed, 12 Feb 2020 18:44:26 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] serial: 8250_pci: Replace zero-length array with
 flexible-array member
Message-ID: <20200213004426.GA7886@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 200.68.141.42
X-Source-L: No
X-Exim-ID: 1j22cG-003j8p-Kx
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [200.68.141.42]:1177
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 58
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/tty/serial/8250/8250_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 939685fed396..0804469ff052 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -53,7 +53,7 @@ struct serial_private {
 	unsigned int		nr;
 	struct pci_serial_quirk	*quirk;
 	const struct pciserial_board *board;
-	int			line[0];
+	int			line[];
 };
 
 static const struct pci_device_id pci_use_msi[] = {
-- 
2.23.0

