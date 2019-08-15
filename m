Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 430BF8ED1C
	for <lists+linux-serial@lfdr.de>; Thu, 15 Aug 2019 15:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732314AbfHONkx (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 15 Aug 2019 09:40:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:36890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732267AbfHONkx (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 15 Aug 2019 09:40:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF5F7206C1;
        Thu, 15 Aug 2019 13:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565876452;
        bh=8fkos3bJ03vfzr91v3bkBePjiTgQUfL0AC+nbnlTyX4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GaOhF6vbyf+T7aulWg92TMC6bUDvEbaPxwD2xqLBCY4CHHdPDRWT9gjWEDCpwNFt7
         QWxfcdLHp1h0+mTzJ+LulblqiIx4HaWbkhXARaJs2a3K06CdvLBjy+BiEDHMruilXF
         YsizqWrmueY4Bb4qqkAyMln60GbfTZ1pf47HE0k0=
Date:   Thu, 15 Aug 2019 15:40:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     soc@kernel.org, Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 11/13] serial: lpc32xx: allow compile testing
Message-ID: <20190815134049.GA3372@kroah.com>
References: <20190809144043.476786-1-arnd@arndb.de>
 <20190809144043.476786-12-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809144043.476786-12-arnd@arndb.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Aug 09, 2019 at 04:40:37PM +0200, Arnd Bergmann wrote:
> The lpc32xx_loopback_set() function in hte lpc32xx_hs driver is the
> one thing that relies on platform header files. Move that into the
> core platform code so we only need a variable declaration for it,
> and enable COMPILE_TEST building.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
