Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7754E3BA02
	for <lists+linux-serial@lfdr.de>; Mon, 10 Jun 2019 18:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfFJQun (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 10 Jun 2019 12:50:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:54882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727914AbfFJQun (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 10 Jun 2019 12:50:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09DC5206C3;
        Mon, 10 Jun 2019 16:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560185442;
        bh=IfkuH4QdGGwZoDp+X7T2nRPo/51iLlSiAiiHm/+uJjo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=04Wa46m4OqMS4nMsCoL6Kl0DCTHFMtKfZA/ilxstSrLFpFhir8DuX0YitoR+URRJc
         2Cb15xkPe9D7qIYa2Q3djy+4hYS7/hrxSnxJkx5hz4phfBKDjmd7jP+lFxKTTKeorI
         kyoWZRk93z+67h6eLwfe3/4+21AiROHdtIjbr6vc=
Date:   Mon, 10 Jun 2019 18:50:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "sudheer.v" <open.sudheer@gmail.com>
Cc:     mchehab+samsung@kernel.org, jslaby@suse.com, joel@jms.id.au,
        andrew@aj.id.au, benh@kernel.crashing.org, robh+dt@kernel.org,
        mark.rutland@arm.com,
        shivahshankar.shankarnarayanrao@aspeedtech.com,
        sudheer.veliseti@aspeedtech.com,
        sudheer Kumar veliseti <sudheer.open@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org
Subject: Re: [patch 1/5] AST2500 DMA UART driver
Message-ID: <20190610165040.GB32085@kroah.com>
References: <1559737395-28542-1-git-send-email-open.sudheer@gmail.com>
 <1559737395-28542-2-git-send-email-open.sudheer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559737395-28542-2-git-send-email-open.sudheer@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jun 05, 2019 at 05:53:11PM +0530, sudheer.v wrote:
> +
> +#define CONFIG_UART_DMA_DEBUG
> +
> +#ifdef CONFIG_UART_DMA_DEBUG
> +#define UART_DBG(fmt, args...) pr_debug("%s() " fmt, __func__, ## args)
> +#else
> +#define UART_DBG(fmt, args...)
> +#endif
> +
> +#define  CONFIG_UART_TX_DMA_DEBUG 1
> +
> +#ifdef CONFIG_UART_TX_DMA_DEBUG
> +#define UART_TX_DBG(fmt, args...) pr_debug("%s()"fmt, __func__, ## args)
> +#else
> +#define UART_TX_DBG(fmt, args...)
> +#endif

Why have you left debugging on here?

Why does your tiny driver have custom debug macros?  Please always use
the in-kernel standard ones so you can dynamically enable/disable them
as needed without having to rebuild the code.

I stopped reading here, sorry.

greg k-h
