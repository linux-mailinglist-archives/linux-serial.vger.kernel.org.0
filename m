Return-Path: <linux-serial+bounces-249-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6437FA00A
	for <lists+linux-serial@lfdr.de>; Mon, 27 Nov 2023 13:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BF671C20935
	for <lists+linux-serial@lfdr.de>; Mon, 27 Nov 2023 12:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FE026AF9;
	Mon, 27 Nov 2023 12:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-serial@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9074AA;
	Mon, 27 Nov 2023 04:52:59 -0800 (PST)
Received: from francesco-nb.int.toradex.com (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id C546F206D2;
	Mon, 27 Nov 2023 13:52:57 +0100 (CET)
Date: Mon, 27 Nov 2023 13:52:53 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Francesco Dolcini <francesco@dolcini.it>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	Amitkumar Karwar <amitkumar.karwar@nxp.com>,
	Neeraj Kale <neeraj.sanjaykale@nxp.com>,
	Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: WARNING around serdev/bt/btnxpuart with 6.7-rc2
Message-ID: <ZWSRJfGSYF8XlJnW@francesco-nb.int.toradex.com>
References: <ZWEIhcUXfutb5SY6@francesco-nb.int.toradex.com>
 <ZWI4gMCoY_YzcH7f@livingston.pivistrello.it>
 <087be419-ec6b-47ad-851a-5e1e3ea5cfcc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <087be419-ec6b-47ad-851a-5e1e3ea5cfcc@kernel.org>

On Mon, Nov 27, 2023 at 09:43:41AM +0100, Jiri Slaby wrote:
> On 25. 11. 23, 19:10, Francesco Dolcini wrote:
> > On Fri, Nov 24, 2023 at 09:33:09PM +0100, Francesco Dolcini wrote:
> > > Hello all,
> > > while doing some test with current [1] Linux mainline I randomly hit a
> > > warning. It is not systematic and I cannot really tell when
> > > it was introduced, posting here to collect some ideas.
> > > 
> > > Amitkumar, Neeraj: to me the issue is around the bluetooth/btnxpuart
> > > driver, however I could also be plain wrong.
> > > 
> > > The issue was reproduced on a Toradex Verdin AM62 [2] that is based on a TI
> > > AM625 SOC (arm64) running with a arm64 defconfig and built with GCC 9 [3].
> > > 
> > > [    9.599027] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
> > > [    9.962266] Bluetooth: hci0: Frame reassembly failed (-84)
> > > [    9.972939] ------------[ cut here ]------------
> > > [    9.977922] serial serial0: receive_buf returns -84 (count = 6)
> > > [    9.994857] WARNING: CPU: 0 PID: 37 at drivers/tty/serdev/serdev-ttyport.c:37 ttyport_receive_buf+0xd8/0xf8
> > > [   10.004840] Modules linked in: mwifiex_sdio(+) mwifiex snd_soc_simple_card crct10dif_ce cfg80211 snd_soc_simple_card_utils k3_j72xx_bandgap rti_wdt rtc_ti_k3 btnxpuart bluetooth sa2ul ecdh_generic ecc sha256_generic tidss rfkill libsha256 drm_dma_helper snd_soc_davinci_mcasp authenc omap_mailbox snd_soc_ti_udma snd_soc_ti_edma snd_soc_ti_sdma atmel_mxt_ts ina2xx snd_soc_nau8822 ti_sn65dsi83 tc358768 ti_ads1015 tps65219_pwrbutton at24 m_can_platform industrialio_triggered_buffer drm_kms_helper m_can kfifo_buf rtc_ds1307 lm75 pwm_tiehrpwm can_dev spi_omap2_mcspi panel_lvds pwm_bl libcomposite fuse drm backlight ipv6
> > > [   10.059984] CPU: 0 PID: 37 Comm: kworker/u4:2 Not tainted 6.7.0-rc2-00147-gf1a09972a45a #1
> > > [   10.071793] Hardware name: Toradex Verdin AM62 WB on Verdin Development Board (DT)
> > > [   10.082898] Workqueue: events_unbound flush_to_ldisc
> > > [   10.091345] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > > [   10.101820] pc : ttyport_receive_buf+0xd8/0xf8
> > > [   10.109712] lr : ttyport_receive_buf+0xd8/0xf8
> > > [   10.117581] sp : ffff800082b9bd20
> > > [   10.124202] x29: ffff800082b9bd20 x28: ffff00000000ee05 x27: ffff0000002f21c0
> > > [   10.134735] x26: ffff000002931820 x25: 61c8864680b583eb x24: ffff0000002f21b8
> > > [   10.145209] x23: ffff00000026e740 x22: ffff0000002f21e0 x21: ffffffffffffffac
> > > [   10.155686] x20: ffff000000da5c00 x19: 0000000000000006 x18: 0000000000000000
> > > [   10.166178] x17: ffff7fffbe0e7000 x16: ffff800080000000 x15: 000039966db1c650
> > > [   10.176564] x14: 000000000000022c x13: 000000000000022c x12: 0000000000000000
> > > [   10.186979] x11: 000000000000000a x10: 0000000000000a60 x9 : ffff800082b9bb80
> > > [   10.197352] x8 : ffff00000026f200 x7 : ffff00003fd90080 x6 : 00000000000022e5
> > > [   10.207680] x5 : 00000000410fd030 x4 : 0000000000c0000e x3 : ffff7fffbe0e7000
> > > [   10.218051] x2 : 0000000000000002 x1 : 0000000000000000 x0 : 0000000000000000
> > > [   10.228393] Call trace:
> > > [   10.233989]  ttyport_receive_buf+0xd8/0xf8
> > > [   10.241224]  flush_to_ldisc+0xbc/0x1a4
> > > [   10.248117]  process_scheduled_works+0x16c/0x28c
> > > [   10.255851]  worker_thread+0x16c/0x2e0
> > > [   10.262673]  kthread+0x11c/0x128
> > > [   10.268953]  ret_from_fork+0x10/0x20
> > > [   10.275460] ---[ end trace 0000000000000000 ]---
> > > [   10.294674] Bluetooth: hci0: Frame reassembly failed (-84)
> > > [   10.461657] Bluetooth: hci0: Frame reassembly failed (-84)
> > > [   10.472025] Bluetooth: hci0: Frame reassembly failed (-84)
> > 
> > I think that what is happening is the following:
> > 
> >   -> serdev-ttyport.c:ttyport_receive_buf()
> >     -> btnxpuart.c:btnxpuart_receive_buf()
> >        -> h4_recv_buf() errors out
> >        -> return -84
> >     -> warn because ret is <0
> > 
> > Is this the desired behavior? If I understand correct recv_buf() is supposed to
> > return how many bytes it has consumed, e.g. something from 0 to count.
> 
> You understand it correctly. serdev should adopt:
> commit 0468a8071d7cfb0f5bc02b0888cec4525551299f
> Author: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Date:   Thu Aug 10 11:14:44 2023 +0200
> 
>     tty: make counts in tty_port_client_operations hooks size_t
> 
> and propagate it further to its users. The commit was meant to exactly avoid
> these mistakes (but one layer upper).
> 
> btmtkuart_receive_buf is broken the same way.
> 
> Do you want to fix it yourself?
I'll send a patch myself, thanks.


