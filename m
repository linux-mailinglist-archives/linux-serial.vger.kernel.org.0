Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D195D118BAA
	for <lists+linux-serial@lfdr.de>; Tue, 10 Dec 2019 15:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfLJOyF (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 10 Dec 2019 09:54:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:34724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727492AbfLJOyE (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 Dec 2019 09:54:04 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2ECC32077B;
        Tue, 10 Dec 2019 14:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575989643;
        bh=a5BHMVgtPZwxKGzK9Kll2jVkr61mgNawIAex25lud2g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a4TFMfvd0F/X1H5S/tJzVb+P1hLYpiTHlMSKDRBBCcXBeVOGGqNLgg+mV3tvtag5l
         N8ueB474Z+e04eueZAbwwsInGwdoaAW9Yur5XdhWYcT1M6azCT97/yEpsEp+uNF1ew
         Gx6y0ozwRqOc9p4OH7WnrTiprj+0O5cEjdC1Bhxs=
Date:   Tue, 10 Dec 2019 15:54:00 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-serial@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
        Hyunki Koo <kkoos00@naver.com>,
        HYUN-KI KOO <hyunki00.koo@samsung.com>,
        Shinbeom Choi <sbeom.choi@samsung.com>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] tty: serial: samsung: allow driver to be built by
 anyone
Message-ID: <20191210145400.GA4012141@kroah.com>
References: <20191210143706.3928480-1-gregkh@linuxfoundation.org>
 <20191210144656.GA11222@pi3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210144656.GA11222@pi3>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Dec 10, 2019 at 03:46:56PM +0100, Krzysztof Kozlowski wrote:
> On Tue, Dec 10, 2019 at 03:36:57PM +0100, Greg Kroah-Hartman wrote:
> > There is no need to tie this driver to only the OMAP platform,
> 
> s/OMAP/Exynos/

Oops, sorry, was thinking of another driver :)

> Beside that:
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Thanks for the review, will fix up the text in here when I apply this.

greg k-h
