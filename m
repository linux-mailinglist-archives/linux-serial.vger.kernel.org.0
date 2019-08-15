Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E19F78E790
	for <lists+linux-serial@lfdr.de>; Thu, 15 Aug 2019 11:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730762AbfHOJBP (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 15 Aug 2019 05:01:15 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:42290 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730204AbfHOJBP (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 15 Aug 2019 05:01:15 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id EC1F3A1527;
        Thu, 15 Aug 2019 11:01:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id wg0lXCnK0Cr1; Thu, 15 Aug 2019 11:01:08 +0200 (CEST)
Subject: Re: [PATCH v1] serial: mctrl_gpio: Use gpiod flags directly
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20190814140759.17486-1-andriy.shevchenko@linux.intel.com>
From:   Stefan Roese <sr@denx.de>
Message-ID: <9afdf2e4-332b-4dc0-a2fd-def472dbb9b7@denx.de>
Date:   Thu, 15 Aug 2019 11:01:07 +0200
MIME-Version: 1.0
In-Reply-To: <20190814140759.17486-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 14.08.19 16:07, Andy Shevchenko wrote:
> Description of the modem line control GPIOs contain a boolean type to set
> direction of the line. Since GPIO library provides an enumerator type of flags,
> we may utilize it and allow a bit more flexibility on the choice of the type of
> the line parameters. It also removes an additional layer of value conversion.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan
