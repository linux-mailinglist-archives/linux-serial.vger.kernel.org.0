Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12460423C5
	for <lists+linux-serial@lfdr.de>; Wed, 12 Jun 2019 13:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436593AbfFLLPM (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 12 Jun 2019 07:15:12 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53849 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438301AbfFLLO4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 12 Jun 2019 07:14:56 -0400
Received: by mail-wm1-f66.google.com with SMTP id x15so6138167wmj.3
        for <linux-serial@vger.kernel.org>; Wed, 12 Jun 2019 04:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=bYhm6q2mQOQHxwpH1cNDyslfzzaeNb5NDBbPExBr2hU=;
        b=gUz4s4x3wAGkHBCidbCda40ZHrM+oc5MtKFf8IFar51RKlJuK1zOLWaojoQZUxDrdT
         w5897ogwbbZPOnHWEZrig35pkYl3fmCEvcMf0ROCNClQ9Q8hml1Adv3IMHjMickCUPwU
         3UaHIWLyQmnprriSbA06WUAowV1Uuq+/7V7dhatbGWhVC/GXDc4o7CXsGZ3RsEWZGWMP
         vt2hylAoq102zrYvnqKX1TUeoOZ3S5M0L9icqq1CuDzPFeCuahixzClKF2/ooA1+TXV0
         aTRhJzAKqP5JG4oPxNYGTOUwo0Ewgn159jICgnUkhW+8i72KHQCQ6i8tkDVmxmJDEe0o
         LU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=bYhm6q2mQOQHxwpH1cNDyslfzzaeNb5NDBbPExBr2hU=;
        b=c2AuKy28XFAi8bLW869+/zTAe1QEXZlB/lY7wEgeu9HwRxsPRM/ZFSM4+NHUiU7lUH
         Dnkqjbcgb8DcJ/TJr+N9PAvz0qfUnMn3ud/uy/PsUKtW33C1pIc9V5VokR9zbAfMrpaA
         PHx0bkivZNcmB4PFbgVFiKz+CCJr5wRfyV1DhinuEsFd7LAjOGTbeyimHFiqp3KlFHhW
         ErGIaxRNfIz2Pxj8nV4SMIxo79x3jIj3RWHEeQMNONqWVvsQWavbz5tegHwNwwG03Ogq
         mHfSLGhlj+qjIaC/+e6Nj+KZHGZFILvI+wXLEDk+dCkyhZGPv0dHenpkJMF8Ta3IlikJ
         pYvA==
X-Gm-Message-State: APjAAAUVjFUsDfupAwHm0Eaqs2gU5MP2uohckfB5nNoYX6lLXlpwI92t
        RKqNnZVVkY4NPIm0YSbYR0ib0g==
X-Google-Smtp-Source: APXvYqyGMKCnljobGJkFGV/NdFNdLPAxnN5nwF08PzReraHvnNcveanzCoORDBgv7OzKCjvRD9L/bg==
X-Received: by 2002:a1c:3886:: with SMTP id f128mr21530360wma.151.1560338095263;
        Wed, 12 Jun 2019 04:14:55 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id d10sm19536766wrp.74.2019.06.12.04.14.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2019 04:14:54 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com
Cc:     Nava kishore Manne <nava.manne@xilinx.com>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 4/6] serial: uartps: Fix long line over 80 chars
Date:   Wed, 12 Jun 2019 13:14:41 +0200
Message-Id: <a7eb75d2900d354b3b2ba4355f4c9b9cb00f1456.1560338079.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1560338079.git.michal.simek@xilinx.com>
References: <cover.1560338079.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1560338079.git.michal.simek@xilinx.com>
References: <cover.1560338079.git.michal.simek@xilinx.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Nava kishore Manne <nava.manne@xilinx.com>

Trivial patch which fixes one checkpatch warning:
WARNING: line over 80 characters
+		       !(readl(port->membase + CDNS_UART_SR)
			& CDNS_UART_SR_TXFULL)) {

Fixes: c8dbdc842d30 ("serial: xuartps: Rewrite the interrupt handling logic")
Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2:
- Split patch from v1
- Add Fixes tag

 drivers/tty/serial/xilinx_uartps.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 4cd20c036750..c3949a323815 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -312,7 +312,8 @@ static void cdns_uart_handle_tx(void *dev_id)
 	} else {
 		numbytes = port->fifosize;
 		while (numbytes && !uart_circ_empty(&port->state->xmit) &&
-		       !(readl(port->membase + CDNS_UART_SR) & CDNS_UART_SR_TXFULL)) {
+		       !(readl(port->membase + CDNS_UART_SR) &
+						CDNS_UART_SR_TXFULL)) {
 			/*
 			 * Get the data from the UART circular buffer
 			 * and write it to the cdns_uart's TX_FIFO
-- 
2.17.1

