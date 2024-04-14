Return-Path: <linux-serial+bounces-3303-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D374989DAE9
	for <lists+linux-serial@lfdr.de>; Tue,  9 Apr 2024 15:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 119661C21B73
	for <lists+linux-serial@lfdr.de>; Tue,  9 Apr 2024 13:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326871386B2;
	Tue,  9 Apr 2024 13:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oI4NdefV"
X-Original-To: linux-serial@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDF6130A4E;
	Tue,  9 Apr 2024 13:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712670035; cv=none; b=id90wV32MRKHzN8yKJoS5kzgo8OUfEL0rusLvKwvwU6EG5kRcxFzkhsn7uYADC4HsU8wuF/kSAVDfmIJppu/dBgEfuWgcdJpWZh/6DbXr43pmZV/C+bz72SMTKk0PplwVYrD3mns7xQa8XYtrW54f+qxGNbmdbbbI2zwNzTq+b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712670035; c=relaxed/simple;
	bh=HgosSJ3u5EJ7OCEFXDV5HeG0gZWoOdOo9itx9Woi0Fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+R+7R3DkRkCRc+sMK6aD1T00UHBfkBx6MEBufnw9lWUpo6O4aj/lGHSAWQ7mUoH1MXGFdoWD9D2yIX+Zv4ifxM8WwYx9naBrNR9GPQgLja9+Qa/Hi4duMN/LjKbfwyhgagMq3OVycLW0pbOkMt6rYMGp3YWdZD+399bnHHAcCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oI4NdefV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AA9FC433F1;
	Tue,  9 Apr 2024 13:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712670034;
	bh=HgosSJ3u5EJ7OCEFXDV5HeG0gZWoOdOo9itx9Woi0Fg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oI4NdefViyY6cw3qVFOmHjavZVHauMI03D07pGxakvJzu82JWr8YuQovTtZG4drsv
	 Ff2bEmzyuw9hL8eRSZ4oAOE+arXhAyd1iMPpEpOZ8EkoOLE48RGJTYSpsHQauJXYY3
	 zZs87EJenHI2tykyf9kBklp68ab4lr+I2UdKE7Z0=
Date: Tue, 9 Apr 2024 15:40:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: wangkaiyuan <wangkaiyuan@inspur.com>
Cc: jirislaby@kernel.org, hvilleneuve@dimonoff.com,
	andy.shevchenko@gmail.com, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/2] tty: serial: max310x: convert to use maple tree
 register cache
Message-ID: <2024040905-facecloth-cornmeal-e9cb@gregkh>
References: <20240318064036.1656-1-wangkaiyuan@inspur.com>
 <2024040904-agreeably-deferral-f2f8@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024040904-agreeably-deferral-f2f8@gregkh>

On Tue, Apr 09, 2024 at 03:39:32PM +0200, Greg KH wrote:
> On Mon, Mar 18, 2024 at 02:40:36PM +0800, wangkaiyuan wrote:
> > The maple tree register cache is based on a much more modern data structure
> > than the rbtree cache and makes optimisation choices which are probably
> > more appropriate for modern systems than those made by the rbtree cache.
> > 
> > Signed-off-by: wangkaiyuan <wangkaiyuan@inspur.com>
> > ---
> >  drivers/tty/serial/max310x.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Where is patch 2/2 of this series?  I don't see it anywhere on
> lore.kernel.org.

Ah, I see it now, it is not connected here.  I'll take both now but next
time please use something like 'git send-email' for both commits at the
same time.

thanks,

greg k-h

