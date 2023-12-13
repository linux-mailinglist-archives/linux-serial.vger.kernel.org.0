Return-Path: <linux-serial+bounces-791-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A46AC80D29D
	for <lists+linux-serial@lfdr.de>; Mon, 11 Dec 2023 17:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E5E61F21563
	for <lists+linux-serial@lfdr.de>; Mon, 11 Dec 2023 16:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224542574D;
	Mon, 11 Dec 2023 16:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="jTC8tqA/"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD548E;
	Mon, 11 Dec 2023 08:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=TL1+ZfABaO3NcVU1msasX17Cuyls1YNXC9R1nv/2x6o=; b=jTC8tqA/1cCyBgw7v5730bbj3L
	iZei9gN1mFQ1V8pWnpCVnIQnuEpoUfsZiuGLn2eL+X9Y5ZfKrdg0o/CxqY+Y8JSquwVDK+Fw+zvoy
	4feyUI1MsxIfwYOQ0rNe9nsDj1/XJBbYWOd6ZB0VW7ktU2kyszdIzadd3q7M7zH7vqRM=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:48306 helo=debian-acer)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rCjOp-0003hR-5C; Mon, 11 Dec 2023 11:44:55 -0500
Date: Mon, 11 Dec 2023 11:44:54 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, kernel test robot <lkp@intel.com>
Message-Id: <20231211114454.44ef3b7e5d994142af506a6f@hugovil.com>
In-Reply-To: <20231211090949.297683-1-crescentcy.hsieh@moxa.com>
References: <20231211090949.297683-1-crescentcy.hsieh@moxa.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
Subject: Re: [PATCH v2] tty: serial: 8250: Fix MOXA RS422/RS485 PCIe boards
 not work by default
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

Hi,
your commit title message is somewhat vague and not really usefull in
determining why the change is done.

Maybe change it to something like : "Set RS422 mode by default to fix
MOXA RS422/RS485 PCIe boards..."

Hugo Villeneuve.


On Mon, 11 Dec 2023 17:09:49 +0800
Crescent CY Hsieh <crescentcy.hsieh@moxa.com> wrote:

> MOXA PCIe RS422/RS485 boards will not function by default because of the
> initial default serial interface of all MOXA PCIe boards is set to
> RS232.
> 
> This patch fixes the problem above by setting the initial default serial
> interface to RS422 for those MOXA RS422/RS485 PCIe boards.
> 
> Signed-off-by: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
> Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202312060523.Kmstf65q-lkp@intel.com/
> 
> ---
> Changes from v1 to v2:
> - Fix issue reported by kernel test robot
> 	- Replace function return type from u32 to static unsigned int
> 
> v1: https://lore.kernel.org/all/20231201074055.259207-1-crescentcy.hsieh@moxa.com/
> 
> ---
>  drivers/tty/serial/8250/8250_pci.c | 58 +++++++++++++++++++++++++++++-
>  1 file changed, 57 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> index b2be3783f..42fbbe89e 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -19,6 +19,7 @@
>  #include <linux/serial_core.h>
>  #include <linux/8250_pci.h>
>  #include <linux/bitops.h>
> +#include <linux/bitfield.h>
>  
>  #include <asm/byteorder.h>
>  #include <asm/io.h>
> @@ -1968,6 +1969,20 @@ pci_sunix_setup(struct serial_private *priv,
>  
>  #define MOXA_GPIO_PIN2	BIT(2)
>  
> +#define MOXA_RS232	0x00
> +#define MOXA_RS422	0x01
> +#define MOXA_RS485_4W	0x0B
> +#define MOXA_RS485_2W	0x0F
> +#define MOXA_UIR_OFFSET	0x04
> +#define MOXA_EVEN_RS_MASK	GENMASK(3, 0)
> +#define MOXA_ODD_RS_MASK	GENMASK(7, 4)
> +
> +enum {
> +	MOXA_SUPP_RS232 = BIT(0),
> +	MOXA_SUPP_RS422 = BIT(1),
> +	MOXA_SUPP_RS485 = BIT(2),
> +};
> +
>  static bool pci_moxa_is_mini_pcie(unsigned short device)
>  {
>  	if (device == PCI_DEVICE_ID_MOXA_CP102N	||
> @@ -1981,13 +1996,54 @@ static bool pci_moxa_is_mini_pcie(unsigned short device)
>  	return false;
>  }
>  
> +static unsigned int pci_moxa_supported_rs(struct pci_dev *dev)
> +{
> +	switch (dev->device & 0x0F00) {
> +	case 0x0000:
> +	case 0x0600:
> +		return MOXA_SUPP_RS232;
> +	case 0x0100:
> +		return MOXA_SUPP_RS232 | MOXA_SUPP_RS422 | MOXA_SUPP_RS485;
> +	case 0x0300:
> +		return MOXA_SUPP_RS422 | MOXA_SUPP_RS485;
> +	}
> +	return 0;
> +}
> +
> +static int pci_moxa_set_interface(const struct pci_dev *dev,
> +				  unsigned int port_idx,
> +				  u8 mode)
> +{
> +	resource_size_t iobar_addr = pci_resource_start(dev, 2);
> +	resource_size_t UIR_addr = iobar_addr + MOXA_UIR_OFFSET + port_idx / 2;
> +	u8 val;
> +
> +	val = inb(UIR_addr);
> +
> +	if (port_idx % 2) {
> +		val &= ~MOXA_ODD_RS_MASK;
> +		val |= FIELD_PREP(MOXA_ODD_RS_MASK, mode);
> +	} else {
> +		val &= ~MOXA_EVEN_RS_MASK;
> +		val |= FIELD_PREP(MOXA_EVEN_RS_MASK, mode);
> +	}
> +	outb(val, UIR_addr);
> +
> +	return 0;
> +}
> +
>  static int pci_moxa_init(struct pci_dev *dev)
>  {
>  	unsigned short device = dev->device;
>  	resource_size_t iobar_addr = pci_resource_start(dev, 2);
> -	unsigned int num_ports = (device & 0x00F0) >> 4;
> +	unsigned int num_ports = (device & 0x00F0) >> 4, i;
>  	u8 val;
>  
> +	if (!(pci_moxa_supported_rs(dev) & MOXA_SUPP_RS232)) {
> +		for (i = 0; i < num_ports; ++i)
> +			pci_moxa_set_interface(dev, i, MOXA_RS422);
> +	}
> +
>  	/*
>  	 * Enable hardware buffer to prevent break signal output when system boots up.
>  	 * This hardware buffer is only supported on Mini PCIe series.
> -- 
> 2.34.1
> 
> 


-- 
Hugo Villeneuve <hugo@hugovil.com>

