Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11FB33BA79
	for <lists+linux-serial@lfdr.de>; Mon, 10 Jun 2019 19:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbfFJRLY (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 10 Jun 2019 13:11:24 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:44911 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728289AbfFJRLW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 10 Jun 2019 13:11:22 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id D770F448;
        Mon, 10 Jun 2019 13:11:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 10 Jun 2019 13:11:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=yeLY2xFH5wrGsiULn8I7DCAYgtm
        huelFHcLKcLlb5gA=; b=n4rYuvf204f035c9YagdqZkhrEwjBavF5hRr8uh6zYC
        aZuhQa8ShcAEjB9fNLp6eTulCsFDW+1v2YmRBG3hHpwc7Onkw7y9JTeAmuWh33yT
        XJ9tX/4hsGt9DTzXyTa6QYjhd4KpYrh3uuBKbXFEc5FXCwcD9Gwj6gBUXAKPMnOC
        f8Qxb6VK2XGUFknV2Wyg+GrG5SNoT2sFCvyUzBQMuddXIT/zDAMkl1zrq07Yktx0
        6+TOBBMKh6g6KFi5LLe2nZHqwVs6RwqADJdyIYcPCoBC3ihqq9V1wrlQ+hAjj95L
        aQzHz7WPXP/EdFmGYmo8++GSmNVDDHpt0SnFYOrkZPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=yeLY2x
        FH5wrGsiULn8I7DCAYgtmhuelFHcLKcLlb5gA=; b=jk3h/zX7FOAagjoZLtxV7C
        nQ2bBoX2VKijprA7oEuVzOKOm877K2uQkTS5FMOtOxUsbgFNAJkRV0tCPwd8jbvb
        xFSN0+zKR2KczEY/XEiZ/r6vZbx3CMXcNFgajbA0RThvggx6IanvnUX3JNzPOJxh
        aNBo8hqacBga+Zajoo7A+GuRb/ltFVGHDVhUxXtPyFBNtLS9ixQbfOrhfG8VfuJi
        gS4h28mCKdcRcCf9S3yFS1N9D5J8lVdGyVcwZVraavflAZFaL2OsMdYnitRtdXlx
        0YXSSHeDUNMHIcUHGGB0xfYa2oP8FANc5kNTzWvYn9BZXDN0cQaaGvITYLZsgqkQ
        ==
X-ME-Sender: <xms:OI_-XOmTtJunJ31xNep2pBwDt-sfytSbNvMB1UvtGx4vQ3PCVGd4Cw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrudehvddgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjfgesth
    dtredttdervdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtgho
    mheqnecukfhppeekfedrkeeirdekledruddtjeenucfrrghrrghmpehmrghilhhfrhhomh
    epghhrvghgsehkrhhorghhrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:OI_-XMXv_1bl8eqGGfwDyYIE53wfeGMHRZVwJR7MY-EtmNh6UxGa_g>
    <xmx:OI_-XKof6nRqK2BoV-gQqHXzl99_BBpJpvkQEDDmRwxGZ4MtqKE4jQ>
    <xmx:OI_-XFWDhMp8AuuhYM_XDCvezQshaf9EKE9uQV51p3PtlxueywDc_Q>
    <xmx:OI_-XKtlEP9QSbLEO8wgLWEH35u-kuuDeeb7yUFHc7rlADTtpcPz2w>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9A46780062;
        Mon, 10 Jun 2019 13:11:19 -0400 (EDT)
Date:   Mon, 10 Jun 2019 19:11:16 +0200
From:   Greg KH <greg@kroah.com>
To:     jay.dolan@accesio.com
Cc:     linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 1/1] serial: 8250: Add support for higher baud rates
 to Pericom chips
Message-ID: <20190610171116.GA22893@kroah.com>
References: <20190528035943.6274-1-jay.dolan@accesio.com>
 <20190528035943.6274-2-jay.dolan@accesio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528035943.6274-2-jay.dolan@accesio.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, May 27, 2019 at 08:59:43PM -0700, jay.dolan@accesio.com wrote:
> From: Jay Dolan <jay.dolan@accesio.com>
> 
> The Pericom chips can achieve additional baud rates by programming the
> sample clock register. The baud rates can be described as
> 921600 * 16 / (16 - scr) for scr values 5 to 15. The divisor is set to 1
> for these baud rates.
> 
> Adds new quirk for Pericom chips other than the four port chips to use
> the
> 
> Signed-off-by: Jay Dolan <jay.dolan@accesio.com>
> ---
>  drivers/tty/serial/8250/8250_pci.c | 97 ++++++++++++++++++++++++------
>  1 file changed, 79 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> index df41397de478..9a895ae449c5 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -1326,13 +1326,66 @@ static int pci_default_setup(struct serial_private *priv,
>  
>  	return setup_port(priv, port, bar, offset, board->reg_shift);
>  }
> -
> +void
> +pericom_do_set_divisor(struct uart_port *port, unsigned int baud,
> +			       unsigned int quot, unsigned int quot_frac)
> +{
> +	int scr;
> +	int lcr;
> +	int actual_baud;
> +	int tolerance;
> +
> +	for (scr = 5 ; scr <= 15 ; scr++) {
> +		actual_baud = 921600 * 16 / scr;
> +		tolerance = actual_baud / 50;
> +
> +		if ((baud < actual_baud + tolerance) &&
> +			(baud > actual_baud - tolerance)) {
> +
> +			lcr = serial_port_in(port, UART_LCR);
> +			serial_port_out(port, UART_LCR, lcr | 0x80);
> +
> +			serial_port_out(port, UART_DLL, 1);
> +			serial_port_out(port, UART_DLM, 0);
> +			serial_port_out(port, UART_PCM_SCR, 16 - scr);

This line breaks the build :(

Are you sure you tested this patch?

greg k-h
