Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7CFA5826
	for <lists+linux-serial@lfdr.de>; Mon,  2 Sep 2019 15:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731391AbfIBNjg (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 2 Sep 2019 09:39:36 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36487 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731259AbfIBNjQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 2 Sep 2019 09:39:16 -0400
Received: by mail-wm1-f67.google.com with SMTP id p13so14704185wmh.1;
        Mon, 02 Sep 2019 06:39:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ngzz2+0c/jv3SRVMmnFYIH53w6JSEj4AGmcVRCCY2d0=;
        b=dMvvqHaOWij3qBN2cUYpxdPKSywFhinZVrHUXB8MiGsd/SaZstCyjcrm9E5jthc6ge
         LNR+G63jaqu+TR8EFaRLs4uLiOw6Itz4lKIY0imHDX2kI9Avp7vi7kOlNJQryWXnCmNb
         fFSBXor0hJ57eIsz60izjx0Mmq8CU/pMEawwm6QxWZZMdqssLdW7tMedL3bRiIU+nHa6
         uhrRl7OfVA3vcemt5agF089J6QOVBx//x8TYBNeGdEmJmY9z0GrY5Wu13qZY+sahrNGk
         1RcFbjBweukSOY8Z+sz+wQN9Cke/S4Yt07mRvoL3Ut1UhjaJE/Z+wUrnKNZdT+Z/dNqL
         E4kw==
X-Gm-Message-State: APjAAAV/oh0wmBqR8PUKqUPdNN3NUU0q8+iRknnouvQ69AifYcjPdM3o
        J+w/hq3cU+xO3eOpruF+hA==
X-Google-Smtp-Source: APXvYqw1xeIt9IrWtmGbP4r+M7qtMVUSdcA2xRPxZ8mz4CDhRECunDIbi/BMLIMgry30fnWUNBjcwg==
X-Received: by 2002:a7b:cb51:: with SMTP id v17mr34925999wmj.118.1567431553507;
        Mon, 02 Sep 2019 06:39:13 -0700 (PDT)
Received: from localhost ([212.187.182.166])
        by smtp.gmail.com with ESMTPSA id z21sm2865531wmf.30.2019.09.02.06.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 06:39:13 -0700 (PDT)
Message-ID: <5d6d1b81.1c69fb81.7eabb.cabd@mx.google.com>
Date:   Mon, 02 Sep 2019 14:39:12 +0100
From:   Rob Herring <robh@kernel.org>
To:     Pragnesh Patel <pragnesh.patel@sifive.com>
Cc:     palmer@sifive.com, paul.walmsley@sifive.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: serial: Convert riscv,sifive-serial to
 json-schema
References: <1567321765-3738-1-git-send-email-pragnesh.patel@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567321765-3738-1-git-send-email-pragnesh.patel@sifive.com>
X-Mutt-References: <1567321765-3738-1-git-send-email-pragnesh.patel@sifive.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Sep 01, 2019 at 12:39:21PM +0530, Pragnesh Patel wrote:
> Convert the riscv,sifive-serial binding to DT schema using json-schema.
> 
> Signed-off-by: Pragnesh Patel <pragnesh.patel@sifive.com>
> ---
>  .../devicetree/bindings/serial/sifive-serial.txt   | 33 ------------
>  .../devicetree/bindings/serial/sifive-serial.yaml  | 62 ++++++++++++++++++++++
>  2 files changed, 62 insertions(+), 33 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/sifive-serial.txt
>  create mode 100644 Documentation/devicetree/bindings/serial/sifive-serial.yaml
> 
> diff --git a/Documentation/devicetree/bindings/serial/sifive-serial.txt b/Documentation/devicetree/bindings/serial/sifive-serial.txt
> deleted file mode 100644
> index c86b1e5..0000000
> --- a/Documentation/devicetree/bindings/serial/sifive-serial.txt
> +++ /dev/null
> @@ -1,33 +0,0 @@
> -SiFive asynchronous serial interface (UART)
> -
> -Required properties:
> -
> -- compatible: should be something similar to
> -	      "sifive,<chip>-uart" for the UART as integrated
> -	      on a particular chip, and "sifive,uart<version>" for the
> -	      general UART IP block programming model.	Supported
> -	      compatible strings as of the date of this writing are:
> -	      "sifive,fu540-c000-uart" for the SiFive UART v0 as
> -	      integrated onto the SiFive FU540 chip, or "sifive,uart0"
> -	      for the SiFive UART v0 IP block with no chip integration
> -	      tweaks (if any)
> -- reg: address and length of the register space
> -- interrupts: Should contain the UART interrupt identifier
> -- clocks: Should contain a clock identifier for the UART's parent clock
> -
> -
> -UART HDL that corresponds to the IP block version numbers can be found
> -here:
> -
> -https://github.com/sifive/sifive-blocks/tree/master/src/main/scala/devices/uart
> -
> -
> -Example:
> -
> -uart0: serial@10010000 {
> -	compatible = "sifive,fu540-c000-uart", "sifive,uart0";
> -	interrupt-parent = <&plic0>;
> -	interrupts = <80>;
> -	reg = <0x0 0x10010000 0x0 0x1000>;
> -	clocks = <&prci PRCI_CLK_TLCLK>;
> -};
> diff --git a/Documentation/devicetree/bindings/serial/sifive-serial.yaml b/Documentation/devicetree/bindings/serial/sifive-serial.yaml
> new file mode 100644
> index 0000000..56fa935
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/sifive-serial.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/serial/sifive-serial.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SiFive asynchronous serial interface (UART)
> +
> +maintainers:
> +  - Pragnesh Patel <pragnesh.patel@sifive.com>
> +  - Paul Walmsley  <paul.walmsley@sifive.com>
> +  - Palmer Dabbelt <palmer@sifive.com>
> +
> +allOf:
> +  - $ref: /schemas/serial.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sifive,fu540-c000-uart
> +      - sifive,uart0

This is wrong and should have warned if you tested this on 5.3.

items:
  - const: sifive,fu540-c000-uart
  - const: sifive,uart0


> +
> +    description:
> +      Should be something similar to "sifive,<chip>-uart"
> +      for the UART as integrated on a particular chip,
> +      and "sifive,uart<version>" for the general UART IP
> +      block programming model.
> +
> +      UART HDL that corresponds to the IP block version
> +      numbers can be found here -
> +
> +      https://github.com/sifive/sifive-blocks/tree/master/src/main/scala/devices/uart
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +      #include <dt-bindings/clock/sifive-fu540-prci.h>
> +      serial@10010000 {
> +        compatible = "sifive,fu540-c000-uart", "sifive,uart0";
> +        interrupt-parent = <&plic0>;
> +        interrupts = <80>;
> +        reg = <0x0 0x10010000 0x0 0x1000>;
> +        clocks = <&prci PRCI_CLK_TLCLK>;
> +      };
> +
> +...
> -- 
> 2.7.4
> 

