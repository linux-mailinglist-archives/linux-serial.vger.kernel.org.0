Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12CE87DE96
	for <lists+linux-serial@lfdr.de>; Thu,  1 Aug 2019 17:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730816AbfHAPPT (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 1 Aug 2019 11:15:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:39090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729812AbfHAPPT (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 1 Aug 2019 11:15:19 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92CA620B7C;
        Thu,  1 Aug 2019 15:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564672517;
        bh=uA5DuDfByrWnX/ae2A1G+1Mtk6MansklqnA2pEJdupo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=J2mrSmLujUUFABdK72fcr2TW7agwhVkmfa/Cf259JquuoLyGhU1gCczm1hJqzgDAc
         TYlkBVwQ8g37RNKu54reyUtCZ3wCgvEOJPkQ2kVTLN70qFdJRFxTmUydVfS401y0dY
         XPW2JwX2cGRw3pXnotPCRaKKaJRk7ec1iOvuhE/s=
Received: by mail-qk1-f170.google.com with SMTP id t8so52297449qkt.1;
        Thu, 01 Aug 2019 08:15:17 -0700 (PDT)
X-Gm-Message-State: APjAAAUY0yZc7wYm9bu/3orz36161PGUMBNDT5EfailszG1V3GidrSUL
        ux+xpLRzlVmf05jPNDaI/PqaVGZwhtzqIZ4UhA==
X-Google-Smtp-Source: APXvYqz01CYxZNt/Xy/YcsZufgzVCjzSi/3SAevXz+2Mup+zxxWrzaySvqq35mED05tE8I4G9MmfZPTnjTC/K4sAw9M=
X-Received: by 2002:a37:a44a:: with SMTP id n71mr21034952qke.393.1564672516768;
 Thu, 01 Aug 2019 08:15:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190801135644.12843-1-narmstrong@baylibre.com> <20190801135644.12843-9-narmstrong@baylibre.com>
In-Reply-To: <20190801135644.12843-9-narmstrong@baylibre.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 1 Aug 2019 09:15:05 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+FyKhLfKHXS71cSRSKmvBj_BquOMbaNUenr1uivnDCng@mail.gmail.com>
Message-ID: <CAL_Jsq+FyKhLfKHXS71cSRSKmvBj_BquOMbaNUenr1uivnDCng@mail.gmail.com>
Subject: Re: [RFC 8/9] dt-bindings: serial: meson-uart: convert to yaml
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Aug 1, 2019 at 7:56 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../bindings/serial/amlogic,meson-uart.txt    | 38 ----------
>  .../bindings/serial/amlogic,meson-uart.yaml   | 75 +++++++++++++++++++
>  2 files changed, 75 insertions(+), 38 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/amlogic,meson-uart.txt
>  create mode 100644 Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
>
> diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.txt b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.txt
> deleted file mode 100644
> index c06c045126fc..000000000000
> --- a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.txt
> +++ /dev/null
> @@ -1,38 +0,0 @@
> -Amlogic Meson SoC UART Serial Interface
> -=======================================
> -
> -The Amlogic Meson SoC UART Serial Interface is present on a large range
> -of SoCs, and can be present either in the "Always-On" power domain or the
> -"Everything-Else" power domain.
> -
> -The particularity of the "Always-On" Serial Interface is that the hardware
> -is active since power-on and does not need any clock gating and is usable
> -as very early serial console.
> -
> -Required properties:
> -- compatible : compatible: value should be different for each SoC family as :
> -       - Meson6 : "amlogic,meson6-uart"
> -       - Meson8 : "amlogic,meson8-uart"
> -       - Meson8b : "amlogic,meson8b-uart"
> -       - GX (GXBB, GXL, GXM) : "amlogic,meson-gx-uart"
> -       eventually followed by : "amlogic,meson-ao-uart" if this UART interface
> -       is in the "Always-On" power domain.
> -- reg : offset and length of the register set for the device.
> -- interrupts : identifier to the device interrupt
> -- clocks : a list of phandle + clock-specifier pairs, one for each
> -          entry in clock names.
> -- clock-names :
> -   * "xtal" for external xtal clock identifier
> -   * "pclk" for the bus core clock, either the clk81 clock or the gate clock
> -   * "baud" for the source of the baudrate generator, can be either the xtal
> -       or the pclk.
> -
> -e.g.
> -uart_A: serial@84c0 {
> -       compatible = "amlogic,meson-gx-uart";
> -       reg = <0x0 0x84c0 0x0 0x14>;
> -       interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
> -       /* Use xtal as baud rate clock source */
> -       clocks = <&xtal>, <&clkc CLKID_UART0>, <&xtal>;
> -       clock-names = "xtal", "pclk", "baud";
> -};
> diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> new file mode 100644
> index 000000000000..e150e3504fa0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> @@ -0,0 +1,75 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2019 BayLibre, SAS
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/serial/amlogic,meson-uart.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Amlogic Meson SoC UART Serial Interface
> +
> +maintainers:
> +  - Neil Armstrong <narmstrong@baylibre.com>
> +
> +description: |
> +  The Amlogic Meson SoC UART Serial Interface is present on a large range
> +  of SoCs, and can be present either in the "Always-On" power domain or the
> +  "Everything-Else" power domain.
> +
> +  The particularity of the "Always-On" Serial Interface is that the hardware
> +  is active since power-on and does not need any clock gating and is usable
> +  as very early serial console.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - description: Allways-on power domain UART controller
> +        items:
> +        - enum:
> +          - amlogic,meson6-uart
> +          - amlogic,meson8-uart
> +          - amlogic,meson8b-uart
> +          - amlogic,meson-gx-uart
> +        - const: amlogic,meson-ao-uart
> +      - description: Everything-Else power domain UART controller
> +        enum:
> +        - amlogic,meson6-uart
> +        - amlogic,meson8-uart
> +        - amlogic,meson8b-uart
> +        - amlogic,meson-gx-uart
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 3
> +    maxItems: 3

Should list out what each clock is.

items:
  - description: external xtal clock identifier
  - description: the bus core clock, either the clk81 clock or the gate clock
  - description: the source of the baudrate generator, can be either
the xtal or the pclk

This makes minItems/maxItems implicit.

> +
> +  clock-names:
> +    description: |
> +      "xtal" for external xtal clock identifier
> +      "pclk" for the bus core clock, either the clk81 clock or the gate clock
> +      "baud" for the source of the baudrate generator, can be either the xtal
> +      or the pclk.

Then this description can be dropped.

> +    items:
> +      - const: xtal
> +      - const: pclk
> +      - const: baud
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names

interrupts?

If the old binding was wrong, it's fine to fix here. Just mention what
you're fixing in the commit message.

> +
> +examples:
> +  - |
> +    serial@84c0 {
> +          compatible = "amlogic,meson-gx-uart";
> +          reg = <0x84c0 0x14>;
> +          interrupts = <26>;
> +          clocks = <&xtal>, <&pclk>, <&xtal>;
> +          clock-names = "xtal", "pclk", "baud";
> +    };
> --
> 2.22.0
>
