Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943F91D63ED
	for <lists+linux-serial@lfdr.de>; Sat, 16 May 2020 22:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgEPUPC (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sat, 16 May 2020 16:15:02 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:50579 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgEPUPB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 16 May 2020 16:15:01 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id EE8FE3000253D;
        Sat, 16 May 2020 22:14:56 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id C5026AF8E5; Sat, 16 May 2020 22:14:56 +0200 (CEST)
Date:   Sat, 16 May 2020 22:14:56 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        andriy.shevchenko@linux.intel.com, matwey.kornilov@gmail.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com,
        giulio.benetti@micronovasrl.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: Re: [PATCH v2 6/7] serial: 8250: Support separate rs485 rx-enable
 GPIO
Message-ID: <20200516201456.pieoebueqkq7q7ov@wunner.de>
References: <20200325231422.1502366-1-heiko@sntech.de>
 <20200325231422.1502366-7-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325231422.1502366-7-heiko@sntech.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Mar 26, 2020 at 12:14:21AM +0100, Heiko Stuebner wrote:
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -3356,6 +3356,18 @@ int uart_get_rs485_mode(struct uart_port *port)
>  			rs485conf->flags |= SER_RS485_TERMINATE_BUS;
>  	}
>  
> +	port->rs485_re_gpio = devm_gpiod_get(dev, "rs485-rx-enable",
> +					       GPIOD_FLAGS_BIT_DIR_OUT);

I think you want to use GPIOD_OUT_HIGH here so that rs485 reception
is enabled by default and only disabled at runtime when sending
(if half-duplex mode is used).

Thanks,

Lukas
