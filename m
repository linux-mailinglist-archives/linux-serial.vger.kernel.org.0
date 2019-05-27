Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1F6C2AEFC
	for <lists+linux-serial@lfdr.de>; Mon, 27 May 2019 08:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbfE0G4G (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 27 May 2019 02:56:06 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:36432 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfE0G4G (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 May 2019 02:56:06 -0400
Received: by mail-pf1-f169.google.com with SMTP id u22so1719293pfm.3
        for <linux-serial@vger.kernel.org>; Sun, 26 May 2019 23:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TeNy7RkvUC/tZIz1EDVrSnZnLU7u1m9Wj+LAMsx50Jc=;
        b=eFgp3V2hvv7JafUIy375NmPswn7jajZjuQkt7lJRS4JAQVdZJ8Mhh0XBIqNoI3LVpG
         Vbl2+8WCQXIufkTOJ08L1GQtsryPmknnmkSaUPn45jlpavim2u4oFlnfL0G7gjixJ+Nt
         KDC0Pqu6LOZ8cQ7Cc9o8jWjn6PGPUGr8rleJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TeNy7RkvUC/tZIz1EDVrSnZnLU7u1m9Wj+LAMsx50Jc=;
        b=NskrNEX0Br/tChIO+g6nnCtK/dCu5n/4GmLQttzymoYpGBLJmtTdi0vrUSjZpFrPPc
         DmOr6fuXsv0nhvnP6jWbJEdPGfoO9kaDTgV8ibUwhkVue4fpuX42iuPZ5J445wyHQgsF
         ZU1dmCLi/tP9MqjuD1m3qbQazrTE9rhgCh69iFRC8NJN8nvJkm6jPROfm1Y7PAZiXml0
         Pz5N4wDkCNzdvRsvjVidSCnMc0eXQ7fxDcPcknhvwEhOjrNF0+iGUOUAed6MoQCK347f
         K4zhupX+GFnyoefaIBFZ/6fh/Jswmu6nYEHqkWDFtBIqzX4CPpAmcsRLvIujnDjQq7gg
         jSHg==
X-Gm-Message-State: APjAAAW0ujIr/CYEriQRx80bfpSia61tP8hEFRJKN+Z5lOY5DlxS8toz
        TIWlZe2gskZXRX95IGBTA719Gw==
X-Google-Smtp-Source: APXvYqyUuaOndaoSwbxgEgdDYQ3O0ZdeC94zB9K+jNz+W0jsMNQ5zp3Pgxj9Iz2WqwJOydRXgOzREw==
X-Received: by 2002:a63:7443:: with SMTP id e3mr28520078pgn.391.1558940166061;
        Sun, 26 May 2019 23:56:06 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:3db2:76bf:938b:be05])
        by smtp.gmail.com with ESMTPSA id n12sm9469049pgq.54.2019.05.26.23.56.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 23:56:05 -0700 (PDT)
From:   Claire Chang <tientzu@chromium.org>
To:     gregkh@linuxfoundation.org
Cc:     changqi.hu@mediatek.com, linux-serial@vger.kernel.org,
        linux-mediatek@lists.infradead.org, drinkcat@chromium.org,
        Claire Chang <tientzu@chromium.org>
Subject: [PATCH v2 0/2] support 8250-mtk uart in-band wake up
Date:   Mon, 27 May 2019 14:55:57 +0800
Message-Id: <20190527065559.66056-1-tientzu@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

changes in v2:
	1. add commit message
	2. drop return err in the resume path
	3. ignore disable_irq_wake()'s return value

Claire Chang (2):
  dt-bindings: serial: add documentation for Rx in-band wakeup support
  uart: mediatek: support Rx in-band wakeup

 .../devicetree/bindings/serial/mtk-uart.txt   | 13 ++++++++--
 drivers/tty/serial/8250/8250_mtk.c            | 26 +++++++++++++++++++
 2 files changed, 37 insertions(+), 2 deletions(-)

-- 
2.22.0.rc1.257.g3120a18244-goog

