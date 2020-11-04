Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5170B2A6E0C
	for <lists+linux-serial@lfdr.de>; Wed,  4 Nov 2020 20:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731106AbgKDTgX (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 4 Nov 2020 14:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730971AbgKDTgU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 4 Nov 2020 14:36:20 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0CBC0613D3
        for <linux-serial@vger.kernel.org>; Wed,  4 Nov 2020 11:36:20 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id w1so23361862wrm.4
        for <linux-serial@vger.kernel.org>; Wed, 04 Nov 2020 11:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZRGBxzQtBfGTRe7EqXYUnIcL2t2WHoGJ4hWtx+aHv4c=;
        b=YHTiFMRkE/9n47TPA+A1i93yUz5O+ImX7W2Xhyx04uUSduApku9suwx2FzSaJonUjv
         a5PHQ0i/GK4CbcDeK70V1zA0ZOBWfJ3fk2Uv4lCIVFBs5FB5EQq+t3ocSxZLRV1r/XHO
         x6VwGq7e99bbQT4nil61aoKB0hqOdR4mlrIB5dxW6Cps44btfF82dRoyEb1OkrIYS8VX
         BfcindWv8Z9YWFBpW++7Sr22VbItLakxYMCWqAxVYZBPmYGoWSmEM9JKNH6ECbm8faHs
         qf5Ab9xOaLJGu7XkIhax8pLb5i7yP7YFn6q39FTKiOk0D+mQGZgEkeimJfS6FW5KLv8e
         dDQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZRGBxzQtBfGTRe7EqXYUnIcL2t2WHoGJ4hWtx+aHv4c=;
        b=OqgK0Kv5coZ/0Pqe8gldhZIrXjeYqCmFcbSDhq2KNicyBi/D90nEUQLKN5lZzsWNXR
         GPWXBQzObpzD6k4/pTlfah+tkiAAfCTIuZ4p//TWVVZKKI4HgqJJBzoSjsrmYoNLgl84
         /iAie0LdnHKTUBZ008HWLZkPJy7Xo90/fJ7Je1w2AAlruH51khw53ghrOSfaZY+5FsEa
         iX9kPPW0kZwvZOwhIBQz04lz217CHABj2LEN7SnjX+CxGLanKLpiQ5eG+fvin0xuzfhl
         FnA357OSewVsQ+nwYgQMsIxQ0UkVwdpQmV5AvDeVAAk1A4IzPiGplnq210HvOg9Uq/E6
         zS2Q==
X-Gm-Message-State: AOAM5319vvIeVrQVhYb5Arg3Fm/LvQ33aFvFBhuFp50zyWp+BF/PhA1y
        vbX02Ag2sZTXnooFpVQb/hHvbQ==
X-Google-Smtp-Source: ABdhPJzjdlEHI3sL271W1qkBQa43pmdUJBTxOaZr9G05Uu6C1ihR+7MN/MOPLi/I6w4LuoxiC4k5Ng==
X-Received: by 2002:adf:c101:: with SMTP id r1mr32418679wre.87.1604518578909;
        Wed, 04 Nov 2020 11:36:18 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id x10sm4034444wrp.62.2020.11.04.11.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 11:36:18 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        "David A. Hinds" <dahinds@users.sourceforge.net>,
        linux-serial@vger.kernel.org
Subject: [PATCH 14/36] tty: serial: 8250: serial_cs: Remove unused/unchecked variable 'err'
Date:   Wed,  4 Nov 2020 19:35:27 +0000
Message-Id: <20201104193549.4026187-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104193549.4026187-1-lee.jones@linaro.org>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/tty/serial/8250/serial_cs.c: In function ‘multi_config’:
 drivers/tty/serial/8250/serial_cs.c:562:7: warning: variable ‘err’ set but not used [-Wunused-but-set-variable]

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Colin Ian King <colin.king@canonical.com>
Cc: "David A. Hinds" <dahinds@users.sourceforge.net>
Cc: linux-serial@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/serial/8250/serial_cs.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/serial_cs.c b/drivers/tty/serial/8250/serial_cs.c
index e3d10794dbba3..35ff6627c61be 100644
--- a/drivers/tty/serial/8250/serial_cs.c
+++ b/drivers/tty/serial/8250/serial_cs.c
@@ -559,16 +559,13 @@ static int multi_config(struct pcmcia_device *link)
 	 */
 	if (info->manfid == MANFID_OXSEMI || (info->manfid == MANFID_POSSIO &&
 				info->prodid == PRODID_POSSIO_GCC)) {
-		int err;
-
 		if (link->config_index == 1 ||
 		    link->config_index == 3) {
-			err = setup_serial(link, info, base2,
-					link->irq);
+			setup_serial(link, info, base2, link->irq);
 			base2 = link->resource[0]->start;
 		} else {
-			err = setup_serial(link, info, link->resource[0]->start,
-					link->irq);
+			setup_serial(link, info, link->resource[0]->start,
+				     link->irq);
 		}
 		info->c950ctrl = base2;
 
-- 
2.25.1

