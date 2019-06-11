Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 019033CA54
	for <lists+linux-serial@lfdr.de>; Tue, 11 Jun 2019 13:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389887AbfFKLr2 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 11 Jun 2019 07:47:28 -0400
Received: from mail-pl1-f177.google.com ([209.85.214.177]:40066 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389881AbfFKLr2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 11 Jun 2019 07:47:28 -0400
Received: by mail-pl1-f177.google.com with SMTP id a93so5016552pla.7
        for <linux-serial@vger.kernel.org>; Tue, 11 Jun 2019 04:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=accesio-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=hKAO+1LkRuH2J4+8xLUuHjj+12TKH3GY++ZxSeB8iTE=;
        b=oU8jj76Rb4J4B2qmdLTQ/O1P+/miyVJoosCpeeLBTHT4AgswFo8+OeVdXgp78Nu00d
         4WOJJ81de0tH+jbTsovFf/KOCZgHAHuTPIJ1kIW4vkcJBRx6nNptTlCBzT5rKicZePm7
         4tXG4yiN+wrCxCzhDsGS9QhZA2fUULQ9O1mN4ndYEI4U2bc58pWtAmF6QmVkDgHI3tr+
         Pg0tdvKKBvmutzFrfR+UxfkIbar81MeXdszSoPT3AYyIi4U/QRvXkxgRCjqGyhtF6Nou
         8DM/gvIPCFR41G4WhGGDhEeBLKcfjUgvRnkDobd2VE1cA5IMUuEZqOfmhwdlE7ABirkz
         GXJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hKAO+1LkRuH2J4+8xLUuHjj+12TKH3GY++ZxSeB8iTE=;
        b=MPONYyK1zbnq3XcSvrSA4JtYwTKjFDzuMtUi3iFURtGhj1Vqa8wV7VthnrE344j9/K
         i6fLDVy118kq3xLw2Sx7ooGEbDs4VM6X5bY9Xx0dUB+4eL6uaV5Uy6fNAlCWWGgXFdg7
         ydvMiiUDumGCD8bt+ioYRKb1v+yhuW5l+0+yS9biJj7EUfkt3QKgq+k6cuxiI8EOXD8R
         a1DRkdbEjX8lGKsM4gw1xMX9KAfbTR7GQLEBns8X7gATGcJ/BzyaL0djl7JBBsGcRu0w
         i6mNP+OpyZGHE4wPdvzzFQMSgzTOlnOfI1VbzxNcGgh/NZqdnCy0YPwjlPxNel0sCoA9
         qzQA==
X-Gm-Message-State: APjAAAX5vdALSEMBGcDLm4TFbGv2bJev/e74WVPp1n9sH9e8qNIU9kBd
        X3niDKugMOi9G1a7G33WdlC0ceqhzAKZRtxCXvCcbG8JdlOVI5BaghZjGi00J5ewVMTp7iFb5wj
        pCdRn9NPph9npPgQRgJ+Dh9Ie2SVLdNY0InIOfa7CGEq0pCZAVG6py2hd0zqIWHa50vGSnTBcex
        al
X-Google-Smtp-Source: APXvYqzFG1FA3C7XNtxvA8ji9ZRDrWFq19aXtbfMiXjHjqDzUx+H/28B59/DU5G6K8aMRkA6YsnNHw==
X-Received: by 2002:a17:902:b110:: with SMTP id q16mr68123230plr.218.1560253647593;
        Tue, 11 Jun 2019 04:47:27 -0700 (PDT)
Received: from acces-pc.dolannet.net (cpe-70-95-148-49.san.res.rr.com. [70.95.148.49])
        by smtp.gmail.com with ESMTPSA id 25sm14174078pfp.76.2019.06.11.04.47.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 04:47:27 -0700 (PDT)
From:   jay.dolan@accesio.com
To:     linux-serial@vger.kernel.org
Cc:     Jay Dolan <jay.dolan@accesio.com>
Subject: [PATCH v4 0/1] Add support for higher baud rates to Pericom
Date:   Tue, 11 Jun 2019 04:47:14 -0700
Message-Id: <20190611114715.31372-1-jay.dolan@accesio.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Jay Dolan <jay.dolan@accesio.com>

Change in v4: (v4 is what should have gone out as v3)
1. Remove reference to define.

Change in v3:
1. Moved pericom_do_set_divisor to 8250_pci.c
2. No longer touch any other file

Change in v2:
1. Fixed whitespace
2. Don't export pericom_do_set_divisor()


Jay Dolan (1):
  serial: 8250: Add support for higher baud rates to Pericom chips

 drivers/tty/serial/8250/8250_pci.c | 97 ++++++++++++++++++++++++------
 1 file changed, 79 insertions(+), 18 deletions(-)

-- 
2.17.1

