Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74486E9246
	for <lists+linux-serial@lfdr.de>; Tue, 29 Oct 2019 22:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbfJ2Voa (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 29 Oct 2019 17:44:30 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33852 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727706AbfJ2Voa (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 29 Oct 2019 17:44:30 -0400
Received: by mail-ot1-f66.google.com with SMTP id m19so294731otp.1;
        Tue, 29 Oct 2019 14:44:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eERT633zpTpiXVAkUrSD8WDkRXUEU8DoMl3k7v69kII=;
        b=kgzLP0Jweg7tactR9I/lx5oTpXIgiSqPyNeOinutVFWqrnsw5XMdUepOLfCZir8LT+
         IAex/r9icoDISRAgwBKM5sdHEeKWytQKXHc1kZxjju+JauGyZh6vda2KFSpGj2E0Epea
         iprY4g9fK5W+K9oQW/Jnnsiiim2KszHAKg50VDkiGL1pD+Nrtu4suOqWIhH5njIJ47Sr
         EgL4RXV+MX6f79v+x9DvYZbs3L22MJVFCuyUimW6W14Z3xY0SHLARD2NWJPf+oeWoOuF
         z+I/1kGr9DOMIxYK+3S0iLZMmele8uO2TpD7wUDEoIupSa3NlsgujEWmzsLW49RFS5O3
         XMJw==
X-Gm-Message-State: APjAAAW3zKvWbZ3+t43XDvRuiSlfi0/VfT1+1z1g8eIdnTNIbUpEtdWI
        j3sOLDNc2YOTJmS0eNJpfg==
X-Google-Smtp-Source: APXvYqyoecpFPppfXsLEqIWXXUlD+Ze9wBUz1nEAtV4aAW6npe4LAXNR78CkMfncFjuo+CHl60g4kg==
X-Received: by 2002:a9d:1d2:: with SMTP id e76mr20727064ote.30.1572385469478;
        Tue, 29 Oct 2019 14:44:29 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o22sm70063otk.47.2019.10.29.14.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 14:44:28 -0700 (PDT)
Date:   Tue, 29 Oct 2019 16:44:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chunyan Zhang <chunyan.zhang@unisoc.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: Re: [PATCH 1/3] dt-bindings: serial: Add a new compatible string for
 SC9863A
Message-ID: <20191029214428.GA20706@bogus>
References: <20191025102915.23677-1-chunyan.zhang@unisoc.com>
 <20191025102915.23677-2-chunyan.zhang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025102915.23677-2-chunyan.zhang@unisoc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, 25 Oct 2019 18:29:13 +0800, Chunyan Zhang wrote:
> 
> SC9863A use the same serial device which SC9836 uses.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  Documentation/devicetree/bindings/serial/sprd-uart.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
