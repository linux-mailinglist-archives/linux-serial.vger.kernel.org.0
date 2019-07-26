Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72573771A5
	for <lists+linux-serial@lfdr.de>; Fri, 26 Jul 2019 20:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387904AbfGZSxU (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 26 Jul 2019 14:53:20 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43902 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387763AbfGZSxT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Jul 2019 14:53:19 -0400
Received: by mail-lj1-f194.google.com with SMTP id y17so27873710ljk.10
        for <linux-serial@vger.kernel.org>; Fri, 26 Jul 2019 11:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G0pHjtARnD3Hiwz8gSdS85wwMBwqGQevX+xPBDAniJs=;
        b=qCghrCzQKAGpYOOOHD7PDVhM5Ss6B8u2HhhzDVPLZuUGLBtDgr9yO4JqBzxECygNzu
         tG48/gg2oizX/6DKgJaWrw+2oCvZT5NLMo+pmW14r7GPFpeWdPOCRZp4eMhpGaAI2CH8
         Y7Z5uQfiSut6q0xEEM+vkv+deYQ4cdNf1UCmmZqIpUi6z60Qn4zXVEj6KdE2IJH7711I
         N9+b+PZWTaBnbq4XDDivmieh795B+uGGeIcbUNoMNlnQz9bdgP+4xvG+mFiFEnDSQdCv
         lYLgShRT4WSrfqrzeVctEm7nGodUSl99ejeCQQEYcC1K/IeAx6hegsoqLfatWlyJ9hNG
         5D+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G0pHjtARnD3Hiwz8gSdS85wwMBwqGQevX+xPBDAniJs=;
        b=lbtFMy9de0OLvkOxDVEex2C3hgt2TqyL9DYpW9i1dWIz/Nv1UJr0KQZG8ubyyJv+4v
         hZEwPf3Kh5lTuv1dfs9dDDGD7j5UznaIG2prdHmEDR9MCXqhu0wnNmrAq8OdeoJGJMsQ
         A7wCECLKErr38PMCsv43HKVyu3ww6LOSo2eO1jRG9E3imlsYoCBGQXPSiTDfMJnMAS5m
         JO30r0BzQ5asSEYfBNCG2Ra8ihosOJkVRv/0WdSvho5XDMgujSKdHfRJ8CX1k8dwiNKi
         e12dnM7IfvrD1LtAyNrLG/sGJL71VHFOQ2emvvXrKDHn83pikvNobcovUM6MtYv16etp
         /JCA==
X-Gm-Message-State: APjAAAWRVpGhsaJejH/yxFS4hDmFQXxibhDl9hcclRC1qh1ipUpeP+Fr
        /aRxmLVe5qnMGNvWJz4u5HKdhE7L
X-Google-Smtp-Source: APXvYqykUbpm1J2/esFYVf8rB4ei0UaA7a3QsZK/bSaOQhmiQdwfK7jxuVHXla21NvBQTuI3gkhn0Q==
X-Received: by 2002:a2e:7013:: with SMTP id l19mr51336336ljc.141.1564167197848;
        Fri, 26 Jul 2019 11:53:17 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id u15sm10254810lji.61.2019.07.26.11.53.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jul 2019 11:53:17 -0700 (PDT)
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
Subject: [PATCH v7 0/3] serial: imx: fix RTS and RTS/CTS handling
Date:   Fri, 26 Jul 2019 21:52:38 +0300
Message-Id: <1564167161-3972-1-git-send-email-sorganov@gmail.com>
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

  v7:

     * removed "Acked-by:" Uwe Kleine-König from
       two last patches where they were put by mistake.

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

