Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E439BB789F
	for <lists+linux-serial@lfdr.de>; Thu, 19 Sep 2019 13:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390011AbfISLkF (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 19 Sep 2019 07:40:05 -0400
Received: from mx1.emlix.com ([188.40.240.192]:57970 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390009AbfISLkF (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 19 Sep 2019 07:40:05 -0400
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id F22E2603CA;
        Thu, 19 Sep 2019 13:40:03 +0200 (CEST)
Subject: Re: [PATCH v2] serial: imx: adapt rx buffer and dma periods
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        yibin.gong@nxp.com, fugang.duan@nxp.com, l.stach@pengutronix.de,
        jslaby@suse.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190919102628.23621-1-philipp.puschmann@emlix.com>
 <20190919112216.qjkx5wvqhsadjxg5@pengutronix.de>
From:   Philipp Puschmann <philipp.puschmann@emlix.com>
Openpgp: preference=signencrypt
Message-ID: <9923d405-a62d-0c6a-6039-f4a7bc3bf2e8@emlix.com>
Date:   Thu, 19 Sep 2019 13:40:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190919112216.qjkx5wvqhsadjxg5@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Uwe

Am 19.09.19 um 13:22 schrieb Uwe Kleine-König:
> On Thu, Sep 19, 2019 at 12:26:28PM +0200, Philipp Puschmann wrote:
>> Using only 4 DMA periods for UART RX is very few if we have a high
>> frequency of small transfers - like in our case using Bluetooth with
>> many small packets via UART - causing many dma transfers but in each
>> only filling a fraction of a single buffer. Such a case may lead to
>> the situation that DMA RX transfer is triggered but no free buffer is
>> available. While we have addressed the dma handling already with
>> "dmaengine: imx-sdma: fix dma freezes" we still want to avoid
> 
> Is this statement still true now that you split this patch out of your
> bigger series?
Yes. The dma patches care about stopping DMA channel. This patch tries to
avoid that the channel runs out of usable buffers (aka dma periods).

> 
>> UART RX FIFO overrun. So we decrease the size of the buffers and
>> increase their number and the total buffer size.
> 
> What happens when such an RX FIFO overrun happens? Are characters lost?
> Or only time?
Good question. In explanation i have missed an important point:
When using HW flowcontrol via RTS/CTS and the buffer is full CTS is used to
tell the remote device - here the Bluetooth chip - to stop sending data.
For a while this prevents losing of characters. But then the remote device
comes into trouble as its internal TX buffers runs over. Depends on the
device how it handles this case and if it recovers if data flow is enabled
again.

In case without HW flow control characters would be lost. Depends on the upper
layer what happens then.

> Does your change have an influence if I do fewer but
> bigger transfers?
Don't think so. The dma periods are raw data buffers. If one is full the next one
is being used. For the performance i don't see a significant difference between
using 1 kB buffers or 4 kB buffers.

Regards,
Philipp

> 
> Best regards
> Uwe
>
