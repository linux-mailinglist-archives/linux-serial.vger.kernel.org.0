Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1154956A7CE
	for <lists+linux-serial@lfdr.de>; Thu,  7 Jul 2022 18:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236148AbiGGQN3 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 7 Jul 2022 12:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236155AbiGGQMz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 7 Jul 2022 12:12:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F024D14F
        for <linux-serial@vger.kernel.org>; Thu,  7 Jul 2022 09:12:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2F56623E3
        for <linux-serial@vger.kernel.org>; Thu,  7 Jul 2022 16:12:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6603C3411E;
        Thu,  7 Jul 2022 16:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657210349;
        bh=bMoPPyIPT5vc17Mq+LS2ol1HSBnTgt2gb0OIwQhmQiQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CGLEcdaYt5Ar/3e98YJed+VMRNdsh54d/8k5wQtPkYE8LBI1sGGxNBMkoh8zJTUWr
         k2ML9qynO6IefhExsaTTOK7MmCu0dKOFCq89WZnzVDyl0i4HXVqQNINLhNvhFf0xes
         MuYKsILHoSC0ED8PmLdqiecmP70X1RWOU/0Jm/Tc=
Date:   Thu, 7 Jul 2022 18:12:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     linux-serial@vger.kernel.org,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Subject: Re: [PATCH 5/7] USB: serial: ftdi_sio: Fix baudrate rounding for
 ASYNC_SPD_CUST
Message-ID: <YscF6pONFktLx3el@kroah.com>
References: <20220707145354.29705-1-kabel@kernel.org>
 <20220707145354.29705-6-kabel@kernel.org>
 <Ysb3hNJ6wPRe+oxo@kroah.com>
 <20220707180818.53b7e79a@dellmb>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220707180818.53b7e79a@dellmb>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jul 07, 2022 at 06:08:18PM +0200, Marek Beh�n wrote:
> On Thu, 7 Jul 2022 17:11:00 +0200
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > On Thu, Jul 07, 2022 at 04:53:52PM +0200, Marek Beh�n wrote:
> > > From: Pali Roh�r <pali@kernel.org>
> > > 
> > > Use DIV_ROUND_CLOSEST() for more accurate baudrate calculation for
> > > ASYNC_SPD_CUST instead of rounding it just down.  
> > 
> > Why?  What does this change or fix?
> 
> To compute more accurate baudrate when given custom divisor.
> 
> User requests a baudrate B.
> Application uses old API, so it computes divisor D for baudrate B.
> The driver then tries to compute back the requested baudrate B. To
> compute it back more accurately, rounding to closes value should be
> used.

Then please describe this in the changelog text, don't make us guess...
