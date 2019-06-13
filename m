Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCA9437C6
	for <lists+linux-serial@lfdr.de>; Thu, 13 Jun 2019 17:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732984AbfFMPBG (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 13 Jun 2019 11:01:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:52366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732566AbfFMOka (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 13 Jun 2019 10:40:30 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57D532175B;
        Thu, 13 Jun 2019 14:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560436829;
        bh=AMfYYiFDnSPplYQGWm8VdFubFiToLLjY7NKHWlMj/7Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YnLk7DLWFZz4W5tpbheLAhQBzjY5uDLN+9Uv+hxWIC0R+FMWbozryhgV8EhJX6bfL
         4qhrMiGPmVxEhBQvpzFwOUOeEKf+M4rCIGazgenVj9yTrnf8FgPE3cFho3w5UApcxb
         I2EvYzXkabni0m4zeSV/se3EChpj7AyJ37XTFztM=
Received: by mail-qt1-f170.google.com with SMTP id p15so3437048qtl.3;
        Thu, 13 Jun 2019 07:40:29 -0700 (PDT)
X-Gm-Message-State: APjAAAUG0ltqFaZBLoqSUIIizFFuRmJmgY8hw6UL1MKHCezTv0dPjFl4
        0W++mEPEcskTqTL1jVLpP7+T8YS+5OHmPLHX5Q==
X-Google-Smtp-Source: APXvYqxctR3wbgWzXGF/JoJM/uXXh7dkhlI9vwjgxMVNu6wr1wBEMkkREu2EEkaC7/NyGasJGU/Mex5miLNVy6SnR4c=
X-Received: by 2002:a0c:b627:: with SMTP id f39mr3981799qve.72.1560436828511;
 Thu, 13 Jun 2019 07:40:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190611121510.260188-1-tientzu@chromium.org>
In-Reply-To: <20190611121510.260188-1-tientzu@chromium.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 13 Jun 2019 08:40:16 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKJMAhOLH_Y2rgbdWZ9f5CEVdMMEF8+bHfjxxtu-cBKdQ@mail.gmail.com>
Message-ID: <CAL_JsqKJMAhOLH_Y2rgbdWZ9f5CEVdMMEF8+bHfjxxtu-cBKdQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: serial: add documentation for Rx in-band
 wakeup support
To:     Claire Chang <tientzu@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        changqi.hu@mediatek.com,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jun 11, 2019 at 6:15 AM Claire Chang <tientzu@chromium.org> wrote:
>
> To support Rx in-band wakeup, one must create an interrupt specifier with
> edge sensitivity on Rx pin and an addtional pinctrl to reconfigure Rx pin
> to normal GPIO in sleep state. Driver will switch to sleep mode pinctrl and
> enable irq wake before suspend and restore to default settings when
> resuming.
>
> Signed-off-by: Claire Chang <tientzu@chromium.org>
> ---
> Resending this patch since I forgot to cc device tree maintainers/mailing list.
> The 2/2 patch in this series[1] is already in tty-next[2].
>
> [1] https://patchwork.kernel.org/patch/10962299/
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/log/?h=tty-testing
>
>  .../devicetree/bindings/serial/mtk-uart.txt         | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/serial/mtk-uart.txt b/Documentation/devicetree/bindings/serial/mtk-uart.txt
> index bcfb13194f16..3488b6e24e0c 100644
> --- a/Documentation/devicetree/bindings/serial/mtk-uart.txt
> +++ b/Documentation/devicetree/bindings/serial/mtk-uart.txt
> @@ -21,7 +21,12 @@ Required properties:
>
>  - reg: The base address of the UART register bank.
>
> -- interrupts: A single interrupt specifier.
> +- interrupts or interrupts-extended:

interrupts-extended support is implied as both are supported and the
connection to the interrupt parent is outside the scope of the
binding. So we just document 'interrupts'.

> +  index 0: an interrupt specifier for the UART controller itself
> +  index 1: optional, an interrupt specifier with edge sensitivity on Rx pin to
> +           support Rx in-band wake up. If one would like to use this feature,
> +           one must create an addtional pinctrl to reconfigure Rx pin to normal
> +           GPIO before suspend.
>
>  - clocks : Must contain an entry for each entry in clock-names.
>    See ../clocks/clock-bindings.txt for details.
> @@ -37,7 +42,11 @@ Example:
>         uart0: serial@11006000 {
>                 compatible = "mediatek,mt6589-uart", "mediatek,mt6577-uart";
>                 reg = <0x11006000 0x400>;
> -               interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_LOW>;
> +               interrupts-extended = <&sysirq GIC_SPI 51 IRQ_TYPE_LEVEL_LOW>,
> +                                     <&gpio 121 IRQ_TYPE_EDGE_FALLING>;
>                 clocks = <&uart_clk>, <&bus_clk>;
>                 clock-names = "baud", "bus";
> +               pinctrl-names = "default", "sleep";
> +               pinctrl-0 = <&uart_pin>;
> +               pinctrl-1 = <&uart_pin_sleep>;
>         };
> --
> 2.22.0.rc2.383.gf4fbbf30c2-goog
>
