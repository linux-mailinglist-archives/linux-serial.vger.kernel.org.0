Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0DE71230E1
	for <lists+linux-serial@lfdr.de>; Tue, 17 Dec 2019 16:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfLQPwW (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 17 Dec 2019 10:52:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:38750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727202AbfLQPwW (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 17 Dec 2019 10:52:22 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 909992146E;
        Tue, 17 Dec 2019 15:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576597942;
        bh=V5+Sh7PgM5ICNdJTZk6XqRi35Wh2myELF/Wv/B5/e+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PQkVBAIH7jGcRnjZN5ngOC31sywwyOt+Tuf+3tFEhL4KNqExiI3y8kYIn1xM3ceHp
         mXOC0ijONbiZWkofH0f3WsjQvESUWE07fsnh4lulzIcVwRrwHrYlvKoEuIwxI7rHfQ
         NjgRU+xWLIMq7lUOJf8pbqj/gDa5KfbtZ4UA0ZPs=
Date:   Tue, 17 Dec 2019 16:52:19 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitry Safonov <dima@arista.com>
Cc:     Kukjin Kim <kgene@kernel.org>, Hyunki Koo <kkoos00@naver.com>,
        HYUN-KI KOO <hyunki00.koo@samsung.com>,
        Shinbeom Choi <sbeom.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: serial: samsung_tty: do not abuse the struct
 uart_port unused fields
Message-ID: <20191217155219.GA3754999@kroah.com>
References: <20191217140232.GA3489190@kroah.com>
 <e0fbb679-54fb-25c6-0e88-012d0490e291@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0fbb679-54fb-25c6-0e88-012d0490e291@arista.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Dec 17, 2019 at 03:47:34PM +0000, Dmitry Safonov wrote:
> On 12/17/19 2:02 PM, Greg Kroah-Hartman wrote:
> > The samsung_tty driver was trying to abuse the struct uart_port by using
> > two "empty" bytes for its own use.  That's not ok, and was found by
> > removing those fields from the structure.
> > 
> > Move the variables into the port-specific structure, which is where
> > everything else for this port already is.  There is no space wasted here
> > as there was an empty "hole" in the structure already for these bytes.
> 
> Thanks!
> Sorry for not noticing this myself.

You wouldn't have noticed this unless you build for that platform. I
just recently made it buildable for other ones.

> 
> > Cc: Kukjin Kim <kgene@kernel.org>
> > Cc: Hyunki Koo <kkoos00@naver.com>
> > Cc: HYUN-KI KOO <hyunki00.koo@samsung.com>
> > Cc: Shinbeom Choi <sbeom.choi@samsung.com>
> > Cc: Krzysztof Kozlowski <krzk@kernel.org>
> > Cc: Dmitry Safonov <dima@arista.com>
> > Cc: Jiri Slaby <jslaby@suse.com>
> > Cc: linux-serial@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> I see you already applied it to your tree, but in case it helps anything:
> Reviewed-by: Dmitry Safonov <dima@arista.com>

The review helps, thanks :)

greg k-h
