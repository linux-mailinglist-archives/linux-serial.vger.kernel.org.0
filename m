Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 391623B9F8
	for <lists+linux-serial@lfdr.de>; Mon, 10 Jun 2019 18:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbfFJQtd (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 10 Jun 2019 12:49:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:54186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727922AbfFJQtd (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 10 Jun 2019 12:49:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C0BC206C3;
        Mon, 10 Jun 2019 16:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560185372;
        bh=DJWzh4M4XAj7HnA5+HP6vbhzYDiXG0edcx1jVTCzodk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TN35St+LWALMFOUIbNZCi+b2AKvJT7luQr7HO7i0ZYDPGVHb/uaL6ku9c+pEHrNV9
         aItkt+n3O5qsGddEuzo286gMrtLAE6RNGenXK2AfCNAOJ0wbArn700Fjx6zWdNeFlU
         DP/D7Zm8gFmoa04wmmEJU8O0ce8DdSFxMXwc52Ro=
Date:   Mon, 10 Jun 2019 18:49:30 +0200
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
Message-ID: <20190610164930.GA32085@kroah.com>
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
> From: sudheer Kumar veliseti <sudheer.open@gmail.com>
> 
> Signed-off-by: sudheer veliseti <sudheer.open@gmail.com>
> ---

I can not take a patch without any changelog text at all, especially for
one that is 1928 lines long :(

Please provide a proper changelog and I will be glad to review it.

thanks,

greg k-h
