Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D824C415E
	for <lists+linux-serial@lfdr.de>; Fri, 25 Feb 2022 10:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239059AbiBYJZw (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 25 Feb 2022 04:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236298AbiBYJZv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 25 Feb 2022 04:25:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A121A182D98
        for <linux-serial@vger.kernel.org>; Fri, 25 Feb 2022 01:25:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 57291B82D01
        for <linux-serial@vger.kernel.org>; Fri, 25 Feb 2022 09:25:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7046AC340E7;
        Fri, 25 Feb 2022 09:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645781114;
        bh=LhEaV986nKIul6SMp2+k3xvgLYzsk6k9mlP+oxfPyiI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g9abWTQZcSu8tqMtS0gqnDlZxG1IcHIk+LLJ2ZN0FZaGltLnIAz3+xk805OjujVy1
         vDQQVSFWy1V6u6NP97kXtwwVG5L5lP4ZpGSQ31Nyo3zg1eacTwbI9LbicEThrU14BW
         Y12yYCW1u8LynWgpV7N3eHE1/pssRZLr7sQMKeOQ=
Date:   Fri, 25 Feb 2022 10:25:11 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tomasz =?utf-8?Q?Mo=C5=84?= <tomasz.mon@camlingroup.com>
Cc:     linux-serial@vger.kernel.org, Phil Elwell <phil@raspberrypi.com>,
        Daniel Mack <daniel@zonque.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Krzysztof =?utf-8?Q?Drobi=C5=84ski?= 
        <k.drobinski@camlintechnologies.com>,
        Lech Perczak <l.perczak@camlintechnologies.com>
Subject: Re: [PATCH 0/6] sc16is7xx: Hardware flow control fixes
Message-ID: <Yhigd0pu2hmSLirE@kroah.com>
References: <20220221105618.3503470-1-tomasz.mon@camlingroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220221105618.3503470-1-tomasz.mon@camlingroup.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Feb 21, 2022 at 11:56:12AM +0100, Tomasz Moń wrote:
> sc16is7xx driver assumes that the device handles hardware flow control
> automatically. This is not really true as the driver does inadvertently
> clear the bits that enable hardware flow control.
> 
> This patch series solves multiple issues present in the driver. While
> the patches are fairly independent, there are some dependencies. The
> "sc16is7xx: Properly resume TX after stop" adds IER bit set function
> that is later used in "sc16is7xx: Set AUTOCTS and AUTORTS bits". Also
> the patches that control which interrupts are enabled are dependent on
> each other.
> 
> Patches should be applied respecting the order in the series. The whole
> series applies on top of "sc16is7xx: Fix for incorrect data being
> transmitted" [1].

The first 3 patches of this series applied.  Please rebase and resend
the remaining.

thanks,

greg k-h
