Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCC04BA486
	for <lists+linux-serial@lfdr.de>; Thu, 17 Feb 2022 16:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242568AbiBQPhT (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 17 Feb 2022 10:37:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242572AbiBQPhR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 17 Feb 2022 10:37:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9D62B1032
        for <linux-serial@vger.kernel.org>; Thu, 17 Feb 2022 07:37:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2BEDDB8233C
        for <linux-serial@vger.kernel.org>; Thu, 17 Feb 2022 15:37:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D668C340E8;
        Thu, 17 Feb 2022 15:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645112221;
        bh=CjtipKfwYPKBnLwWyOSsQ2HNEGOpPCRTeF1exqcGWH0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nJOo7yfuhi7EC2oUa6jW4Z/92nxPBbrrc3KtO/8d6MCkZi+Ahso+ZVFWqpzb1nQzv
         1jM4ZwqGGpA/RgJGOpsDJz3kle93sNnOnCHVKy8XINQDJ/DZc4ah1n1gjbutsaQWg2
         C9gbBV0nXwWIFD31EzpGRHOkTcFSU77jcmeKkOWU=
Date:   Thu, 17 Feb 2022 16:36:57 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Grant Edwards <grant.b.edwards@gmail.com>
Cc:     linux-serial@vger.kernel.org
Subject: Re: Opening already open serial port now sets RTS and DTR?
Message-ID: <Yg5rmQxl0AKCyez2@kroah.com>
References: <sulpi0$85i$1@ciao.gmane.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sulpi0$85i$1@ciao.gmane.io>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Feb 17, 2022 at 03:28:00PM -0000, Grant Edwards wrote:
> It used to be that opening a serial port only set RTS and DTR if it
> was a "first open". If the port was already open, subsequent opens
> didn't mess up RTS and DTR. This was a very useful behavior in the
> embedded world where RTS and DTR are often used to power and or
> control things (reset lines, mode controls, line driver enables,
> etc.).
> 
> This seems to have changed, and now _every_ open sets RTS and DTR even
> if the port was already open and RTS and DTR had already been put in
> the desired state.

When did it change?  Any chance you can do 'git bisect' to track it
down?

And what hardware are you using here?  Different hardware works
differently in this way at times.

thanks,

greg k-h
