Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5C074EA07
	for <lists+linux-serial@lfdr.de>; Fri, 21 Jun 2019 15:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbfFUN6R convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-serial@lfdr.de>); Fri, 21 Jun 2019 09:58:17 -0400
Received: from mail1.bemta23.messagelabs.com ([67.219.246.210]:33972 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725985AbfFUN6R (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 21 Jun 2019 09:58:17 -0400
Received: from [67.219.247.53] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-d.us-east-1.aws.symcld.net id 31/57-07834-672EC0D5; Fri, 21 Jun 2019 13:58:14 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCKsWRWlGSWpSXmKPExsXi5LtOQLfsEU+
  sQed6EYvmxevZLB4ecLY4s7iX3eLP/odMFps3TWW2OL9+N4vFjw2PWR3YPTat6mTzeHfuHLvH
  /rlr2D2eTT/M5PF5k1wAaxRrZl5SfkUCa8bhZdEFX9Ur7t6bz9zA2K/QxcjFISSwmlHi3/9jL
  BDOXkaJj7cesHUxcnKwCRhKrF5whB3EFhHQkNh46RYzSBGzQDeTxIqmzWAJYQEDidmXlgIlOI
  CKDCVW/uSCMPUkFm6OAqlgEVCVmL25gRXE5hWwlli86wgLiM0oICvxon0CE4jNLCAucevJfDB
  bQkBAYsme88wQtqjEy8f/WEFGigqES1y/UggRVpC4cmUnC0SrnsSzU7OgbHOJ45MXsUPY2hLL
  Fr5mhlgrKHFy5hOwGiEBFYltU7rZJjCKzkKyeRaSUbOQjJqFZNQsJKMWMLKuYjRPKspMzyjJT
  czM0TU0MNA1NDQC0rpGxqZ6iVW6KXqlxbqpicUluoZ6ieXFesWVuck5KXp5qSWbGIERnFLA9X
  oH44QDr/UOMUpyMCmJ8vqd54kV4kvKT6nMSCzOiC8qzUktPsQow8GhJMG78AFQTrAoNT21Ii0
  zB5hMYNISHDxKIryeD4HSvMUFibnFmekQqVOMuhwTXs5dxCzEkpeflyolznsCpEgApCijNA9u
  BCyxXWKUlRLmZWRgYBDiKUgtys0sQZV/xSjOwagkzNsLMoUnM68EbtMroCOYgI5YMJsL5IiSR
  ISUVAPTdLWq6p264pvuBvH0C+k8sF2YztSh2f+dVXuzbuP+AAWGx2FbcgKVk/xaz9/h0nx3nV
  v2qMf76T2uKa4qiydz77u7UWBK+iQzfyvu+dUlr7Y1xzeHs6h1h+VqbV09/eNnbv6P+y5F3Ku
  PuuPBIbTl/5M3ywPvnJ3Pbnqrs8//25tzvaHOuvOc03fV7Tm3l+fKjeZcWeYf53SPrzRszU5m
  fDbTYxUL063HPGm/Ji1YWx/bHsGuseTU68J1n53X2ou6pu2QXVhRPj/ZL29Ns+h+s6MPVJbPv
  rR8RarCtefZ697rzbNkfZR00mODROEnc++bHL1n5AQP5xTEBvzz2MFVdH6P6szV1xs5tUSnLG
  5RYinOSDTUYi4qTgQAuSSROucDAAA=
X-Env-Sender: Robert.Hodaszi@digi.com
X-Msg-Ref: server-34.tower-425.messagelabs.com!1561125494!1984640!1
X-Originating-IP: [66.77.174.16]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.43.9; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 1972 invoked from network); 21 Jun 2019 13:58:14 -0000
Received: from owa.digi.com (HELO MCL-VMS-XCH01.digi.com) (66.77.174.16)
  by server-34.tower-425.messagelabs.com with SMTP; 21 Jun 2019 13:58:14 -0000
Received: from MTK-SMS-XCH04.digi.com (10.10.8.198) by MCL-VMS-XCH01.digi.com
 (10.5.8.49) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 21 Jun 2019
 08:58:13 -0500
Received: from MTK-SMS-XCH02.digi.com ([fe80::4960:cfbf:ad5e:3cdb]) by
 MTK-SMS-XCH04.digi.com ([fe80::ed97:4834:fa1b:3be7%19]) with mapi id
 14.03.0439.000; Fri, 21 Jun 2019 08:58:13 -0500
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
Thread-Index: AQHVKDldOPMq6dwWv0y/P7fHdq3NuA==
Date:   Fri, 21 Jun 2019 13:58:12 +0000
Message-ID: <dcc1febb-2afc-da9b-696e-3c9bf63f4b76@digi.com>
Accept-Language: en-US, hu-HU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
x-originating-ip: [172.27.2.119]
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <C771C9BC3021B844AD13211287E45FBC@digi.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

> Michael,
> 
> On Mon, 10 Dec 2018, Michael Shych wrote:
> > Do you have some news about this issue?
> 
> No. I was waiting for the below.
> 
> > > > This is specific to nolapic=1, with "noapic=1" the ERR interrupt number
> > > > stays at 51. But I guess this is a red herring, too, because who runs
> > > > his box with nolapic=1 in the first place :-)
> > > 
> > > Could you do the same test without nolapic please?
> 
>     ^^^^^^^^^^
> 
> Thanks,
> 
>  tglx

