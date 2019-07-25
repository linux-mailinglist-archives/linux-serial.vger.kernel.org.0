Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 389EF7471B
	for <lists+linux-serial@lfdr.de>; Thu, 25 Jul 2019 08:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbfGYGXW (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 25 Jul 2019 02:23:22 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35259 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728825AbfGYGXV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 25 Jul 2019 02:23:21 -0400
Received: by mail-pg1-f194.google.com with SMTP id s1so16164848pgr.2
        for <linux-serial@vger.kernel.org>; Wed, 24 Jul 2019 23:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SKeRVtWPpX2z2aupFYsAn/DuYt86HP/HmwWHClDFuVM=;
        b=Wj/T7ChgzV4bhBgIVKnPIFJHBpzSf6kstrzU3AIGnPEXY5r3Ie+R4xa49Rsu7WeDLb
         skksDmIENXbzU/hPc8VjsYFAx35SAmUucpgLjO+hWDTmYwZNVaqOfGQ+adk4HxoIZ9vx
         D6nGFAyzi30qOVZx66t5vqGV04sT0rele/30LXyHZPlLL31aSG5QjXGAKs3aq5AfQqYQ
         24h3m1AOHaHZYDrOzS7dKJcO8dG+iJG5aRLofIqLCM6MhFNbEaOsXFOqi2uZXaxxGkN/
         DUnXeU7zn1hQjnVTdbPCYSf+7huNmvKrFElKO9f5GSxUm4DoZzjmIGSO9Ms94bqnFBaH
         NjXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SKeRVtWPpX2z2aupFYsAn/DuYt86HP/HmwWHClDFuVM=;
        b=TJtuzvxBjboEdb1dcodUo9I+Eq5ZFGVuI6wwLja8kngv1bRq8rU4lWeH9UmYu5sOWE
         YaDxtoM09E+02JeaY1cnD/cX3Xs/lqai3vYbXlsK2zuhuNhpB1tucrQufg5KUuqA0rSz
         KOsOQqJHhL5gYHM0M5v0xbXCgeQliY67Zi8JP+FV3FKyY63uIRj/YS/XIkCmlKIGagkt
         0g9gApfwbouZDOaIoEhh2a+f51pF8PnP7uwNJA7myfSc1f8qNQuMtWXgnyQM9BvI/mbZ
         dayyTVYzU+B7920N4fPyfpKrrTBZRBnso4tNi62v+Oyuf6qg8rUDLOX/ccM8s1ImD4D9
         ziCQ==
X-Gm-Message-State: APjAAAUjLDi4DFX+kcwDmDkg7WGIMwJMFknIAzLVpiubZdygev1hlBTG
        tO19xf7TJ4JfJ/OGX7+aXbq3vtD2mMM=
X-Google-Smtp-Source: APXvYqwyJx3vJ8qtdOwegK8SMHND3nRT9vcnE2cBLPneNCulfTmuM4z0CIfmu6pd8uzy46ubJkSGCw==
X-Received: by 2002:a17:90a:970a:: with SMTP id x10mr92356112pjo.12.1564035800753;
        Wed, 24 Jul 2019 23:23:20 -0700 (PDT)
Received: from test-System-Product-Name.sunix.com.tw (114-36-237-209.dynamic-ip.hinet.net. [114.36.237.209])
        by smtp.gmail.com with ESMTPSA id g11sm50550467pgu.11.2019.07.24.23.23.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 23:23:20 -0700 (PDT)
From:   Morris Ku <saumah@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, morris_ku@sunix.com,
        kai.heng.feng@canonical.com, tiffany.wang@canonical.com,
        Morris Ku <saumah@gmail.com>
Subject: [PATCH] Add driver for SUNIX serial board
Date:   Thu, 25 Jul 2019 14:23:08 +0800
Message-Id: <20190725062308.7986-1-saumah@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,K-H,
Thanks for review, my replies are inline:

Signed-off-by: Morris Ku <saumah@gmail.com>
---
 0004-Add-driver-for-SUNIX-serial-board.patch | 36 ++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 0004-Add-driver-for-SUNIX-serial-board.patch

diff --git a/0004-Add-driver-for-SUNIX-serial-board.patch b/0004-Add-driver-for-SUNIX-serial-board.patch
new file mode 100644
index 0000000..56909d2
--- /dev/null
+++ b/0004-Add-driver-for-SUNIX-serial-board.patch
@@ -0,0 +1,36 @@
>On Wed, Jul 24, 2019 at 07:26:47PM +0800, morrisku wrote:
>> This patch add support for SUNIX serial board.
>> 
>> Signed-off-by: morrisku <saumah@gmail.com>

>I need a "real" name here, and on the From: line in order to ba able to
>apply anything.  Use whatever you sign legal documents with please.

I will fix it.

>> ---
>>  serial/Kconfig      |  11 ++
>>  serial/Makefile     |   1 +
>>  serial/sunix_uart.c | 357 ++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 369 insertions(+)
>>  create mode 100644 serial/sunix_uart.c

>Why can't you just use the 8250_pci.c driver here instead of a whole
>separate one?  What does this hardware need that is so different that
>you can not just add to the normal pci_boards[] array in that code?

>If you can not do that, then you need to explain in great detail why
>that is in the changelog comment in order for us to be able to accept
>this code.

SUNIX uses a mixture of bars and offsets, 
the first four ports use bar0,fifth to sixteenth ports use bar1,
8025_pci.c using different bars and offsets,
fist port use bar0,port two use use bar0 + offset,
but three to four ports use bar1 ,after port use bar2~bar5,
can not just use 8250 existing code to set up our hardware,
the configure method is not suitable for us,
therefore, we separate one driver for SUNIX serial board. 

>thanks,

>greg k-h
-- 
2.17.1

