Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 776B81636DE
	for <lists+linux-serial@lfdr.de>; Wed, 19 Feb 2020 00:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbgBRXHG (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 18 Feb 2020 18:07:06 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44747 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgBRXHG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 Feb 2020 18:07:06 -0500
Received: by mail-ot1-f67.google.com with SMTP id h9so21232631otj.11;
        Tue, 18 Feb 2020 15:07:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oQ6HXMPbNstVZuD1oSRD2QgxoQ585LC4t0FY+ch2UdQ=;
        b=sLrAn+SdvZUK+3Ho9ScthnH6nCvhU5U203brIOvYMXLDvEqnvMwOerAvPA+Dul8f2Q
         ljPvblJ0w6mRUa+9QgUJp1R+6/jmxzjm5inIFKCqBciC8oZoMLZF6Auy4iRIePEtx6Cc
         a8XOCE4vk9VneGpnXkdpM3yZaAYMGtNTcxxdd33N+k6h6YPwXKaEGmeh5rO37BimQxMr
         q1l6cc5CRgE7rUnRhHGOysxQsKj/KIKXcSglfKXiqtF7eIJIvJHD9GBCQkPBFceGys+S
         1btDqXcH7caK5DDFSL17XZyaATEjGHLpH4K9NrpMyO5DCV7AlK2sRM4TuwyNPknel7co
         qKMA==
X-Gm-Message-State: APjAAAWBOoO2o6N8JalYHZfqGIezX5no1KfXG7AJwxASJhOGZH29c5O1
        bpR1xNPxPKblww6OXw2Vxw==
X-Google-Smtp-Source: APXvYqwTxpV4kU3tx4nRPN+zr0+mHQXxJJeyx9lcbPQZBLTy5xUUG/tMPRzXr3oe6dw4/n0WRnn4yA==
X-Received: by 2002:a05:6830:1251:: with SMTP id s17mr15204599otp.108.1582067225496;
        Tue, 18 Feb 2020 15:07:05 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p24sm1820339otq.64.2020.02.18.15.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 15:07:04 -0800 (PST)
Received: (nullmailer pid 16645 invoked by uid 1000);
        Tue, 18 Feb 2020 23:07:04 -0000
Date:   Tue, 18 Feb 2020 17:07:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     George Hilliard <ghilliard@kopismobile.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        George Hilliard <ghilliard@kopismobile.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>, kernel@pengutronix.de
Subject: Re: [PATCH v3 1/2] dt-bindings: serial: document fsl,inverted-tx and
 -rx options
Message-ID: <20200218230704.GA16589@bogus>
References: <20200212163538.3006-1-ghilliard@kopismobile.com>
 <20200212163538.3006-2-ghilliard@kopismobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212163538.3006-2-ghilliard@kopismobile.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, 12 Feb 2020 10:35:37 -0600, George Hilliard wrote:
> Add a description for the new fsl,inverted-tx and fsl,inverted-rx
> options for the i.MX UART peripheral.
> 
> Signed-off-by: George Hilliard <ghilliard@kopismobile.com>
> ---
> v1..v2: Removed confidentiality spam
> 
>  Documentation/devicetree/bindings/serial/fsl-imx-uart.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
