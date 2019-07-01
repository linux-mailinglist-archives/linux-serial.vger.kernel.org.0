Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 547BA464CC
	for <lists+linux-serial@lfdr.de>; Fri, 14 Jun 2019 18:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfFNQp7 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 14 Jun 2019 12:45:59 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:32810 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfFNQp7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Jun 2019 12:45:59 -0400
Received: by mail-qt1-f195.google.com with SMTP id x2so3252507qtr.0;
        Fri, 14 Jun 2019 09:45:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tkF76/YWyBi2DNFHRTKUkXkyJ1fsnWPr1qR9pgyZkc0=;
        b=Mku7dyw/bXMHmtwe4LUJnaWM8TvuklyT+rjoYtjSN8wpTxJdYq7SJkCeF4kaaoIO62
         tFmVNrisEtRJBDWvPW5Q7OSR2cJueYZ+Hvza7y93BFD6lrGtzOit+X2MR/KziHN7ztY0
         K/S6s1e/+ps7PfELjDUe8WGL3w+XydtLc0pw1x2AgU2bE6abGAK1uxRDNmHV/aSXTXWs
         0Y92+CallBlu+mgN8klmGIOZDadLCEloE7kQ6CMocRrxR/3dOp5kqVubP1IK+TXxCSip
         /pvHC83V6vhFNHcvzJRf9c6SAuzfkllWyAY7mTdqHk88iooefBZm1sLLarK9+2PDccOV
         1YOg==
X-Gm-Message-State: APjAAAUqsJNU5b4SVF0/ncWEPQwd5kyQI22pfdh5I4q0BZS6zNpgQOri
        X8VQ+Wcd2nfpJnmbIYOA9w==
X-Google-Smtp-Source: APXvYqzeZjnaIMhoekYjI1KAjGSgD0u8xfYWVwEDuon+Prg33JgQL/mvg90QKAMLqnJN9uLyklsNNw==
X-Received: by 2002:a0c:ae5a:: with SMTP id z26mr9212014qvc.65.1560530757901;
        Fri, 14 Jun 2019 09:45:57 -0700 (PDT)
Received: from localhost ([64.188.179.243])
        by smtp.gmail.com with ESMTPSA id e8sm1819685qkn.95.2019.06.14.09.45.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 09:45:57 -0700 (PDT)
Date:   Fri, 14 Jun 2019 10:45:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nishanth Menon <nm@ti.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH 2/6] dt-bindings: serial: 8250_omap: Add compatible for
 J721E UART controller
Message-ID: <20190614164555.GA18636@bogus>
References: <20190522161921.20750-1-nm@ti.com>
 <20190522161921.20750-3-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522161921.20750-3-nm@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, 22 May 2019 11:19:17 -0500, Nishanth Menon wrote:
> J721e uses a UART controller that is compatible with AM654 UART.
> Introduce a specific compatible to help handle the differences if
> necessary.
> 
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Vignesh R <vigneshr@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> NOTE:
>  - If Greg is ok, we can pick up the uart compatibility via the k3 tree,
>    else, I can spawn it off the series into it's own patch, but it
>    seemed better in a logical order.
> 
>  Documentation/devicetree/bindings/serial/omap_serial.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
