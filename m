Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 488F96EB37
	for <lists+linux-serial@lfdr.de>; Fri, 19 Jul 2019 21:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730265AbfGSToV (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 19 Jul 2019 15:44:21 -0400
Received: from xes-mad.com ([162.248.234.2]:45703 "EHLO mail.xes-mad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733029AbfGSToV (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 19 Jul 2019 15:44:21 -0400
X-Greylist: delayed 489 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Jul 2019 15:44:20 EDT
Received: from zimbra.xes-mad.com (zimbra.xes-mad.com [10.52.0.127])
        by mail.xes-mad.com (Postfix) with ESMTP id 3982720FE7;
        Fri, 19 Jul 2019 14:36:10 -0500 (CDT)
Date:   Fri, 19 Jul 2019 14:36:08 -0500 (CDT)
From:   Aaron Sierra <asierra@xes-inc.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>,
        Rob Groner <rgroner@rtd.com>
Message-ID: <1370607771.276118.1563564968480.JavaMail.zimbra@xes-inc.com>
In-Reply-To: <20190719143052.67038-1-andriy.shevchenko@linux.intel.com>
References: <20190719143052.67038-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] serial: 8250_exar: Move the Exar bits from 8250_port
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.0.127]
X-Mailer: Zimbra 8.7.5_GA_1764 (ZimbraWebClient - GC75 (Linux)/8.7.5_GA_1764)
Thread-Topic: serial: 8250_exar: Move the Exar bits from 8250_port
Thread-Index: LtPtulEvvufescumKWtK/vzJ3sqgTA==
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

----- Original Message -----
> From: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
> Sent: Friday, July 19, 2019 9:30:52 AM

> There are Exar quirks in 8250_port which belong to 8250_exar module.
> Move them to the correct module and do not contaminate generic code
> with it.
> 
> Cc: Aaron Sierra <asierra@xes-inc.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> in v2:
> - rebase on top of latest vanilla / serial-next
> - move divisor callbacks
> - drop RFC
> - compile tested only on my side, please, who has a hardware, test it

Andy,

I'll do some testing on v3 of this patch :P  See explanation below.

> drivers/tty/serial/8250/8250_exar.c | 82 ++++++++++++++++++++++++++++-
> drivers/tty/serial/8250/8250_port.c | 74 +-------------------------
> 2 files changed, 81 insertions(+), 75 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_exar.c
> b/drivers/tty/serial/8250/8250_exar.c
> index edd6dfe055bf..b9ab17b5b32d 100644
> --- a/drivers/tty/serial/8250/8250_exar.c
> +++ b/drivers/tty/serial/8250/8250_exar.c
> @@ -36,6 +36,8 @@
> 
> #define UART_EXAR_INT0		0x80
> #define UART_EXAR_8XMODE	0x88	/* 8X sampling rate select */
> +#define UART_EXAR_SLEEP		0x8b	/* Sleep mode */
> +#define UART_EXAR_DVID		0x8d	/* Device identification */
> 
> #define UART_EXAR_FCTR		0x08	/* Feature Control Register */
> #define UART_FCTR_EXAR_IRDA	0x10	/* IrDa data encode select */
> @@ -127,18 +129,94 @@ struct exar8250 {
> 	int			line[0];
> };
> 
> +/*
> + * These Exar UARTs have an extra interrupt indicator that could
> + * fire for a few unimplemented interrupts.  One of which is a
> + * wakeup event when coming out of sleep.  Put this here just
> + * to be on the safe side that these interrupts don't go unhandled.
> + */
> +static int exar_handle_irq(struct uart_port *port)
> +{
> +	unsigned int iir = serial_port_in(port, UART_IIR);
> +	int ret = 0;
> +
> +	if (serial_port_in(port, UART_EXAR_INT0) != 0)
> +		ret = 1;
> +
> +	ret |= serial8250_handle_irq(port, iir);
> +
> +	return ret;
> +}

This seems to (accidentally) reintroduce the per-port INT0 clearing that was
eliminated in c7e1b4059075 (tty: serial: exar: Relocate sleep wake-up handling)
and further polished in 60ab0fafc4b6 (serial: 8250_exar: Read INT0 from slave device, too)

The rest seems like harmless, but worthwhile cleanup as you suggest.

-Aaron

