Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3947A52927
	for <lists+linux-serial@lfdr.de>; Tue, 25 Jun 2019 12:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbfFYKM5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-serial@lfdr.de>); Tue, 25 Jun 2019 06:12:57 -0400
Received: from mail1.bemta23.messagelabs.com ([67.219.246.115]:35556 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727763AbfFYKM5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 25 Jun 2019 06:12:57 -0400
Received: from [67.219.246.197] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-c.us-east-1.aws.symcld.net id 5A/3C-10850-7A3F11D5; Tue, 25 Jun 2019 10:12:55 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDKsWRWlGSWpSXmKPExsXi5LtOQHfZZ8F
  Yg+O9lhbNi9ezWTw84GxxZnEvu8Wf/Q+ZLDZvmspscX79bhaLHxseszqwe2xa1cnm8e7cOXaP
  /XPXsHs8m36YyePzJrkA1ijWzLyk/IoE1owPG48yF2wUq/jweCNjA2OrQBcjJ4eQwGpGic3vq
  7sYuYDsvYwSSx70s4Ak2AQMJVYvOMIOYosIaEhsvHSLGaSIWaCbSWJF02awhLCAgcS2s/+AbA
  6gIkOJlT+5IOrLJGYe2M4KYrMIqEr8PvwXbCavgLXEoy3nmCGWbWCVeHh7AdgcTgEbiSULboI
  VMQrISrxon8AEYjMLiEvcejIfzJYQEJBYsuc8M4QtKvHy8T9WkL2iAuES168UQoQVJD7t/sMC
  0aon8ezULCjbXGLP1ClsELa2xLKFr5kh7hGUODnzCQskIFQktk3pZpvAKD4LyeZZSEbNQjJqF
  pJRs5CMWsDIuorRNKkoMz2jJDcxM0fX0MBA19DQSNdE18RQL7FKN1mvtFg3NbG4RBfILS/WK6
  7MTc5J0ctLLdnECIz4lAIWzR2MOw+81jvEKMnBpCTKa9QhGCvEl5SfUpmRWJwRX1Sak1p8iFG
  Gg0NJgjfkI1BOsCg1PbUiLTMHmHxg0hIcPEoivJUgad7igsTc4sx0iNQpRl2OCS/nLmIWYsnL
  z0uVEue9DFIkAFKUUZoHNwKWCC8xykoJ8zIyMDAI8RSkFuVmlqDKv2IU52BUEuY1fQ80hSczr
  wRu0yugI5iAjtg8gQ/kiJJEhJRUA5Nj3322/TmP5cR4b3VsTAvW0wh5du+hn9acLXyW0YmxO9
  c7MbEkrjr77dUHnSVf6xg7LpnaKGzbLXTw5ISlS9ck8C951Trz6YHsBP8/26883Mdi5H025da
  HBf+0fNv+V+18qOC969iqY3P8Sv0zqyJ1radu/mWiaZFxQrJKov3O2mz9O3NYfhWGKzzfdpn3
  gt8DjTerjiSzbD2jWdV9+m3+qSeJPyL+mMyZe+DWJgahKt/7KXr3nY6nbz510qmai/lZwLbYv
  w++H+LQtPiUsePxd+XH6yf+mvmOJ1JA6tPCosSEjn9vrt5atlY76cluFxfBkOcH/s30ObhVXe
  l+7+eJgeeelLBnbZc0zn0fcd9PWomlOCPRUIu5qDgRAC4qhGX/AwAA
X-Env-Sender: Robert.Hodaszi@digi.com
X-Msg-Ref: server-17.tower-405.messagelabs.com!1561457574!216514!1
X-Originating-IP: [66.77.174.16]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 9844 invoked from network); 25 Jun 2019 10:12:54 -0000
Received: from owa.digi.com (HELO MCL-VMS-XCH01.digi.com) (66.77.174.16)
  by server-17.tower-405.messagelabs.com with SMTP; 25 Jun 2019 10:12:54 -0000
Received: from MTK-SMS-XCH01.digi.com (10.10.8.195) by MCL-VMS-XCH01.digi.com
 (10.5.8.49) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 25 Jun 2019
 05:12:54 -0500
