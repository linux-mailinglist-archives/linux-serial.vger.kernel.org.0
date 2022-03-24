Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCB54E6386
	for <lists+linux-serial@lfdr.de>; Thu, 24 Mar 2022 13:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350254AbiCXMqA (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 24 Mar 2022 08:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350262AbiCXMp7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 24 Mar 2022 08:45:59 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EF0387AE
        for <linux-serial@vger.kernel.org>; Thu, 24 Mar 2022 05:44:27 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id o13so3716897pgc.12
        for <linux-serial@vger.kernel.org>; Thu, 24 Mar 2022 05:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ek2lZBtUjkC3pnGqt+RBhxkpe48kew374lr6zTExP6Q=;
        b=VBtLwBophOkXYa3sjzk54y3KqNxAuQ229WfiaEN1R1te9C9LR6qu145jvFeTUWrYVk
         KVpm88luvBK2bpn4sG/eUBfnGu/cxGM1941ufMCcDo/0I8+X0QF2cFQWv9L1UkU201m5
         7T/Ui6EdP3+zuWnw7pWXVyNUjpjlc8wOUEWMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ek2lZBtUjkC3pnGqt+RBhxkpe48kew374lr6zTExP6Q=;
        b=kBeyqmCxK5leGOJ39bdf0HMO2X2/2Npv7aUZCI8A0AbHkIhbKXaKESqf5qVtnS4/Pz
         yzXBNmrZr81DpzcUiGJlaARr/U5MFmkfyuo4N1g61A60o6IYartGkWbaop/JYM3uAi0S
         wt+yi/0AaLC8pYR1yYkL+gQ3tYFVHMgWST8qYj/00wnsnKBxIJRC1IOjIhvvbBk12GQ7
         XqPpQ+zzC3/l2uvVROPsDmDHUD4cohmxLEjMFd+1hrLz+7dcWJp98xNQjDHbWvlOZbNa
         C6G3HWUwkYAI9EcOtJlQ+lkT28LPl+3Ml043JTZaRV30Ky2TCX1DwfD86rOEem+7/lx2
         rCIw==
X-Gm-Message-State: AOAM530nlz6Y4+Bh6vR++718XlWgCk/3NkAgcNgf3tpqOzxgYjz3Ewjz
        cI3nC+zQZsa+0Xubvp1TdSENMQ==
X-Google-Smtp-Source: ABdhPJxE9rk71v/iZm8H2lR14hvHWEvXaS7otrzLAMDM+Yy8zoArKBz8EzsuScDPwRmORi2z7rJgeA==
X-Received: by 2002:a05:6a00:2310:b0:4fa:7eb1:e855 with SMTP id h16-20020a056a00231000b004fa7eb1e855mr5055729pfh.14.1648125867265;
        Thu, 24 Mar 2022 05:44:27 -0700 (PDT)
Received: from shiro.work ([2400:4162:2428:2f01:7285:c2ff:fe8e:66d7])
        by smtp.googlemail.com with ESMTPSA id t10-20020a056a00138a00b004fa9c9fda44sm3786924pfg.89.2022.03.24.05.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 05:44:27 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        robh+dt@kernel.org, andriy.shevchenko@linux.intel.com,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        romain.perier@gmail.com, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 2/4] serial: 8250_dw: Add MStar MSC313 quirk
Date:   Thu, 24 Mar 2022 21:44:00 +0900
Message-Id: <20220324124402.3631379-3-daniel@0x0f.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220324124402.3631379-1-daniel@0x0f.com>
References: <20220324124402.3631379-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The version of the IP used on the MStar MSC313 and later
MStar and SigmaStar SoCs has the USR register at a different
location. Add a quirk for this.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 drivers/tty/serial/8250/8250_dw.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 1769808031c5..01737e5706a5 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -416,6 +416,10 @@ static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
 			p->serial_out = dw8250_serial_out38x;
 		if (of_device_is_compatible(np, "starfive,jh7100-uart"))
 			p->set_termios = dw8250_do_set_termios;
+		if (of_device_is_compatible(np, "mstar,msc313-uart")) {
+			data->usr_reg = 0x7;
+			data->skip_autocfg = true;
+		}
 
 	} else if (acpi_dev_present("APMC0D08", NULL, -1)) {
 		p->iotype = UPIO_MEM32;
@@ -699,6 +703,7 @@ static const struct of_device_id dw8250_of_match[] = {
 	{ .compatible = "marvell,armada-38x-uart" },
 	{ .compatible = "renesas,rzn1-uart" },
 	{ .compatible = "starfive,jh7100-uart" },
+	{ .compatible = "mstar,msc313-uart" },
 	{ /* Sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, dw8250_of_match);
-- 
2.35.1

