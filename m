Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 564B256B91
	for <lists+linux-serial@lfdr.de>; Wed, 26 Jun 2019 16:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfFZOOR (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 26 Jun 2019 10:14:17 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46350 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfFZOOR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 26 Jun 2019 10:14:17 -0400
Received: by mail-lf1-f65.google.com with SMTP id z15so1664698lfh.13
        for <linux-serial@vger.kernel.org>; Wed, 26 Jun 2019 07:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WJuUxIWdx7E9MvnriBAYHhzNHu31FVqwrxDDMgUFPw0=;
        b=PSYYc0+B4QlGEKPAY87jv8oooLRF8PAi00CHSZQE0MfEwrUyM9o0TNWpiWUQdIiwRO
         PYHviZTIn9/KBUdf6K2vzJ1ZjrHbi9guDWkTvVIxyaIOeqxMz2YnoQSDCWEg1acfynrq
         mX+PIAw5nwfMip4Wr565dSk5slef8IMdM0Qy8bIxu2L1DDCWzCZvg6euplEJmUYfrNpY
         K3BEXcUG6iS1aE98zAeVsVInm1gS+2a0W57uUZ31jLjvb93R0famcl/e3O0un/+/VzeR
         PVGlSwH2/E/0368shAT8ticd1bPb7bUrenRSEvfaBB45PsGgkz26sYiDLG3UMJ+Blmti
         8DZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WJuUxIWdx7E9MvnriBAYHhzNHu31FVqwrxDDMgUFPw0=;
        b=jyUyMaGCm7BnIXaHh7qsEkD+TCQppMZl93tgHl+ePGlEBiC+nXywFfbxbg27b02Kip
         gX6gduehVixFUIQBwGBuHTZmC06VR7RrBBSBi3mNaXNqRYQJnzpWQ5POT2r45p6g+dID
         969GVU7rwNJg2dV9QPLiqEcXLpOAWSPgriy2m0lz+Zcq32WnxZSKRg3leo77MFL5kQ5g
         uVN8tUWZenjssL7SFZ7rtjrOCtId68kFVdogfnry/SFCcK1gl1R37JIRnfZKYRLONm/H
         92NISohVGt/zgRYEFUSZXgPOIoiq5+r6ngwMslhjKILtpeR7CmqGHHuNipR+d3dRwSd1
         NvuQ==
X-Gm-Message-State: APjAAAXvguoHTpztekJcUDpnVfsXeoW3wR7Fmqx5ar1e99Z9KAbKBNWb
        B85YPgXPcRjdo8Xi9uDUvA8=
X-Google-Smtp-Source: APXvYqxc0z9OHzQhclj4HTtvYUhemdP59UMHs9KiDRvAuNViDyUoAqE676dypmM/JJBHuhpYjYQe2A==
X-Received: by 2002:a19:9156:: with SMTP id y22mr2707624lfj.43.1561558455172;
        Wed, 26 Jun 2019 07:14:15 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 25sm2863825ljn.62.2019.06.26.07.14.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Jun 2019 07:14:14 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v2 0/7] serial: imx: fix RTS and RTS/CTS handling
Date:   Wed, 26 Jun 2019 17:11:26 +0300
Message-Id: <1561558293-7683-1-git-send-email-sorganov@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <20190614072801.3187-1-s.hauer@pengutronix.de>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

RTS signal and RTS/CTS handshake handling had a few problems these
patches fix.

In addition, minor cleanups are made to the involved code.

Changelog:

  v2:
      * Appended: "Reviewed-by:" and "Tested-by:"
        Sascha Hauer <s.hauer@pengutronix.de>

      * Removed "RFC" from header

  v1:

      * Fixed in "serial: imx: set_termios(): preserve RTS state"

-+	ucr2 = UCR2_SRST | UCR2_IRTS;
++	ucr2 |= UCR2_SRST | UCR2_IRTS;
      
        as noticed by Lothar Waßmann <LW@KARO-electronics.de>

      * Fixed in "serial: imx: set_termios(): preserve RTS state"
      
-+	ucr2 = old_ucr2 & (UCR2_TXEN | UCR2_RXEN | UCR2_ATEN | UCR2_CTSC);
++	ucr2 = old_ucr2 & (UCR2_TXEN | UCR2_RXEN | UCR2_ATEN | UCR2_CTS);

        as the fix for the problem found by Sascha Hauer
        <s.hauer@pengutronix.de>

      * Reordered:

        serial: imx: set_termios(): preserve RTS state
        serial: imx: set_termios(): do not enable autoRTS if RTS is unset

        as the latter makes sense only provided the former is already applied.
      

Sergey Organov (7):
  serial: imx: fix locking in set_termios()
  serial: imx: set_termios(): factor-out 'ucr2' initial value
  serial: imx: set_termios(): clarify RTS/CTS bits calculation
  serial: imx: set_termios(): preserve RTS state
  serial: imx: set_termios(): do not enable autoRTS if RTS is unset
  serial: imx: set_mctrl(): correctly restore autoRTS state
  serial: imx: get rid of imx_uart_rts_auto()

 drivers/tty/serial/imx.c | 93 ++++++++++++++++++++++++------------------------
 1 file changed, 47 insertions(+), 46 deletions(-)

--
2.10.0.1.g57b01a3
