Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1671551A6
	for <lists+linux-serial@lfdr.de>; Tue, 25 Jun 2019 16:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbfFYO1o (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 25 Jun 2019 10:27:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43391 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbfFYO1o (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 25 Jun 2019 10:27:44 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hfmQ5-00016Q-1z; Tue, 25 Jun 2019 16:27:37 +0200
Date:   Tue, 25 Jun 2019 16:27:35 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Hodaszi, Robert" <Robert.Hodaszi@digi.com>
cc:     Michael Shych <michaelsh@mellanox.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: "No irq handler for vector" problem
In-Reply-To: <e1eda070-6326-ac1f-803f-917e0e1c1ee6@digi.com>
Message-ID: <alpine.DEB.2.21.1906251625430.32342@nanos.tec.linutronix.de>
References: <dcc1febb-2afc-da9b-696e-3c9bf63f4b76@digi.com> <alpine.DEB.2.21.1906211858340.5503@nanos.tec.linutronix.de> <37433D8393E7AF43B0D856B93884DA9E4FD67B64@MTK-SMS-XCH02.digi.com> <AM6PR05MB61689A1EE1E6B31682A476FAD9E10@AM6PR05MB6168.eurprd05.prod.outlook.com>
 <alpine.DEB.2.21.1906231955420.32342@nanos.tec.linutronix.de> <AM6PR05MB6168265CCF44FBCAEBBD4EA8D9E00@AM6PR05MB6168.eurprd05.prod.outlook.com> <d40acbee-df87-1f4b-48c1-66fe31c841fd@digi.com> <alpine.DEB.2.21.1906241609080.32342@nanos.tec.linutronix.de>
 <c49e9454-d6d2-408c-8232-ee4c17d6975d@digi.com> <alpine.DEB.2.21.1906242335250.32342@nanos.tec.linutronix.de> <a1582e82-c2b3-95fd-0c92-e04765da0a59@digi.com> <alpine.DEB.2.21.1906251213021.32342@nanos.tec.linutronix.de> <c7a830df-56ff-e03d-7634-7a6f1e45f9d9@digi.com>
 <e1eda070-6326-ac1f-803f-917e0e1c1ee6@digi.com>
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

Robert,

On Tue, 25 Jun 2019, Hodaszi, Robert wrote:
> On Mon, 25 Jun 2019, Gleixner, Thomas wrote:
> 
> I'm working on a clean fix for both the level and the edge problems. Just
> at the point to start testing. Will post the result in a couple of hours.
> 
> I checked the patch. That will obviously fix the "error message
> appearing" problem. :) I assume, no need to test that, but just in case,
> I applied all patches, and error message is gone. Which is probably more
> useful feedback: interrupts, and everything seems working fine on my
> side.

as I explained before this is legit and no harm done on edge type
interrupts. Level type could get into wedged state.

Thanks a lot for debugging this and providing all the useful data!

       tglx
