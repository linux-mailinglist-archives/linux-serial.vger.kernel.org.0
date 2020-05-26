Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 151091C593A
	for <lists+linux-serial@lfdr.de>; Tue,  5 May 2020 16:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbgEEOXa (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 5 May 2020 10:23:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:52988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729471AbgEEOX1 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 5 May 2020 10:23:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF38520675;
        Tue,  5 May 2020 14:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588688607;
        bh=btspPBgx+wVDD4t0Y6wDO3EI1PcWVHUnacBogaW1ocA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KoX6cbhl9KFl5qC+HaUXcuwpnBxYaKxiIaJZTANX5bGE2IngJcYpuvWr1QlhxXGlh
         1R5dHIp1+d3GYw4NsCiD6U1UUsrifGaWTC1XxwmX2cWkQvoDoAWDQSCJh0IjO5NVXd
         auv9NPi8x7CcnXfkAd456dhu0aKZLe2Is1LKPZnI=
Date:   Tue, 5 May 2020 16:23:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hyunki Koo <hyunki00.koo@samsung.com>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/3] serial: samsung: Replace rd_regb/wr_regb with
 rd_reg/wr_reg
Message-ID: <20200505142325.GA816056@kroah.com>
References: <CGME20200420013322epcas2p263e72997dd4ebdaf00b095a83a6b6651@epcas2p2.samsung.com>
 <20200420013300.17249-1-hyunki00.koo@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200420013300.17249-1-hyunki00.koo@samsung.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Apr 20, 2020 at 10:32:56AM +0900, Hyunki Koo wrote:
> This patch change the name of macro for general usage.
> 
> Signed-off-by: Hyunki Koo <hyunki00.koo@samsung.com>

This patch series creates the following build error, which is not
allowed:

  CC [M]  drivers/tty/serial/samsung_tty.o
drivers/tty/serial/samsung_tty.c:186:13: warning: ‘wr_reg_barrier’ defined but not used [-Wunused-function]
  186 | static void wr_reg_barrier(struct uart_port *port, u32 reg, u32 val)
      |             ^~~~~~~~~~~~~~

Please fix up and resend.  Always make sure you keep the reviewed-by
tags from others as well.

greg k-h
