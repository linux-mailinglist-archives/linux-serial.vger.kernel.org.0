Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC0B0B55CF
	for <lists+linux-serial@lfdr.de>; Tue, 17 Sep 2019 20:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729763AbfIQS7m (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 17 Sep 2019 14:59:42 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35636 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfIQS7m (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 17 Sep 2019 14:59:42 -0400
Received: by mail-ot1-f68.google.com with SMTP id z6so4064280otb.2;
        Tue, 17 Sep 2019 11:59:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OGt11jcTV4+nEwNY8mFGWxFr7o7axon1ADE+8rl/MVY=;
        b=HoB6IlYt/NZr9FEpxKjunsJx4qB1EmU7q8/zknxsOUIojSUF92a9Fsui4JCphZ/8Ve
         1S2d1dsNumB+G4AxtmnP29/vG4f9GLzJ3O8GfXF/6r3W87IsSpTSaeEVrvGxPHaC7pVS
         8n71fxjZq5ZfXTlVrHhnJkDmc1GbUTSs+KE6yaFbXiXuJ5kJWbHWKOAadn2ZkkP2Nl5y
         LnLKBTIk0/qzHqQY5R5DELRCYAM0ymqSEFZOi0JMA3LfDewmcFD98ZHkcOJ5a8hYilcy
         +qVnjgw/utUtIzw0gOWx7PABB3zLV3+1C9VYY+cM5gvGR+0GMVqmkZIZvVFJ/Sx3bSRK
         wr9w==
X-Gm-Message-State: APjAAAX3GiGDvH5LNAQKOlw5CNdyoajaZJ14VkuqjAbo/xnolWOuz4kQ
        xfqs/c6JNGDy1FlTKWxiIA==
X-Google-Smtp-Source: APXvYqzRk2LhCglVMO/W5uafIlAuiwWW96jddRxz2JFxKqZkzHLQP9MO0dW7aSqfvaH7/hTZGTVnmg==
X-Received: by 2002:a9d:30c8:: with SMTP id r8mr316477otg.158.1568746781626;
        Tue, 17 Sep 2019 11:59:41 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 109sm963555otc.52.2019.09.17.11.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 11:59:41 -0700 (PDT)
Date:   Tue, 17 Sep 2019 13:59:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Oskar Senft <osk@google.com>
Cc:     joel@jms.id.au, andrew@aj.id.au, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, jk@ozlabs.org,
        openbmc@lists.ozlabs.org, linux-aspeed@lists.ozlabs.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        Oskar Senft <osk@google.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: serial: 8250: Add
 aspeed,sirq-polarity-sense.
Message-ID: <20190917185940.GA4964@bogus>
References: <20190905144130.220713-1-osk@google.com>
 <20190905144130.220713-2-osk@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905144130.220713-2-osk@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu,  5 Sep 2019 10:41:29 -0400, Oskar Senft wrote:
> Add documentation for 8250_aspeed_vuart's aspeed,sirq-polarity-sense
> property that enables to auto-configure the VUART's SIRQ polarity.
> 
> Signed-off-by: Oskar Senft <osk@google.com>
> ---
>  Documentation/devicetree/bindings/serial/8250.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
