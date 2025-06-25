Return-Path: <linux-serial+bounces-9959-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E078DAE8C99
	for <lists+linux-serial@lfdr.de>; Wed, 25 Jun 2025 20:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99EB53A69AE
	for <lists+linux-serial@lfdr.de>; Wed, 25 Jun 2025 18:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1357C2D5C6D;
	Wed, 25 Jun 2025 18:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ijdc8opz"
X-Original-To: linux-serial@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18441DC98B;
	Wed, 25 Jun 2025 18:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750876559; cv=none; b=Glr9DUmFyFlb/JJZ5F8T6DLPLUJhdXHpja435iGEvgfh1ib+VEQpIEUJ2oX7e44xmcdREDgm06xmeIbKKWKzQFZ/yG3UbUTIo7CxPxVT87jZ1Pcd+V8Baun8tw/6xkDqkRTtf/IU2xTNxJE8rn/hA7pCUVxVrelP7WW5B2efEHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750876559; c=relaxed/simple;
	bh=rNYUfS+QC6CJz32WWVNOnG+NFAUPmM8wTr2iF+yy6i8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FX1M3kWLUhU1mwE9oZnCGRCZBu53n2w9LLTJbeqivBG2aMESn7iVOGW53LjyzBCavVs5vaNLx7U61Bu2L9TwcYQ3oBV5KwLg5Fpqg5p2DDhx7iPjawYJ8YDhbtg0Spa/VEzPEHtKYlWXLutiBV+jmeOuO4IBjB87KquVqNgOGgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ijdc8opz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 522FBC4CEF0;
	Wed, 25 Jun 2025 18:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750876558;
	bh=rNYUfS+QC6CJz32WWVNOnG+NFAUPmM8wTr2iF+yy6i8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ijdc8opzcaW6MuLyFnJUXGU1CZ8ABOCxbuSE1BtuDANMj48/SGChoOa92abfv1XIl
	 qpZ7Eik37hF1LDo+2oq16TgoTRuffYQEJv5dNinJDTv0KjlynhGBlUfSuqBfcYJBxS
	 lPZou+m+ADZbe/4SRat7B5eslYfTPKi+cG9iqYln3hpSJfKN/Xodl1GCNXHw+FVMca
	 1uNRnYq3Jr/SIrOVVkdIr76t8VaP2vpk0oAX71sb/gnH8cLFLaJiUj+V1PIwN3Nrij
	 PY/6j1sDx652jPiz36ANOKSrHBQhpZDbBVQ49L1nhVRLauVFBO5Qs8bW9uoCCVocg4
	 PlOEm7rFGF8ug==
Date: Wed, 25 Jun 2025 13:35:57 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	Yixun Lan <dlan@gentoo.org>, Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	imx@lists.linux.dev, Lubomir Rintel <lkundrak@v3.sk>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/1] dt-bindings: serial: 8250: allow clock 'uartclk' and
 'reg' for nxp,lpc1850-uart
Message-ID: <175087655526.1993020.9662520639460479640.robh@kernel.org>
References: <20250602142745.942568-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602142745.942568-1-Frank.Li@nxp.com>


On Mon, 02 Jun 2025 10:27:45 -0400, Frank Li wrote:
> Allow clock 'uartclk' and 'reg' for nxp,lpc1850-uart to align existed
> driver and dts. It is really old platform. Keep the same restriction for
> others.
> 
> Allow dmas and dma-names property, which allow maxItems 4 because very old
> platform (arch/arm/boot/dts/nxp/lpc/lpc18xx.dtsi) use duplicate "tx", "rx",
> "tx", "rx" as dma-names.
> 
> Fix below CHECK_DTB warnings:
>   arch/arm/boot/dts/nxp/lpc/lpc4337-ciaa.dtb: serial@40081000 (nxp,lpc1850-uart): clock-names: ['uartclk', 'reg'] is too long
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../devicetree/bindings/serial/8250.yaml      | 41 +++++++++++++++++--
>  1 file changed, 37 insertions(+), 4 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


