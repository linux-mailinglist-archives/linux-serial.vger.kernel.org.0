Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16BED2B03E
	for <lists+linux-serial@lfdr.de>; Mon, 27 May 2019 10:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfE0Ibz (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 27 May 2019 04:31:55 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:44924 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfE0Ibz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 May 2019 04:31:55 -0400
Received: by mail-pg1-f169.google.com with SMTP id n2so8687199pgp.11
        for <linux-serial@vger.kernel.org>; Mon, 27 May 2019 01:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PGMGnU7bw686SIdW3vgxfTructN9L6Cf5iAj7/YhEG4=;
        b=C/UKJrAxvjKIJGfm3LByb902UV/Wo/Aiirw35D0zlboFcOYF5a3E/70eLACjFK7zs+
         flUZAq8e05EY9pPd8DGdCGjbk6PDoWi7+ut7hfWp0V6BJ6DyKTw/l3Tpdo99zArp//kC
         pilyuTG5GpiseAo0anjmyBBI5TC9D10yDSSaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PGMGnU7bw686SIdW3vgxfTructN9L6Cf5iAj7/YhEG4=;
        b=RatLiYH0bPOa5fNAYaHo3ZoyK1A5A57H95FE4xmd/WWKqDYPKkXcKtp0TEIwdkNxIV
         C7TPAa/rjs9mtIUNU3+zp3ZhLdNkJcdWM6u0IEi/tB6yDvBQ2xP/zWk5W4XnXIy1qHdL
         sRrGpWcOE8yaVKtRTPbyC/H9cMXi9BrQHMeKL7qX5JkhFSTg4N0WaacsVtRVAheFy1+/
         BWbdiOX+kQzP7SO8Zi+1r/G93mPSyH98lIKzifk/2hECiq7+ZwqPi2DR031CG2AZ0gQu
         Ey0FYzCXvUa+0wr0fP0qogQrTuFbTwrbMNsvpwJ8UT1tsioa/naZurWc9sCdL6tLYopB
         oj8g==
X-Gm-Message-State: APjAAAUzVPkmn0ozadK7plgpvlPcNeNT/OteNBuPKg7lqKaZ3szDCK/E
        WkIvVI3Si2Tx+slcvA2g+akNBpg7H9hfiQ==
X-Google-Smtp-Source: APXvYqz/asWNgFUAYKi4OWzSmEVnPj1RnEePEisMcbO3kbG5gHvCia22OVQY8buyqVMfOPBX1Y3Qnw==
X-Received: by 2002:a63:4104:: with SMTP id o4mr5363655pga.345.1558945914922;
        Mon, 27 May 2019 01:31:54 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:3db2:76bf:938b:be05])
        by smtp.gmail.com with ESMTPSA id d35sm2952236pgb.55.2019.05.27.01.31.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 01:31:54 -0700 (PDT)
From:   Claire Chang <tientzu@chromium.org>
To:     gregkh@linuxfoundation.org
Cc:     changqi.hu@mediatek.com, linux-serial@vger.kernel.org,
        linux-mediatek@lists.infradead.org, drinkcat@chromium.org,
        Claire Chang <tientzu@chromium.org>
Subject: [PATCH v3 0/2] support 8250-mtk uart in-band wake up
Date:   Mon, 27 May 2019 16:31:48 +0800
Message-Id: <20190527083150.220194-1-tientzu@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

changes in v3:
	1. remove an extra line in patch 2/2

changes in v2:
	1. add commit message
	2. drop return err in the resume path
	3. ignore disable_irq_wake()'s return value

Claire Chang (2):
  dt-bindings: serial: add documentation for Rx in-band wakeup support
  uart: mediatek: support Rx in-band wakeup

 .../devicetree/bindings/serial/mtk-uart.txt   | 13 ++++++++--
 drivers/tty/serial/8250/8250_mtk.c            | 24 +++++++++++++++++++
 2 files changed, 35 insertions(+), 2 deletions(-)

-- 
2.22.0.rc1.257.g3120a18244-goog

