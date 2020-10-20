Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7833285995
	for <lists+linux-serial@lfdr.de>; Wed,  7 Oct 2020 09:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbgJGHbw (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 7 Oct 2020 03:31:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:35196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727629AbgJGHbt (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Oct 2020 03:31:49 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46EAD2075A;
        Wed,  7 Oct 2020 07:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602055908;
        bh=K/XlL6HP9dRTABtPxA+ECp/xsKPeqpXJvl1JRYfjKh8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vfYiIv1WeMZZl1EoHkRYA+X85mCJPbYaJ7w+oGFhf0gfUjRyuVTPd+md3S0EW3oYM
         ygn6gAPHzGFWn8Xn0dCJRIkBtX5VW+meFRGoCO7hTyF1VeM8/xrH7kmVLLg8ElsL4S
         Gxkf/yHxZCe11tTT4W96bTwPIylJCJ16BD296KUQ=
Date:   Wed, 7 Oct 2020 09:32:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-serial@vger.kernel.org
Subject: Re: [PATCH v1 1/2] serial: max310x: Make use of device properties
Message-ID: <20201007073232.GB340590@kroah.com>
References: <20201006222222.583254-1-andy.shevchenko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006222222.583254-1-andy.shevchenko@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Oct 07, 2020 at 01:22:21AM +0300, Andy Shevchenko wrote:
> Device property API allows to gather device resources from different sources,
> such as ACPI. Convert the drivers to unleash the power of device property API.
> 
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  drivers/tty/serial/max310x.c | 27 +++++++++------------------
>  1 file changed, 9 insertions(+), 18 deletions(-)
> 

Did you send 2 copies of this patch series?

Which is correct?

I'll drop both and wait for a v2 :)

thanks,

greg k-h
