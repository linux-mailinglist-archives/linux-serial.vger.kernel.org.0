Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20C56E576C
	for <lists+linux-serial@lfdr.de>; Sat, 26 Oct 2019 02:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbfJZAO4 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 25 Oct 2019 20:14:56 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37374 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfJZAO4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 25 Oct 2019 20:14:56 -0400
Received: by mail-ot1-f66.google.com with SMTP id 53so3244364otv.4;
        Fri, 25 Oct 2019 17:14:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b/fqKzX/vnTAVXMLKRT3D/CXlKeMTuTH7nGknDqJCHE=;
        b=CwOqd67V71iNrl5V4cIF+g+AdlF8RlHY2SG/VJwNNedOX/kG1pyhl7oRKKHuH7ID0s
         hFQB725lMDfiNZK8hfX7cQ6K8QEtoIvA4V7t6h7tmoXCiGj29WZPfBnTSizKqfqr6YjP
         QUZzT6lxC9izWhqJ9jsOVwQRckP50BgOsjTLJTOTVF6ooF0v/splhQewm1fzPNs19Bv2
         3zt3TKdRDKRQX7Af+KuHwrXcQcGzXef3Nz03DE+57Z7rOFXOFS1IYzjVY5yzHe0WSMeM
         kuTF/iNBTHJrClvthZ4IM5YOQGE3JY9Dj5Guq9SOexGVMeYDvlHDUjnB6fKPWRv0A+n9
         EnLQ==
X-Gm-Message-State: APjAAAVhCVe38/FBA/hGaXj61XG9V9cTQML3opZjkAP6mMwoiCrkLmoK
        KrjckWoRaWi0D7LAtZhZQg==
X-Google-Smtp-Source: APXvYqyK0gWiKJACY34bQRCBt53yRAiREV/XUoMTHmacL7PgkxZyfxgYB+13H3jFjEqEmo1FjWtfIQ==
X-Received: by 2002:a9d:721c:: with SMTP id u28mr4945875otj.359.1572048894172;
        Fri, 25 Oct 2019 17:14:54 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c21sm1218018otp.15.2019.10.25.17.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 17:14:53 -0700 (PDT)
Date:   Fri, 25 Oct 2019 19:14:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mateusz Holenko <mholenko@antmicro.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, Stafford Horne <shorne@gmail.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Filip Kokosinski <fkokosinski@internships.antmicro.com>,
        Joel Stanley <joel@jms.id.au>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] dt-bindings: serial: document LiteUART bindings
Message-ID: <20191026001452.GA2522@bogus>
References: <20191023114634.13657-0-mholenko@antmicro.com>
 <20191023114634.13657-3-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023114634.13657-3-mholenko@antmicro.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, 23 Oct 2019 11:47:14 +0200, Mateusz Holenko wrote:
> From: Filip Kokosinski <fkokosinski@internships.antmicro.com>
> 
> Add documentation for LiteUART devicetree bindings.
> 
> Signed-off-by: Filip Kokosinski <fkokosinski@internships.antmicro.com>
> Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
> ---
> Changes in v2:
> - binding description rewritten to a yaml schema file
> - added interrupt line
> - fixed unit address
> - patch number changed from 2 to 3
> 
>  .../bindings/serial/litex,liteuart.yaml       | 38 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/litex,liteuart.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
