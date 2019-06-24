Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95FFC50B28
	for <lists+linux-serial@lfdr.de>; Mon, 24 Jun 2019 14:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbfFXMyQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-serial@lfdr.de>); Mon, 24 Jun 2019 08:54:16 -0400
Received: from mail1.bemta24.messagelabs.com ([67.219.250.215]:59825 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726740AbfFXMyP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 24 Jun 2019 08:54:15 -0400
Received: from [67.219.250.197] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.us-west-2.aws.symcld.net id 33/BA-11015-4F7C01D5; Mon, 24 Jun 2019 12:54:12 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDKsWRWlGSWpSXmKPExsXi5LtOQPfLcYF
  Yg+ZT/BbNi9ezWTw84GxxZnEvu8Wf/Q+ZLDZvmspscX79bhaLHxseszqwe2xa1cnm8e7cOXaP
  /XPXsHs8m36YyePzJrkA1ijWzLyk/IoE1oyrXy+yFCxUqujZfYGtgfG5dBcjF4eQwGpGiR+Pr
  zBBOHsZJW6e+sTWxcjJwSZgKLF6wRF2EFtEIFDibPMBdpAiZoHHjBIrGpaBJYQFDCS2nf0HZH
  MAFRlKrPzJBWGGSex6Vg9SwSKgKjFz51awCl4Ba4ltl1whVs1nljjUvoMJpIZTIFZiybZvjCA
  2o4CsxIv2CWBxZgFxiVtP5oPZEgICEkv2nGeGsEUlXj7+xwoyU1QgXOL6lUIQU0JAXmL/Cm2I
  Tj2JZ6dmsUDY5hLXP65mh7C1JZYtfA02hVdAUOLkzCdgNUICKhLbpnSzTWAUn4Vk8Swko2YhG
  TULyahZSEYtYGRdxWieVJSZnlGSm5iZo2toYKBraGika2hsomthpJdYpZukV1qsW55aXKIL5J
  YX6xVX5ibnpOjlpZZsYgRGfEpBW9AOxvdHXusdYpTkYFIS5XXawBcrxJeUn1KZkVicEV9UmpN
  afIhRhoNDSYL3/TGBWCHBotT01Iq0zBxg8oFJS3DwKInw8gETkBBvcUFibnFmOkTqFKMux4SX
  cxcxC7Hk5eelSonzyoIUCYAUZZTmwY2AJcJLjLJSwryMDAwMQjwFqUW5mSWo8q8YxTkYlYR51
  UGm8GTmlcBtegV0BBPQEZsn8IEcUZKIkJJqYDrB783OWtsfsZLr6Yqpzu+DJ8+6wsTW3bWk6O
  KiFEZBp//Htn0szuA+bmN1JX4jq7v2qcqFvnXXzpbLvORzaVTYrcGwXtdP1S3J8dumVTuenap
  cW6zU9HNF3qtzl/OvXPHmu/D2dm6K6L5WGcftPRxFU7JUjHw/Rew/UsrQ9/DIIzuTp3X1pf1G
  t95q25adV1NUPrHa7sn0BUZGC0u/WMi+nsOx+veMKrcbfcuiOo04NyzZNI0nqka9LvxLo07b4
  tyiZ/NkFm6ekpxQXvuwY9YKsbqFoi7z2XVP6z86/PRaRKdlXOXkRZvaZx51MClL4sph9N3+2i
  X96P5/vO3TXM58ZxP+XP47bGJ3wRkjSSWW4oxEQy3mouJEAG5GbfX/AwAA
X-Env-Sender: Robert.Hodaszi@digi.com
X-Msg-Ref: server-8.tower-345.messagelabs.com!1561380850!234594!3
X-Originating-IP: [66.77.174.16]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.43.9; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 1647 invoked from network); 24 Jun 2019 12:54:12 -0000
Received: from owa.digi.com (HELO MCL-VMS-XCH01.digi.com) (66.77.174.16)
  by server-8.tower-345.messagelabs.com with SMTP; 24 Jun 2019 12:54:12 -0000
