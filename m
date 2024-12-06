Return-Path: <linux-serial+bounces-7091-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E06B29E6785
	for <lists+linux-serial@lfdr.de>; Fri,  6 Dec 2024 07:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C83A016B3FC
	for <lists+linux-serial@lfdr.de>; Fri,  6 Dec 2024 06:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74A91D7992;
	Fri,  6 Dec 2024 06:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0LEWLt9f"
X-Original-To: linux-serial@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C6E145B38;
	Fri,  6 Dec 2024 06:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733468335; cv=none; b=PL9jj7jkxgVa0r7MgegvzJk+r8QHDsybSyz6Pp4clvr//5irf1eug6cpKJqsLvGCpDQiwTlOmT+x12S7iRUbrNay8JF5KmR4rWesqjmQElxP92Y5GffL45qrpAQkjJM7eD3OXC0s90HX6talOueMKJSUgf3mrAF5x8asARLwuDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733468335; c=relaxed/simple;
	bh=VL5IklISwI+v77qNel3fS9Zq8lGUS1Gx9r3odgehNH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/dLzXy+vNVemRP11B8WM+u7Fv13MOFB4TtyNBIQleNhCgtvDzJ0LFHkx2uEHGX25NTRqW/knlViN1D76zLX3Em5KLiHuoUxhewiSIxmPkmS4tJ7q4LMHgPfda+jkP6D7PKFMec6G5g8J3ayZL61U1u9+MKIO6TiiyCQArRufsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0LEWLt9f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89086C4CED1;
	Fri,  6 Dec 2024 06:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733468335;
	bh=VL5IklISwI+v77qNel3fS9Zq8lGUS1Gx9r3odgehNH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0LEWLt9fPzYGcF5IyFqG6x02YHIXWYHJeAB9fX1d8odcdYZV0pEENHxD/kq6sKyEq
	 p5xL8LOpyWnNl4ZLgpGS8+FLrHqJksecI/bXnMk6G80JkN+4L2Jxs0TrOenF+s9oBj
	 DrB8OD7rtD52V6ntUKc+T52CmU6Ary/A4yDQJC7M=
Date: Fri, 6 Dec 2024 07:58:52 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Niklas Schnelle <schnelle@linux.ibm.com>
Subject: Re: [PATCH] tty: serial: Work around warning backtrace in
 serial8250_set_defaults
Message-ID: <2024120642-prize-shawl-979d@gregkh>
References: <20241205143033.2695333-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205143033.2695333-1-linux@roeck-us.net>

On Thu, Dec 05, 2024 at 06:30:33AM -0800, Guenter Roeck wrote:
> Commit 7c7e6c8924e7 ("tty: serial: handle HAS_IOPORT dependencies")
> triggers warning backtraces on a number of platforms which don't support
> IO ports.
> 
> WARNING: CPU: 0 PID: 0 at drivers/tty/serial/8250/8250_port.c:470 serial8250_set_defaults+0x148/0x1d8
> Unsupported UART type 0
> 
> The problem is seen because serial8250_set_defaults() is called for
> all members of the serial8250_ports[] array even if that array is
> not initialized.
> 
> Work around the problem by only displaying the warning if the port
> type is not 0 (UPIO_PORT) or if iobase is set for the port.
> 
> Fixes: 7c7e6c8924e7 ("tty: serial: handle HAS_IOPORT dependencies")
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> A complete fix will require a sequence of patches, which will have to be
> tested thoroughly and is thus not 6.13 material. This patch doesn't fix
> the underlying problem, but it is good enough for 6.13, or at least not
> worse than 6.12, while at the same time avoiding the warning backtrace.

Thanks, I'll take this for now.

greg k-h

