Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB24591EA2
	for <lists+linux-serial@lfdr.de>; Mon, 19 Aug 2019 10:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfHSIPL (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 19 Aug 2019 04:15:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:41304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbfHSIPL (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 19 Aug 2019 04:15:11 -0400
Received: from X250 (37.80-203-192.nextgentel.com [80.203.192.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40BF12085A;
        Mon, 19 Aug 2019 08:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566202510;
        bh=O4e325kx7cwySscV/ilDWSUX2qJy3pR9jyuhGb1Ccws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XXHcbaH2UEQ6efRbP60vzBrmInpr9EOJhViVbpdsMcI0VM6YbXqdvZIxlA4d/bn4C
         I08CSCbhtK2rHRxDXtwnf0u9kGCfGAxBzLZcbsifvEnjJtRSzbvwBttE+W1UjtYdgG
         TqK3bb2f7N8xwmPuEspZVwEGUvdOERwVn99JW5NM=
Date:   Mon, 19 Aug 2019 10:14:58 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Cosmin Stefan Stoica <cosmin.stoica@nxp.com>
Subject: Re: [PATCH v2 2/6] arm64: Introduce config for S32
Message-ID: <20190819081457.GH5999@X250>
References: <20190809112853.15846-1-stefan-gabriel.mirea@nxp.com>
 <20190809112853.15846-3-stefan-gabriel.mirea@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809112853.15846-3-stefan-gabriel.mirea@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Aug 09, 2019 at 11:29:10AM +0000, Stefan-gabriel Mirea wrote:
> From: Mihaela Martinas <Mihaela.Martinas@freescale.com>
> 
> Add configuration option for the Freescale S32 platform family in
> Kconfig.platforms. For starters, the only SoC supported will be Treerunner
> (S32V234), with a single execution target: the S32V234-EVB (rev 29288)
> board.
> 
> Signed-off-by: Mihaela Martinas <Mihaela.Martinas@freescale.com>
> Signed-off-by: Stoica Cosmin-Stefan <cosmin.stoica@nxp.com>
> Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
> ---
>  arch/arm64/Kconfig.platforms | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 4778c775de1b..a9a6152d37eb 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -210,6 +210,11 @@ config ARCH_ROCKCHIP
>  	  This enables support for the ARMv8 based Rockchip chipsets,
>  	  like the RK3368.
>  
> +config ARCH_S32
> +	bool "Freescale S32 SoC Family"

So you still want to use 'Freescale' than 'NXP' here?

> +	help
> +	  This enables support for the Freescale S32 family of processors.

Shawn

> +
>  config ARCH_SEATTLE
>  	bool "AMD Seattle SoC Family"
>  	help
> -- 
> 2.22.0
> 
