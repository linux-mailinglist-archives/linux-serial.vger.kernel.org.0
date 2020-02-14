Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A49F15F3B2
	for <lists+linux-serial@lfdr.de>; Fri, 14 Feb 2020 19:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393295AbgBNSOP (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 14 Feb 2020 13:14:15 -0500
Received: from muru.com ([72.249.23.125]:55322 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389895AbgBNSOL (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Feb 2020 13:14:11 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 10E1880E7;
        Fri, 14 Feb 2020 18:14:54 +0000 (UTC)
Date:   Fri, 14 Feb 2020 10:14:07 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH v2 5/8] serial: 8250_port: Don't use power management for
 kernel console
Message-ID: <20200214181407.GQ16391@atomide.com>
References: <20200214114339.53897-1-andriy.shevchenko@linux.intel.com>
 <20200214114339.53897-6-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214114339.53897-6-andriy.shevchenko@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

* Andy Shevchenko <andriy.shevchenko@linux.intel.com> [200214 11:44]:
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -608,6 +608,14 @@ static int univ8250_console_setup(struct console *co, char *options)
>  	return retval;
>  }
>  
> +static int univ8250_console_exit(struct console *co)
> +{
> +	struct uart_port *port;
> +
> +	port = &serial8250_ports[co->index].port;
> +	return serial8250_console_exit(port);
> +}
> +
>  /**
>   *	univ8250_console_match - non-standard console matching
>   *	@co:	  registering console
> @@ -666,6 +674,7 @@ static struct console univ8250_console = {
>  	.write		= univ8250_console_write,
>  	.device		= uart_console_device,
>  	.setup		= univ8250_console_setup,
> +	.exit		= univ8250_console_exit,
>  	.match		= univ8250_console_match,
>  	.flags		= CON_PRINTBUFFER | CON_ANYTIME,
>  	.index		= -1,

You're missing adding exit to struct console or these patches
are based on some tree I don't have. I had to add the following
change to compile for you to fold into this patch.

Regards,

Tony

8< -------------------
diff --git a/include/linux/console.h b/include/linux/console.h
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -148,6 +148,7 @@ struct console {
 	struct tty_driver *(*device)(struct console *, int *);
 	void	(*unblank)(void);
 	int	(*setup)(struct console *, char *);
+	int	(*exit)(struct console *);
 	int	(*match)(struct console *, char *name, int idx, char *options);
 	short	flags;
 	short	index;
