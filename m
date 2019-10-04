Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74FA8CC619
	for <lists+linux-serial@lfdr.de>; Sat,  5 Oct 2019 00:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfJDWyK (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 4 Oct 2019 18:54:10 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:33536 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbfJDWyK (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 4 Oct 2019 18:54:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=19m7S1ibmLavrZocSRtbIxgDYoEh4ZDgSaklaxr4C+0=; b=RoVawQ43TmYht9G8E0Tv66fR6Q
        xHjHxAiGrRAUs3kAOD8aXD21+iFFomqFnLF6vsLBntn3iJ7LuQjnFWGs3Q8kNg49BtN0m1Q10bdpN
        TcaiZlf6mn39RJVZ9+SXInEoRCjdLumAJSzwslKFyYGqN8Qhen3E/6/JtPMXlgVQUy18=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.92.2)
        (envelope-from <andrew@lunn.ch>)
        id 1iGWSV-0003ji-5G; Sat, 05 Oct 2019 00:53:59 +0200
Date:   Sat, 5 Oct 2019 00:53:59 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefan Agner <stefan@agner.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Lucas Stach <l.stach@pengutronix.de>,
        Jiri Slaby <jslaby@suse.com>, linux-imx@nxp.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: serial: fsl_lpuart: Fix lpuart_flush_buffer()
Message-ID: <20191004225359.GE3817@lunn.ch>
References: <20191004215537.5308-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004215537.5308-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Oct 04, 2019 at 02:55:37PM -0700, Andrey Smirnov wrote:
> Fix incorrect read-modify-write sequence in lpuart_flush_buffer() that
> was reading from UARTPFIFO and writing to UARTCFIFO instead of
> operating solely on the latter.
> 
> Fixes: 9bc19af9dacb ("tty: serial: fsl_lpuart: Flush HW FIFOs in .flush_buffer")
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Tested-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
