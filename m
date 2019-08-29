Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6755BA1437
	for <lists+linux-serial@lfdr.de>; Thu, 29 Aug 2019 10:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbfH2I45 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 29 Aug 2019 04:56:57 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34413 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfH2I45 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 29 Aug 2019 04:56:57 -0400
Received: by mail-lf1-f66.google.com with SMTP id z21so1914941lfe.1
        for <linux-serial@vger.kernel.org>; Thu, 29 Aug 2019 01:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=FfP7mAa0BrormMJe3e64jyxstRSj+yfPmV3zDoXdQGg=;
        b=A/1wNtvKJVsGvzlTY7oZX4q3ZfLYJGU4zdXvHMbPAq+7zMDUSIVwLM9XslTv1tr2y7
         yObXKk2KzhOfxq+r64V58TA2EUmbDqPdugSgGYIDVimVmByTHqWPGpA4K1efwr+02kUQ
         3j/VLTJGZ5vx+CXpPLxO0k+cqZBhYLuWBXNJHRvXFaisaK9v769OsvGta0vJo6MlaQgf
         ihxS5sq1uP9NildYBC3pNjS1LveSmvlSLNkyJpqczkqVtrkKnDP1A77yMxNw+W5zVCrl
         D4rn2iXdX0fBrkvlfyt+b6nn2Gq/kAXrXdfcFZipaKJdxhsE1q8MXtyCg+m0t8739d4W
         YH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=FfP7mAa0BrormMJe3e64jyxstRSj+yfPmV3zDoXdQGg=;
        b=OERxY+xEElbjisixzqrQqlxTDdivzxPOetwIHE+2R51hMU0ui5B8qpfIIk0oii6i/t
         tYdEBNYZ/cXFiKhxdcY/UxtKavfjbESqxIJCogBW4ayOU8RwwXkBdOCKmLXDmED7U8/V
         Zwp3QDcobGoJ6CA9gfRIl3L2vgYCYOeNadObSBVUenA61L3hCE+LMCcqA7/ll3ivI/GA
         4+FR3yz06kG0NIjeYhm2NAUSOx3DIBe3oBHQHC5+f4rK46l8lei1FebONmBfLxp5W0f8
         LjDwE64Ud1BrycY3aLS4uapEkyhTqhDeTNwPjU7ffgOYAaiopKwNlVcQxQrXB4+CnwMk
         yykg==
X-Gm-Message-State: APjAAAW+NwL7CZEzQ/JpuFVCEGh6D+4XfVcuqvsE/towGMKWdK2edOf/
        eUZdtQ9VBEzbUL938ia1Q+0=
X-Google-Smtp-Source: APXvYqzLOU6PpV0+8LPZZvF7OG1riddARCSrJr1EerHtsU+mdxpToJZPLf1K9c0+FNpsAggsFjcDmA==
X-Received: by 2002:a19:8c14:: with SMTP id o20mr5413383lfd.158.1567069015709;
        Thu, 29 Aug 2019 01:56:55 -0700 (PDT)
Received: from mobilestation (mail.baikalelectronics.com. [87.245.175.226])
        by smtp.gmail.com with ESMTPSA id s7sm254739lji.26.2019.08.29.01.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 01:56:55 -0700 (PDT)
Date:   Thu, 29 Aug 2019 11:56:54 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Jan =?utf-8?Q?Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>
Cc:     linux-serial@vger.kernel.org,
        Joe Burmeister <joe.burmeister@devtank.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] tty: max310x: fix off-by-one buffer access when
 storing overrun
Message-ID: <20190829085653.kc5rlzwev4552d73@mobilestation>
References: <13ea227620aaad8a7231d42ed03a8508297d4eb3.1567027079.git.jan.kundrat@cesnet.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <13ea227620aaad8a7231d42ed03a8508297d4eb3.1567027079.git.jan.kundrat@cesnet.cz>
User-Agent: NeoMutt/20180716
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello Jan,

On Wed, Aug 28, 2019 at 07:56:26PM +0200, Jan Kundrát wrote:
> A recent change split the insertion loop into two parts. The first part
> accessed bytes 0, 1, ... (rxlen - 2), and the second part by mistake
> took offset `rxlen` instead of the correct `rxlen - 1`. So one byte was
> not stored, and the final access wrote past the end of the rx_buf.
> 
> Fixes: 9c12d739d69b (tty: max310x: Split uart characters insertion loop)
> Signed-off-by: Jan Kundrát <jan.kundrat@cesnet.cz>

Good catch, thank you!

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Sergey

> ---
>  drivers/tty/serial/max310x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> index e6c48a99bd85..0e0c2740ec7e 100644
> --- a/drivers/tty/serial/max310x.c
> +++ b/drivers/tty/serial/max310x.c
> @@ -689,7 +689,7 @@ static void max310x_handle_rx(struct uart_port *port, unsigned int rxlen)
>  		 * tail.
>  		 */
>  		uart_insert_char(port, sts, MAX310X_LSR_RXOVR_BIT,
> -				 one->rx_buf[rxlen], flag);
> +				 one->rx_buf[rxlen-1], flag);
>  
>  	} else {
>  		if (unlikely(rxlen >= port->fifosize)) {
> -- 
> 2.21.0
> 
> 
