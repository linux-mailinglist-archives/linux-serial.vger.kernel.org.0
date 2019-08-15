Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 852FD8F4A3
	for <lists+linux-serial@lfdr.de>; Thu, 15 Aug 2019 21:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731327AbfHOTcA (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 15 Aug 2019 15:32:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:59398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730372AbfHOTcA (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 15 Aug 2019 15:32:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1FAC20656;
        Thu, 15 Aug 2019 19:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565897519;
        bh=5Hho1H0gvXGhYBThqlBbx1EEYWVxMcLvKkaZfbyKZy8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sjqIXPo7zHGHkSVwA6S732Pi9FtdK78CEnqtgytEoxAfAdzS3H05cUtlTsc1waqqJ
         sjfXP8kAeL0K79qkH9gro2K4+8NW6KTgSV9f7LKxWWZo/LjdxrPyq5qzK7BkXTRMCp
         R9gIT7MNHRk74XGRSyK401lP9O5H8LrVIU7w3jXc=
Date:   Thu, 15 Aug 2019 21:31:57 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, kbuild-all@01.org,
        linux-serial@vger.kernel.org
Subject: Re: [tty:tty-testing 84/90] drivers/tty/serial/lpc32xx_hs.c:447:14:
 sparse: sparse: incompatible types for 'case' statement
Message-ID: <20190815193157.GE30437@kroah.com>
References: <201908160045.ql5LACNr%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201908160045.ql5LACNr%lkp@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Aug 16, 2019 at 12:21:48AM +0800, kbuild test robot wrote:
> Hi Arnd,
> 
> First bad commit (maybe != root cause):
> 
> tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
> head:   92770c07234fb9e097ceb512e4bb29aca750075c
> commit: 5dce8eccb54355ea42918b651f1085e54b2c5f2f [84/90] serial: lpc32xx_hs: allow compile-testing
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.1-rc1-7-g2b96cd8-dirty
>         git checkout 5dce8eccb54355ea42918b651f1085e54b2c5f2f
>         make ARCH=x86_64 allmodconfig
>         make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>

Given that there are at least 3 issues with this patch, I'll go drop it
from my tty-testing branch now :(

thanks,

greg k-h
