Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06BCD18078D
	for <lists+linux-serial@lfdr.de>; Tue, 10 Mar 2020 20:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgCJTA4 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 10 Mar 2020 15:00:56 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35183 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgCJTA4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 Mar 2020 15:00:56 -0400
Received: by mail-ot1-f67.google.com with SMTP id k26so7009514otr.2;
        Tue, 10 Mar 2020 12:00:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xrW22r5IgXxjJkco6J5hYgaefJp0zEugXeX1yVtVQQw=;
        b=nDe7Txj8c6ZVlxCTNX/6qnRJf+Ajbm7bdQcfFpmHvuG5OHw2vvtUPoYkXxKqiF29T8
         CGiXim6wzdsK6n6aYYUT4WJPs6j7iyw9RqzgukBTOURP+VeSkrzktZEl1atuT5Dgb0Cr
         /qNieTYgu/Y2P0FSJ7/jyNkcfKgya3irdc/fgJvH5B9WhYTpbJBdjv7RdW6yy7ru4X9I
         gfO24Nl56mgsPOIvuUmUgVHbTH0dmQwV3/uBVsYmcFjkP2i2+NQrAlztNox49o1PTqwg
         IS+26UMMGDTdLekMoKoefpq4lJpIcdh+9N4g6sm3ZMLU6GNZtX8/x8rM/7tqK7QOBq0p
         0kHw==
X-Gm-Message-State: ANhLgQ0uPPrH6qgQQSdExnK6QWGcDNHeuxE7n8dOrOM21JJ2Uwt3oTry
        2VoxuKrnR4C4GGOGNJCEWg==
X-Google-Smtp-Source: ADFU+vsTVy/bN+/Yx0XnJKlcuYj2yXiLOzpK+Ll/Tq1shrnyv0KxkX3AgutsfYoYbIbd8kIetQiYeA==
X-Received: by 2002:a9d:4c10:: with SMTP id l16mr6789936otf.109.1583866855618;
        Tue, 10 Mar 2020 12:00:55 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 187sm3993505oii.35.2020.03.10.12.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 12:00:55 -0700 (PDT)
Received: (nullmailer pid 2887 invoked by uid 1000);
        Tue, 10 Mar 2020 19:00:54 -0000
Date:   Tue, 10 Mar 2020 14:00:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Martin Devera <devik@eaxlabs.cz>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Martin Devera <devik@eaxlabs.cz>
Subject: Re: [PATCH 2/2] dt-bindings: serial: Add st,swap to stm32-usart
Message-ID: <20200310190054.GA2826@bogus>
References: <20200229160507.31309-1-devik@eaxlabs.cz>
 <20200229160507.31309-2-devik@eaxlabs.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200229160507.31309-2-devik@eaxlabs.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, 29 Feb 2020 17:05:07 +0100, Martin Devera wrote:
> Add new st,swap property to allow for RX & TX pin swapping.
> 
> Signed-off-by: Martin Devera <devik@eaxlabs.cz>
> ---
>  Documentation/devicetree/bindings/serial/st,stm32-usart.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
