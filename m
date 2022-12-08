Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A6064698E
	for <lists+linux-serial@lfdr.de>; Thu,  8 Dec 2022 08:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiLHHLZ (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 8 Dec 2022 02:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLHHLY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 8 Dec 2022 02:11:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435542AC61
        for <linux-serial@vger.kernel.org>; Wed,  7 Dec 2022 23:11:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CEC4EB8212D
        for <linux-serial@vger.kernel.org>; Thu,  8 Dec 2022 07:11:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD69C433C1;
        Thu,  8 Dec 2022 07:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670483481;
        bh=5xOfxYgodqXqUBqH63LDMZaTapmWezVIx72PYv8B+ys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qLQ+BILW437L3NzKnEqYNo+zZbHLLc4DyorNQ7fHXSX6C5A5QkFhG1KkXo4y8VWp5
         Ls6bBtJUn5mHWhWEY4z4YrixjIBEPYZigfYLBwaJmMBrDz+YgVmtuJCOxa3UyGm2iO
         EjQGe14T+WFFkKAgiLUriqgbQDSCWqfu5GteXzXg=
Date:   Thu, 8 Dec 2022 08:11:18 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christina Quast <contact@christina-quast.de>
Cc:     linux-serial@vger.kernel.org,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Daniel Beer <daniel.beer@igorinstitute.com>
Subject: Re: [PATCH tty-next 1/3] hid-ft260: Cleanup macro formatting
Message-ID: <Y5GOFsuirrWl3C5i@kroah.com>
References: <20221207215540.114920-1-contact@christina-quast.de>
 <20221207215540.114920-2-contact@christina-quast.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221207215540.114920-2-contact@christina-quast.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Dec 07, 2022 at 10:55:38PM +0100, Christina Quast wrote:
> Signed-off-by: Christina Quast <contact@christina-quast.de>
> Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Cc: Daniel Beer <daniel.beer@igorinstitute.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/hid/hid-ft260.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

I can't take patches without any changelog text at all, sorry.

greg k-h
