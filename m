Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E95156A697
	for <lists+linux-serial@lfdr.de>; Thu,  7 Jul 2022 17:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235842AbiGGPGV (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 7 Jul 2022 11:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235502AbiGGPGU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 7 Jul 2022 11:06:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755012F03C
        for <linux-serial@vger.kernel.org>; Thu,  7 Jul 2022 08:06:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0748E6233C
        for <linux-serial@vger.kernel.org>; Thu,  7 Jul 2022 15:06:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAFADC3411E;
        Thu,  7 Jul 2022 15:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657206378;
        bh=24sw31J/+EMXz7NqWKPRzQlFTbunmmL/bkQfoEK7nKU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RtCNpd3+PeMndLUkuE5cXh25gn04NGt54oH5zgxBqZ3FOYW4pQ6f1LiiROTcV3GBk
         ilQsDB9GlZ3JXc5QdBOMjNMAdCvceTCkYUdPhe8MfEM+KF0zdTtJvlPTsunUiYOQF8
         WWzjWJhVK1taA8+UgYWvB7b8wPbsi2SzmCqro0is=
Date:   Thu, 7 Jul 2022 17:06:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     linux-serial@vger.kernel.org,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Subject: Re: [PATCH 3/7] USB: serial: ftdi_sio: Extract SIO divisor code to
 function
Message-ID: <Ysb2Z7zrZBTduXfx@kroah.com>
References: <20220707145354.29705-1-kabel@kernel.org>
 <20220707145354.29705-4-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220707145354.29705-4-kabel@kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jul 07, 2022 at 04:53:50PM +0200, Marek Beh�n wrote:
> From: Pali Roh�r <pali@kernel.org>
> 
> As a code cleanup for future changes, extract divisor code for SIO chip
> into new function ftdi_sio_baud_to_divisor().
> 
> No functional change.
> 
> Signed-off-by: Pali Roh�r <pali@kernel.org>
> Tested-by: Marek Beh�n <kabel@kernel.org>

If you forward on patches from someone else, you too need to sign off on
them.  Please read the documentation for the details as to what that all
means.

We can't take these as-is without that, for obvious reasons.

thanks,

greg k-h
