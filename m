Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDF41C7AD5
	for <lists+linux-serial@lfdr.de>; Wed,  6 May 2020 21:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgEFT7V (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 6 May 2020 15:59:21 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37407 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbgEFT7T (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 6 May 2020 15:59:19 -0400
Received: by mail-oi1-f194.google.com with SMTP id r25so2911507oij.4;
        Wed, 06 May 2020 12:59:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bO0DJaCUE0XKssvRg38lswObA4y7SjfSv2q1CR1u7z0=;
        b=Gi5chG4/JpnzOfFxkdDoZ4tjGs17v118ckN6didtg16/EukLeaUZD1bs0kTOLQTNCN
         Rqb1wUSdD6GEKn51f1TKUlENsLIRR4fUYPfuV4M7TP/e2Duw5Pjga7J6aJmNUGv+Zaor
         grWff5+9uuBFQyVK2xszT3oWyi3/z88h2m30b8AIQ2n19+XSnSFyNIQ0YLFnwhO6G82/
         4C4SjypEnAFUqaxnNkyVGrwuVW/InwdW5YWYn38kLkZ4XUVjXWoQO+zM4Uk7j+S12DRo
         IbnVmgarOVVFIprodTFa8xi8S7YS1w63iJGVgjx1GdXHpYxaHMFApB8Kx37y7LVJQ5vm
         H7NA==
X-Gm-Message-State: AGi0PuaGD3GtV4Sry6aedSWGhlFBou6gceYwDs+6nN3eDoWBah2+yeFP
        cF4vPf9BmRsY06gMbuvF/w==
X-Google-Smtp-Source: APiQypLR5WjjYamVAcv6tfzD1IA0+5vseecA/FXkvzZpzsWL3ae3CrTRLxA9Orkli3Z7VBOdSdow2Q==
X-Received: by 2002:a54:4811:: with SMTP id j17mr3960001oij.29.1588795158503;
        Wed, 06 May 2020 12:59:18 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e13sm767826otj.46.2020.05.06.12.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 12:59:17 -0700 (PDT)
Received: (nullmailer pid 22166 invoked by uid 1000);
        Wed, 06 May 2020 19:59:16 -0000
Date:   Wed, 6 May 2020 14:59:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     mani@kernel.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com,
        linux-serial@vger.kernel.org, fabrice.gasnier@st.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/2] dt-bindings: serial: Document CTS/RTS gpios in
 STM32  UART
Message-ID: <20200506195916.GA22126@bogus>
References: <20200420170204.24541-1-mani@kernel.org>
 <20200420170204.24541-2-mani@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420170204.24541-2-mani@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, 20 Apr 2020 22:32:03 +0530, mani@kernel.org wrote:
> From: Manivannan Sadhasivam <mani@kernel.org>
> 
> Document the use of CTS/RTS gpios for flow control in STM32 UART
> controller. These properties can be used instead of 'st,hw-flow-ctrl'
> for making use of any gpio pins for flow control instead of dedicated
> pins. It should be noted that both CTS/RTS and 'st,hw-flow-ctrl'
> properties cannot co-exist in a design.
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
> ---
>  .../devicetree/bindings/serial/st,stm32-uart.yaml  | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
