Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB7ADB4EFF
	for <lists+linux-serial@lfdr.de>; Tue, 17 Sep 2019 15:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfIQNTM (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 17 Sep 2019 09:19:12 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45873 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfIQNTM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 17 Sep 2019 09:19:12 -0400
Received: by mail-qk1-f193.google.com with SMTP id z67so3884446qkb.12
        for <linux-serial@vger.kernel.org>; Tue, 17 Sep 2019 06:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=y9WGLrKKo8Mkmz25tH5PKr+ryw2VCq/9Rb24CinmnPc=;
        b=G4742H6+c5HXp7NKayVefS8q9iEn3EZcdnSAYjvT9MLpnzHJKBAEHq7dSd2tiGREvn
         QxbQUPEHbiWMJVtV1rzefcVnQJeRC+12Ciys2cR2qNVuAqtBuQIZSme9J6lojTxsxZcs
         WmGUA/gGbhxE17e2YsL069WNjJcUuPoYQ+UigYJ0gJQcp+7v0HxFiTDXsnDNwpsRK2ow
         EPTb3ZQ58M8MCWD5wghHSLIbHWWLc+dqg0b+GkEfrTWuuhviSs/4IHuLfInYXsIFsvWm
         y0PkI+J3kSAjPyWi9yE/2JjfssmqlSyQIL+rW0JHmwDZvSlQhCekDlhbk5MH8D2u0Zms
         75Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=y9WGLrKKo8Mkmz25tH5PKr+ryw2VCq/9Rb24CinmnPc=;
        b=R3dwMpPsigxsoWL8cwNq+trp7VF59nAREyogsS8P5J7ozt+i3OCC/Y3Ddgf5KMvExG
         QTpsJJJjhVWesrN4d5Wo+Fog9L0sJuWwLahrDYWSipt+OSQPsj9vUbo84+RfY8r4Eq0L
         r/3gRnRHHPVeoQFl32fw9EHdym0XMQZC0r1QgBAK+mWt/kWRg83cITVudZYD3jUfN5hj
         yF1D1sdwepiXd6mRQCNTut83BAFKROXCY9hwfQprv4ekcvrOYPgPESAkutGiaW+ZQy6j
         ypgwo0QUJ++m0zT7bpzSz2JUIiFzkPpgyxbvVKs2NaqWZLkZWAqOPgzhC4zHG2mD618A
         KY1w==
X-Gm-Message-State: APjAAAUq44HpzJ5GvOh2poaRRaJV46dZxJIgnlmYkZW3eQIQbr2W5icF
        mld3w/U45ApyfSz7nvXyZRvK9A==
X-Google-Smtp-Source: APXvYqxrJy4rG5OBkjx64ujR31ERVUX+Ep+FcVymYk+DtsTFlFvsmfXl3LXDJ4xE/5Uhk7FWLrNA+g==
X-Received: by 2002:ae9:d885:: with SMTP id u127mr3575112qkf.109.1568726351778;
        Tue, 17 Sep 2019 06:19:11 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id m19sm1074152qke.22.2019.09.17.06.19.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2019 06:19:10 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     linux@armlinux.org.uk, gregkh@linuxfoundation.org
Cc:     jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] tty/amba-pl011: fix a -Wunused-function warning
Date:   Tue, 17 Sep 2019 09:19:00 -0400
Message-Id: <1568726340-4518-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

pl011_dma_probe() is only used in pl011_dma_startup() which does only
exist when CONFIG_DMA_ENGINE=y, so remove the unused dummy version to
silence the warning.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/tty/serial/amba-pl011.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 5921a33b2a07..91b59f1cd3e6 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1236,10 +1236,6 @@ static inline bool pl011_dma_rx_running(struct uart_amba_port *uap)
 
 #else
 /* Blank functions if the DMA engine is not available */
-static inline void pl011_dma_probe(struct uart_amba_port *uap)
-{
-}
-
 static inline void pl011_dma_remove(struct uart_amba_port *uap)
 {
 }
-- 
1.8.3.1