> +
> +static void exar_pm(struct uart_port *port, unsigned int state, unsigned int
> old)
> +{
> +	/*
> +	 * Exar UARTs have a SLEEP register that enables or disables each UART
> +	 * to enter sleep mode separately. On the XR17V35x the register
> +	 * is accessible to each UART at the UART_EXAR_SLEEP offset, but
> +	 * the UART channel may only write to the corresponding bit.
> +	 */
> +	serial_port_out(port, UART_EXAR_SLEEP, state ? 0xff : 0);
> +}
> +
> +/*
> + * XR17V35x UARTs have an extra fractional divisor register (DLD)
> + * Calculate divisor with extra 4-bit fractional portion
> + */
> +static unsigned int xr17v35x_get_divisor(struct uart_port *p, unsigned int
> baud,
> +					 unsigned int *frac)
> +{
> +	unsigned int quot_16;
> +
> +	quot_16 = DIV_ROUND_CLOSEST(p->uartclk, baud);
> +	*frac = quot_16 & 0x0f;
> +
> +	return quot_16 >> 4;
> +}
> +
> +static void xr17v35x_set_divisor(struct uart_port *p, unsigned int baud,
> +				 unsigned int quot, unsigned int quot_frac)
> +{
> +	serial8250_do_set_divisor(p, baud, quot, quot_frac);
> +
> +	/* Preserve bits not related to baudrate; DLD[7:4]. */
> +	quot_frac |= serial_port_in(p, 0x2) & 0xf0;
> +	serial_port_out(p, 0x2, quot_frac);
> +}
> +
> static int default_setup(struct exar8250 *priv, struct pci_dev *pcidev,
> 			 int idx, unsigned int offset,
> 			 struct uart_8250_port *port)
> {
> 	const struct exar8250_board *board = priv->board;
> 	unsigned int bar = 0;
> +	unsigned char status;
> 
> 	port->port.iotype = UPIO_MEM;
> 	port->port.mapbase = pci_resource_start(pcidev, bar) + offset;
> 	port->port.membase = priv->virt + offset;
> 	port->port.regshift = board->reg_shift;
> 
> +	/*
> +	 * XR17V35x UARTs have an extra divisor register, DLD that gets enabled
> +	 * with when DLAB is set which will cause the device to incorrectly match
> +	 * and assign port type to PORT_16650. The EFR for this UART is found
> +	 * at offset 0x09. Instead check the Deice ID (DVID) register
> +	 * for a 2, 4 or 8 port UART.
> +	 */
> +	status = readb(port->port.membase + UART_EXAR_DVID);
> +	if (status == 0x82 || status == 0x84 || status == 0x88) {
> +		port->port.type = PORT_XR17V35X;
> +
> +		port->port.get_divisor = xr17v35x_get_divisor;
> +		port->port.set_divisor = xr17v35x_set_divisor;
> +	} else {
> +		port->port.type = PORT_XR17D15X;
> +	}
> +
> +	port->port.handle_irq = exar_handle_irq;
> +	port->port.pm = exar_pm;
> +
> 	return 0;
> }
> 
> @@ -496,8 +574,8 @@ exar_pci_probe(struct pci_dev *pcidev, const struct
> pci_device_id *ent)
> 		return rc;
> 
> 	memset(&uart, 0, sizeof(uart));
> -	uart.port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ
> -			  | UPF_EXAR_EFR;
> +	uart.port.flags = UPF_SHARE_IRQ | UPF_EXAR_EFR |
> +			  UPF_FIXED_TYPE | UPF_FIXED_PORT;
> 	uart.port.irq = pci_irq_vector(pcidev, 0);
> 	uart.port.dev = &pcidev->dev;
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c
> b/drivers/tty/serial/8250/8250_port.c
> index c1cec808571b..3bf3b06fe0cb 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -44,8 +44,6 @@
>  * These are definitions for the Exar XR17V35X and XR17(C|D)15X
>  */
> #define UART_EXAR_INT0		0x80
> -#define UART_EXAR_SLEEP		0x8b	/* Sleep mode */
> -#define UART_EXAR_DVID		0x8d	/* Device identification */
> 
> /* Nuvoton NPCM timeout register */
> #define UART_NPCM_TOR          7
> @@ -709,19 +707,8 @@ EXPORT_SYMBOL_GPL(serial8250_rpm_put_tx);
> static void serial8250_set_sleep(struct uart_8250_port *p, int sleep)
> {
> 	unsigned char lcr = 0, efr = 0;
> -	/*
> -	 * Exar UARTs have a SLEEP register that enables or disables
> -	 * each UART to enter sleep mode separately.  On the XR17V35x the
> -	 * register is accessible to each UART at the UART_EXAR_SLEEP
> -	 * offset but the UART channel may only write to the corresponding
> -	 * bit.
> -	 */
> +
> 	serial8250_rpm_get(p);
> -	if ((p->port.type == PORT_XR17V35X) ||
> -	   (p->port.type == PORT_XR17D15X)) {
> -		serial_out(p, UART_EXAR_SLEEP, sleep ? 0xff : 0);
> -		goto out;
> -	}
> 
> 	if (p->capabilities & UART_CAP_SLEEP) {
> 		if (p->capabilities & UART_CAP_EFR) {
> @@ -1011,27 +998,6 @@ static void autoconfig_16550a(struct uart_8250_port *up)
> 	up->port.type = PORT_16550A;
> 	up->capabilities |= UART_CAP_FIFO;
> 
> -	/*
> -	 * XR17V35x UARTs have an extra divisor register, DLD
> -	 * that gets enabled with when DLAB is set which will
> -	 * cause the device to incorrectly match and assign
> -	 * port type to PORT_16650.  The EFR for this UART is
> -	 * found at offset 0x09. Instead check the Deice ID (DVID)
> -	 * register for a 2, 4 or 8 port UART.
> -	 */
> -	if (up->port.flags & UPF_EXAR_EFR) {
> -		status1 = serial_in(up, UART_EXAR_DVID);
> -		if (status1 == 0x82 || status1 == 0x84 || status1 == 0x88) {
> -			DEBUG_AUTOCONF("Exar XR17V35x ");
> -			up->port.type = PORT_XR17V35X;
> -			up->capabilities |= UART_CAP_AFE | UART_CAP_EFR |
> -						UART_CAP_SLEEP;
> -
> -			return;
> -		}
> -
> -	}
> -
> 	/*
> 	 * Check for presence of the EFR when DLAB is set.
> 	 * Only ST16C650V1 UARTs pass this test.
> @@ -1170,18 +1136,6 @@ static void autoconfig_16550a(struct uart_8250_port *up)
> 	}
> 	serial_out(up, UART_IER, iersave);
> 
> -	/*
> -	 * Exar uarts have EFR in a weird location
> -	 */
> -	if (up->port.flags & UPF_EXAR_EFR) {
> -		DEBUG_AUTOCONF("Exar XR17D15x ");
> -		up->port.type = PORT_XR17D15X;
> -		up->capabilities |= UART_CAP_AFE | UART_CAP_EFR |
> -				    UART_CAP_SLEEP;
> -
> -		return;
> -	}
> -
> 	/*
> 	 * We distinguish between 16550A and U6 16550A by counting
> 	 * how many bytes are in the FIFO.
> @@ -2453,23 +2407,6 @@ static void serial8250_shutdown(struct uart_port *port)
> 		serial8250_do_shutdown(port);
> }
> 
> -/*
> - * XR17V35x UARTs have an extra fractional divisor register (DLD)
> - * Calculate divisor with extra 4-bit fractional portion
> - */
> -static unsigned int xr17v35x_get_divisor(struct uart_8250_port *up,
> -					 unsigned int baud,
> -					 unsigned int *frac)
> -{
> -	struct uart_port *port = &up->port;
> -	unsigned int quot_16;
> -
> -	quot_16 = DIV_ROUND_CLOSEST(port->uartclk, baud);
> -	*frac = quot_16 & 0x0f;
> -
> -	return quot_16 >> 4;
> -}
> -
> /* Nuvoton NPCM UARTs have a custom divisor calculation */
> static unsigned int npcm_get_divisor(struct uart_8250_port *up,
> 		unsigned int baud)
> @@ -2497,8 +2434,6 @@ static unsigned int serial8250_do_get_divisor(struct
> uart_port *port,
> 	else if ((port->flags & UPF_MAGIC_MULTIPLIER) &&
> 		 baud == (port->uartclk/8))
> 		quot = 0x8002;
> -	else if (up->port.type == PORT_XR17V35X)
> -		quot = xr17v35x_get_divisor(up, baud, frac);
> 	else if (up->port.type == PORT_NPCM)
> 		quot = npcm_get_divisor(up, baud);
> 	else
> @@ -2585,13 +2520,6 @@ void serial8250_do_set_divisor(struct uart_port *port,
> unsigned int baud,
> 		serial_port_out(port, UART_LCR, up->lcr | UART_LCR_DLAB);
> 
> 	serial_dl_write(up, quot);
> -
> -	/* XR17V35x UARTs have an extra fractional divisor register (DLD) */
> -	if (up->port.type == PORT_XR17V35X) {
> -		/* Preserve bits not related to baudrate; DLD[7:4]. */
> -		quot_frac |= serial_port_in(port, 0x2) & 0xf0;
> -		serial_port_out(port, 0x2, quot_frac);
> -	}
> }
> EXPORT_SYMBOL_GPL(serial8250_do_set_divisor);
> 
> --
> 2.20.1
