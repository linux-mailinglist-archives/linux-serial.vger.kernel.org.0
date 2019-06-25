Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13BD352891
	for <lists+linux-serial@lfdr.de>; Tue, 25 Jun 2019 11:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfFYJtN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-serial@lfdr.de>); Tue, 25 Jun 2019 05:49:13 -0400
Received: from mail1.bemta23.messagelabs.com ([67.219.246.112]:37461 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726441AbfFYJtN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 25 Jun 2019 05:49:13 -0400
Received: from [67.219.247.53] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-6.bemta.az-d.us-east-1.aws.symcld.net id E5/93-13972-61EE11D5; Tue, 25 Jun 2019 09:49:10 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKKsWRWlGSWpSXmKPExsXi5LtOQFfsnWC
  swZ5ZUhbNi9ezWTw84GxxZnEvu8Wf/Q+ZLDZvmspscX79bhaLHxseszqwe2xa1cnm8e7cOXaP
  /XPXsHs8m36YyePzJrkA1ijWzLyk/IoE1oxd8yMLJkpVrL97gqWB8axoFyMXh5DAXkaJTR9+s
  3YxcnKwCRhKrF5whB3EFhHQkNh46RYzSBGzQDeTxIqmzWAJYQEDiW1n/wHZHEBFhhIrf3JB1O
  dJTDy/CmwOi4CqxM1NncwgNq+AtcT7W/0sEMv+s0i8/fILrIhTwEvi56tPjCA2o4CsxIv2CUw
  gNrOAuMStJ/PBbAkBAYkle84zQ9iiEi8f/2MF2SsqEC5x/UohRFhB4tPuPywQrXoSz07NgrLN
  JV5+nQY1Ulti2cLXUPcISpyc+YRlAqPoLCTbZiFpn4WkfRaS9llI2hcwsq5iNE8qykzPKMlNz
  MzRNTQw0DU0NAJiXSMDU73EKt0UvdJi3dTE4hJdQ73E8mK94src5JwUvbzUkk2MwBhOKeA+u4
  Nxx5HXeocYJTmYlER5jToEY4X4kvJTKjMSizPii0pzUosPMcpwcChJ8Fq+AcoJFqWmp1akZeY
  A0wlMWoKDR0mENxokzVtckJhbnJkOkTrFqMsx4eXcRcxCLHn5ealS4ryzQYoEQIoySvPgRsBS
  2yVGWSlhXkYGBgYhnoLUotzMElT5V4ziHIxKwrwlIFN4MvNK4Da9AjqCCeiIzRP4QI4oSURIS
  TUwrTgnr9ien9khsTahMqy4Yur/KPZCpjVly2xPRHEK+6zreX9nVeOyd6p+dUqzg27JLfklFy
  19XSKwd1+65llHhd/C4ds+BmUU334pOHm1X1Vz9huGJXlpV575v4js25BV8vX92ruRPRN/3FH
  uuLfSVubH3QqFi53OmUwtdt9ObfvOxe52JDJjb01BfPmv4v9LlCrd+W8f2eGpn1iprb9x/plp
  nkdfGvyb0Bfru8Zw/9Orq82ceqxSJiR81F1nwspnO7PbZ0rRz6raPfmce0JcNpycesmnptLw7
  WG+uv237GuPrlLhyA1nWHkgaenZNuc9MjZflwTviC78fWv/7CSVVpFlIir3rknbGv10EixTYi
  nOSDTUYi4qTgQAgfVMyOgDAAA=
X-Env-Sender: Robert.Hodaszi@digi.com
X-Msg-Ref: server-20.tower-425.messagelabs.com!1561456150!2318665!1
X-Originating-IP: [66.77.174.16]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.43.9; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 370 invoked from network); 25 Jun 2019 09:49:10 -0000
Received: from owa.digi.com (HELO MCL-VMS-XCH01.digi.com) (66.77.174.16)
  by server-20.tower-425.messagelabs.com with SMTP; 25 Jun 2019 09:49:10 -0000
Received: from MTK-SMS-XCH02.digi.com ([fe80::4960:cfbf:ad5e:3cdb]) by
 MCL-VMS-XCH01.digi.com ([fe80::5587:821d:f8e4:6578%13]) with mapi id
 14.03.0439.000; Tue, 25 Jun 2019 04:49:09 -0500