Received: from MTK-SMS-XCH02.digi.com ([fe80::4960:cfbf:ad5e:3cdb]) by
 MTK-SMS-XCH01.digi.com ([fe80::cca7:5299:c88e:1c40%20]) with mapi id
 14.03.0439.000; Tue, 25 Jun 2019 05:12:54 -0500
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
Thread-Index: AQHVKDldOPMq6dwWv0y/P7fHdq3NuKamqPoA//+5LYeAAzhHgIAASXUAgAEJGYCAAC41AIAAFYCAgABOuACAAEL3AIAAt3SAgAAGooA=
Date:   Tue, 25 Jun 2019 10:12:52 +0000
Message-ID: <d75e0442-ac90-b721-1bd6-609a6a4ae3d8@digi.com>
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
 <a1582e82-c2b3-95fd-0c92-e04765da0a59@digi.com>
In-Reply-To: <a1582e82-c2b3-95fd-0c92-e04765da0a59@digi.com>
Accept-Language: en-US, hu-HU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
x-originating-ip: [172.27.2.174]
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <F0448CF4848B8E43B19001A9235F67BE@digi.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, 25 Jun 2019, Hodaszi, Robert wrote:
Actually, I tried to print IO-APIC's IRR at the end of mask_ioapic_irq() on Friday, and it always showed 0. I did that again. Here's the patch, and debug output:

   diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
   index 53aa234a68..b0f655c61f 100644
   --- a/arch/x86/kernel/apic/io_apic.c
   +++ b/arch/x86/kernel/apic/io_apic.c
   @@ -472,6 +472,17 @@ static void mask_ioapic_irq(struct irq_data *irq_data)

            raw_spin_lock_irqsave(&ioapic_lock, flags);
            io_apic_modify_irq(data, ~0, IO_APIC_REDIR_MASKED, &io_apic_sync);
   +
   +       {
   +               struct irq_pin_list *entry;
   +
   +               for_each_irq_pin(entry, data->irq_2_pin) {
   +                       struct IO_APIC_route_entry re;
   +                       re = __ioapic_read_entry(entry->apic, entry->pin);
   +                       printk("%d -> %x\n", entry->pin, re.irr);
   +               }
   +       }
   +
            raw_spin_unlock_irqrestore(&ioapic_lock, flags);
     }


   # dmesg -c >/dev/null; taskset 1 cat /dev/ttyS1 & >/dev/null ;
   PID=$!; usleep 100000; kill $PID; dmesg -c
   <4>3 -> 0
   <0>do_IRQ: 1.44 No irq handler for vector
   [1]+  Terminated                 taskset 1 cat /dev/ttyS1


So I assume, only the local APIC has info about the pending IRQ. But as free_irq() is running on CPU#0 and the IRQ is pending on CPU#1, CPU#0 cannot read CPU#1's local APIC, right? Or maybe I'm missing something?

Robert

I just tried your patch, and same issue. It correlates to my previous findings:

# /opt/test3.sh ; trace-cmd report
  plugin 'function'
do_IRQ: 1.44 No irq handler for vector
CPU0 data recorded at offset=0x363000
    4096 bytes in size
CPU1 data recorded at offset=0x364000
    4096 bytes in size
CPU2 data recorded at offset=0x365000
    0 bytes in size
CPU3 data recorded at offset=0x365000
    0 bytes in size
CPU 2 is empty
CPU 3 is empty
cpus=4
             cat-3825  [000]   683.390815: function:             mask_ioapic_irq <-- mask_irq.part.33
             cat-3825  [000]   683.390823: function:             ioapic_sync_irq <-- __free_irq
             cat-3825  [000]   683.390824: function:             __ioapic_read_entry <-- ioapic_sync_irq
             cat-3825  [000]   683.390826: function:             synchronize_hardirq <-- __free_irq
             cat-3825  [000]   683.390829: function:             x86_vector_deactivate <-- __irq_domain_deactivate_irq
             cat-3825  [000]   683.390829: function:             clear_irq_vector <-- x86_vector_deactivate
             cat-3825  [000]   683.390830: function:             reserve_irq_vector_locked <-- x86_vector_deactivate
          <idle>-0     [001]   683.390895: function:             do_IRQ <-- ret_from_intr
Robert

