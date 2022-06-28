Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA38D55E7BC
	for <lists+linux-serial@lfdr.de>; Tue, 28 Jun 2022 18:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345948AbiF1Nvm (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 28 Jun 2022 09:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345906AbiF1Nvm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 28 Jun 2022 09:51:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F392CE3B;
        Tue, 28 Jun 2022 06:51:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9CED618F7;
        Tue, 28 Jun 2022 13:51:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83AF6C3411D;
        Tue, 28 Jun 2022 13:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656424300;
        bh=tavwUDptky926TBvCoHB46pswP2jEsYYHlFbhtrikbY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nlAkrFvSDeqAOF4EqhNtymAfoIea1Fm0mYKul9EXHS817F1aLRvx3/MYMEA9mve7u
         qKiEcgm5UhoCUFY8XntpnIlprm0uW8B1wLDCftkp7cu1m2x9SUgJ4XuTJvZ1Yvav8n
         3Gf34qvdER1x6h4h1AXSF5V15uK208DHdc/Y2oXA=
Date:   Tue, 28 Jun 2022 15:51:37 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chanho Park <chanho61.park@samsung.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Hector Martin <marcan@marcan.st>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] tty: serial: samsung_tty: loopback mode support
Message-ID: <YrsHaUqM03I6I9Om@kroah.com>
References: <CGME20220628124300epcas2p45f1e3a7051bb93ecba778cf7d96720d3@epcas2p4.samsung.com>
 <20220628124050.144398-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628124050.144398-1-chanho61.park@samsung.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jun 28, 2022 at 09:40:50PM +0900, Chanho Park wrote:
> Internal loopback mode can be supported by setting
> UCON register's Loopback Mode bit. The mode & bit can be supported since
> s3c2410 and later SoCs. The prefix of LOOPBACK / BIT(5) naming should be
> also changed to S3C2410_ to avoid confusion.
> 
> We can test it by linux-serial-test program
> with -k option. The tool will set TIOCM_LOOP mode when the option is
> specified.
> -k, --loopback     Use internal hardware loop back

Again, what does this line mean in a changelog text?

And properly wrap your lines at 72 columns.

thanks,

greg k-h
