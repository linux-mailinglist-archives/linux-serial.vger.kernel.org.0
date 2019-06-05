Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9084C35C79
	for <lists+linux-serial@lfdr.de>; Wed,  5 Jun 2019 14:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfFEMVf (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 5 Jun 2019 08:21:35 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34811 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbfFEMVf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 Jun 2019 08:21:35 -0400
Received: by mail-pl1-f195.google.com with SMTP id i2so5287279plt.1;
        Wed, 05 Jun 2019 05:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+mvlP3fCWubOTs9ufovlGWO4LIbpoCYwwxHP1hQzgBU=;
        b=tlSG9UuB2TIIVAhHkXyJteVss4sNjvVtjXzlISfVJ57kQpbON4O5dZEU9L18mwQYFs
         JTIdlAgGZ9RCft5JELCWRXMw5SqujYG2bU/gLo+3ZnGY0WHnf6nBLmJkY8zUoFWOEwEf
         i7cAHxNH1Mb9N+MyyYapQ9SPrP1qGmQOG2EFf+6r3EE8IxcDimOtAaTxl9VaUhgrvJ7B
         Y06vQcg8C2/sXWt8dY3VsyIlcZUCRLTER9dLcIkQ4C5t27gL5lDg3xSipRvENPcujW0F
         R3Gh8mmIpRo9kS+B0YfFcTYt+ZDhCI0V+0zUMWJPfGmfgjOePv/blY9BP6hnVJ18kbNI
         WhqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+mvlP3fCWubOTs9ufovlGWO4LIbpoCYwwxHP1hQzgBU=;
        b=D0xCuvCt0W+UV2VSSTlnNOrHxIyHCplj0tEAoi4+PZy022qS+thHzFE1cQSyorwRnx
         UceDkqrQ6Kp+jENFfE/HIftMUo3Qv1BywyNgxL8cCqIueyJ3LJPloH1w0FKnsZzj5J/K
         jqyT+lXUlIuyUQKTGOBegTaNaV5EfTdiDpp14PTVENrzkjf6TnUzk+X7rsFECElzr4ZX
         np0zdm1zMPLtIs1B2aNAkebux0mzVPbdxgmOCsiSNEBD2OpoWmTLg4zVs1iWglrjikdI
         gPVPIM73BWPKBDaulPNEh+EWb4ogRQ1uNn9Dt0HIQps6msMdUVy9fkhFiIOvdx+I82YR
         zEZQ==
X-Gm-Message-State: APjAAAXbmOhVY0t8P9mgbp4WyeYtC2lWKBMUsx6X+vFgkuB+ulXlIXOx
        oofeeBdD/07JLBSd9Ke7yCg=
X-Google-Smtp-Source: APXvYqwbCXonwkvVPjKpk6HE8xu6iR7IhL2CJLmh9dIfEhZBwqq+WLhlUvdi0BcMGzufDaw9EJZ+1A==
X-Received: by 2002:a17:902:b194:: with SMTP id s20mr30104605plr.77.1559737294765;
        Wed, 05 Jun 2019 05:21:34 -0700 (PDT)
Received: from Pilot130.192.168.0.22 (211-20-114-70.HINET-IP.hinet.net. [211.20.114.70])
        by smtp.googlemail.com with ESMTPSA id q22sm3322094pff.63.2019.06.05.05.21.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Jun 2019 05:21:34 -0700 (PDT)
From:   "sudheer.v" <open.sudheer@gmail.com>
To:     gregkh@linuxfoundation.org, mchehab+samsung@kernel.org,
        jslaby@suse.com, joel@jms.id.au, andrew@aj.id.au,
        benh@kernel.crashing.org, robh+dt@kernel.org, mark.rutland@arm.com,
        shivahshankar.shankarnarayanrao@aspeedtech.com,
        sudheer.veliseti@aspeedtech.com
Cc:     sudheer Kumar veliseti <sudheer.open@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org
Subject: [patch 0/5] *** Cover Letter: patch submission for AST2500 UART driver ***
Date:   Wed,  5 Jun 2019 17:53:10 +0530
Message-Id: <1559737395-28542-1-git-send-email-open.sudheer@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: sudheer Kumar veliseti <sudheer.open@gmail.com>

Hi,

The below mentioned patches are for AST2500 UART driver.

AST2500 has dedicated Uart DMA controller which has 12 sets of
Tx and RX channels connected to UART controller directly.
Since the DMA controller have dedicated buffers and registers,
there would be little benifit in adding DMA framework overhead.
So the software for DMA controller is included within the UART driver itself.

Thanks and Regards
Sudheer.V

sudheer veliseti (5):
  AST2500 DMA UART driver
  build configuration for AST2500 DMA UART driver
  DT nodes for AST2500 DMA UART driver
  defconfig and MAINTAINERS updated for AST2500 DMA UART driver
  Documentation: DT bindings AST2500 DMA UART driver

 .../bindings/serial/ast2500-dma-uart.txt      |   40 +
 MAINTAINERS                                   |   13 +
 arch/arm/boot/dts/aspeed-ast2500-evb.dts      |   21 +
 arch/arm/boot/dts/aspeed-g5.dtsi              |   71 +-
 arch/arm/configs/aspeed_g5_defconfig          |    1 +
 .../tty/serial/8250/8250_ast2500_uart_dma.c   | 1928 +++++++++++++++++
 drivers/tty/serial/8250/Kconfig               |   35 +-
 drivers/tty/serial/8250/Makefile              |    1 +
 8 files changed, 2105 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/ast2500-dma-uart.txt
 create mode 100644 drivers/tty/serial/8250/8250_ast2500_uart_dma.c

-- 
2.17.1

