Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35D10A09BB
	for <lists+linux-serial@lfdr.de>; Wed, 28 Aug 2019 20:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfH1SiH (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 28 Aug 2019 14:38:07 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44615 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbfH1SiG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 28 Aug 2019 14:38:06 -0400
Received: by mail-lf1-f68.google.com with SMTP id v16so358220lfg.11
        for <linux-serial@vger.kernel.org>; Wed, 28 Aug 2019 11:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xCaK1ced0ulZ5Oi9MjTSpYNGY2zdz0BpkWuSplpvYpM=;
        b=DLDXIOeukCSaR4ozFwatuOZ0GeW1Fdfn4XiPmOgxc+Htze5r+wmOShGgoki8kTD5dL
         RpLUyDw6fgLbP5W9jBazIJRLTJfLaEzmDrqCWslsN+DHvQAH2MpRpmPJzN1gqyIRfv0h
         teXXeWouWgOUsWdbsbcu1BvN0MeB/DD2aUrB+DcNeX9bueneDq1EN6cBNbdTQS4fDhdx
         r1LMrh6kEH5ICvnfgshJvOnKmJJXsZTXpRgAH3UPp7iG21wTL35XSIHpURAQSJyuOwIb
         FazZFZrgskbu3HMsijJfKtNwcgxfh2pM0M755q+1vKr3QYM9WSYRo+SCv/gAqxG4ynAB
         2MLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xCaK1ced0ulZ5Oi9MjTSpYNGY2zdz0BpkWuSplpvYpM=;
        b=kHAJ97i3CyRcc+r48WI7lnlhBh/f8TJaL+Zkyii056i3g4QUwx7KDF33l5UHebTB1R
         eewa4sDRZI41FM7qSAwbsQWvoQ6NVFf4TavwjZzIKz38PXnxJqhVpuVvK/y9lExBW27v
         vUyOnOgFA7HmXnExWfxCo7TOxg7TF/AFloqeAOlxUITsgGrAPok+62pxihx/hXaz1EiZ
         Q10eZOEMacC43gKbO2PZ8c2k7AfAfr+NDmybJ5ToEZtUD5p9L1wRrby+N1MtoWZmF2Q3
         avFMvAQAsdP9dxRp0b1yFYxgA6oXAfo/4XU0+EhobffyIAeV9WLyD7I+4HJdSB0d4tfX
         3QHg==
X-Gm-Message-State: APjAAAUh2NUldJVbTvhInlTvOrC+SySUyq3lwPU5zBCiket1tf6kil6G
        THOFIQP8iB2lqNlyJFHGPkACWvOT
X-Google-Smtp-Source: APXvYqxZcQaMXFbFrhwlGpA29oI6ZlxWY2I7KCR8fOMirHvzdALnfMPFwVHc24srptHbofDqkM/lEQ==
X-Received: by 2002:ac2:4558:: with SMTP id j24mr3364247lfm.54.1567017484096;
        Wed, 28 Aug 2019 11:38:04 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id f6sm9226lja.16.2019.08.28.11.38.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Aug 2019 11:38:03 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v2 0/5] Serial: imx: various fixes
Date:   Wed, 28 Aug 2019 21:37:50 +0300
Message-Id: <1567017475-11919-1-git-send-email-sorganov@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <20190530152950.25377-1-sorganov@gmail.com>
References: <20190530152950.25377-1-sorganov@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The original problem that caused these changes was broken bytes being
sent/received at random on RTS/CTS handshake switch (i.e., on
setting/clearing termios CRTSCTS bit).

As it went, a few other problems were found and fixed, and then the
fix for original issue has been split into multiple patches that seem
to make sense by themselves. Thus, the "serial: imx: fix data breakage
on termios change", that finally fixes the issue, depends on 2
preceding patches.

The last patch in the series, "serial: imx: use Tx ready rather than
Tx empty irq" is independent of the rest and doesn't fix any serious
issue, but it should get rid of holes in continuous output,
specifically in PIO mode.

Changes in v2:
  - Removed wrong [PATCH 1/8] serial: imx: fix DTR inversion
  - Rebased on top of "tty-next"

Sergey Organov (5):
  serial: imx: get rid of unbounded busy-waiting loop
  serial: imx: do not stop Rx/Tx on termios change
  serial: imx: do not disable individual irqs during termios change
  serial: imx: fix data breakage on termios change
  serial: imx: use Tx ready rather than Tx empty irq

 drivers/tty/serial/imx.c | 56 ++++++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 30 deletions(-)

-- 
2.10.0.1.g57b01a3

