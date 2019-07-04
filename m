Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 525C35F683
	for <lists+linux-serial@lfdr.de>; Thu,  4 Jul 2019 12:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbfGDKWi (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 4 Jul 2019 06:22:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:51546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727303AbfGDKWi (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 4 Jul 2019 06:22:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49F1C21852;
        Thu,  4 Jul 2019 10:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562235757;
        bh=8g36ElRk5zNhfnSW7mukCxm2S+AdG6G8Zu7zPYGBlnI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dltovTzMRkQGwTf8XrJxLEX0D7Bmv6zlb4pWIWF9xkUH2rtXMzpu0Dvt+Pk5t6smr
         8vYOuPJiuGP5C72SLmI3Dr0QQCAN58kY9unJVoLloaHv2Nx9fpQEjypq/etqS7u6fj
         3EaVsmOQX5wWaak6hev34Z9Rj92zIsT5D58yPV/k=
Date:   Thu, 4 Jul 2019 12:22:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     fugang.duan@nxp.com
Cc:     linux-serial@vger.kernel.org, jslaby@suse.com,
        u.kleine-koenig@pengutronix.de, daniel.baluta@nxp.com
Subject: Re: [PATCH tty/serial 2/2] dt-bindings: serial: lpuart: add the
 clock requirement for imx8qxp
Message-ID: <20190704102234.GA11348@kroah.com>
References: <20190704100021.10859-1-fugang.duan@nxp.com>
 <20190704100021.10859-3-fugang.duan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704100021.10859-3-fugang.duan@nxp.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jul 04, 2019 at 06:00:21PM +0800, fugang.duan@nxp.com wrote:
> From: Fugang Duan <fugang.duan@nxp.com>
> 
> Add the baud clock requirement for imx8qxp.
> 
> Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
> ---
>  Documentation/devicetree/bindings/serial/fsl-lpuart.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

dt stuff needs to cc: the dt maintainers, right?

