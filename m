Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8DA26FC07
	for <lists+linux-serial@lfdr.de>; Mon, 22 Jul 2019 11:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbfGVJWW (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 22 Jul 2019 05:22:22 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44113 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727744AbfGVJWW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Jul 2019 05:22:22 -0400
Received: by mail-lj1-f196.google.com with SMTP id k18so36863502ljc.11
        for <linux-serial@vger.kernel.org>; Mon, 22 Jul 2019 02:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lrWYZGqJXzSxKADpLuyahH23cD3MUUQeJThT2mI2Whc=;
        b=depTRLXJ/ZmYHWhXEMVfUAAryrh6TYc+k7bN9TkX3l0j7uKhu0wKRH4ZK6BDbimDPt
         I5eu3yyL04yoaAH8Y8jOkcqszxrfAZtHM+rtui7QOHWbJQ+JHXU79RTlR1LZVxoNCXWa
         wrVaqnu25zkGwC/762zdYlPadRxWNMyHBKUwCVULp7g5j9whk/r0gTyff7tuqAnlpFKC
         wpvcHLyL1vIT0S1gbDRvQCtLEEDTVCfHXflx57E/+Ck8nj2wiwjXBLhBSlk7lxGYTRyg
         N/yeTNXx+cnNK7KqwOxeXhiR++6HLEy+xcuWGrXVj76DxKJV/4qEh8l/G598Y+LlPwWT
         y68A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lrWYZGqJXzSxKADpLuyahH23cD3MUUQeJThT2mI2Whc=;
        b=Pw3qkMwx6b0ESZTGj5impddI5N1zgux+Q1wv2X62B+l1XOl4g03w9WfdDBlTfPuUM3
         Ys7tlGtpEnpLD9dE+AF0G9FYIjvjZAFReNStsFLJKz5iyEz9JWTX38YHMOsnQ3v739vp
         inn0ctO6vQ+eRKCV5T6rgWXnlgIyp+pWobY2BU+DeIBWFhLhycAafqIKZ+zmYQUbq1ts
         kkW4D7EYMI9j+R/i548I+JWiVAL4/8fSlk/hNF/XlJut0HUHbHVrdyjBUR4W6vk+28TJ
         wmCgsaZMmnaxJXpVfjOR8n5XWuiUA/Ryd1OdatY8KIuKAZUYPqyYgTc6Z5vnh4HzqZg5
         T35w==
X-Gm-Message-State: APjAAAVVuMqk9qeQeOHmzTTrK8U3FSDI4JT6UC3LlpW6K/7cXfgHgMRv
        F5/iZBI3Vhh9u6HaGEwK3Nqrz2Ec
X-Google-Smtp-Source: APXvYqwPyJK2i33PLD/7pimqBkGh9JZClfOytaE32uS94uzJXSr83ogFfrmup5Kx18y0Vl75SV7hqg==
X-Received: by 2002:a2e:8847:: with SMTP id z7mr35982100ljj.51.1563787340123;
        Mon, 22 Jul 2019 02:22:20 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id b68sm8425088ljb.0.2019.07.22.02.22.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Jul 2019 02:22:19 -0700 (PDT)
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
Subject: [PATCH v5 0/3] serial: imx: fix RTS and RTS/CTS handling
Date:   Mon, 22 Jul 2019 12:22:07 +0300
Message-Id: <1563787330-1394-1-git-send-email-sorganov@gmail.com>
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

 drivers/tty/serial/imx.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

--
2.10.0.1.g57b01a3

