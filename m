Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7E05261E
	for <lists+linux-serial@lfdr.de>; Tue, 25 Jun 2019 10:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfFYILr (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 25 Jun 2019 04:11:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41059 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbfFYILr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 25 Jun 2019 04:11:47 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hfgYG-0008CD-Oo; Tue, 25 Jun 2019 10:11:40 +0200
Date:   Tue, 25 Jun 2019 10:11:39 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Hodaszi, Robert" <Robert.Hodaszi@digi.com>
cc:     Michael Shych <michaelsh@mellanox.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: "No irq handler for vector" problem
In-Reply-To: <alpine.DEB.2.21.1906242335250.32342@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1906251010020.32342@nanos.tec.linutronix.de>
References: <dcc1febb-2afc-da9b-696e-3c9bf63f4b76@digi.com> <alpine.DEB.2.21.1906211858340.5503@nanos.tec.linutronix.de> <37433D8393E7AF43B0D856B93884DA9E4FD67B64@MTK-SMS-XCH02.digi.com> <AM6PR05MB61689A1EE1E6B31682A476FAD9E10@AM6PR05MB6168.eurprd05.prod.outlook.com>
 <alpine.DEB.2.21.1906231955420.32342@nanos.tec.linutronix.de> <AM6PR05MB6168265CCF44FBCAEBBD4EA8D9E00@AM6PR05MB6168.eurprd05.prod.outlook.com> <d40acbee-df87-1f4b-48c1-66fe31c841fd@digi.com> <alpine.DEB.2.21.1906241609080.32342@nanos.tec.linutronix.de>
 <c49e9454-d6d2-408c-8232-ee4c17d6975d@digi.com> <alpine.DEB.2.21.1906242335250.32342@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, 25 Jun 2019, Thomas Gleixner wrote:
> On Mon, 24 Jun 2019, Hodaszi, Robert wrote:
>  
> +static void sync_on_free(struct irq_desc *desc)
> +{
> +	unsigned long flags;
> +
> +	chip_bus_lock(desc);
> +	raw_spin_lock_irqsave(&desc->lock, flags);

Hrmpf. That might actually dead lock. /me goes back to the drawing board.

