Return-Path: <linux-serial+bounces-2009-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F888845AB1
	for <lists+linux-serial@lfdr.de>; Thu,  1 Feb 2024 15:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFCFA283E66
	for <lists+linux-serial@lfdr.de>; Thu,  1 Feb 2024 14:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2531162140;
	Thu,  1 Feb 2024 14:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KwWQ48H7"
X-Original-To: linux-serial@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB06C5B670;
	Thu,  1 Feb 2024 14:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706799439; cv=none; b=WAJBjhuVWkrRFwChFxHAWS+IHxeATOeTNiqx7otdn3gXpJLjj8J1FuraUZHqlwkvJ613nqJIxtIsa/YeI7Q5defNxa3cB7aD3rumseWhL0D/2vdAjaem/TQkzPDP/OyKwZ//SJNNAjkc7umDtMHDKw/bokeCIEFmf6KYDiSATbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706799439; c=relaxed/simple;
	bh=586MbdCr4ab+GUo95iwkYyM7AH0vvm3SwJZaU8WxvQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=POQJHRT6QzAummReeuvEtuZiIC8pC/cOJS9bkG7e3vN7vzq1iQu+/T7Y+QbXG9zvILDdRGY0LywyfHcP5gg2FhageQgyTKf1bPeUD7gjOBK0M44yy112Hb/cxV/xQRm4ONN0yEd7PGFyXlH2W/WX15uGNvMfjbg3wHmpjL5VC4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KwWQ48H7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49727C433C7;
	Thu,  1 Feb 2024 14:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706799438;
	bh=586MbdCr4ab+GUo95iwkYyM7AH0vvm3SwJZaU8WxvQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KwWQ48H7tx9fTyOaCsv1FUdP1bHTxEF1PYIlDkUz+Wb/uVQ6Jm0JDWPzvJxbybfhC
	 TpEkzpHbFWkTdFUKDlZ6+J2R3Q8YQPJT6tIPFDFMJRubcIyBwjd5eYYspk4HVLhlfh
	 sTNiKs78cA6Zf6Fa2y6i1CZ22vgHz+oITh0B8J9g=
Date: Thu, 1 Feb 2024 06:57:17 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Emil Kronborg <emil.kronborg@protonmail.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/2] serial: mxs-auart: fix tx
Message-ID: <2024020103-dictation-magma-d8ed@gregkh>
References: <20240201105557.28043-1-jirislaby@kernel.org>
 <20240201105557.28043-2-jirislaby@kernel.org>
 <3935b841-77b7-4265-a727-98a358cd56be@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3935b841-77b7-4265-a727-98a358cd56be@kernel.org>

On Thu, Feb 01, 2024 at 01:05:42PM +0100, Jiri Slaby wrote:
> On 01. 02. 24, 11:55, Jiri Slaby (SUSE) wrote:
> > Emil reports:
> >    After updating Linux on an i.MX28 board, serial communication over
> >    AUART broke. When I TX from the board and measure on the TX pin, it
> >    seems like the HW fifo is not emptied before the transmission is
> >    stopped.
> > 
> > MXS performs weird things with stop_tx(). The driver makes it
> > conditional on uart_tx_stopped().
> > 
> > So the driver needs special handling. Pass the brand new UART_TX_NOSTOP
> > to uart_port_tx_flags() and handle the stop on its own.
> > 
> > Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> > Reported-by: Emil Kronborg <emil.kronborg@protonmail.com>
> > Fixes: 2d141e683e9a ("tty: serial: use uart_port_tx() helper")
> > Closes: https://lore.kernel.org/all/miwgbnvy3hjpnricubg76ytpn7xoceehwahupy25bubbduu23s@om2lptpa26xw/
> 
> Am I unable to send a proper patch anymore?
> 
> I forgot to add mxs+arm maintainers:
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: linux-arm-kernel@lists.infradead.org
> 
> I can resend with those fixed, if you prefer...

Nah, this is fine, I'll take this as-is, thanks!

greg k-h

