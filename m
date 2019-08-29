Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8457A29CC
	for <lists+linux-serial@lfdr.de>; Fri, 30 Aug 2019 00:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbfH2WdO (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 29 Aug 2019 18:33:14 -0400
Received: from mta01.hs-regensburg.de ([194.95.104.11]:47838 "EHLO
        mta01.hs-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbfH2WdN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 29 Aug 2019 18:33:13 -0400
Received: from E16S02.hs-regensburg.de (e16s02.hs-regensburg.de [IPv6:2001:638:a01:8013::92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client CN "E16S02", Issuer "E16S02" (not verified))
        by mta01.hs-regensburg.de (Postfix) with ESMTPS id 46KHSQ3n2szyBC;
        Fri, 30 Aug 2019 00:33:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oth-regensburg.de;
        s=mta01-20160622; t=1567117990;
        bh=re3CHT5eR8aTHujCy74OHFomUsdAIlXuCx7nE+yjlGI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=gifvJAL6cAPy2MDPjZBJEhV8pGRSESzwYblf/svBqiboHNLb/kC1Si+dc3CID3rBv
         mVe/ZOLX8otPuB/m8Kq7YWlIJf6RHmwlbwlZn5gyw7BQYK6j3ytGvdAG8OUl38urgV
         DXBJDQXOshbN41qqVzntqEfqRAxLvcvAiyXl9OZV8qcaAsyrlq+r/4QdMqoDRQCpWB
         8t1uaW+M0J0U3KVD//7jMCkAB/B6co5LdOuCNS4bsJfUuvFvLOjGjHATce0FwD2lqu
         m8BcAr4cyNqu1Fv4i8QSgLsmlDUs+IK9f65iDaAv2tcXh6m1VYwr9ppDcjSQNwX+5j
         hkp4TICOXkf2Q==
Received: from [172.23.3.82] (194.95.106.138) by E16S02.hs-regensburg.de
 (2001:638:a01:8013::92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 30 Aug
 2019 00:33:10 +0200
Subject: Re: [PATCH] serial: 8250_pci: Implement MSI(-X) support
To:     Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, <linux-serial@vger.kernel.org>,
        <jailhouse-dev@googlegroups.com>
CC:     Jay Dolan <jay.dolan@accesio.com>
References: <20190812112152.693622-1-ralf.ramsauer@oth-regensburg.de>
From:   Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
Openpgp: preference=signencrypt
Autocrypt: addr=ralf.ramsauer@oth-regensburg.de; keydata=
 mQINBFsT8OUBEADEz1dVva7HkfpQUsAH71/4RzV23kannVpJhTOhy9wLEJclj0cGMvvWFyaw
 9lTRxKfmWgDNThCvNziuPgJdaZ3KMlCuF9QOsW/e2ZKvP5N1GoIperljb3+DW3FFGC8mzCDa
 x6rVeY0MtSa9rdKbWKIwtSOPBgPk7Yg+QkF0gMHyDMjKrNPolnCZjypAIj81MQfG0s6hIwMB
 5LXZPl9WL2NwcBWxU71NBhyTvtVMy6eCPTDIT+rDIaIjdqXUbL8QBzaApxSLAgb7Nbatkx7k
 3LjqflPMmtQfQ67O1qS/ILe5DrYjGbwZWYb2xmXNwJvEENIDou9Wnusxphh1P1acnn+9DIjQ
 9/A+/zCiube3tgCpv5sq8++knQChn2NLMrHlVsRCgGApciO7/0hCvcS9mGE1JM3Nmwfs2wqW
 vG9vhv3uBJHjH4C8s5UCvF/44E22+bBqsrLUlr5d+YRNtY+LCH1rwNIrzNtfZraq0hPiI8pv
 P4GpvHDmrsGTyG9YbD33XiI7DD8IaAtwld7wSkMmt07NRhyxVsPc1ZIBQMyS28VvuLbDK4f6
 WyjQMJmA8EQspEmNcTFG6LnmW+7PGad2Nt7RhHRs4e4JkT8WckWzTCRzlRusyr13SbiFWznt
 +29Q47elnVUG3nB2h1VGZofX+myYJS0uX4BQ2G7sO+LrBY4HXQARAQABtC9SYWxmIFJhbXNh
 dWVyIDxyYWxmLnJhbXNhdWVyQG90aC1yZWdlbnNidXJnLmRlPokCVAQTAQgAPhYhBMAttVrc
 MMGXiLwkKnP5TRHIUlLMBQJbE/EnAhsDBQkFo5qABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheA
 AAoJEHP5TRHIUlLMICYQALEBOS5+OegeYvi/8qwcXWTtSPu6/L6z2kgh6XCii8zH8Rn9T1mB
 xzA5h1sBku1wIH+xloRxNNmZlxNyJOML5zMng8cLw/PRTDZ3JdzIFFw7bssAgDiLzr8F0gTq
 bRrAwFCDuZMNCJgJhxRrPRNSrZovqUeaSUAxw10Dea3NgcvJ1SLtClBaU2+U7dHQdBINBLXm
 UAg54P6voe/MhkPEwESRHWKsiEWBp4BBPv8AjXnYAth6F9LZksugF4KZMPWnEgXNjw6ObD6C
 T7qA46/ETXBcxI05lQFs3G9P6YpeOmH1V5pRWb2pS/f9vDudU52QRcAIUir0yjR45tmgJMLV
 oRR7xRyj/BXqBHbzjilg3GDZMiUtfjg6skr++du79b7xnoEgzHR/ByHW67MCbjcuTmpTeXBK
 Iq61He/l2NETfy+2ZnWOUNC7/lZHdfrEyHR3Q3S7TQbkm80TXE05Cfb5NXtZxlbCNxFEMtCT
 UeaUX0NtsHfRDNBzFY6pKSpg8EXDtEFe8+utLekEZ6lFgQ5ZJ1c9NfaOiRJ/NrnQfqAEXUyo
 uILPmXK+3UiFlWtmIIzSQ/Wd+4pJtM291zt0umnxboOZc1mOU9B2wKT3mnA3HxQ1LiRIT9j8
 l8iT6TwRB/aiiXa51hN4R7rfSQMxK6a93EAyUZSoWFpZiBo1/5PynB4zuQINBFsT8OUBEAC9
 HeOKJ/KJ861Q/5C1qwHRK95nJiwCCpASxip68e3ZW9vPTV3VmcQ3tPNRBLPZW1S+IV6DL8/j
 HnopXyyrFBkSJYEAtKkBI5xO6olYglCJqhJ5GdE2WIxvFfTkKwXf3gYc7zuif/5tS7D4XeEH
 wScrncFHCxDSUCXyGM/lnLhu3HfQbK49whpel67uteHrXC4tCMzaTy1SOwlXQi4nufxfARBe
 PT2udi+aZCs4a5bTqvEllPsWRsab4JjTsd831VLYCeRM6siKkzzv9nUjBjTri2cPm0FDS80X
 vQVHEw4bP+V4EvcrarNh/9VmCypuH23qRsAX33mLhB94aBoE6afCkWG5G2m24pj3NCkdA0MG
 IleuuD4/I+6+31Dip53AMvx5EDepMrA2b7gsQOKidgDe1fz/j1qkszmQlxlcb/LruXMWWY7L
 3NcwGUjNRfH0KiSyQ6GMtU5ECu8/o4fecOee76fHTviI6h7jSL3O0AKJadUXekAfhyVS/zUD
 iZTv2zI4wAyxIWj3AFVXXeb1T4UG+k4Ea+M7+jtgGUz/K3/mDYXWWRHkT5CMZLiU8BCdfewg
 Zp94L5KOWDYCeX5LWworOwtkoePd9h5g7L2EBbeINk8Ru018FkEiqALN03vPI8KYNXb6epUg
 xhdvhaPoSD3aCnQttvU8lN70cKBGMwTZYwARAQABiQI8BBgBCAAmFiEEwC21WtwwwZeIvCQq
 c/lNEchSUswFAlsT8OUCGwwFCQWjmoAACgkQc/lNEchSUswevA//RM2YQI1Z3QMBRMr/5As0
 2zXcJFp+j07wkO9avm8U7GwjPjLHGVvs44rTSc0IKSsIKCJDSqNod9jd2iR39lr5/FpRiRk/
 7A1ACZUagASNC+PiyCCjlg34bWulzVmb5ozjqKQqgYww4c6D0P44JDUtedVbKd7HdwjjzP0P
 cubSgAohnXzrkp3gtVg07KeoQyiZctJqJu9Z84MiXMIQ+G75mFkIJEL4WYIkcJ9pamUHX71Y
 T1s6qtrqXemn25w87TioHUMcW4wRXhHHJ4gDbe/P9wb9XKS41ks0kiTia1ZcFsf6QQzoCoK1
 R8ahGzsqvCRHMR7fU5w25qXAPfS5ENZgH0KcAVi1bDjwDyhQk3PfPiraiHmtEz2IlthAPpRD
 Drr0lqCvDFNtqaC+ZI0eOmTvy6/zfVh7ODmaDq1KqMu5EB9ojHXM7N6XXN8OubY+lNx+q0T5
 STssqr8EKkrHp6rw2OQHCX7uaEQri2GEJW4HowVvlashmxC4bxR8B4gbm+EB8gR8PD7BSZQG
 k5NkPOqUZJXq1HO+d5Udk1WdT+mkFGwIMN/U9t3gJNWkab+aAYg1mKwdz7B+10j51vbQbFgY
 2/n9jtl/AFgfYQocbJta5+0fOwIJObNFpLAotvtFNF+Q164Bc3E7Njh230nFduU/9BnmCpOQ
 RncIIYr0LjXAAzY=
Message-ID: <740fc1e7-fb3d-c0c7-c17b-2ea3a8864d89@oth-regensburg.de>
Date:   Fri, 30 Aug 2019 00:33:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190812112152.693622-1-ralf.ramsauer@oth-regensburg.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-PH
Content-Transfer-Encoding: 7bit
X-Originating-IP: [194.95.106.138]
X-ClientProxiedBy: E16S03.hs-regensburg.de (2001:638:a01:8013::93) To
 E16S02.hs-regensburg.de (2001:638:a01:8013::92)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

*ping* :)

On 8/12/19 1:21 PM, Ralf Ramsauer wrote:
> There may be setups, where legacy interrupts are not available. This is
> the caese, e.g., when Linux runs as guest (aka. non-root cell) of the
> partitioning hypervisor Jailhouse. There, only MSI(-X) interrupts are
> available for guests.
> 
> But the 8250_pci driver currently only supports legacy ints. So let's
> enable MSI(-X) interrupts.
> 
> Nevertheless, this needs to handled with care: while many 8250 devices
> actually claim to support MSI(-X) interrupts it should not be enabled be
> default. I had at least one device in my hands with broken MSI
> implementation.
> 
> So better introduce a whitelist with devices that are known to support
> MSI(-X) interrupts. I tested all devices mentioned in the patch.
> 
> Signed-off-by: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
> ---
>  drivers/tty/serial/8250/8250_pci.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> index bbe5cba21522..97992884c0ee 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -53,6 +53,16 @@ struct serial_private {
>  	int			line[0];
>  };
>  
> +static const struct pci_device_id pci_use_msi[] = {
> +	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9900,
> +			 0xA000, 0x1000) },
> +	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9912,
> +			 0xA000, 0x1000) },
> +	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9922,
> +			 0xA000, 0x1000) },
> +	{ }
> +};
> +
>  static int pci_default_setup(struct serial_private*,
>  	  const struct pciserial_board*, struct uart_8250_port *, int);
>  
> @@ -3643,7 +3653,22 @@ pciserial_init_ports(struct pci_dev *dev, const struct pciserial_board *board)
>  	memset(&uart, 0, sizeof(uart));
>  	uart.port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ;
>  	uart.port.uartclk = board->base_baud * 16;
> -	uart.port.irq = get_pci_irq(dev, board);
> +
> +	if (pci_match_id(pci_use_msi, dev)) {
> +		dev_dbg(&dev->dev, "Using MSI(-X) interrupts\n");
> +		pci_set_master(dev);
> +		rc = pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_ALL_TYPES);
> +	} else {
> +		dev_dbg(&dev->dev, "Using legacy interrupts\n");
> +		rc = pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_LEGACY);
> +	}
> +	if (rc < 0) {
> +		kfree(priv);
> +		priv = ERR_PTR(rc);
> +		goto err_deinit;
> +	}
> +
> +	uart.port.irq = pci_irq_vector(dev, 0);
>  	uart.port.dev = &dev->dev;
>  
>  	for (i = 0; i < nr_ports; i++) {
> 
