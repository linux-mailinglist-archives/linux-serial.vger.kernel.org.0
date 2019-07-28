Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 771B0781F9
	for <lists+linux-serial@lfdr.de>; Mon, 29 Jul 2019 00:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbfG1WMN (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sun, 28 Jul 2019 18:12:13 -0400
Received: from xes-mad.com ([162.248.234.2]:19851 "EHLO mail.xes-mad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbfG1WMN (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 28 Jul 2019 18:12:13 -0400
Received: from zimbra.xes-mad.com (zimbra.xes-mad.com [10.52.0.127])
        by mail.xes-mad.com (Postfix) with ESMTP id 5CF12200D2;
        Sun, 28 Jul 2019 17:12:11 -0500 (CDT)
Date:   Sun, 28 Jul 2019 17:12:09 -0500 (CDT)
From:   Aaron Sierra <asierra@xes-inc.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Message-ID: <1785128142.57495.1564351929356.JavaMail.zimbra@xes-inc.com>
In-Reply-To: <20190721142659.60773-1-andriy.shevchenko@linux.intel.com>
References: <20190721142659.60773-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3] serial: 8250_exar: Move the Exar bits out from
 8250_port
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.0.127]
X-Mailer: Zimbra 8.7.5_GA_1764 (ZimbraWebClient - GC75 (Linux)/8.7.5_GA_1764)
Thread-Topic: serial: 8250_exar: Move the Exar bits out from 8250_port
Thread-Index: fdzkpKhyA75ELI+3KCS/RVnucNmL2A==
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

----- Original Message -----
> From: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
> Sent: Sunday, July 21, 2019 9:26:59 AM

> There are Exar quirks in 8250_port which belong to 8250_exar module.
> Move out them to the correct module and do not contaminate generic code
> with it.

Andy,

Your changes seem functionally equivalent based on my review and testing.

However, based on this commit description, I was expecting more of the
Exar-specific code to be moved from 8250_port.c to 8250_exar.c. I think that
can reasonably be achieved without too much additional effort.

There are two pieces of Exar-specific support in serial8250_do_startup():

1. The two reads to clear INT0, could be boiled down to a single read in
   exar_pci_probe(), immediately after registering the common IRQ handler.
   What do you think?

2. The following block could be moved to a new exar_startup() function:

	if (port->type == PORT_XR17V35X) {
		/*
		 * First enable access to IER [7:5], ISR [5:4], FCR [5:4],
		 * MCR [7:5] and MSR [7:0]
		 */
		serial_port_out(port, UART_XR_EFR, UART_EFR_ECB);

		/*
		 * Make sure all interrups are masked until initialization is
		 * complete and the FIFOs are cleared
		 */
		serial_port_out(port, UART_IER, 0);
	}

   Do you agree?

The only thing that seems to need to stay put is UART_XR_EFR support in
serial8250_do_set_termios().

There are a couple additional notes below for you to find. One involves a
compile warning.

> Cc: Aaron Sierra <asierra@xes-inc.com>
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> Cc: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> in v3:
> - dropped unneeded IRQ handler (Aaron)
> - compile tested only on my side, please, whoever has a hardware, test it
> drivers/tty/serial/8250/8250_exar.c | 61 +++++++++++++++++++++++-
> drivers/tty/serial/8250/8250_port.c | 74 +----------------------------
> 2 files changed, 60 insertions(+), 75 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_exar.c
> b/drivers/tty/serial/8250/8250_exar.c
> index edd6dfe055bf..4f8f45e2fc1d 100644
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
> @@ -127,18 +129,74 @@ struct exar8250 {
> 	int			line[0];
> };
> 
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
> +	port->port.pm = exar_pm;
> +
> 	return 0;
> }
> 
> @@ -496,8 +554,7 @@ exar_pci_probe(struct pci_dev *pcidev, const struct
> pci_device_id *ent)
> 		return rc;
> 
> 	memset(&uart, 0, sizeof(uart));
> -	uart.port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ
> -			  | UPF_EXAR_EFR;
> +	uart.port.flags = UPF_SHARE_IRQ | UPF_EXAR_EFR | UPF_FIXED_TYPE |
> UPF_FIXED_PORT;
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

My note above about cleaning up serial8250_do_startup() would eliminate
the need for UART_EXAR_INT0 to be defined here, too.

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

Take the "out" label as well to avoid introducing a compile warning.

-Aaron

[ snip ]
