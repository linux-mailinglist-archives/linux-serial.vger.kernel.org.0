Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 788EF9F164
	for <lists+linux-serial@lfdr.de>; Tue, 27 Aug 2019 19:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730260AbfH0RVZ (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 27 Aug 2019 13:21:25 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40659 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfH0RVZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 27 Aug 2019 13:21:25 -0400
Received: by mail-oi1-f195.google.com with SMTP id h21so15575869oie.7;
        Tue, 27 Aug 2019 10:21:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TzlJDZhfydcuzWtj1D7/gRqYXuI2l2jfwe/r2X4rP3M=;
        b=OvSbg1yT/HuD8oA+hIa0M8/+MdEpQZbyQcBcNq52Rxmouti1Lfo0sabuvuWjg+Ef6Q
         vicggjHmw+kV/TeiUI/CgbkZeizFJu2YAqd5Oy4mB8c1sCzeOOpheUXmHMLnXHXjms4t
         ZYmDWwy0BeEwL7Z99+7BZG5EmaTfjKuzRmuj4f5vtma2A4zwCxa+mJgG83VlFr//KSCC
         sOmcL9yVGGFTzYEfV75Ml1HG53fmAPofV0oTwLDLP5tlwPyFru6cvawS8vtL+hb8T5VW
         u6VEvZdCQMCUFZ/4mxfZ7y8Ie3YBnbCq0PDS/KDeTxisvakQFj8x2zH+7v530qlD9qbx
         jPHA==
X-Gm-Message-State: APjAAAXcXu0Kp+f8fRNG3kGcCSMht0VqFj5zfYAvWSOHxea6//dYx6Ut
        az2kw6d0IRgQwS6pNHl08w==
X-Google-Smtp-Source: APXvYqy+H7o5a8N4vxEpSqDTDlgH+Ol5wAX4ZBBqVE7CxT5zNQaPDyao/XH6eHuHK9kVhBPiUlnqBw==
X-Received: by 2002:aca:b808:: with SMTP id i8mr11296oif.68.1566926484296;
        Tue, 27 Aug 2019 10:21:24 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d27sm5476692otf.25.2019.08.27.10.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 10:21:23 -0700 (PDT)
Date:   Tue, 27 Aug 2019 12:21:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        gregkh@linuxfoundation.org, mark.rutland@arm.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com, qi-ming.wu@intel.com,
        cheol.yong.kim@intel.com, rahul.tanwar@intel.com,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: serial: lantiq: Convert to YAML
 schema
Message-ID: <20190827172123.GA9417@bogus>
References: <cover.1566370151.git.rahul.tanwar@linux.intel.com>
 <b8e0fa2981176dba29cd8e29f14532501cf962b4.1566370151.git.rahul.tanwar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8e0fa2981176dba29cd8e29f14532501cf962b4.1566370151.git.rahul.tanwar@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, 21 Aug 2019 15:06:51 +0800, Rahul Tanwar wrote:
> Convert the existing DT binding document for Lantiq SoC ASC serial controller
> from txt format to YAML format.
> 
> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
> ---
>  .../devicetree/bindings/serial/lantiq,asc.yaml     | 55 ++++++++++++++++++++++
>  .../devicetree/bindings/serial/lantiq_asc.txt      | 31 ------------
>  2 files changed, 55 insertions(+), 31 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/serial/lantiq,asc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/serial/lantiq_asc.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
