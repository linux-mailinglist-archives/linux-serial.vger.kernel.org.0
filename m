Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94EC5B083F
	for <lists+linux-serial@lfdr.de>; Thu, 12 Sep 2019 07:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbfILFYX (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 12 Sep 2019 01:24:23 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:33047 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725922AbfILFYX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Sep 2019 01:24:23 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 0574245A;
        Thu, 12 Sep 2019 01:24:20 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Thu, 12 Sep 2019 01:24:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm3; bh=YqIItF7+rTZqrxpReTwaFBiMZzmfFKq
        6p2/0awERfQI=; b=cJ0I601jQAJg3Jd2w8Oa/rowHgRwLGGuROAJoRIi/ZZtsOh
        CTnkeqQdIb9nNQSQ6h0+9aU1hMqsNG/5C2HtNv+U1muVn68fw6Oi0r1HCx7Eidig
        oUJ0XhO/FlqP8g+Gnzi69F7A3Us9P1lE9jW0B9K0qbJkk4hTmvUH6wmtuzrDo5Wi
        Q9/x+FurqXNKnZ9nehMi336ecsK6p4beVa/z8XFAvXg0ZI4Z0EBatRdBf6WnPTAN
        87kdK1ZLIOjm8xjHSCuCykeFAdJiJv9Owa74aQlnH/VDOJA1cKylC4660xVf1uF2
        2SySKSfKgVaVLJ++9aI3mJnO65JTgBDjl0a3KAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=YqIItF
        7+rTZqrxpReTwaFBiMZzmfFKq6p2/0awERfQI=; b=p8pTvV6KtjB/y7F/OEEZoe
        5tZckJXCVujqNr8NwpuxXCOLhszFtcQvXUM2grF7wv15StGEtJzrMVhzV2VyR/dH
        KSn9GEG7oDffhqSJKPiOk3Q42madD0DIXroOQpGvNSEvp4d+ByVFqeCCiTaveJKI
        MGBDXfKV+utSAkqprXlAXi6bFIQIypDXqr+aELVLdMXXxR0ryXq1E5blvecfQ6Px
        MVOHMkT5fX0VxXR+2eOTDAbgNF3ZgswdHWiTybBWeqJiV6MsMRv7dLq/YJlBZRCk
        ZoOloOVK+mwvBCkvc3H4/ISw6JxcrRxFrcuqhE/u4KR6UReY3E/wknzozjTE/kNA
        ==
X-ME-Sender: <xms:g9Z5XUdKZdy9hfpKrc1dOXYZ-auwW9Fn7sdHw6uHImgqmGBjqhQAJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrtdeggdelhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderreejnecuhfhrohhmpedftehnughr
    vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucfrrghrrg
    hmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruhenucevlhhushhtvghr
    ufhiiigvpedt
X-ME-Proxy: <xmx:g9Z5XU1eAFQMfc0hhfN3xY298WiFyw-N14byqyTjY7XeEhh9EDs-ag>
    <xmx:g9Z5XVLklxKFvk_Uv3cdoj2pgbfJHVhVXHlkNx_UW1OfWWUBLZCc6A>
    <xmx:g9Z5XQJE73njcMoXynhJUr93paapF972iCtGtlWEHwS8aCmkht2a3w>
    <xmx:hNZ5Xefge8GuwgDNwueVRisuTH6bA_RrusxiPz6PmDdsbK4ZgIQvlg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0FC43E00A9; Thu, 12 Sep 2019 01:24:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-237-gf35468d-fmstable-20190912v1
Mime-Version: 1.0
Message-Id: <1c9552b6-1640-483f-8977-9601e9383d2a@www.fastmail.com>
In-Reply-To: <20190905144130.220713-1-osk@google.com>
References: <20190905144130.220713-1-osk@google.com>
Date:   Thu, 12 Sep 2019 14:54:47 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Oskar Senft" <osk@google.com>, "Joel Stanley" <joel@jms.id.au>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Jeremy Kerr" <jk@ozlabs.org>
Cc:     openbmc@lists.ozlabs.org, linux-aspeed@lists.ozlabs.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: =?UTF-8?Q?Re:_[PATCH_v3_1/3]_drivers/tty/serial/8250:_Make_Aspeed_VUART_?=
 =?UTF-8?Q?SIRQ_polarity_configurable?=
Content-Type: text/plain
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On Fri, 6 Sep 2019, at 00:11, Oskar Senft wrote:
> Make the SIRQ polarity for Aspeed AST24xx/25xx VUART configurable via
> sysfs. This setting need to be changed on specific host platforms
> depending on the selected host interface (LPC / eSPI).
> 
> The setting is configurable via sysfs rather than device-tree to stay in
> line with other related configurable settings.
> 
> On AST2500 the VUART SIRQ polarity can be auto-configured by reading a
> bit from a configuration register, e.g. the LPC/eSPI interface
> configuration bit.
> 
> Tested: Verified on TYAN S7106 mainboard.
> Signed-off-by: Oskar Senft <osk@google.com>
> ---
>  .../ABI/stable/sysfs-driver-aspeed-vuart      | 11 ++-
>  drivers/tty/serial/8250/8250_aspeed_vuart.c   | 84 +++++++++++++++++++
>  drivers/tty/serial/8250/Kconfig               |  1 +
>  3 files changed, 95 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/stable/sysfs-driver-aspeed-vuart 
> b/Documentation/ABI/stable/sysfs-driver-aspeed-vuart
> index 8062953ce77b..950cafc9443a 100644
> --- a/Documentation/ABI/stable/sysfs-driver-aspeed-vuart
> +++ b/Documentation/ABI/stable/sysfs-driver-aspeed-vuart
> @@ -6,10 +6,19 @@ Description:	Configures which IO port the host side 
> of the UART
>  Users:		OpenBMC.  Proposed changes should be mailed to
>  		openbmc@lists.ozlabs.org
>  
> -What:		/sys/bus/platform/drivers/aspeed-vuart*/sirq
> +What:		/sys/bus/platform/drivers/aspeed-vuart/*/sirq

Bit of a nit, but this is unrelated

>  Date:		April 2017
>  Contact:	Jeremy Kerr <jk@ozlabs.org>
>  Description:	Configures which interrupt number the host side of
>  		the UART will appear on the host <-> BMC LPC bus.
>  Users:		OpenBMC.  Proposed changes should be mailed to
>  		openbmc@lists.ozlabs.org
> +
> +What:		/sys/bus/platform/drivers/aspeed-vuart/*/sirq_polarity
> +Date:		July 2019
> +Contact:	Oskar Senft <osk@google.com>
> +Description:	Configures the polarity of the serial interrupt to the
> +		host via the BMC LPC bus.
> +		Set to 0 for active-low or 1 for active-high.
> +Users:		OpenBMC.  Proposed changes should be mailed to
> +		openbmc@lists.ozlabs.org
> diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c 
> b/drivers/tty/serial/8250/8250_aspeed_vuart.c
> index 0438d9a905ce..6e67fd89445a 100644
> --- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
> +++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
> @@ -14,6 +14,8 @@
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_platform.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/syscon.h>
>  #include <linux/tty.h>
>  #include <linux/tty_flip.h>
>  #include <linux/clk.h>
> @@ -22,6 +24,7 @@
>  
>  #define ASPEED_VUART_GCRA		0x20
>  #define ASPEED_VUART_GCRA_VUART_EN		BIT(0)
> +#define ASPEED_VUART_GCRA_HOST_SIRQ_POLARITY	BIT(1)
>  #define ASPEED_VUART_GCRA_DISABLE_HOST_TX_DISCARD BIT(5)
>  #define ASPEED_VUART_GCRB		0x24
>  #define ASPEED_VUART_GCRB_HOST_SIRQ_MASK	GENMASK(7, 4)
> @@ -131,8 +134,53 @@ static ssize_t sirq_store(struct device *dev, 
> struct device_attribute *attr,
>  
>  static DEVICE_ATTR_RW(sirq);
>  
> +static ssize_t sirq_polarity_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	struct aspeed_vuart *vuart = dev_get_drvdata(dev);
> +	u8 reg;
> +
> +	reg = readb(vuart->regs + ASPEED_VUART_GCRA);
> +	reg &= ASPEED_VUART_GCRA_HOST_SIRQ_POLARITY;
> +
> +	return snprintf(buf, PAGE_SIZE - 1, "%u\n", reg ? 1 : 0);
> +}
> +
> +static void aspeed_vuart_set_sirq_polarity(struct aspeed_vuart *vuart,
> +					   bool polarity)
> +{
> +	u8 reg = readb(vuart->regs + ASPEED_VUART_GCRA);
> +
> +	if (polarity)
> +		reg |= ASPEED_VUART_GCRA_HOST_SIRQ_POLARITY;
> +	else
> +		reg &= ~ASPEED_VUART_GCRA_HOST_SIRQ_POLARITY;
> +
> +	writeb(reg, vuart->regs + ASPEED_VUART_GCRA);
> +}
> +
> +static ssize_t sirq_polarity_store(struct device *dev,
> +				   struct device_attribute *attr,
> +				   const char *buf, size_t count)
> +{
> +	struct aspeed_vuart *vuart = dev_get_drvdata(dev);
> +	unsigned long val;
> +	int err;
> +
> +	err = kstrtoul(buf, 0, &val);
> +	if (err)
> +		return err;
> +
> +	aspeed_vuart_set_sirq_polarity(vuart, val != 0);
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR_RW(sirq_polarity);
> +
>  static struct attribute *aspeed_vuart_attrs[] = {
>  	&dev_attr_sirq.attr,
> +	&dev_attr_sirq_polarity.attr,
>  	&dev_attr_lpc_address.attr,
>  	NULL,
>  };
> @@ -302,8 +350,30 @@ static int aspeed_vuart_handle_irq(struct uart_port *port)
>  	return 1;
>  }
>  
> +static void aspeed_vuart_auto_configure_sirq_polarity(
> +	struct aspeed_vuart *vuart, struct device_node *syscon_np,
> +	u32 reg_offset, u32 reg_mask)
> +{
> +	struct regmap *regmap;
> +	u32 value;
> +
> +	regmap = syscon_node_to_regmap(syscon_np);
> +	if (IS_ERR(regmap)) {
> +		dev_warn(vuart->dev,
> +			 "could not get regmap for aspeed,sirq-polarity-sense\n");
> +		return;
> +	}
> +	if (regmap_read(regmap, reg_offset, &value)) {
> +		dev_warn(vuart->dev, "could not read hw strap table\n");
> +		return;
> +	}

So in the couple of cases above we may have tried to auto-configure the IRQ
polarity but failed. We print the messages, but there's no mention of the
impact of the failure as it doesn't stop the driver from probing (void return).

I'm thinking it might be useful briefly describe the potential impact, and,
given we have the sysfs interface suggest what might need to be done to
configure the hardware so it works? Maybe something like:

dev_warn(vuart->dev, "SIRQ polarity auto-configuration failed, host console may misbehave\n");
dev_info(vuart->dev, "Configure SIRQ polarity via %s\n", sysfs_path); // If we have access to the path?

However, both are unlikely corner-cases as they imply either MMIO regmap
failed or that the devicetree description was present but broken in some
fashion (should be caught in testing), so I'm not hung up about this.

Aside from those nits it looks reasonable to me.

Andrew
