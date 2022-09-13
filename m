Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7711F5B6D4B
	for <lists+linux-serial@lfdr.de>; Tue, 13 Sep 2022 14:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbiIMMas (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 13 Sep 2022 08:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiIMMag (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 13 Sep 2022 08:30:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CCDDA8
        for <linux-serial@vger.kernel.org>; Tue, 13 Sep 2022 05:30:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13B7D61466
        for <linux-serial@vger.kernel.org>; Tue, 13 Sep 2022 12:30:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15887C433D6;
        Tue, 13 Sep 2022 12:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663072234;
        bh=ms/BcURCUo49LaTi2MW8XVDhbOgSMK4PXGD7gq0c/Dw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GYtL2dndDcqxOZln5PyIZkUGyWo7K+OfcEj/72qYw7qEwk2h+rnS+Gbh4rZNHjItP
         6oHuBy1BK96Q63BijhSkUHGw2gwlAe42dnILMP3eAdWoJHRBsJlwYIPsGNStOwbPvZ
         t20BbgMhjprwemdEbLvUm7kNoddhGHgQMCUr4/Rw=
Date:   Tue, 13 Sep 2022 14:30:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Anders Blomdell <anders.blomdell@control.lth.se>
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        linux-serial@vger.kernel.org
Subject: Re: kernel 5.19.8: "Oxford Semiconductor Ltd OXPCIe952 Dual Native
 950 UART" gets wrong baudrate (PCI ID 1415:c158)
Message-ID: <YyB4AtFJx++PeA6S@kroah.com>
References: <ef8fd762-88cf-548a-0599-17d939ad3a57@control.lth.se>
 <YyA9maUOlPIExIUd@kroah.com>
 <ff41c70a-767a-45b8-f993-1f70ad3d9254@control.lth.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff41c70a-767a-45b8-f993-1f70ad3d9254@control.lth.se>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Sep 13, 2022 at 02:16:39PM +0200, Anders Blomdell wrote:
> I get incorrect baudrates, my oscilloscope gives:
> 
> Programmed	Measured
> 
>   2400		  5208
>   4800		 13150
>   9600		 10410
>  19200		 71420
>  38400		142000
>  57600		201600
> 115200		138800

I'm sorry, I have no context here at all, what does this pertain to?

confused,

greg k-h
