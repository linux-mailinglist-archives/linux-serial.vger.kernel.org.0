Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E34DE137449
	for <lists+linux-serial@lfdr.de>; Fri, 10 Jan 2020 18:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgAJRAq (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 10 Jan 2020 12:00:46 -0500
Received: from smtprelay0218.hostedemail.com ([216.40.44.218]:45647 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725937AbgAJRAq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Jan 2020 12:00:46 -0500
X-Greylist: delayed 587 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Jan 2020 12:00:45 EST
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave04.hostedemail.com (Postfix) with ESMTP id 1CA1118013824
        for <linux-serial@vger.kernel.org>; Fri, 10 Jan 2020 16:50:59 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 9F9C34DA5;
        Fri, 10 Jan 2020 16:50:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:599:960:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2828:2896:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3870:3873:3874:4250:4321:5007:6119:8957:10004:10400:10848:11026:11232:11473:11658:11914:12043:12114:12296:12297:12438:12555:12740:12760:12895:12986:13439:14096:14097:14181:14659:14721:21080:21627:21740:21939:21990:30029:30046:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: doll74_8316ba625761
X-Filterd-Recvd-Size: 3602
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Fri, 10 Jan 2020 16:50:56 +0000 (UTC)
Message-ID: <5293a7cb1ccb16275ddb36c7f26fb9e83f4fac9b.camel@perches.com>
Subject: Re: [PATCH-next 3/3] serial/sysrq: Add MAGIC_SYSRQ_SERIAL_SEQUENCE
From:   Joe Perches <joe@perches.com>
To:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Date:   Fri, 10 Jan 2020 08:50:03 -0800
In-Reply-To: <20200109215444.95995-4-dima@arista.com>
References: <20200109215444.95995-1-dima@arista.com>
         <20200109215444.95995-4-dima@arista.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, 2020-01-09 at 21:54 +0000, Dmitry Safonov wrote:
> Many embedded boards have a disconnected TTL level serial which can
> generate some garbage that can lead to spurious false sysrq detects.

trivia:

> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
[]
> @@ -3081,6 +3081,38 @@ void uart_insert_char(struct uart_port *port, unsigned int status,
[]
> +const char sysrq_toggle_seq[] = CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE;

static const?

> +static int uart_try_toggle_sysrq(struct uart_port *port, unsigned int ch)

This function return might read better as bool not int

> +{
> +	if (sysrq_toggle_seq[0] == '\0')
> +		return 0;
> +
> +	BUILD_BUG_ON(ARRAY_SIZE(sysrq_toggle_seq) >= sizeof(port->sysrq_seq)*U8_MAX);
> +	if (sysrq_toggle_seq[port->sysrq_seq] != ch) {
> +		port->sysrq_seq = 0;
> +		return 0;
> +	}
> +
> +	/* Without the last \0 */
> +	if (++port->sysrq_seq < (ARRAY_SIZE(sysrq_toggle_seq) - 1)) {
> +		port->sysrq = jiffies + HZ*5;
> +		return 1;
> +	}
> +
> +	schedule_work(&sysrq_enable_work);
> +
> +	port->sysrq = 0;
> +	return 1;
> +}
[]
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index 255e86a474e9..1f4443db5474 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -243,10 +243,10 @@ struct uart_port {
>  	unsigned long		sysrq;			/* sysrq timeout */
>  	unsigned int		sysrq_ch;		/* char for sysrq */
>  	unsigned char		has_sysrq;
> +	unsigned char		sysrq_seq;		/* index in sysrq_toggle_seq */

unsigned int?

Or maybe set a maximum length of MAGIC_SYSRQ_SERIAL_SEQUENCE.


>  
>  	unsigned char		hub6;			/* this should be in the 8250 driver */
>  	unsigned char		suspended;
> -	unsigned char		unused;
>  	const char		*name;			/* port name */
>  	struct attribute_group	*attr_group;		/* port specific attributes */
>  	const struct attribute_group **tty_groups;	/* all attributes (serial core use only) */
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 330909c600b1..f6f3e82fee25 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -431,6 +431,14 @@ config MAGIC_SYSRQ_SERIAL
>  	  This option allows you to decide whether you want to enable the
>  	  magic SysRq key.
>  
> +config MAGIC_SYSRQ_SERIAL_SEQUENCE
> +	string "Char sequence that enables magic SysRq over serial"
> +	depends on MAGIC_SYSRQ_SERIAL
> +	default ""
> +	help
> +	  Specifies a sequence of characters that can follow BREAK to enable
> +	  SysRq on a serial console.
> +
>  config DEBUG_FS
>  	bool "Debug Filesystem"
>  	help

