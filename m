Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 194701DADF4
	for <lists+linux-serial@lfdr.de>; Wed, 20 May 2020 10:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgETItW (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 20 May 2020 04:49:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:54284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbgETItV (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 20 May 2020 04:49:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB5F6207D3;
        Wed, 20 May 2020 08:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589964561;
        bh=eblFyyo+k2RaYd0+iiRyO4z9SGJsqN/xJoRoGxuCfFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dK4w2mEYdM+Sr3vwpZfqPznt1WEKRmeAxboNv9gdiUE4AvBpIxh7c3aqF4VOkXc8/
         l7KurB+zEWY8/QjecdnB6W/8IefBIytfc5Ha/tluqZcCzIwkE95U5m6Bi/WZf7k9DU
         LhVzjgD9suQIh5MLM3bec18ndeBcOxoBoLTOocpw=
Date:   Wed, 20 May 2020 10:49:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     gengcixi@gmail.com
Cc:     oberpar@linux.ibm.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, jslaby@suse.com, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, Cixi Geng <cixi.geng1@unisoc.com>
Subject: Re: [RFC][PATCH V2] GCOV: profile by modules
Message-ID: <20200520084918.GD2837844@kroah.com>
References: <20200520083821.9602-1-gengcixi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520083821.9602-1-gengcixi@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, May 20, 2020 at 04:38:21PM +0800, gengcixi@gmail.com wrote:
> From: Cixi Geng <cixi.geng1@unisoc.com>
> 
> ---
> Replace symbol GCOV_PROFILE_MODULES with GCOV_PROFILE_PREREQS
> ---

That can't go in the body of a changelog, as it will be cut off.  Try
applying this patch with 'git am' and see what happens :(

