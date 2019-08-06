Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8352A8397E
	for <lists+linux-serial@lfdr.de>; Tue,  6 Aug 2019 21:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbfHFTSO (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 6 Aug 2019 15:18:14 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36769 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfHFTSO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 6 Aug 2019 15:18:14 -0400
Received: by mail-oi1-f193.google.com with SMTP id c15so12855729oic.3;
        Tue, 06 Aug 2019 12:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QksYxQSRVQDPGMXGjLmAF5kWT3zgenhIbfjlqIRDB50=;
        b=iw+xNSGevvMp6QLQVcVDCK0k0UGmX2/q6doQuB+4F7OBPyZTK3hzRgdZyPv1BpuCNR
         41aiHV5FtoCKa7c9e/LEqc6QhaFwd3tNOcUN9yCOJI6Zm91427xrlixL94Wu1vF8XPjI
         lk/YT2YB+3V1T5s1DuyLpLYeVLSqkc5lgcYyWMTEIAf/oqnKgmsRyr8Vv5WYQQCXddgv
         a0y9wO5WiWcFZm6yav6zWYEo2+sguptnPXTLjcnOZc97NgZf4+0SKGbl/8dWSsf2wfyF
         cheAsvSdNs+6FEn03jWyUp6ZC4jz6sgBeJyM+/l58GHPZfm24/PyjQQIaju/mlTAq993
         2exQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QksYxQSRVQDPGMXGjLmAF5kWT3zgenhIbfjlqIRDB50=;
        b=e060davN5u4q6uTWZhetKUhNRomNdOV5klTKhFgIPnK7IIBp5ueRFEbgffyVXqp3n0
         +fgYOEiv8QUq34ZuMJcWrW2bDhbSjIKiT/wL6e/hQmyJQfOaAAjOSRHCMxR+xvFx6j1w
         nktSiJvp/va2Wo9hV9N0I2lpf/RTSVzN5dRK31PHVeR4RqAvHkU530IFBpwz+q8b9cHl
         kz9uMx4Tu8Xh+hFHTYJClQPSMTQKo4jG8i2R27heexScjvTzSPySmwVBeUVYXGV/8WQS
         O6q2kvNq34DeL6Ld1XIEwM72ltw5JCiKy9LG3ZIsPj76RQha13eQPF6pdfFRL+QqlphB
         9Ujw==
X-Gm-Message-State: APjAAAVNAvMVHC1FqiTEs4Z2wxgqTKWZAm53F5MgfwL7zvTVXrxms3ka
        wpcKBPd8LH95g3ae6QwGO5q8rfCGskLU//IaapttHdTx
X-Google-Smtp-Source: APXvYqwZTvJvfIjhNSPBRRSCo+e2K2SBi/qn4E7udh0JEH4LHYhlDQFNci1czKK09aurjIPZPDW+4WBLDxj7tgdfX8I=
X-Received: by 2002:a05:6808:8f0:: with SMTP id d16mr2928463oic.47.1565119093090;
 Tue, 06 Aug 2019 12:18:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190805120320.32282-1-narmstrong@baylibre.com> <20190805120320.32282-9-narmstrong@baylibre.com>
In-Reply-To: <20190805120320.32282-9-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 6 Aug 2019 21:18:02 +0200
Message-ID: <CAFBinCBSC-wrSxKajwfQNJuzf3ZGFNS4bYPE8qnJF92gTMK_8w@mail.gmail.com>
Subject: Re: [RFCv2 8/9] dt-bindings: serial: meson-uart: convert to yaml
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     robh+dt@kernel.org, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Neil,

On Mon, Aug 5, 2019 at 2:06 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Now that we have the DT validation in place, let's convert the device tree
> bindings for the Amlogic UART Serial controller over to a YAML schemas.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
two nit-picks below, but overall this looks good:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

> ---
>  .../bindings/serial/amlogic,meson-uart.txt    | 38 ----------
>  .../bindings/serial/amlogic,meson-uart.yaml   | 73 +++++++++++++++++++
>  2 files changed, 73 insertions(+), 38 deletions(-)
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
> index 000000000000..5d48a8c04aa9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> @@ -0,0 +1,73 @@
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
Always instead of Allways

[...]
> +examples:
> +  - |
> +    serial@84c0 {
> +          compatible = "amlogic,meson-gx-uart";
> +          reg = <0x84c0 0x14>;
> +          interrupts = <26>;
> +          clocks = <&xtal>, <&pclk>, <&xtal>;
> +          clock-names = "xtal", "pclk", "baud";
> +    };
more a hint than a nit-pick: you can add #includes to the example,
just like in the real .dtb
then you can keep the GIC_SPI and IRQ_TYPE_... macros
