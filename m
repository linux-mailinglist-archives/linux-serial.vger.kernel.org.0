Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0CC151AFB
	for <lists+linux-serial@lfdr.de>; Mon, 24 Jun 2019 20:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfFXSw4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-serial@lfdr.de>); Mon, 24 Jun 2019 14:52:56 -0400
Received: from mail1.bemta23.messagelabs.com ([67.219.246.117]:35529 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726375AbfFXSwz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 24 Jun 2019 14:52:55 -0400
Received: from [67.219.246.197] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-6.bemta.az-c.us-east-1.aws.symcld.net id EB/B2-10051-50C111D5; Mon, 24 Jun 2019 18:52:53 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKKsWRWlGSWpSXmKPExsXi5LtOQJdFRjD
  WYPo/fYvmxevZLB4ecLY4s7iX3eLP/odMFps3TWW2OL9+N4vFjw2PWR3YPTat6mTzeHfuHLvH
  /rlr2D2eTT/M5PF5k1wAaxRrZl5SfkUCa8aZmaeYCjrkKi7/aWdpYNwv2cXIxSEksJdRYkv3T
  ZYuRk4ONgFDidULjrCD2CICGhIbL91iBiliFuhmkljRtBksISxgILHt7D8gmwOoyFBi5U8uiP
  okiaa2HkYQm0VAVeLC/JPMIDavgLXE0t3T2CCW9bNIfL/7CizBKeAlsfvdNVYQm1FAVuJF+wQ
  mEJtZQFzi1pP5YLaEgIDEkj3nmSFsUYmXj/+xguwVFQiXuH6lECKsIPFp9x8WiFY9iWenZkHZ
  5hLfLu5ihLC1JZYtfA11j6DEyZlPWCYwis5Csm0WkvZZSNpnIWmfhaR9ASPrKkazpKLM9IyS3
  MTMHF1DAwNdQ0MjXTNdQ3NLvcQq3WS90mLd1MTiEl1DvcTyYr3iytzknBS9vNSSTYzAGE4pYN
  u8g/H2kdd6hxglOZiURHl/igvGCvEl5adUZiQWZ8QXleakFh9ilOHgUJLgnSANlBMsSk1PrUj
  LzAGmE5i0BAePkgjvUSmgNG9xQWJucWY6ROoUoy7HhJdzFzELseTl56VKifPagcwQACnKKM2D
  GwFLbZcYZaWEeRkZGBiEeApSi3IzS1DlXzGKczAqCfP+BFnFk5lXArfpFdARTEBHbJ7AB3JES
  SJCSqqBqcys7MBDlUX8YoVzMzfrF6ffsC9OldGRfKKzdAuv5t2mILXXdzhNpxzbdU/3iG37aq
  WQRYYrJl5p498ouLxnn0NP3GSlxL3hQk/Ccuc7HLuV7XXpT8LO3d95FjmtXD3n3S2X/A9Hj22
  ueuBkrs/af3NJ0aX7uondGbI3CzfYpdZf+R2+PfismB3HpluHV9wL5XLs31MdWdA0jSm/dHKY
  S1DTr8eqs3WKrv29v/mjcgS78Yon89P/B3l0hj/mXBLfxRZtLD6/WFb5wawl+4XnZN/NPLlx4
  9/nOXM3PGvOFVvGf3p1QpQOrzTzNBOOOFs3kRTO3NN7fT5kHvFe9Kx9jon9lhOLfi7eW7rJua
  enUYmlOCPRUIu5qDgRACt1xIjoAwAA
X-Env-Sender: Robert.Hodaszi@digi.com
X-Msg-Ref: server-15.tower-405.messagelabs.com!1561402372!146618!1
X-Originating-IP: [66.77.174.16]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 27918 invoked from network); 24 Jun 2019 18:52:52 -0000
Received: from owa.digi.com (HELO MCL-VMS-XCH01.digi.com) (66.77.174.16)
  by server-15.tower-405.messagelabs.com with SMTP; 24 Jun 2019 18:52:52 -0000
