Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375FF56A6B5
	for <lists+linux-serial@lfdr.de>; Thu,  7 Jul 2022 17:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236048AbiGGPLN (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 7 Jul 2022 11:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236019AbiGGPLL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 7 Jul 2022 11:11:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33B726AFC
        for <linux-serial@vger.kernel.org>; Thu,  7 Jul 2022 08:11:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C980B82246
        for <linux-serial@vger.kernel.org>; Thu,  7 Jul 2022 15:11:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97AEDC3411E;
        Thu,  7 Jul 2022 15:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657206668;
        bh=2cd2PoNnTUIzUKhT1aXoamyiqoPXx51eV3bPQk5PvMg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AFhB9nXIZYJCjVs0R5f7XxQvV80J8Dc7FcO/Nv9xuUQnktawIxEAiwTgqszHaaZmS
         McUplIESKOvHgZBjl0GGyG9/vOcXnJD/Y/vXm0zbo1nYssPlKd+BkvGARKv2rcqzAl
         XRfd20z798/W9wtSNZFEy0GS6Phj3O93BywHYxaU=
Date:   Thu, 7 Jul 2022 17:11:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     linux-serial@vger.kernel.org,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Subject: Re: [PATCH 5/7] USB: serial: ftdi_sio: Fix baudrate rounding for
 ASYNC_SPD_CUST
Message-ID: <Ysb3hNJ6wPRe+oxo@kroah.com>
References: <20220707145354.29705-1-kabel@kernel.org>
 <20220707145354.29705-6-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220707145354.29705-6-kabel@kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jul 07, 2022 at 04:53:52PM +0200, Marek Behún wrote:
> From: Pali Rohár <pali@kernel.org>
> 
> Use DIV_ROUND_CLOSEST() for more accurate baudrate calculation for
> ASYNC_SPD_CUST instead of rounding it just down.

Why?  What does this change or fix?

thanks,

greg k-h