I'm trying to continue this thread, as it seems, this is still an issue. 
I'm getting "No irq handler for vector" message almost on each serial 
port closing. The serial port is on a Nuvoton SuperIO chip, and the CPU 
is an Intel Baytrail E3845.


Here are my observations (misinterpretations are possible, I'm not that 
familiar with the X86):


First of all, the SuperIO seems to send an undesired interrupt, when the 
port's "IRQ enable" flag gets cleared (HCR address: (base + 4), "IRQ 
Enable" bit3). See here:

    # cat /dev/ttyS1 &
    # cat /proc/interrupts | grep ttyS1
        3:          0         19          0          0   IO-APIC
    3-edge      ttyS1
    # cat /sys/class/tty/ttyS1/port
    0x2F8
    # /opt/hr/inb --hex 0x2FC
    b
    # cat /proc/interrupts | grep ttyS1
        3:          0         19          0          0   IO-APIC
    3-edge      ttyS1
    # /opt/hr/outb 0x2FC 0x3 *              <----------- Clearing IRQ
    enable here*
    # cat /proc/interrupts | grep ttyS1
        3:          0 *20*          0          0 IO-APIC    3-edge     
    ttyS1 *<------- IRQ counter increased*
    # /opt/hr/outb 0x2FC 0xb
    # cat /proc/interrupts | grep ttyS1
        3:          0         20          0          0   IO-APIC
    3-edge      ttyS1
    # /opt/hr/outb 0x2FC 0x3 *              <----------- Clearing IRQ
    enable here*
    # cat /proc/interrupts | grep ttyS1
        3:          0 *21*          0          0 IO-APIC    3-edge     
    ttyS1 *<------- IRQ counter increased*
    # /opt/hr/outb 0x2FC 0xb
    # cat /proc/interrupts | grep ttyS1
        3:          0         21          0          0   IO-APIC
    3-edge      ttyS1
    # fg
    cat /dev/ttyS1 *<------- Closing port*
    ^C
    do_IRQ: 1.44 No irq handler for vector
    # cat /proc/interrupts | grep ttyS1
    # cat /proc/interrupts | grep " 3:"
        3:          0         21          0          0   IO-APIC 3-edge
    *<------- IRQ counter NOT increased*
    #


The 8250 driver seems shutting down the port like this:

    - synchronize_irq()
    - disabling port IRQ (clearing TIOCM_OUT2 flag with
    serial8250_set_mctrl)
    - free_irq()

The free_irq() is doing the following:

    1) masking the interrupt in the IO-APIC

    2) clearing the IRQ vector


Now, it seems, the problematic sequence is the following:

    a) the SuperIO sends the interrupt to the IO-APIC

    b) the IO-APIC forwards the interrupt to the local-APIC

    c) the interrupt in the IO-APIC gets masked (IRQ in the local-APIC
    is pending)

    d) the IRQ vector gets cleared

    e) the pending IRQ gets handled (most probably by another core), but
    the vector is already set to VECTOR_UNUSED, so the do_IRQ() function
    prints the error message


When I put a printf (delay) right before the clear_irq_vector() call in 
the x86_vector_deactivate(), I no longer received the error messages -> 
I left time for the interrupt to get processed.

    https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/arch/x86/kernel/apic/vector.c#n378


Also, it seems, if I'm running the serial port opening-closing process 
on the same core as the interrupt is assigned to, I'm not getting the 
error message. If I'm running it on a different core, most of the time, 
I'm getting the error message.

I mean, something like that:

    # echo 2 > /proc/irq/3/smp_affinity
    # taskset 1 cat /dev/ttyS1
    ^C
    # taskset 1 cat /dev/ttyS1
    ^C
    do_IRQ: 1.44 No irq handler for vector
    # taskset 1 cat /dev/ttyS1
    ^C
    do_IRQ: 1.44 No irq handler for vector
    # taskset 2 cat /dev/ttyS1
    ^C
    # taskset 2 cat /dev/ttyS1
    ^C
    # taskset 2 cat /dev/ttyS1
    ^C
    #

Unfortunately, I'm stuck at this point a bit. Don't really know, what 
would be the proper solution (how could I avoid free'ing up a pending 
IRQ's vector), also I'm not knowing the x86 part of the kernel very well 
yet.


Thanks,

Robert
