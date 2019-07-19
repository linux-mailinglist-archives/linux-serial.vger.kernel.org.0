Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D477C6E2D0
	for <lists+linux-serial@lfdr.de>; Fri, 19 Jul 2019 10:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbfGSIsO (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 19 Jul 2019 04:48:14 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45024 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfGSIsO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 19 Jul 2019 04:48:14 -0400
Received: by mail-lf1-f68.google.com with SMTP id r15so4201135lfm.11
        for <linux-serial@vger.kernel.org>; Fri, 19 Jul 2019 01:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oto3ZKEBO7uNTBw2hLUMtLU481PxrOmlSNWwS+t8hHw=;
        b=FmH8Mu9Y5vAHC3tsnVF2eOeEHybGQzFPYjcdPIEwX32vOGyLA4nJ4UTonXdC6YMts9
         aLkHWeXi30ImsHqJPxS1sPaoXe1Jfmuybs3PqFDCMT/vMoa3Y7h7PK5sHzzRj8xaXPJe
         hq95sK1wKAP1eZ5/t0aczLDoFL5nYFJpc9Y9FfYDDTxzNxH3wkxW5clm3dz0UA68GuAv
         +9YkI922HYuDhl5QVeAqzsvjiJT6jdboYER6KVagiQ5S0FSAN9xD6boVzOziEZzhTpWi
         Px/F4AHH8/OPfUuXDseFbFhcCFig3TVDEvbOtqCUZc5q2WWtPg6nyBIocxfthhq7xOND
         44/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oto3ZKEBO7uNTBw2hLUMtLU481PxrOmlSNWwS+t8hHw=;
        b=eaGepOmFJw+c5B1peSvvkHoDl5/YiW9Crjrqin0fzE2xVVTY0BQRzO3kcbusu5LyLm
         gGpEiHWsWy7MXu2ZlCuZpt3zAPvLHFn24Fu9RhBuSg7U3mkVZ9K7eVyRFLksfOKLUJS2
         osaDZInlwSRrzMr6XtwOlwJN1sEJN7swwo/5mcGKT+aCqlnass7RfrmkYHIsuwtn7Gaa
         ugRUgOi9xSiqzM5tawl8KJS7F441KOhnloyJL8TUKOrFIYlbGlpeIkwOeG6hjqkAwwLb
         7fXn6FXR0RVk0OJSRi7jnYZUuBYhJwgcXnCb8buiZesu1LzorvISEiy9nk3QmeI6x0Xz
         jKZA==
X-Gm-Message-State: APjAAAV0oEHtSJWJ19GrHfXJPRlzsUO5HaJeeQ7sRQ4njc4KkMips6Lb
        XR+RBwgv3I4KLXXxVYQuysi3fTRc
X-Google-Smtp-Source: APXvYqyP+aKWOpZc9wPTPESqYu90m/fOpcXXAVg3c5T/FoSA0Uyt5SPFiSS93ZR71XVNjYJjv8CFjg==
X-Received: by 2002:ac2:465e:: with SMTP id s30mr9546033lfo.19.1563526091674;
        Fri, 19 Jul 2019 01:48:11 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id s21sm5588742ljm.28.2019.07.19.01.48.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Jul 2019 01:48:11 -0700 (PDT)
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
Subject: [PATCH v4 0/3] serial: imx: fix RTS and RTS/CTS handling
Date:   Fri, 19 Jul 2019 11:47:51 +0300
Message-Id: <1563526074-20399-1-git-send-email-sorganov@gmail.com>
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

 drivers/tty/serial/imx.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

--
2.10.0.1.g57b01a3

