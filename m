Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0003724AAA
	for <lists+linux-serial@lfdr.de>; Tue, 21 May 2019 10:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfEUIrJ (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 21 May 2019 04:47:09 -0400
Received: from mail-pl1-f172.google.com ([209.85.214.172]:36916 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfEUIrI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 21 May 2019 04:47:08 -0400
Received: by mail-pl1-f172.google.com with SMTP id p15so8107917pll.4
        for <linux-serial@vger.kernel.org>; Tue, 21 May 2019 01:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cBQpnNC7cx5OsBOJCw5hI7DNKrfhdtLUAlzCJ/LaMss=;
        b=WslhLKd9eAkgA9Co/HbEn3iQLbkReIdUXiscIHlchHPMfiBoC4KOJen645cNJYFgYf
         GCaiY+EOVaaRfIgTiiw3Km8tr5qXoq57xF2v6ghsDUsH0rP4e5wcTtjOkxI2jvTG1Z0r
         LyWWC09Ye3SvEq58GIY+1ZW41HNbZXHyPbI2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cBQpnNC7cx5OsBOJCw5hI7DNKrfhdtLUAlzCJ/LaMss=;
        b=KAcWhA1Mghedqu2vv7WwwTnUjRgAcn45/NJKDdOyjjPBbZ5LmTOXKz7qK/TqdmxNS2
         CquW98C5I1+y4U5En3BKeuwsX9Fe2uGxjyB2QXSo2kiKEMh4+LFON05utFFCl9DpE/BB
         1VwS48Gyi69X70eemHaYKX8XrpKOJCu69FlOM4T+j+xNfwcilD5y6nm00GzPTBXl61bM
         lfmPihQ1xTPezAx7fXndxj9Spcyk6i/lWl1q6slK6c1p8IsXi3rhptAKGCB52KrbyoMG
         4KBIWtyzftTOzn/cRDQZ8/VW6vEJca/4UqS7HT+ABsQYnMvRrJ3Fvt1EXetPHO72vRFs
         s9EQ==
X-Gm-Message-State: APjAAAVN80Wsf+4zFWoxcoMHoaf9AioFgKiEVqv2VT+PEiETd6M8++UG
        w6/vdszuRKRiAEBkBLyMdckSzA==
X-Google-Smtp-Source: APXvYqyBT8UBQCsPh/fg2sRbFs9aVUy6oJxHY0tUrJssB44cn3L2H7g0apXMGmMtCBcUuyzyw2vXGg==
X-Received: by 2002:a17:902:169:: with SMTP id 96mr33484592plb.272.1558428428380;
        Tue, 21 May 2019 01:47:08 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:3db2:76bf:938b:be05])
        by smtp.gmail.com with ESMTPSA id r138sm27845868pfr.2.2019.05.21.01.47.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 01:47:07 -0700 (PDT)
From:   Claire Chang <tientzu@chromium.org>
To:     gregkh@linuxfoundation.org
Cc:     changqi.hu@mediatek.com, linux-serial@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Claire Chang <tientzu@chromium.org>
Subject: [PATCH 0/2] support 8250-mtk uart in-band wake up
Date:   Tue, 21 May 2019 16:46:59 +0800
Message-Id: <20190521084701.100179-1-tientzu@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

enable irq wake on an edge sensitive interrupt of Rx pin before suspend to
support uart in-band wake up

Claire Chang (2):
  dt-bindings: serial: add documentation for Rx in-band wakeup support
  uart: mediatek: support Rx in-band wakeup

 .../devicetree/bindings/serial/mtk-uart.txt   | 13 ++++++--
 drivers/tty/serial/8250/8250_mtk.c            | 33 +++++++++++++++++++
 2 files changed, 44 insertions(+), 2 deletions(-)

-- 
2.21.0.1020.gf2820cf01a-goog

