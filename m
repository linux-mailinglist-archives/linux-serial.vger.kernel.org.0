Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4043F9E06
	for <lists+linux-serial@lfdr.de>; Fri, 27 Aug 2021 19:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhH0R1r (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 27 Aug 2021 13:27:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:51768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230367AbhH0R1q (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 27 Aug 2021 13:27:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C69AA60EB3;
        Fri, 27 Aug 2021 17:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630085217;
        bh=H0S3G/qkC2XQBQDSTyESgyXJRBdnAEEuEDHNayaPYDw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R3kRXxInvrPdBzORmIUJwOqlPe1H6CgNEDGAZ5OfwetWIN0cr//Q35utQ1YWj/jgC
         shmDA4wn8n/gGShE00MaSxr1Zk9qgUw10+S9o3kwyfKsNa7xhjFdD9vmAKsms8Sz60
         /SrAj46/Y1wAX6VRkJTtLlHR6l2tYcjLgLftP0Ig=
Date:   Fri, 27 Aug 2021 19:26:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Sathish Kumar Balasubramaniam -ERS, HCL Tech" 
        <b-sathishkumar@hcl.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: [PATCH] tty: serial: UART driver for RISC-V based Chromite SoC
 family
Message-ID: <YSkgWpZnZXhv6PYD@kroah.com>
References: <SG2PR04MB382047047E75CF30B8E8EA0B81C89@SG2PR04MB3820.apcprd04.prod.outlook.com>
 <SG2PR04MB3820B2DED21B7B5DB868A18F81C89@SG2PR04MB3820.apcprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SG2PR04MB3820B2DED21B7B5DB868A18F81C89@SG2PR04MB3820.apcprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Aug 27, 2021 at 04:32:58PM +0000, Sathish Kumar Balasubramaniam -ERS, HCL Tech wrote:
> Classification: Public

This does not belong in a changelog comment, please remove.

> 
> This driver patch adds the UART TTY serial support for the RISC-V based InCore Semiconductor's Chromite SoC family like Chromite M, Chromite H.

Please line wrap your changelog comments properly.

I'll wait for a v2 before reviewing the code...

thanks,

greg k-h
