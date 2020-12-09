Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86CF2D446B
	for <lists+linux-serial@lfdr.de>; Wed,  9 Dec 2020 15:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgLIOcf (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 9 Dec 2020 09:32:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:40364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727016AbgLIOcf (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 9 Dec 2020 09:32:35 -0500
Date:   Wed, 9 Dec 2020 15:33:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607524314;
        bh=vTBJROgGIIIxUOXvSftl1pnRuq5PCJZfwFuZRk3XolU=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=cVpaUCl/mn7EVCXXbK+KJJJ98bOU9gG3FJLMjlGfiR5ErjEnxbwUc1ZtjwgiVKkmM
         5uOqSsxX4yU4NQ7xtFgyKCuevsCXX6ud7+K0XUHM/HHKMtvPeauIFAXKaXiMbtV1IJ
         7CxJAEPFZjQ8hfmC/dizKLX+UI7NnQAXYcrmgKyc=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc:     linux-serial@vger.kernel.org, git@xilinx.com, jacmet@sunsite.dk,
        linuxfoundation.org@xilinx.com
Subject: Re: [PATCH 2/3] serial-uartlite: Add runtime pm support
Message-ID: <X9DgJ25PmC2Ws0V0@kroah.com>
References: <1607516301-26975-1-git-send-email-shubhrajyoti.datta@xilinx.com>
 <1607516301-26975-2-git-send-email-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607516301-26975-2-git-send-email-shubhrajyoti.datta@xilinx.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Dec 09, 2020 at 05:48:20PM +0530, Shubhrajyoti Datta wrote:
>  Add runtime pm support

Again, we need more information here.

thanks,

greg k-h
