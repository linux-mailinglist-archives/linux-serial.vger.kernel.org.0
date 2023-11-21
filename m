Return-Path: <linux-serial+bounces-88-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 489597F37C8
	for <lists+linux-serial@lfdr.de>; Tue, 21 Nov 2023 21:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7855C1C208FE
	for <lists+linux-serial@lfdr.de>; Tue, 21 Nov 2023 20:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E91651016;
	Tue, 21 Nov 2023 20:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=eberhard.stoll@gmx.de header.b="ftOfFLSK"
X-Original-To: linux-serial@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB6919E;
	Tue, 21 Nov 2023 12:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1700600360; x=1701205160; i=eberhard.stoll@gmx.de;
	bh=ht3lyZWYQxo1DULkRSGST5LLzTeidHvVO5reRkjwvzA=;
	h=X-UI-Sender-Class:Date:To:Cc:References:Subject:Reply-To:From:
	 In-Reply-To;
	b=ftOfFLSKgWtA8F9WeUaEv7wo3xHDnxV5vqYkVsfcNPEDTBLArE/aOWe6CR1PtS3k
	 OC+MaPSt7hiZ75XbsOIauY7d0a+hGGBTv2KsrClT7FCP7XJGs4LbgL8z+yBK5i1wL
	 lu6NI4PzN73JBaVhYUVa6zm2qDk1uGA7x3C6lsJW9uFkDHXzi3E/2T7SweaRa6m7J
	 HtNOaCddCFb56jy4csekQSM36vRkLo2qGM3WNIC3B9ihIzXQAgXxMQV2VFVFCx2Yb
	 DMYgc4iFyhzCB4oCJTJL7KQSOs583QIcxtPeHDLZzhGJzPkbXJhasYCQK/AYK7ft9
	 t4B3K3NdSNcWOowgow==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.200.6] ([77.246.119.226]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MuUnA-1rNtlq17uU-00rVco; Tue, 21
 Nov 2023 21:59:20 +0100
Message-ID: <0dc938c5-0d11-4d21-940f-9be1f771b7df@gmx.de>
Date: Tue, 21 Nov 2023 21:59:19 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: rasmus.villemoes@prevas.dk
Cc: festevam@gmail.com, gregkh@linuxfoundation.org, jirislaby@kernel.org,
 kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
 linux-imx@nxp.com, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org,
 eberhard.stoll@kontron.de
References: <20231120132256.136625-1-rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH] serial: imx: also enable Transmit Complete interrupt in
 rs232 mode
Content-Language: en-US
Reply-To: 20231120132256.136625-1-rasmus.villemoes@prevas.dk
From: Eberhard Stoll <eberhard.stoll@gmx.de>
In-Reply-To: <20231120132256.136625-1-rasmus.villemoes@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/8nmmdp4YuAZhHN/9C+w15sDJWilERK8BhvYMh2pZa1zOg7XMQc
 6+GbNEREoxas9d4zmRRKBe7uUMzavVmDWYahcHwdrY2OvVWfDQViXLYwzzU2R/Vn7MEHzFn
 hpE3AxcKCfepqjD3ypsgyC63y/CIu+JnmCtb9zdvi5ROcwW1cMxlF9uCnlfTEWbDHISB7IA
 Gy+wUimx/5kWqtqX9hKrg==
