Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 969345F8B9
	for <lists+linux-serial@lfdr.de>; Thu,  4 Jul 2019 15:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbfGDNBC (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 4 Jul 2019 09:01:02 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46829 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbfGDNBC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 4 Jul 2019 09:01:02 -0400
Received: by mail-lj1-f196.google.com with SMTP id v24so6072013ljg.13
        for <linux-serial@vger.kernel.org>; Thu, 04 Jul 2019 06:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ra8RdVFYK5DBO8QxOB3FtDU0BA7sfZz2SeBlsVeKUKw=;
        b=pHM+Vv2BkdQUcKnCaqTF40XNspUR/QDrEJbTzJhhUvDjETu77Bx0FCDoZKRTK7whJa
         TechV/0jUexK/ONmNLVT8jJJi3usdA9m7HAtYEko7kw7IFB8k6odrG74zSeOAUx7UPDq
         Cjgsb9NpQkzeyk/Q7hB11owH+BP7psfVbrRPjj7nPROZ76PhdYMxMd93qOm6TJTwUMum
         pudnmiPpettfPypUUxA4XsHBZSBevpNFVPHNuhzFyp0wUaMpjxLdIBNRn0HBhi5akzRx
         wJmRu9w4aosxVaj5nrrdaNnqfvHRp5otxc+LfXvvk4ZZPVTXm+4wEP6zL+bSEMCqKtSk
         chKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ra8RdVFYK5DBO8QxOB3FtDU0BA7sfZz2SeBlsVeKUKw=;
        b=dXT2BGYAD0HvmqVWWZVi7oxf2oUZ69ZL10jOfn2rHC/Uoa5GDY1kXO9rLJT1QwCwHj
         fJ/ibayhBCXbLkN+roHVW42yvPu0zVcxoHssN676FU+bot0H5cpWbEYJmVi15AQd5G5U
         TYjQ6irJ6iC3qhTBPBJsZNHJg3awFEyH8TyV4kBV1LYb3ruL6Sp2y3dsmkh7rEeA+V7J
         uXjBPxir6nq5/VoDN1KbxPd9T+rvsiAfmvjCv9/pVr/0oTa69vgimCEF9E6/ZgOTBq52
         /GwEgArovMsWaSKPKJ4mRMDeP0wYOsi5HdXa/vKJprVufbqo6RE3LvP+clac1bLA+Cno
         v1ZA==
X-Gm-Message-State: APjAAAUCsc4TBdeSLPtUpaLlpDcu5lAAz9OPnzCbrwKPjxbQ9nD+jSx8
        hIAy4WUgBxVmFT8+i1nKyOW2cvzw
X-Google-Smtp-Source: APXvYqzb8XllzW+5e3C12GZuMGbmsfh0gAivSO23lXyZdbBjGaQAK10G4UTz1E++PGtHB27u0ksKiA==
X-Received: by 2002:a2e:a0d6:: with SMTP id f22mr2956590ljm.182.1562245259689;
        Thu, 04 Jul 2019 06:00:59 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id h1sm485914lfj.21.2019.07.04.06.00.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Jul 2019 06:00:58 -0700 (PDT)
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
Subject: [PATCH v3 0/7] serial: imx: fix RTS and RTS/CTS handling
Date:   Thu,  4 Jul 2019 16:00:22 +0300
Message-Id: <1562245229-709-1-git-send-email-sorganov@gmail.com>
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

  v3:

      * Appended: "Reviewed-by:"
        Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
        to the first 2 patches

      * Added braces to one-line 'else if', to the "serial: imx:
        set_termios(): clarify RTS/CTS bits calculation", as suggested
        by Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

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

        as the latter makes sense only provided the former is already applied.


Sergey Organov (7):
  serial: imx: fix locking in set_termios()
  serial: imx: set_termios(): factor-out 'ucr2' initial value
  serial: imx: set_termios(): clarify RTS/CTS bits calculation
  serial: imx: set_termios(): preserve RTS state
  serial: imx: set_termios(): do not enable autoRTS if RTS is unset
  serial: imx: set_mctrl(): correctly restore autoRTS state
  serial: imx: get rid of imx_uart_rts_auto()

 drivers/tty/serial/imx.c | 96 +++++++++++++++++++++++++-----------------------
 1 file changed, 50 insertions(+), 46 deletions(-)

--
2.10.0.1.g57b01a3