Received: from MTK-SMS-XCH02.digi.com ([fe80::4960:cfbf:ad5e:3cdb]) by
 MCL-VMS-XCH01.digi.com ([fe80::5587:821d:f8e4:6578%13]) with mapi id
 14.03.0439.000; Mon, 24 Jun 2019 13:52:51 -0500
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
Thread-Index: AQHVKDldOPMq6dwWv0y/P7fHdq3NuKamqPoA//+5LYeAAzhHgIAASXUAgAEJGYCAAC41AIAAFYCAgABOuAA=
Date:   Mon, 24 Jun 2019 18:52:51 +0000
Message-ID: <c49e9454-d6d2-408c-8232-ee4c17d6975d@digi.com>
References: <dcc1febb-2afc-da9b-696e-3c9bf63f4b76@digi.com>
 <alpine.DEB.2.21.1906211858340.5503@nanos.tec.linutronix.de>
 <37433D8393E7AF43B0D856B93884DA9E4FD67B64@MTK-SMS-XCH02.digi.com>
 <AM6PR05MB61689A1EE1E6B31682A476FAD9E10@AM6PR05MB6168.eurprd05.prod.outlook.com>
 <alpine.DEB.2.21.1906231955420.32342@nanos.tec.linutronix.de>
 <AM6PR05MB6168265CCF44FBCAEBBD4EA8D9E00@AM6PR05MB6168.eurprd05.prod.outlook.com>
 <d40acbee-df87-1f4b-48c1-66fe31c841fd@digi.com>
 <alpine.DEB.2.21.1906241609080.32342@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1906241609080.32342@nanos.tec.linutronix.de>
Accept-Language: en-US, hu-HU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
x-originating-ip: [172.27.2.174]
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <5239E20E98ADC6449D3D0EDD81CC5073@digi.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, 24 Jun 2019, Gleixner, Thomas wrote:
>
> The best way to figure out how the timing is of all those moving parts is
> to enable trace points and selective function tracing. That should give us
> a good picture.
>
> Thanks,
>
> 	tglx
>
>
Here are 2 logs, using ftrace with filter for do_IRQ(), 
synchronize_irq(), some IRQ deactivation functions, and 
irq_handler_entry event. The IRQ is assigned to the core#1, and the test 
script (opening and closing the serial port) is running on core#0.

First time, I did not see the error message:

    CPU 2 is empty
    CPU 3 is empty
    cpus=4
                   sh-2843  [001]   177.742582: function: do_IRQ <--
    ret_from_intr
                   sh-2843  [001]   177.742591: irq_handler_entry: irq=3
    name=ttyS1
                  cat-2837  [000]   177.742598: function:
    synchronize_hardirq <-- __free_irq
                  cat-2837  [000]   177.742601: function:
    x86_vector_deactivate <-- __irq_domain_deactivate_irq
                  cat-2837  [000]   177.742602: function:
    clear_irq_vector <-- x86_vector_deactivate
                  cat-2837  [000]   177.749014: function:
    reserve_irq_vector_locked <-- x86_vector_deactivate

As you see, do_IRQ() hit before synchronize_hardirq, and clear_irq_vector.


The second time, I got the error message:

    CPU 2 is empty
    CPU 3 is empty
    cpus=4
                  cat-5240  [000]  1678.875391: function:
    synchronize_hardirq <-- __free_irq
                  cat-5240  [000]  1678.875395: function:
    x86_vector_deactivate <-- __irq_domain_deactivate_irq
                  cat-5240  [000]  1678.875396: function:
    clear_irq_vector <-- x86_vector_deactivate
               <idle>-0     [001]  1678.875521: function: *do_IRQ <--
    ret_from_intr*
                  cat-5240  [000]  1678.885972: function:
    reserve_irq_vector_locked <-- x86_vector_deactivate
                  cat-5240  [000]  1678.885986: function: do_IRQ <--
    ret_from_intr
                  cat-5240  [000]  1678.885989: irq_handler_entry: irq=5
    name=ttyS3
               <idle>-0     [000]  1678.894122: function:            
    do_IRQ <-- ret_from_intr
               <idle>-0     [000]  1678.894125: irq_handler_entry:   
    irq=5 name=ttyS3
               <idle>-0     [000]  1678.902480: function:            
    do_IRQ <-- ret_from_intr
               <idle>-0     [000]  1678.902483: irq_handler_entry:   
    irq=5 name=ttyS3
               <idle>-0     [000]  1678.910752: function:            
    do_IRQ <-- ret_from_intr
               <idle>-0     [000]  1678.910755: irq_handler_entry:   
    irq=5 name=ttyS3

Note, that you can see additional do_IRQ() calls, but after those, you 
can see irq_handler_entry events as well, with the corresponding IRQ line.


It seems, either the core#1 is busy with something else (other, higher 
priority IRQ), and the UART interrupt is pending in the local APIC. Or 
the masking in the IO-APIC is not working (is that possible?).

Here's a complete ftrace log (nothing filtered out):

    https://drive.google.com/open?id=1fTvfjPELE-xjc1xRVcwW04-U5QZCXGI1


Robert


