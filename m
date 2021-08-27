Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7EC33F9C70
	for <lists+linux-serial@lfdr.de>; Fri, 27 Aug 2021 18:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbhH0QbE (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 27 Aug 2021 12:31:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:34776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229675AbhH0QbD (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 27 Aug 2021 12:31:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED1C160E99;
        Fri, 27 Aug 2021 16:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630081814;
        bh=7BV7G/KLksmspqXcQ7D6We1m/gEBHS0VFBfg4msfhYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u/zHsuODl6KZ+BAc4e75m08ZDggIPMPcnQOGhwAjMWidC3SjEuio2Ts9Co3dxLADs
         k/Q1hd4w9q9G9mvFgq/k9W4BJfx3PkMOMDDHWLBkMp8vV60nI8bKRNmeQ6jm4Cz+0N
         lDmVllt3+I63N0k/I4JInu8un0S4x7pmmP7KeqHs=
Date:   Fri, 27 Aug 2021 18:30:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Sathish Kumar Balasubramaniam -ERS, HCL Tech" 
        <b-sathishkumar@hcl.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: [PATCH] tty: serial: UART driver for RISC-V based Chromite SoC
 family
Message-ID: <YSkTD1V3wAE6nQ43@kroah.com>
References: <SG2PR04MB382047047E75CF30B8E8EA0B81C89@SG2PR04MB3820.apcprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SG2PR04MB382047047E75CF30B8E8EA0B81C89@SG2PR04MB3820.apcprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Aug 27, 2021 at 04:23:30PM +0000, Sathish Kumar Balasubramaniam -ERS, HCL Tech wrote:
> Classification: Confidential

Hm, odd, I doubt that will be ok in a changelog comment :(

Please fix up properly and resend.

thanks,

greg k-h
