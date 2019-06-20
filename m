Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A103B4D0AF
	for <lists+linux-serial@lfdr.de>; Thu, 20 Jun 2019 16:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfFTOsJ (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 20 Jun 2019 10:48:09 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40259 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfFTOsI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 20 Jun 2019 10:48:08 -0400
Received: by mail-lj1-f194.google.com with SMTP id a21so2965107ljh.7
        for <linux-serial@vger.kernel.org>; Thu, 20 Jun 2019 07:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GrUwatgKfRETWcIOI87bY9cay5YKvy8zjzEuCkPjsuY=;
        b=a/o6N+hTwZ+lrx5CJoloqhlv1pHvXMtuoxcloninxKoLN0WQs14UVYgEdzCYSH7Pcz
         plJWpf8NGVOLqb5GNQd6RLqbQxiUrPEvjlMwlc56+w2MP+olNvYvNZpPWPH7gF1f9h/y
         4ROsSck7mpEnLBhsWqC+FOrhRjqCjA17/vuGJkv3LW7ufo+KI+XjKD8AXRuRVciENi9t
         7NuBb4EVUXd5XDJG3ClAtIpdyOqwkSy58s3/eGN1UzQ9C9tTYYGjyqtKUWG9tEP47B5h
         UZ5ATVAI5G1PyYn0Tz72gvseK6ws9wJLN2vBsYq2H3PdAzk+wp6d9Gok3IRWsI9bmxmk
         YJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GrUwatgKfRETWcIOI87bY9cay5YKvy8zjzEuCkPjsuY=;
        b=diS7ogLLFdyeTFD8/oaMXV7NNeAB57Li8kJgZaaaHpBVyy78SRrUNItPdUVgzxnyAE
         6sOvPWtKeBMtn4I/wAqhZd7SstOcZXg4yLVSeGgWZHS/N9a46hesijajmr313SuyX/oh
         nh8qg0dKcFCstYsThXYXhZpbmhfwXgqZYHMULhAdBdTBPHf8JRupDVXrx0Ub4I+T9pDk
         fSbDHq4L4R7fiP4HSSwMMQ/9bDpEutJvRcK8ktaiWfggr5Z8lCs5F23Am/sN1tI476MR
         LQoEhkset8t3SmPvTGUJKVdpLUXWcY94onM/rKK3ZpDhLTuMPizYzQXb49blnSy46QOG
         4ASg==
X-Gm-Message-State: APjAAAVZMbVjoDf1Qcb2dpFuSJ85Iha6hzlJJKA5nWUkbNrC2vvWHFzl
        gaU4AMdWDP6nsc6kaZXfYlQy62tZ
X-Google-Smtp-Source: APXvYqyK/pqyU6S3QbQf7S/2Ho1sMdLUU9XqeUG1Z4xZ49ccKg246cCv6SsEfL0ddj1t4c2Em2upYg==
X-Received: by 2002:a2e:8613:: with SMTP id a19mr8732452lji.163.1561042086924;
        Thu, 20 Jun 2019 07:48:06 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id f10sm3577768ljk.95.2019.06.20.07.48.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Jun 2019 07:48:06 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH RFC v1 0/7] serial: imx: fix RTS and RTS/CTS handling
Date:   Thu, 20 Jun 2019 17:47:46 +0300
Message-Id: <1561042073-617-1-git-send-email-sorganov@gmail.com>
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

The patches are not tested yet, so the RFC in the header. I'll re-roll
without RFC once Sasha Hauer tests them.

Sasha, in addition to already discussed fixes, I've also reordered 2
patches so that the sequence makes sense.

Changelog:

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
