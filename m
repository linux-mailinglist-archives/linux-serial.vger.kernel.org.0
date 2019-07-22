Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84EAB7099B
	for <lists+linux-serial@lfdr.de>; Mon, 22 Jul 2019 21:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfGVTWW (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 22 Jul 2019 15:22:22 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39568 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbfGVTWW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Jul 2019 15:22:22 -0400
Received: by mail-lf1-f66.google.com with SMTP id v85so27456108lfa.6
        for <linux-serial@vger.kernel.org>; Mon, 22 Jul 2019 12:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B+wLTNf/Uwskbq5M303aynV2tJy9ox88Qjj+ByJiaYE=;
        b=ANdHlqKbTdBYHjMAbE0HYGNKESqdyGrOqyoFguo2nHCiTzNm+nSOlTB75vmGn9lM7o
         C0AMP0scdDw1qesdwa02ykA8zCk+pNWn00vz/h6ULYYZcQ43hGZe2JSH5l5FHPO/I1mT
         A3VSyqcnvlJ5rB/UfF1mGYDuIOHON/Xcmt3zFJ8bfZrqXJKrBYT610UeOHiW9ny7wHoz
         iTWdtLGn/EuXcwoYYXlJft8KbQjNhuq+iTGRGL3bpMlcOkIkwoxwX91vShcMjgzqWqk1
         MJlDIT07H+6EY1iF1KxhnA80tGNjUIluTF62/Rs8GIokuuwPcjmbnUdmvhr3IwhjQV8Q
         WVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B+wLTNf/Uwskbq5M303aynV2tJy9ox88Qjj+ByJiaYE=;
        b=Qfw/1Q1vjlMZ7xM7vRiKeKhtd0wcW7zTymz2nNIGLaeiYEaDYbgaCjzlmk+hGLC2h2
         P2UAzTG29wcsV41zD4/PZiiJCTGvXkdU0Q+WV568iHWi8iumtoTJRf0KWfoffAO/TSJS
         N5A1WwGQN0GpLfzouAqgf0n1AknC8/WQ5Fbv9VMvh7loXHWNIGTr9R4jy1//I04ZpSSh
         7+P34DJgyxGXZK+i4NlUsKABE6Omih2VTL4caCNsdfCr646+m3eOp/Rwq8IjmRAYgNLE
         KN9BRFWF//Or0rzGJBiOuiM+nqIpjvcx21xz/Q/LmzsVPBYphakgLBYI7b14+GY7o1EI
         ZBgw==
X-Gm-Message-State: APjAAAVG7Gu0UINv+4tmSSRccJ+YuJ/kWh3lcy/C9on80H290Hge1SgC
        tZckqOOoNgPaw+lLZb73byyDpkix
X-Google-Smtp-Source: APXvYqxybz96lY/OxtuFHly5X1VQ1wXpABYlNEv5AuhHbT96ydrSIk0EcBLs+DyXCOunCA9cPFhX6A==
X-Received: by 2002:a19:f819:: with SMTP id a25mr34288851lff.183.1563823340126;
        Mon, 22 Jul 2019 12:22:20 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id n124sm6129307lfd.46.2019.07.22.12.22.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Jul 2019 12:22:19 -0700 (PDT)
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
Subject: [PATCH v6 0/3] serial: imx: fix RTS and RTS/CTS handling
Date:   Mon, 22 Jul 2019 22:22:08 +0300
Message-Id: <1563823331-5629-1-git-send-email-sorganov@gmail.com>
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

This is rebase of v3 on top of 'tty-next', to get rid of commits that
are already adopted to mainline.

RTS signal and RTS/CTS handshake handling had a few problems these
patches fix.

In addition, minor cleanups are made to the involved code.

Changelog:

  v6:

     * changed "Reviewed-by:" 
       Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
       to "Acked-by:" him, according to his request

  v5:

     * improved commit description and added more comments for
       "serial: imx: set_termios(): do not enable autoRTS if RTS is
       unset" as suggested by
       Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
       and added corresponding "Reviewed-by:"

  v4:

      * rebased on top of 'tty-next', to get rid of commits that
        are already adopted to mainline.

  v3:

      * Improved comments in "serial: imx: set_mctrl(): correctly
        restore autoRTS state", as suggested by Uwe Kleine-König
        <u.kleine-koenig@pengutronix.de>

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

        as the latter makes sense only provided the former is already
        applied.

Sergey Organov (3):
  serial: imx: set_termios(): do not enable autoRTS if RTS is unset
  serial: imx: set_mctrl(): correctly restore autoRTS state
  serial: imx: get rid of imx_uart_rts_auto()

 drivers/tty/serial/imx.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

-- 
2.10.0.1.g57b01a3

