Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962E94BF9AE
	for <lists+linux-serial@lfdr.de>; Tue, 22 Feb 2022 14:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiBVNn7 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 22 Feb 2022 08:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232514AbiBVNn5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 22 Feb 2022 08:43:57 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1898D11EF01;
        Tue, 22 Feb 2022 05:43:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8AF2CCE13DF;
        Tue, 22 Feb 2022 13:43:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F88C340F3;
        Tue, 22 Feb 2022 13:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645537408;
        bh=V/2qJf6ZSP+uTte+Ubn4pjXBAwZwpHS/NoeabPxxVms=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aVH2J2O49f9Cjfw5rYL2uMu1kLLhVC462OLd1wMAWEldVw7hJYnxiYXmbDw+/PG3F
         +S709lSu2U86PEtO46A/Y/0DqKmSRe3kInlB7KlziSZ8DBgi87ZUaC8OyUO5cDtKrX
         Yd8vTikmfFpxW+ZYJUT89bdnFCUJsAdcVPMC4Fvg=
Date:   Tue, 22 Feb 2022 14:43:25 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-ia64@vger.kernel.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Subject: Re: [PATCH 0/2] termbits.h cleanup
Message-ID: <YhTofdw8JhkKAt8c@kroah.com>
References: <20220222115604.7351-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220222115604.7351-1-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Feb 22, 2022 at 01:56:02PM +0200, Ilpo J�rvinen wrote:
> Two simple cleanup patches to termbits.h. I prefer these to go
> in through tty-next as I've some other work based on them that
> I'll submit later.
> 
> Ilpo J�rvinen (2):
>   ia64: termbits.h is identical to asm-generic one
>   xtensa: termbits.h is identical to asm-generic one
> 
>  arch/ia64/include/uapi/asm/termbits.h   | 209 ----------------------
>  arch/xtensa/include/uapi/asm/termbits.h | 221 ------------------------
>  2 files changed, 430 deletions(-)
>  delete mode 100644 arch/ia64/include/uapi/asm/termbits.h
>  delete mode 100644 arch/xtensa/include/uapi/asm/termbits.h
> 
> -- 
> 2.30.2
> 

Sure, I'll be glad to take them, thanks!

greg k-h
