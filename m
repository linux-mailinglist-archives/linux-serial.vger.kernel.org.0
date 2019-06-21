Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B84264EE1A
	for <lists+linux-serial@lfdr.de>; Fri, 21 Jun 2019 19:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbfFURqw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-serial@lfdr.de>); Fri, 21 Jun 2019 13:46:52 -0400
Received: from mail1.bemta23.messagelabs.com ([67.219.246.113]:61748 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726052AbfFURqw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 21 Jun 2019 13:46:52 -0400
Received: from [67.219.247.53] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-7.bemta.az-d.us-east-1.aws.symcld.net id 6A/84-10605-A081D0D5; Fri, 21 Jun 2019 17:46:50 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJKsWRWlGSWpSXmKPExsXi5LtOQJdTgjf
  W4Mx5E4vmxevZLB4ecLY4s7iX3eLP/odMFps3TWW2OL9+N4vFjw2PWR3YPTat6mTzeHfuHLvH
  /rlr2D2eTT/M5PF5k1wAaxRrZl5SfkUCa0bf9MnsBVd4Ks6f+sbawPiSq4uRi0NIYDWjRMeG/
  2wQzl5Gieff57N3MXJysAkYSqxecATMFhHQkNh46RYzSBGzQDeTxIqmzWAJYQEDidmXlgIlOI
  CKDCVW/uSCqLeSOHb/HxuIzSKgKrH/809WEJtXwFfi4/OlbCDlQgKVEju6+EDCnAKeEoe+/Aa
  byCggK/GifQITiM0sIC5x68l8MFtCQEBiyZ7zzBC2qMTLx/9YIWxlic4V7WwQ9ToSC3Z/grK1
  JZYtfM0MsVZQ4uTMJywgtpCAisS2Kd1sExhFZyFZMQtJ+ywk7bOQtC9gZFnFaJZUlJmeUZKbm
  Jmja2hgoGtoaKRrqWtoZqaXWKWboldarJuaWFyia6iXWF6sV1yZm5yTopeXWrKJERirKQWcy3
  Yw3j3yWu8QoyQHk5Ior995nlghvqT8lMqMxOKM+KLSnNTiQ4wyHBxKErw9YryxQoJFqempFWm
  ZOcC0AZOW4OBREuF1EgdK8xYXJOYWZ6ZDpE4x6nJMeDl3EbMQS15+XqqUOG8ByAwBkKKM0jy4
  EbAUdolRVkqYl5GBgUGIpyC1KDezBFX+FaM4B6OSMK8LyBSezLwSuE2vgI5gAjpiwWwukCNKE
  hFSUg1MSh4P78w+5p+rcFl4xja5oA+zc1an3st2146fsvn0slOnDvY5r1rVfen7ZCZ/3sYLCs
  ayKaEv5oZFZNlXdIk1PJKKeLiD03dGXxFb9MLH59aqpa35JVmXe/lcXNDqtorDD813pTXtrd7
  wZUm93VbrbzGhK97VVmVdZUpiCd43W3bBHyGzhEfnA3/5WpqE3j60P25aesjyrW5/9VXOm2/a
  mmG3+1/JiaUJa81+LBbIOKCh61XFGRp5SePNI8PV+p8+/rZmc47gV3/LcWiricvPneuT9v/M/
  +SxUXI7t9AzqTy75/IPhEKe9QSUnDbmEBV0afffcvoxnyRb7pGFy/iayv7uXvc0RepfruWShJ
  2MSizFGYmGWsxFxYkAlrq7i9wDAAA=
X-Env-Sender: Robert.Hodaszi@digi.com
X-Msg-Ref: server-8.tower-425.messagelabs.com!1561139209!172183!1
X-Originating-IP: [66.77.174.16]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.43.9; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 3847 invoked from network); 21 Jun 2019 17:46:49 -0000
Received: from owa.digi.com (HELO MCL-VMS-XCH01.digi.com) (66.77.174.16)
  by server-8.tower-425.messagelabs.com with SMTP; 21 Jun 2019 17:46:49 -0000
Received: from MTK-SMS-XCH01.digi.com (10.10.8.195) by MCL-VMS-XCH01.digi.com
 (10.5.8.49) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 21 Jun 2019
 12:46:49 -0500
Received: from MTK-SMS-XCH02.digi.com ([fe80::4960:cfbf:ad5e:3cdb]) by
 MTK-SMS-XCH01.digi.com ([fe80::cca7:5299:c88e:1c40%20]) with mapi id
 14.03.0439.000; Fri, 21 Jun 2019 12:46:49 -0500
From:   "Hodaszi, Robert" <Robert.Hodaszi@digi.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Michael Shych <michaelsh@mellanox.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: RE: "No irq handler for vector" problem
Thread-Topic: "No irq handler for vector" problem
Thread-Index: AQHVKDldOPMq6dwWv0y/P7fHdq3NuKamqPoA//+5LYc=
Date:   Fri, 21 Jun 2019 17:46:49 +0000
Message-ID: <37433D8393E7AF43B0D856B93884DA9E4FD67B64@MTK-SMS-XCH02.digi.com>
References: <dcc1febb-2afc-da9b-696e-3c9bf63f4b76@digi.com>
 <alpine.DEB.2.21.1906211858340.5503@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1906211858340.5503@nanos.tec.linutronix.de>
Accept-Language: en-US, hu-HU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [145.236.103.220]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


On June 21, 2019 19:00:25 Thomas Gleixner <tglx@linutronix.de> wrote:

> On Fri, 21 Jun 2019, Hodaszi, Robert wrote:
>>
>>
>> Also, it seems, if I'm running the serial port opening-closing process
>> on the same core as the interrupt is assigned to, I'm not getting the
>> error message. If I'm running it on a different core, most of the time,
>> I'm getting the error message.
>
> ...
>
>> Unfortunately, I'm stuck at this point a bit. Don't really know, what
>> would be the proper solution (how could I avoid free'ing up a pending
>> IRQ's vector), also I'm not knowing the x86 part of the kernel very well
>> yet.
>
> Not freeing the vector would just paper over the problem. Can you try the
> patch below?
>
> Thanks,
>
> tglx
>
> 8<------------------
> diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
> index 53aa234a6803..189db40b0524 100644
> --- a/arch/x86/kernel/apic/io_apic.c
> +++ b/arch/x86/kernel/apic/io_apic.c
> @@ -3003,8 +3003,8 @@ void mp_irqdomain_deactivate(struct irq_domain *domain,
>      struct irq_data *irq_data)
> {
>  /* It won't be called for IRQ with multiple IOAPIC pins associated */
> - ioapic_mask_entry(mp_irqdomain_ioapic_idx(domain),
> -  (int)irq_data->hwirq);
> + clear_IO_APIC_pin(mp_irqdomain_ioapic_idx(domain),
> +  (unsigned int)irq_data->hwirq);
> }
>
> int mp_irqdomain_ioapic_idx(struct irq_domain *domain)

I can try it on Monday. Thanks!

Robert