From:   "Hodaszi, Robert" <Robert.Hodaszi@digi.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Michael Shych <michaelsh@mellanox.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: "No irq handler for vector" problem
Thread-Topic: "No irq handler for vector" problem
Thread-Index: AQHVKDldOPMq6dwWv0y/P7fHdq3NuKamqPoA//+5LYeAAzhHgIAASXUAgAEJGYCAAC41AIAAFYCAgABOuACAAEL3AIAAt3SA
Date:   Tue, 25 Jun 2019 09:49:08 +0000
Message-ID: <a1582e82-c2b3-95fd-0c92-e04765da0a59@digi.com>
References: <dcc1febb-2afc-da9b-696e-3c9bf63f4b76@digi.com>
 <alpine.DEB.2.21.1906211858340.5503@nanos.tec.linutronix.de>
 <37433D8393E7AF43B0D856B93884DA9E4FD67B64@MTK-SMS-XCH02.digi.com>
 <AM6PR05MB61689A1EE1E6B31682A476FAD9E10@AM6PR05MB6168.eurprd05.prod.outlook.com>
 <alpine.DEB.2.21.1906231955420.32342@nanos.tec.linutronix.de>
 <AM6PR05MB6168265CCF44FBCAEBBD4EA8D9E00@AM6PR05MB6168.eurprd05.prod.outlook.com>
 <d40acbee-df87-1f4b-48c1-66fe31c841fd@digi.com>
 <alpine.DEB.2.21.1906241609080.32342@nanos.tec.linutronix.de>
 <c49e9454-d6d2-408c-8232-ee4c17d6975d@digi.com>
 <alpine.DEB.2.21.1906242335250.32342@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1906242335250.32342@nanos.tec.linutronix.de>
Accept-Language: en-US, hu-HU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
x-originating-ip: [172.27.2.174]
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <250450B6E3395346A056420990FF4B36@digi.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, 25 Jun 2019, Gleixner, Thomas wrote:
>
> It's actually deep idle, which makes it slow to come out and service the
> interrupt.
I didn't have time to check the uploaded log (wife pulled the reins :)), 
only a previous one, which was heavily contaminated with debug printk-s, 
so I quickly created a new one. That one showed hrtimer interrupts 
before the UART's, which was confusing a bit, but checking again, that 
was ~15msec before, and the core went to idle, as you wrote.
>   /*
>    * Internal function to unregister an irqaction - used to free
>    * regular and special interrupts that are part of the architecture.
> @@ -1664,6 +1675,7 @@ static struct irqaction *__free_irq(stru
>   	unsigned irq = desc->irq_data.irq;
>   	struct irqaction *action, **action_ptr;
>   	unsigned long flags;
> +	bool sync = false;
>   
>   	WARN(in_interrupt(), "Trying to free IRQ %d from IRQ context!\n", irq);
>   
> @@ -1702,6 +1714,8 @@ static struct irqaction *__free_irq(stru
>   		irq_settings_clr_disable_unlazy(desc);
>   		/* Only shutdown. Deactivate after synchronize_irq() */
>   		irq_shutdown(desc);
> +		if (irq_desc_get_chip(desc)->irq_sync)
> +			sync = true;
>   	}
>   
>   #ifdef CONFIG_SMP
> @@ -1729,6 +1743,9 @@ static struct irqaction *__free_irq(stru
>   
>   	unregister_handler_proc(irq, action);
>   
> +	if (sync)
> +		sync_on_free(desc);
> +
>   	/* Make sure it's not being used on another CPU: */
>   	synchronize_hardirq(irq);
>   

Actually, I tried to print IO-APIC's IRR at the end of mask_ioapic_irq() 
on Friday, and it always showed 0. I did that again. Here's the patch, 
and debug output:

    diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
    index 53aa234a68..b0f655c61f 100644
    --- a/arch/x86/kernel/apic/io_apic.c
    +++ b/arch/x86/kernel/apic/io_apic.c
    @@ -472,6 +472,17 @@ static void mask_ioapic_irq(struct irq_data *irq_data)

             raw_spin_lock_irqsave(&ioapic_lock, flags);
             io_apic_modify_irq(data, ~0, IO_APIC_REDIR_MASKED, &io_apic_sync);
    +
    +       {
    +               struct irq_pin_list *entry;
    +
    +               for_each_irq_pin(entry, data->irq_2_pin) {
    +                       struct IO_APIC_route_entry re;
    +                       re = __ioapic_read_entry(entry->apic, entry->pin);
    +                       printk("%d -> %x\n", entry->pin, re.irr);
    +               }
    +       }
    +
             raw_spin_unlock_irqrestore(&ioapic_lock, flags);
      }


    # dmesg -c >/dev/null; taskset 1 cat /dev/ttyS1 & >/dev/null ;
    PID=$!; usleep 100000; kill $PID; dmesg -c
    <4>3 -> 0
    <0>do_IRQ: 1.44 No irq handler for vector
    [1]+  Terminated                 taskset 1 cat /dev/ttyS1


So I assume, only the local APIC has info about the pending IRQ. But as 
free_irq() is running on CPU#0 and the IRQ is pending on CPU#1, CPU#0 
cannot read CPU#1's local APIC, right? Or maybe I'm missing something?

Robert
