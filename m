Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C32349B76
	for <lists+linux-serial@lfdr.de>; Tue, 18 Jun 2019 09:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbfFRHtH (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 18 Jun 2019 03:49:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfFRHtG (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 Jun 2019 03:49:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87CB120663;
        Tue, 18 Jun 2019 07:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560844146;
        bh=5s30GomD44N92xGZszrfWfrIiZv9xCuvrxnPayt45R8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vXHzl4rTLK5B2MQBjMB7daMyhCH0b6oHm8NOrBCUaIAO4Rl2YuzkoOiDS8d7WntPK
         xUEKOhsQlG77RjUWW+WzokOgbFd0pejnYlX9zU2QBGguNYnTiWErh/UA29nQCsKG2C
         Guzaku0nCrA+RGI2mXHwXzUVZYQP+Ti3e07sXrY4=
Date:   Tue, 18 Jun 2019 09:49:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stefan Roese <sr@denx.de>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yegor Yefremov <yegorslists@googlemail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: Re: [PATCH 2/2 v5] tty/serial/8250: use mctrl_gpio helpers
Message-ID: <20190618074903.GA5216@kroah.com>
References: <20190611105603.4435-1-sr@denx.de>
 <20190611105603.4435-2-sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611105603.4435-2-sr@denx.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jun 11, 2019 at 12:56:03PM +0200, Stefan Roese wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
> 
> This patch permits the usage for GPIOs to control
> the CTS/RTS/DTR/DSR/DCD/RI signals.
> 
> Changed by Stefan:
> Only call mctrl_gpio_init(), if the device has no ACPI companion device
> to not break existing ACPI based systems. Also only use the mctrl_gpio_
> functions when "gpios" is available.
> 
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Please do not add a signed-off-by from people for an old patch that was
reverted.  It implies that I still agree with this change :(

greg k-h
