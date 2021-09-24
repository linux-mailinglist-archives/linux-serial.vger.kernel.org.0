Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB57B41769D
	for <lists+linux-serial@lfdr.de>; Fri, 24 Sep 2021 16:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345078AbhIXOMP (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 24 Sep 2021 10:12:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:59702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346713AbhIXOMN (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 24 Sep 2021 10:12:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C9FBB610D1;
        Fri, 24 Sep 2021 14:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632492640;
        bh=MsWlnwsKESy1TU57hlUOkUOlD9EJaHKzGtqrEkIEBDg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HZKkjFeKtmwmvbHaZSp9rgzaOrE/Ar219AzlNHrGa+tlU5gfeApyxdWN/Fk54vLt1
         gBg1v/Xox3BsCVdajaYGyta/tqc9VCN43UM8zfosWIVMLox1TLCbPCghnUicvdwXFq
         8yCYnkJDq/x0gqRNVRnccih+yc27JS7Cge78gNkPfOxT3jJtbfRV3dSIMg9kABncuH
         dLZlGkLjo6PFwt36ib/aYqiXiequnigNveoptRZkl0mkuMY+HW5qYWiD3JvdxFrX82
         FMOXz3+2H2yxUk/rhABiO7DSdyGyD0zfXc9xQ/eYzYyS5PF2W5ayzz4zoyoSjYbZUG
         hR+jwjTrhfnRw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mTluV-000170-G1; Fri, 24 Sep 2021 16:10:43 +0200
Date:   Fri, 24 Sep 2021 16:10:43 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Scott Wood <oss@buserror.net>, linux-serial@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] serial: 8250: SERIAL_8250_FSL should not default
 to y when compile-testing
Message-ID: <YU3cY0dlNz4iMB70@hovoldconsulting.com>
References: <6421f256407262afd658ffa74ec9430581528a7d.1632467477.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6421f256407262afd658ffa74ec9430581528a7d.1632467477.git.geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Sep 24, 2021 at 09:12:30AM +0200, Geert Uytterhoeven wrote:
> Commit b1442c55ce8977aa ("serial: 8250: extend compile-test coverage")
> added compile-test support to the Freescale 16550 driver.  However, as
> SERIAL_8250_FSL is an invisible symbol, merely enabling compile-testing
> now enables this driver.
> 
> Fix this by dropping the COMPILE_TEST default again, but making the
> SERIAL_8250_FSL symbol visible instead.
> 
> Fixes: b1442c55ce8977aa ("serial: 8250: extend compile-test coverage")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - Split in two parts.

I realised that we can do better than this. I've prepared a patch that
preserves the old behaviour of always enabling the option on platforms
that may need it while also not enabling it by default when compile
testing.

Note that SERIAL_8250_FSL only enables a workaround for an erratum in
the Freescale UARTs in the 8250 driver (leaving the later added ACPI
support aside) and we shouldn't make it easier to disable it by mistake.

> ---
>  drivers/tty/serial/8250/Kconfig | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> index 808268edd2e82a45..0af96f3adab517f6 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -361,9 +361,12 @@ config SERIAL_8250_BCM2835AUX
>  	  If unsure, say N.
>  
>  config SERIAL_8250_FSL
> -	bool
> +	bool "Freescale 16550-style UART support (8250 based driver)"
>  	depends on SERIAL_8250_CONSOLE
> -	default PPC || ARM || ARM64 || COMPILE_TEST
> +	default PPC || ARM || ARM64
> +	help
> +	  Selecting this option will add support for the 16550-style serial
> +	  port hardware found on Freescale SoCs.
>  
>  config SERIAL_8250_DW
>  	tristate "Support for Synopsys DesignWare 8250 quirks"

Johan
