Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 917207B8FF
	for <lists+linux-serial@lfdr.de>; Wed, 31 Jul 2019 07:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfGaFQS (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 31 Jul 2019 01:16:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:50418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbfGaFQS (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 31 Jul 2019 01:16:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29952206A3;
        Wed, 31 Jul 2019 05:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564550177;
        bh=h1eAdPg/SKvR0UJP/5rfurweIeToXs/7LvFSH8DF9Y0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1GiQSyjtSzDviOunwNz4zA8OZ3/+CND6xoLqnc2nfrBR44j/Ji3OUf9BYlFPaMWpY
         HwUE4Fih0B5B5bOujJrWx7fZuj8jc9zr54NGM2sXTIeANblAtXMv7Rtqge+RgOcmrQ
         2NbZB5g9HD0gkIB4QiWUMkjAmzKEBQ2CuKFBvO6g=
Date:   Wed, 31 Jul 2019 07:16:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Robert Middleton <robert.middleton@rm5248.com>
Cc:     linux-serial@vger.kernel.org
Subject: Re: [PATCH v2] serial: 8250_exar: Clear buffer before shutdown
Message-ID: <20190731051615.GB20809@kroah.com>
References: <20190730221308.6929-1-robert.middleton@rm5248.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730221308.6929-1-robert.middleton@rm5248.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jul 30, 2019 at 06:13:08PM -0400, Robert Middleton wrote:
> When closing and shutting down the exar serial port, if the chip
> has not finished sending all of the data in its buffer, the
> remaining bytes will be lost.  Hold off on the shutdown until the
> bytes have all been sent.
> 
> Signed-off-by: Robert Middleton <robert.middleton@rm5248.com>
> ---
>  drivers/tty/serial/8250/8250_exar.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)

What changed from v1?

Always put that below the --- line, like the kernel documentation asks
you to do.  Please fix up and send a v3.

thanks,

greg k-h
