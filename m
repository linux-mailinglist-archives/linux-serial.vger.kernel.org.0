Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2082B4C87D6
	for <lists+linux-serial@lfdr.de>; Tue,  1 Mar 2022 10:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbiCAJ2y (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 1 Mar 2022 04:28:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233720AbiCAJ2y (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 1 Mar 2022 04:28:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1195C10FE3;
        Tue,  1 Mar 2022 01:28:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1CB5615C6;
        Tue,  1 Mar 2022 09:28:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D232DC340EE;
        Tue,  1 Mar 2022 09:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646126893;
        bh=G6h8jszAwYJPPcXy+BDianvBzTvPr+OQ1EdUgeja2xQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dAfQCTgP3bk1zhk4X2i5oeFmoouu+iJ1CL8pd88ePBLQQePKvG8AFws3eFsKA+OwP
         +MQ82Y5E+BxIE6q1f1rpb4Bq/kMoCFBId2/Igq+cXxIwhTTFOEMKkBcWcMVMIO/cGJ
         HEd7igpOy1BgOX16Q8WZmqzwpOv2agHrLEIDe1SgKClWxAcqkwPt85XswWRieW+fGx
         CoSP3TYviCMhdo+vb6OIFWPomhlOKW5sBi1fewOhliFYFJ3DlNfqx30xXno1yXJkDB
         1VjskLB8oMilTw5U1nATo39sN1fXCNI8U/j2dXWlZRjFs/aLTvRkp/LUlOBqE4Tsq+
         wFKclcljWjKHQ==
Received: by pali.im (Postfix)
        id F1988C77; Tue,  1 Mar 2022 10:28:09 +0100 (CET)
Date:   Tue, 1 Mar 2022 10:28:09 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] serial: mvebu-uart: fix return value check in
 mvebu_uart_clock_probe()
Message-ID: <20220301092809.lobuk4u4mfgo4t4p@pali>
References: <20220301075806.3950108-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220301075806.3950108-1-weiyongjun1@huawei.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tuesday 01 March 2022 07:58:06 Wei Yongjun wrote:
> In case of error, the function devm_ioremap() returns NULL pointer
> not ERR_PTR(). The IS_ERR() test in the return value check should
> be replaced with NULL test.

Ou, that is really truth.

Reviewed-by: Pali Rohár <pali@kernel.org>

> Fixes: b7e2b5360f9b ("serial: mvebu-uart: implement UART clock driver for configuring UART base clock")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/tty/serial/mvebu-uart.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
> index 2e9263888ddc..45976e2140d4 100644
> --- a/drivers/tty/serial/mvebu-uart.c
> +++ b/drivers/tty/serial/mvebu-uart.c
> @@ -1382,8 +1382,8 @@ static int mvebu_uart_clock_probe(struct platform_device *pdev)
>  	 */
>  	uart_clock_base->reg1 = devm_ioremap(dev, res->start,
>  					     resource_size(res));
> -	if (IS_ERR(uart_clock_base->reg1))
> -		return PTR_ERR(uart_clock_base->reg1);
> +	if (!uart_clock_base->reg1)
> +		return -ENOMEM;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>  	if (!res) {
> @@ -1401,8 +1401,8 @@ static int mvebu_uart_clock_probe(struct platform_device *pdev)
>  	 */
>  	uart_clock_base->reg2 = devm_ioremap(dev, res->start,
>  					     resource_size(res));
> -	if (IS_ERR(uart_clock_base->reg2))
> -		return PTR_ERR(uart_clock_base->reg2);
> +	if (!uart_clock_base->reg2)
> +		return -ENOMEM;
>  
>  	hw_clk_data = devm_kzalloc(dev,
>  				   struct_size(hw_clk_data, hws,
> 