Received: from MTK-SMS-XCH04.digi.com (10.10.8.198) by MCL-VMS-XCH01.digi.com
 (10.5.8.49) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 24 Jun 2019
 07:54:10 -0500
Received: from MTK-SMS-XCH02.digi.com ([fe80::4960:cfbf:ad5e:3cdb]) by
 MTK-SMS-XCH04.digi.com ([fe80::ed97:4834:fa1b:3be7%19]) with mapi id
 14.03.0439.000; Mon, 24 Jun 2019 07:54:10 -0500
From:   "Hodaszi, Robert" <Robert.Hodaszi@digi.com>
To:     Michael Shych <michaelsh@mellanox.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     "x86@kernel.org" <x86@kernel.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: "No irq handler for vector" problem
Thread-Topic: "No irq handler for vector" problem
Thread-Index: AQHVKDldOPMq6dwWv0y/P7fHdq3NuKamqPoA//+5LYeAAzhHgIAASXUAgAEJGYCAAC41AA==
Date:   Mon, 24 Jun 2019 12:54:09 +0000
Message-ID: <d40acbee-df87-1f4b-48c1-66fe31c841fd@digi.com>
References: <dcc1febb-2afc-da9b-696e-3c9bf63f4b76@digi.com>
 <alpine.DEB.2.21.1906211858340.5503@nanos.tec.linutronix.de>
 <37433D8393E7AF43B0D856B93884DA9E4FD67B64@MTK-SMS-XCH02.digi.com>
 <AM6PR05MB61689A1EE1E6B31682A476FAD9E10@AM6PR05MB6168.eurprd05.prod.outlook.com>
 <alpine.DEB.2.21.1906231955420.32342@nanos.tec.linutronix.de>
 <AM6PR05MB6168265CCF44FBCAEBBD4EA8D9E00@AM6PR05MB6168.eurprd05.prod.outlook.com>
In-Reply-To: <AM6PR05MB6168265CCF44FBCAEBBD4EA8D9E00@AM6PR05MB6168.eurprd05.prod.outlook.com>
Accept-Language: en-US, hu-HU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
x-originating-ip: [188.6.70.45]
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <E435F7E6BF2CCF4491531D940F3E4C4E@digi.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


