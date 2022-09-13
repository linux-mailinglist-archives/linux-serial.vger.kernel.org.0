Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C33F5B696A
	for <lists+linux-serial@lfdr.de>; Tue, 13 Sep 2022 10:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbiIMIVx (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 13 Sep 2022 04:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbiIMIVY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 13 Sep 2022 04:21:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7F513E8E
        for <linux-serial@vger.kernel.org>; Tue, 13 Sep 2022 01:21:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF663B80D87
        for <linux-serial@vger.kernel.org>; Tue, 13 Sep 2022 08:21:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB01C433D6;
        Tue, 13 Sep 2022 08:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663057280;
        bh=x5NJ/4MORNe2ZJf3e8//lzu/IbKN/WWw/5zkXPBfL4A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m02L4F8ZudGmGSX206nQNHKUSpDT5CoaKcv+hgFgdBKrwEtPUwDnZT0p26YH2Wklj
         8v4yAsCgkrtAa07B0hOeTJflm/dUzGQhM7sGArIRQq4sZiejIp5ltl3lihJc6ZnXBC
         ovhfBnyF5iS4q9fA2acelF4uqlN6c6p74oV1wI9c=
Date:   Tue, 13 Sep 2022 10:21:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Anders Blomdell <anders.blomdell@control.lth.se>
Cc:     linux-serial@vger.kernel.org
Subject: Re: kernel 5.19.8: "Oxford Semiconductor Ltd OXPCIe952 Dual Native
 950 UART" gets wrong baudrate (PCI ID 1415:c158)
Message-ID: <YyA9maUOlPIExIUd@kroah.com>
References: <ef8fd762-88cf-548a-0599-17d939ad3a57@control.lth.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef8fd762-88cf-548a-0599-17d939ad3a57@control.lth.se>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Sep 12, 2022 at 09:59:08PM +0200, Anders Blomdell wrote:
> Reverting commits
>   366f6c955d4d1a5125ffcd6875ead26a3c7a2a1c
>   9c5c8aaed50bf3478073ab51b8b1f3f5327d3cfa
> fixes my problems.

What problems exactly?

And why not cc: the developers of those commits?

thanks,

greg k-h