UI-OutboundReport: notjunk:1;M01:P0:BgAN6uwDOgs=;hsIWdYFI98CUuNKvydg0Nq5bLw6
 /xCvmWSBadBaOZfQM45O5PvFANvyRchS+VTATIEUosgt+ZSa1huD1IUAvGhdyexoXjOiglczB
 3YY8LlJiuBAIgqqssr7ft9jJPHU90oSe8MeNHt1uvFfKv662pYePH60m0HO1LlsHirCVB5Qti
 YAD2TdCFHzKDWsGRCmCWCq8kX9LLjwFTWkBFdSVtpLfYZu+u9yMmYrEOrmc91UQR4wNNIPZG3
 P84c1agS1Uu9LOE+YX0I8ItGH9it/yq/qTp8uCm2PROF7g169D0ruIG0E8Pfkm+W9tUqg0gJC
 kejToIkikLI2KzYjRr8I0g9SZPXzmfB3GPQ/c2vRsQWhyBwqybBEqOmaWBFvOsXeWJE887uPU
 1/awyqz1g8ERDv4KCHuMrk3DtQoW1D9Qy82XkSlZOSvC4EWQLGCH2QoOxosEkG/sw3MAZB1cX
 gRUeeYwzMsAFCePEsUttSeo3Zdx6Rmz+v6ngVTUyO0EDRo7NaP36uRe/qnt8udIr+MpR4SeqI
 G+Sm0tzVRkilAqjtGMIR2S9SHabWhmFU5QpMeOTB7Iucobh8NGUA27P6RNZ7RnOCro9O6cg1w
 wzVaVEwcTQFK9Jjuevrp0mTt8ApOHV/+b7PfZ3PJZ5D+UF28tt4v5bymUzcT54E/Mp7cn1zIg
 nrm2APzbeIoMkcjD7H/NL6B38vKtV2LCissZadNG2GVbPzO+sAYk+nkCnd0s24QA2N2Y0kHqh
 hwftrPVzY1d/rQh9UV8GalxedUnq3OK0/9PuCjUmxIMZDUBIE1Nn9FCfHl5Oq/tkpoTp68nfy
 6m1uOgSgCqZvNMekagEmbjoHo06gQYkb6Um8WrhKc4TIUWLFTXbED35lRL7531lY0OTBuOVbn
 FsTiH7Ig+AR0380P19zRVGpG0Ri9F4Y5rtkbia7GtFkfW6muvfpCP31iDNF7ki/1ep6VMCPKx
 io0fEJyoHk6fsgwt7XGLNfBmopY=

> Currently, if one switches to rs232 mode, writes something to the
> device, and then switches to rs485 mode, the imx_port's ->tx_state is
> left as SEND. This then prevents a subsequent write in rs485 mode from
> properly asserting the rts pin (i.e. enabling the transceiver),
> because imx_uart_start_rx() does not enter the "if (sport->tx_state =3D=
=3D
> OFF)" branch. Hence nothing is actually transmitted.
>
> The problem is that in rs232 mode, ->tx_state never gets set to OFF,
> due to
>
> 	usr2 =3D imx_uart_readl(sport, USR2);
> 	if (!(usr2 & USR2_TXDC)) {
> 		/* The shifter is still busy, so retry once TC triggers */
> 		return;
> 	}
>
> in imx_uart_stop_tx(), and TC never triggers because the Transmit
> Complete interrupt is not enabled for rs232.
>
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
> I'm not sure this is the best fix.
>
> At first I considered doing something much more targeted, but
> definitely also more hacky: In imx_uart_rs485_config(), if switching
> on rs485 mode, simply add "sport->tx_state =3D OFF;".
>
> If someone has a better suggestion, I'm all ears.

Hello Rasmus,

i can observe a very similar situation, but with a litte different
configuration. This is how i can trigger the situation very quickly:

   1) open the port
   2) send 1 byte out
   3) close the port

Do it in a loop. As faster, the lockup may occur earlier (but not
mandatory, 100ms is sufficient in my setup at 115200 Baud on an
i.mx8mm board).
With this configuration i get the lockup in around 1 minute.

For my setup it's clear what happens:

   - when the tty is closed imx_uart_shutdown() is called. This calls
     imx_uart_stop_tx()
   - for a lockup, the shifter is still busy and imx_uart_stop_tx()
     returns early (as you explained) without modifying ->tx_state.
   - imx_uart_shutdown() proceeds and finally closes the port. Due to
     imx_uart_stop_tx() is not executed completely tx_state is left in
     state ->tx_state =3D=3D SEND.
   - When the port is opened again, tx_state is SEND and nothing can
     be transmitted any more. The tx path has locked up!

Setting ->tx_state =3D SEND in imx_uart_shutdown() helps for my issue
(and should be ok IMHO).

But IMHO there is one next issue with this situation: When the port
operates with WAIT_AFTER_RTS and WAIT_AFTER_SEND then some timers
for callback functions might be active. I did not discover where they
are stopped for the case when the serial port is closed. Maybe stopping
is not required ...

I'd appreciate someone with more experience could review or revise it

Best Regards
Eberhard


