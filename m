Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 526DE7DFF7
	for <lists+linux-serial@lfdr.de>; Thu,  1 Aug 2019 18:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730713AbfHAQUH (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 1 Aug 2019 12:20:07 -0400
Received: from xes-mad.com ([162.248.234.2]:28123 "EHLO mail.xes-mad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727024AbfHAQUH (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 1 Aug 2019 12:20:07 -0400
Received: from zimbra.xes-mad.com (zimbra.xes-mad.com [10.52.0.127])
        by mail.xes-mad.com (Postfix) with ESMTP id 09E6D200D2;
        Thu,  1 Aug 2019 11:20:06 -0500 (CDT)
Date:   Thu, 1 Aug 2019 11:20:03 -0500 (CDT)
From:   Aaron Sierra <asierra@xes-inc.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Message-ID: <294381572.178544.1564676403888.JavaMail.zimbra@xes-inc.com>
In-Reply-To: <20190731170558.52897-1-andriy.shevchenko@linux.intel.com>
References: <20190731170558.52897-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 1/3] serial: 8250_exar: No need to autoconfigure Exar
 ports
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.0.127]
X-Mailer: Zimbra 8.7.5_GA_1764 (ZimbraWebClient - GC75 (Linux)/8.7.5_GA_1764)
Thread-Topic: serial: 8250_exar: No need to autoconfigure Exar ports
Thread-Index: p9NlfYbqfSf+NCBmQU5gTvaQKKvb5Q==
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

----- Original Message -----
> From: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
> Sent: Wednesday, July 31, 2019 12:05:56 PM

> Since we have a separate driver there is no need to autoconfigure ports,
> we already know what they are.
> 
> Drop autoconfiguration in 8250_port and move type detection to 8250_exar.

Tested-by: Aaron Sierra <asierra@xes-inc.com>

> Cc: Aaron Sierra <asierra@xes-inc.com>
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> Cc: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> drivers/tty/serial/8250/8250_exar.c | 19 ++++++++++++++--
> drivers/tty/serial/8250/8250_port.c | 34 -----------------------------
> 2 files changed, 17 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_exar.c
> b/drivers/tty/serial/8250/8250_exar.c
> index 8d60e5481af0..94212d9bf73f 100644
> --- a/drivers/tty/serial/8250/8250_exar.c
> +++ b/drivers/tty/serial/8250/8250_exar.c
> @@ -36,6 +36,7 @@
> 
> #define UART_EXAR_INT0		0x80
> #define UART_EXAR_8XMODE	0x88	/* 8X sampling rate select */
> +#define UART_EXAR_DVID		0x8d	/* Device identification */
> 
> #define UART_EXAR_FCTR		0x08	/* Feature Control Register */
> #define UART_FCTR_EXAR_IRDA	0x10	/* IrDa data encode select */
> @@ -133,12 +134,27 @@ static int default_setup(struct exar8250 *priv, struct
> pci_dev *pcidev,
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
> +	} else {
> +		port->port.type = PORT_XR17D15X;
> +	}
> +
> 	return 0;
> }
> 
> @@ -494,8 +510,7 @@ exar_pci_probe(struct pci_dev *pcidev, const struct
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
> index c1cec808571b..6729b82ed2e3 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -45,7 +45,6 @@
>  */
> #define UART_EXAR_INT0		0x80
> #define UART_EXAR_SLEEP		0x8b	/* Sleep mode */
> -#define UART_EXAR_DVID		0x8d	/* Device identification */
> 
> /* Nuvoton NPCM timeout register */
> #define UART_NPCM_TOR          7
> @@ -1011,27 +1010,6 @@ static void autoconfig_16550a(struct uart_8250_port *up)
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
> @@ -1170,18 +1148,6 @@ static void autoconfig_16550a(struct uart_8250_port *up)
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
> --
> 2.20.1