>> Stared some more into the interrupt code. I think Robert was on the right
>> track, but I did not see the tree in the forest.
>>
>> The scenario he described can actually happen and yes, we should deactivate
>> the interrupt after the synchronize_hardirq() and not before. Tentative fix
>> below.
>>
>> Thanks,
>>
>> 	tglx
>>
>> 8<-------------
>> --- a/kernel/irq/autoprobe.c
>> +++ b/kernel/irq/autoprobe.c
>> @@ -90,7 +90,7 @@ unsigned long probe_irq_on(void)
>>   			/* It triggered already - consider it spurious. */
>>   			if (!(desc->istate & IRQS_WAITING)) {
>>   				desc->istate &= ~IRQS_AUTODETECT;
>> -				irq_shutdown(desc);
>> +				irq_shutdown_and_deactivate(desc);
>>   			} else
>>   				if (i < 32)
>>   					mask |= 1 << i;
>> @@ -127,7 +127,7 @@ unsigned int probe_irq_mask(unsigned lon
>>   				mask |= 1 << i;
>>
>>   			desc->istate &= ~IRQS_AUTODETECT;
>> -			irq_shutdown(desc);
>> +			irq_shutdown_and_deactivate(desc);
>>   		}
>>   		raw_spin_unlock_irq(&desc->lock);
>>   	}
>> @@ -169,7 +169,7 @@ int probe_irq_off(unsigned long val)
>>   				nr_of_irqs++;
>>   			}
>>   			desc->istate &= ~IRQS_AUTODETECT;
>> -			irq_shutdown(desc);
>> +			irq_shutdown_and_deactivate(desc);
>>   		}
>>   		raw_spin_unlock_irq(&desc->lock);
>>   	}
>> --- a/kernel/irq/chip.c
>> +++ b/kernel/irq/chip.c
>> @@ -314,6 +314,12 @@ void irq_shutdown(struct irq_desc *desc)
>>   		}
>>   		irq_state_clr_started(desc);
>>   	}
>> +}
>> +
>> +
>> +void irq_shutdown_and_deactivate(struct irq_desc *desc)
>> +{
>> +	irq_shutdown(desc);
>>   	/*
>>   	 * This must be called even if the interrupt was never started up,
>>   	 * because the activation can happen before the interrupt is
>> --- a/kernel/irq/cpuhotplug.c
>> +++ b/kernel/irq/cpuhotplug.c
>> @@ -116,7 +116,7 @@ static bool migrate_one_irq(struct irq_d
>>   		 */
>>   		if (irqd_affinity_is_managed(d)) {
>>   			irqd_set_managed_shutdown(d);
>> -			irq_shutdown(desc);
>> +			irq_shutdown_and_deactivate(desc);
>>   			return false;
>>   		}
>>   		affinity = cpu_online_mask;
>> --- a/kernel/irq/internals.h
>> +++ b/kernel/irq/internals.h
>> @@ -82,6 +82,7 @@ extern int irq_activate_and_startup(stru
>>   extern int irq_startup(struct irq_desc *desc, bool resend, bool force);
>>
>>   extern void irq_shutdown(struct irq_desc *desc);
>> +extern void irq_shutdown_and_deactivate(struct irq_desc *desc);
>>   extern void irq_enable(struct irq_desc *desc);
>>   extern void irq_disable(struct irq_desc *desc);
>>   extern void irq_percpu_enable(struct irq_desc *desc, unsigned int cpu);
>> --- a/kernel/irq/manage.c
>> +++ b/kernel/irq/manage.c
>> @@ -13,6 +13,7 @@
>>   #include <linux/module.h>
>>   #include <linux/random.h>
>>   #include <linux/interrupt.h>
>> +#include <linux/irqdomain.h>
>>   #include <linux/slab.h>
>>   #include <linux/sched.h>
>>   #include <linux/sched/rt.h>
>> @@ -1699,6 +1700,7 @@ static struct irqaction *__free_irq(stru
>>   	/* If this was the last handler, shut down the IRQ line: */
>>   	if (!desc->action) {
>>   		irq_settings_clr_disable_unlazy(desc);
>> +		/* Only shutdown. Deactivate after synchronize_irq() */
>>   		irq_shutdown(desc);
>>   	}
>>
>> @@ -1768,6 +1770,14 @@ static struct irqaction *__free_irq(stru
>>   		 * require it to deallocate resources over the slow bus.
>>   		 */
>>   		chip_bus_lock(desc);
>> +		/*
>> +		 * There is no interrupt on the fly anymore. Deactivate it
>> +		 * completely.
>> +		 */
>> +		raw_spin_lock_irqsave(&desc->lock, flags);
>> +		irq_domain_deactivate_irq(&desc->irq_data);
>> +		raw_spin_unlock_irqrestore(&desc->lock, flags);
>> +
>>   		irq_release_resources(desc);
>>   		chip_bus_sync_unlock(desc);
>>   		irq_remove_timings(desc);
>> @@ -1855,7 +1865,7 @@ static const void *__cleanup_nmi(unsigne
>>   	}
>>
>>   	irq_settings_clr_disable_unlazy(desc);
>> -	irq_shutdown(desc);
>> +	irq_shutdown_and_deactivate(desc);
>>
>>   	irq_release_resources(desc);
>>
>>
>>
>>
> Hi,
>
> It significantly decreased appearance of the problem log (at least in my tests),
> But unfortunately, the problem still exists.
>
> Regards,
>      Michael.

I tried it as well, and unfortunately, the error messages are still 
there. I'm seeing, what you're doing, and theoretically it should fix 
the problem, but something is still wrong. Let me try to check on my 
board, what is happening.

Robert
