Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A81D45C45
	for <lists+linux-serial@lfdr.de>; Fri, 14 Jun 2019 14:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbfFNMLw (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 14 Jun 2019 08:11:52 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42764 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbfFNMLw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Jun 2019 08:11:52 -0400
Received: by mail-lj1-f193.google.com with SMTP id t28so2135484lje.9
        for <linux-serial@vger.kernel.org>; Fri, 14 Jun 2019 05:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KAIoL/2xQexpZm/Cnc+ChufT79edLx8XlNo6sI2uttA=;
        b=Q2ObjG3Sfe7OqoICYZqCx3s+htycwitu478+JM5YcIB7+HVMZAzHAQzYI+zKwVcGaa
         deIsef7Va6FD4N2vt7gsDHyy3pQGDWk4OMv6tcWzSm6bJSRjvVShb29qIjOnsYkjAVTo
         0mEl5LsUIDF9iTwqxawJ+/dG9/1w0963RUc8mIhvJ7GlJ9TiiaojbSPzHLW348zzHxIF
         DVuKH9PsQtdDcawd8AJNiNf7B/K/gtBxyaOAdNhlfPI35gipTPjoyHDRecDN0R3wg4iw
         1tt73WtrHzBwKbPVc7p9XJiGp7DEPLlO/S4K2KRmfcYoKzpghNs3yL4LqHJ/xvDvQob5
         uv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KAIoL/2xQexpZm/Cnc+ChufT79edLx8XlNo6sI2uttA=;
        b=SbB0zNtJ9hOf/8ISszh2HCk3/9uho3KJAnbIYqGwnqQbMKUOKvVJpRy8m2V+qSWxvz
         8tQItw5kuAyMbzD3EViUi0IdZe73mAdOKlewbnje+2/yWtCD2fWm8sVQ5tfZmqPYv2iF
         oQIq+n+1wZCecUvJjYLL22Hhs1sVutkwoXpO4//jrEfDnGI/ai6koyYEBY7ILJF373pC
         PKFS5Vc7XqbTqmySeycOYYELKeYMOy0hEwE9xzB0XsysKMxO2ElLEzAQ7gILU9jJQ0oT
         UMtKPVhdxMObvlb54QRkYSdjFEsY0VlVWEeqdgY3nSjrSHn8gubKepcQuzfwpa/+X1sd
         4gkQ==
X-Gm-Message-State: APjAAAXumYoYSl6uwd91df0tLoBC5DyTE5J1GgKnZhBFfsS0o7YFSp46
        gDcbbGwKKk2LeqybkZxUs2mE/VfX
X-Google-Smtp-Source: APXvYqyrqJN7FoWGNCrX2uCsCtNC7FthgP3Vanzx9r8KGxWqdMRrUPgSCZxhUEbHHSo3EzI4wm8oqw==
X-Received: by 2002:a2e:9d4e:: with SMTP id y14mr22449268ljj.199.1560514310517;
        Fri, 14 Jun 2019 05:11:50 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id p27sm459683lfh.8.2019.06.14.05.11.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Jun 2019 05:11:49 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH RFC 0/7] serial: imx: fix RTS and RTS/CTS handling
Date:   Fri, 14 Jun 2019 15:11:27 +0300
Message-Id: <1560514294-29111-1-git-send-email-sorganov@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <20190614072801.3187-1-s.hauer@pengutronix.de>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Dear Sascha,

I think these patches deliver simpler end result and are more complete
than what you just posted. In particular, the

  serial: imx: set_mctrl(): correctly restore autoRTS state

addresses exactly the issue your patch is about, but in a slightly
simpler manner.

The patches are not tested yet, so I've put RFC in the header. Just my
2 cents. I can obviously re-roll them on top of your work later, if
required.

Sergey Organov (7):
  serial: imx: fix locking in set_termios()
  serial: imx: set_termios(): factor-out 'ucr2' initial value
  serial: imx: set_termios(): clarify RTS/CTS bits calculation
  serial: imx: set_termios(): do not enable autoRTS if RTS is unset
  serial: imx: set_termios(): preserve RTS state
  serial: imx: set_mctrl(): correctly restore autoRTS state
  serial: imx: get rid of imx_uart_rts_auto()

 drivers/tty/serial/imx.c | 93 ++++++++++++++++++++++++------------------------
 1 file changed, 47 insertions(+), 46 deletions(-)

-- 
2.10.0.1.g57b01a3

