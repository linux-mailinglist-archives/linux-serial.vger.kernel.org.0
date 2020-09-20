Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9848527142F
	for <lists+linux-serial@lfdr.de>; Sun, 20 Sep 2020 14:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgITMNk (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sun, 20 Sep 2020 08:13:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:32798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbgITMNj (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 20 Sep 2020 08:13:39 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC06C20EDD;
        Sun, 20 Sep 2020 12:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600604019;
        bh=St34CU+hKennzLlK8KQtGoAKVzgqXhSP0qV5c5oRK1s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gZpKOrArKaRAvwTnvWOS5ihs8YMzxfoWS0jauFayh5wm4K6ILhrSVsaECe+o08eH9
         SiP52kmKv/GbiWSnMbZj/uj1TtAYEL16G9BIH3k80ZQKpvYphlwSLaiHm335n/khgp
         +3KAZ136kp3SE1ju1CoVg9FGysGjziqScHdxLk10=
Date:   Sun, 20 Sep 2020 14:14:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     kernel-janitors@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/14] pch_uart: drop double zeroing
Message-ID: <20200920121404.GA2830482@kroah.com>
References: <1600601186-7420-1-git-send-email-Julia.Lawall@inria.fr>
 <1600601186-7420-2-git-send-email-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600601186-7420-2-git-send-email-Julia.Lawall@inria.fr>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Sep 20, 2020 at 01:26:13PM +0200, Julia Lawall wrote:
> sg_init_table zeroes its first argument, so the allocation of that argument
> doesn't have to.
> 
> the semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> expression x,n,flags;
> @@
> 
> x = 
> - kcalloc
> + kmalloc_array
>   (n,sizeof(struct scatterlist),flags)
> ...
> sg_init_table(x,n)
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

It inits the first entry in the array, but what about all of the other
ones?  Is that "safe" to have uninitialized data in them like your
change causes to happen?

thanks,

greg k-h
