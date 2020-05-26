Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 164B91DFFC7
	for <lists+linux-serial@lfdr.de>; Sun, 24 May 2020 17:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbgEXPUC (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sun, 24 May 2020 11:20:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:35568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727985AbgEXPUC (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 24 May 2020 11:20:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CE8420787;
        Sun, 24 May 2020 15:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590333601;
        bh=Wi9y6NoYbpZ7FZyb6D/78my2pZ39r+ZC4BLpbsIYl2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GdBw2Ip+Peo1/6Suqio0869Ab2NIKPeJ7vanqNC1G9KnIJeRlGLVA5bb83eDl5zUj
         pJX5L664ayNLfC3isPAKNKH+Enz7lEH9bvxH3kX6qx9AkR+lZPHTlTtq66Pw85xu8X
         VuwVoBlsFmwdMfZpoAw7LYLcHWJILPBEfWciXkWA=
Date:   Sun, 24 May 2020 17:19:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Denis Ahrens <denis@h3q.com>
Cc:     linux-serial@vger.kernel.org
Subject: Re: Hardwore FlowControl for 16C950 is not activated
Message-ID: <20200524151959.GA21163@kroah.com>
References: <FB64D491-C668-44D0-AB9D-FEE2CEF4705E@h3q.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FB64D491-C668-44D0-AB9D-FEE2CEF4705E@h3q.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, May 24, 2020 at 05:02:19PM +0200, Denis Ahrens wrote:
> Hi
> 
> While playing around with on old SBC with an 16C950 UART I noticed that it does not work properly. After investigating I found out that it is not running with Hardware Flow Control enabled.
> 
> It is a simple patch which only affects the 16C950.
> 
> https://github.com/torvalds/linux/compare/master...denis2342:patch-1

Hi, can you send the patch in email, as Documentation/SubmittingPatches
explains how to do, so that we can properly review and discuss it?

Random web links don't really work for that, and we don't use github for
kernel development, sorry.

thanks,

greg k-h
