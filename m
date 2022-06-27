Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15A155C308
	for <lists+linux-serial@lfdr.de>; Tue, 28 Jun 2022 14:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236213AbiF0Mj2 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 27 Jun 2022 08:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234976AbiF0Mj1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 Jun 2022 08:39:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC241DFE;
        Mon, 27 Jun 2022 05:39:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6766E61004;
        Mon, 27 Jun 2022 12:39:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47960C3411D;
        Mon, 27 Jun 2022 12:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656333565;
        bh=ZnWpSOiSOj0QVZ0k9JieiGzuTBhurNcyR6fM1Su+ZT4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FX2/TwKw5z+EEBKy+Adrchc9L29Buf0efUPFoEuuIxhfulnVktJFgRUi5IkcD+gcF
         Y8b7uSRKqdjoPSDwwdjD6Zp9ABTB+fawDin9rTcFdBzuotFu3SrdUpAixm4x/u35+b
         pI0+9eKwRMP5xdmwntydhpnsunVOJu/hYv/YxAew=
Date:   Mon, 27 Jun 2022 14:39:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chanho Park <chanho61.park@samsung.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Hector Martin <marcan@marcan.st>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] tty: serial: samsung_tty: loopback mode support
Message-ID: <Yrmk+/2CqrBXcqAT@kroah.com>
References: <CGME20220627032556epcas2p26c2cd2786888a5018607bf651bc5dec0@epcas2p2.samsung.com>
 <20220627032353.8868-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627032353.8868-1-chanho61.park@samsung.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Jun 27, 2022 at 12:23:53PM +0900, Chanho Park wrote:
> Internal loopback mode can be supported by setting
> S3C2443_UCON_LOOPBACK bit. The mode & bit can be supported since
> s3c2410 and later SoCs. We can test it by linux-serial-test program[1]
> with -k option. It will set TIOCM_LOOP mode during test.
> 
> -k, --loopback     Use internal hardware loop back

I do not understand this line in the changelog text, what is it for?

> 
> [1]: https://github.com/cbrake/linux-serial-test
> Signed-off-by: Chanho Park <chanho61.park@samsung.com>

Our tools require a blank line before the signed-off-by line.  Did you
not get a warning when checking this patch before sending it out?

Also, no need for a footnote in a changelog that is so short, just put
the link in the body of the text itself.

thanks,

greg k-h
