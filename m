Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D742A5EF7B
	for <lists+linux-serial@lfdr.de>; Thu,  4 Jul 2019 01:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfGCXFg (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 3 Jul 2019 19:05:36 -0400
Received: from gate.crashing.org ([63.228.1.57]:34221 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727021AbfGCXFf (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 3 Jul 2019 19:05:35 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x63N4tut012603;
        Wed, 3 Jul 2019 18:04:56 -0500
Message-ID: <c8b5e295c34aaf8b3d8b03aeaa980c88d870443a.camel@kernel.crashing.org>
Subject: Re: [patch v3 1/5] AST2500 DMA UART driver
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Greg KH <gregkh@linuxfoundation.org>,
        "sudheer.v" <open.sudheer@gmail.com>
Cc:     jslaby@suse.com, joel@jms.id.au, andrew@aj.id.au,
        robh+dt@kernel.org, mark.rutland@arm.com,
        shivahshankar.shankarnarayanrao@aspeedtech.com,
        shivahshankar@gmail.com, sudheer.veliseti@aspeedtech.com,
        sudheer veliseti <sudheer.open@gmail.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org
Date:   Thu, 04 Jul 2019 09:04:55 +1000
In-Reply-To: <20190703174926.GA12813@kroah.com>
References: <1561459476-14268-1-git-send-email-open.sudheer@gmail.com>
         <1561459476-14268-2-git-send-email-open.sudheer@gmail.com>
         <20190703174926.GA12813@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, 2019-07-03 at 19:49 +0200, Greg KH wrote:
> > +
> > +     if (tx_sts & UART_SDMA0_INT) {
> > +             ast_uart_sdma_write(sdma, UART_SDMA0_INT, UART_TX_SDMA_ISR);
> > +             ast_sdma_bufffdone(&(sdma->dma_ch->tx_dma_info[0]));
> > +     } else if (tx_sts & UART_SDMA1_INT) {
> > +             ast_uart_sdma_write(sdma, UART_SDMA1_INT, UART_TX_SDMA_ISR);
> > +             ast_sdma_bufffdone(&(sdma->dma_ch->tx_dma_info[1]));
> > +     } else if (tx_sts & UART_SDMA2_INT) {
> > +             ast_uart_sdma_write(sdma, UART_SDMA2_INT, UART_TX_SDMA_ISR);
> > +             ast_sdma_bufffdone(&(sdma->dma_ch->tx_dma_info[2]));
> > +     } else if (tx_sts & UART_SDMA3_INT) {
> > +             ast_uart_sdma_write(sdma, UART_SDMA3_INT, UART_TX_SDMA_ISR);
> > +             ast_sdma_bufffdone(&(sdma->dma_ch->tx_dma_info[3]));
> > +     } else if (tx_sts & UART_SDMA4_INT) {
> > +             ast_uart_sdma_write(sdma, UART_SDMA4_INT, UART_TX_SDMA_ISR);
> > +             ast_sdma_bufffdone(&(sdma->dma_ch->tx_dma_info[4]));
> > +     } else if (tx_sts & UART_SDMA5_INT) {
> > +             ast_uart_sdma_write(sdma, UART_SDMA5_INT, UART_TX_SDMA_ISR);
> > +             ast_sdma_bufffdone(&(sdma->dma_ch->tx_dma_info[5]));
> > +     } else if (tx_sts & UART_SDMA6_INT) {
> > +             ast_uart_sdma_write(sdma, UART_SDMA6_INT, UART_TX_SDMA_ISR);
> > +             ast_sdma_bufffdone(&(sdma->dma_ch->tx_dma_info[6]));
> > +     } else if (tx_sts & UART_SDMA7_INT) {
> > +             ast_uart_sdma_write(sdma, UART_SDMA7_INT, UART_TX_SDMA_ISR);
> > +             ast_sdma_bufffdone(&(sdma->dma_ch->tx_dma_info[7]));
> > +     } else if (tx_sts & UART_SDMA8_INT) {
> > +             ast_uart_sdma_write(sdma, UART_SDMA8_INT, UART_TX_SDMA_ISR);
> > +             ast_sdma_bufffdone(&(sdma->dma_ch->tx_dma_info[8]));
> > +     } else if (tx_sts & UART_SDMA9_INT) {
> > +             ast_uart_sdma_write(sdma, UART_SDMA9_INT, UART_TX_SDMA_ISR);
> > +             ast_sdma_bufffdone(&(sdma->dma_ch->tx_dma_info[9]));
> > +     } else if (tx_sts & UART_SDMA10_INT) {
> > +             ast_uart_sdma_write(sdma, UART_SDMA10_INT, UART_TX_SDMA_ISR);
> > +             ast_sdma_bufffdone(&(sdma->dma_ch->tx_dma_info[10]));
> > +     } else if (tx_sts & UART_SDMA11_INT) {
> > +             ast_uart_sdma_write(sdma, UART_SDMA11_INT, UART_TX_SDMA_ISR);
> > +             ast_sdma_bufffdone(&(sdma->dma_ch->tx_dma_info[11]));
> > +     } else {
> > +     }

Also this should be a for () loop...

Cheers,
Ben.


