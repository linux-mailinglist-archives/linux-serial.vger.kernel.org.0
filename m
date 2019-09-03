Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57ACDA61D0
	for <lists+linux-serial@lfdr.de>; Tue,  3 Sep 2019 08:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfICGwE (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 3 Sep 2019 02:52:04 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40706 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbfICGwD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 3 Sep 2019 02:52:03 -0400
Received: by mail-io1-f66.google.com with SMTP id h144so18134482iof.7
        for <linux-serial@vger.kernel.org>; Mon, 02 Sep 2019 23:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0F9dHVWqGS8pUXJgoGylFO0BRrE92SZVgNyvb5o+ce8=;
        b=Rb9snEpQ7SvC+b9oG9ag30UFSjulOK5Q7VYo24KhNE4ndEiW127L6VDsWso4nAaiWY
         Gkmfx96iNGy+MKCfw6VvEhxFwrr1QHd4XQeFucutBfqo4UILDU3OmUmAhDxk5yU9nIIM
         1RSCyjZ3XOQMS7iJvz6jt7lqYUb53ha+HBQZByisz3YcwKICC4WvXDU0LNciP2gzO3KC
         OfW57Z5IQyE5YThgotILbUkKItoVs7SYt/j6LEFDvAupjI0oy4lM5jfm28uHSvgseKJk
         FwHvsQHQEEOa34V+jVhrdQgAAJ1zN/2rJcruvgq8wjr4kSk7rA6Bk8Rfx2/6WazDBypQ
         LL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0F9dHVWqGS8pUXJgoGylFO0BRrE92SZVgNyvb5o+ce8=;
        b=SqdvgIP/otPI18NzoKylto2x4UwaYl+LEOt4QVEsFf9e0qRXBEvohu7PYQI4pDsvEX
         ZKCsjCiRkKx1iFECZQ8jGpfS9Vj9gDi8MgWZgPqmxWjnBO94dwvDjcvgoPdhT5n0eizQ
         fe5ixbfJILafmO+Ke3VG+J0ceVo0IcAh/VBKLpWj+r2kIp4bvv01T9qsl8bUnGJFyt3p
         xOAV4Zpf1dd2odyEGlyT8MIt7nNLLLrpOIEUwLazh2IvEtC6RGngu/vxiNEzijtqNqEH
         YcKRPs8wRFEdfC6lCVLU6roWuO0ccbU3Ss+Kx17MLmIJMvyshaPjUxKvfMc8dBUGBHFN
         I+LQ==
X-Gm-Message-State: APjAAAWmPbtgeU9GZKJ4qJAII3nkNPgLgCMOeDMwBzOIPv+4Yx4Y167G
        Ql6BnnsZGbCjpzigj8/sv4vaStwtTU5Z6ot5sp8Hsw==
X-Google-Smtp-Source: APXvYqzaomYalEUMi0UtKAc6wlYG9J1JwC+gFONN+ZRF3rN5gAzYpDYlZkeEBuPHh200MECf4otHjQ3RpjlIGEVlVd4=
X-Received: by 2002:a6b:b714:: with SMTP id h20mr1071770iof.302.1567493522612;
 Mon, 02 Sep 2019 23:52:02 -0700 (PDT)
MIME-Version: 1.0
References: <1567321765-3738-1-git-send-email-pragnesh.patel@sifive.com> <5d6d1b81.1c69fb81.7eabb.cabd@mx.google.com>
In-Reply-To: <5d6d1b81.1c69fb81.7eabb.cabd@mx.google.com>
From:   Pragnesh Patel <pragnesh.patel@sifive.com>
Date:   Tue, 3 Sep 2019 12:21:51 +0530
Message-ID: <CAN8ut8KMjo4KVcgLp6AhZOpuLwWMJ8HeiecH70RgYnLQQ05M9w@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: serial: Convert riscv,sifive-serial to json-schema
To:     Rob Herring <robh@kernel.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Sep 2, 2019 at 7:09 PM Rob Herring <robh@kernel.org> wrote:
>
> On Sun, Sep 01, 2019 at 12:39:21PM +0530, Pragnesh Patel wrote:
> > Convert the riscv,sifive-serial binding to DT schema using json-schema.
> >
> > Signed-off-by: Pragnesh Patel <pragnesh.patel@sifive.com>
> > ---
> >  .../devicetree/bindings/serial/sifive-serial.txt   | 33 ------------
> >  .../devicetree/bindings/serial/sifive-serial.yaml  | 62 ++++++++++++++++++++++
> >  2 files changed, 62 insertions(+), 33 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/serial/sifive-serial.txt
> >  create mode 100644 Documentation/devicetree/bindings/serial/sifive-serial.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/serial/sifive-serial.txt b/Documentation/devicetree/bindings/serial/sifive-serial.txt
> > deleted file mode 100644
> > index c86b1e5..0000000
> > --- a/Documentation/devicetree/bindings/serial/sifive-serial.txt
> > +++ /dev/null
> > @@ -1,33 +0,0 @@
> > -SiFive asynchronous serial interface (UART)
> > -
> > -Required properties:
> > -
> > -- compatible: should be something similar to
> > -           "sifive,<chip>-uart" for the UART as integrated
> > -           on a particular chip, and "sifive,uart<version>" for the
> > -           general UART IP block programming model.  Supported
> > -           compatible strings as of the date of this writing are:
> > -           "sifive,fu540-c000-uart" for the SiFive UART v0 as
> > -           integrated onto the SiFive FU540 chip, or "sifive,uart0"
> > -           for the SiFive UART v0 IP block with no chip integration
> > -           tweaks (if any)
> > -- reg: address and length of the register space
> > -- interrupts: Should contain the UART interrupt identifier
> > -- clocks: Should contain a clock identifier for the UART's parent clock
> > -
> > -
> > -UART HDL that corresponds to the IP block version numbers can be found
> > -here:
> > -
> > -https://github.com/sifive/sifive-blocks/tree/master/src/main/scala/devices/uart
> > -
> > -
> > -Example:
> > -
> > -uart0: serial@10010000 {
> > -     compatible = "sifive,fu540-c000-uart", "sifive,uart0";
> > -     interrupt-parent = <&plic0>;
> > -     interrupts = <80>;
> > -     reg = <0x0 0x10010000 0x0 0x1000>;
> > -     clocks = <&prci PRCI_CLK_TLCLK>;
> > -};
> > diff --git a/Documentation/devicetree/bindings/serial/sifive-serial.yaml b/Documentation/devicetree/bindings/serial/sifive-serial.yaml
> > new file mode 100644
> > index 0000000..56fa935
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/serial/sifive-serial.yaml
> > @@ -0,0 +1,62 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/serial/sifive-serial.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: SiFive asynchronous serial interface (UART)
> > +
> > +maintainers:
> > +  - Pragnesh Patel <pragnesh.patel@sifive.com>
> > +  - Paul Walmsley  <paul.walmsley@sifive.com>
> > +  - Palmer Dabbelt <palmer@sifive.com>
> > +
> > +allOf:
> > +  - $ref: /schemas/serial.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - sifive,fu540-c000-uart
> > +      - sifive,uart0
>
> This is wrong and should have warned if you tested this on 5.3.
>
> items:
>   - const: sifive,fu540-c000-uart
>   - const: sifive,uart0
>

Thanks for the correction, i will update this in v2 patch.

I haven't got any warnings due to my patch.
For your reference, following is the list of warnings when i did "make
dtbs_check" (kernel version - 5.3.0-rc7)

/home/pragneshp/opensource/linux/Documentation/devicetree/bindings/riscv/cpus.example.dt.yaml:
cpu@0: compatible:0: 'riscv' is not one of ['sifive,rocket0',
'sifive,e5', 'sifive,e51', 'sifive,u54-mc', 'sifive,u54', 'sifive,u5']
/home/pragneshp/opensource/linux/Documentation/devicetree/bindings/riscv/cpus.example.dt.yaml:
cpu@0: compatible: ['riscv'] is too short
/home/pragneshp/opensource/linux/Documentation/devicetree/bindings/riscv/cpus.example.dt.yaml:
cpu@0: 'timebase-frequency' is a required property
/home/pragneshp/opensource/linux/Documentation/devicetree/bindings/riscv/cpus.example.dt.yaml:
cpu@0: 'timebase-frequency' is a required property
/home/pragneshp/opensource/linux/Documentation/devicetree/bindings/riscv/cpus.example.dt.yaml:
cpu@1: 'timebase-frequency' is a required property

/home/pragneshp/opensource/linux/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dt.yaml:
/: compatible: ['sifive,hifive-unleashed-a00', 'sifive,fu540-c000'] is
too short
/home/pragneshp/opensource/linux/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dt.yaml:
cpu@3: 'timebase-frequency' is a required property
/home/pragneshp/opensource/linux/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dt.yaml:
cpu@3: compatible: Additional items are not allowed ('riscv' was
unexpected)
/home/pragneshp/opensource/linux/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dt.yaml:
cpu@3: compatible:1: 'riscv' was expected
/home/pragneshp/opensource/linux/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dt.yaml:
cpu@3: compatible: ['sifive,u54-mc', 'sifive,rocket0', 'riscv'] is too
long
/home/pragneshp/opensource/linux/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dt.yaml:
cpu@1: 'timebase-frequency' is a required property
/home/pragneshp/opensource/linux/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dt.yaml:
cpu@1: compatible: Additional items are not allowed ('riscv' was
unexpected)
/home/pragneshp/opensource/linux/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dt.yaml:
cpu@1: compatible:1: 'riscv' was expected
/home/pragneshp/opensource/linux/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dt.yaml:
cpu@1: compatible: ['sifive,u54-mc', 'sifive,rocket0', 'riscv'] is too
long
/home/pragneshp/opensource/linux/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dt.yaml:
cpu@4: 'timebase-frequency' is a required property
/home/pragneshp/opensource/linux/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dt.yaml:
cpu@4: compatible: Additional items are not allowed ('riscv' was
unexpected)
/home/pragneshp/opensource/linux/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dt.yaml:
cpu@4: compatible:1: 'riscv' was expected
/home/pragneshp/opensource/linux/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dt.yaml:
cpu@4: compatible: ['sifive,u54-mc', 'sifive,rocket0', 'riscv'] is too
long
/home/pragneshp/opensource/linux/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dt.yaml:
cpu@2: 'timebase-frequency' is a required property
/home/pragneshp/opensource/linux/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dt.yaml:
cpu@2: compatible: Additional items are not allowed ('riscv' was
unexpected)
/home/pragneshp/opensource/linux/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dt.yaml:
cpu@2: compatible:1: 'riscv' was expected
/home/pragneshp/opensource/linux/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dt.yaml:
cpu@2: compatible: ['sifive,u54-mc', 'sifive,rocket0', 'riscv'] is too
long
/home/pragneshp/opensource/linux/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dt.yaml:
cpu@0: compatible: Additional items are not allowed ('riscv' was
unexpected)
/home/pragneshp/opensource/linux/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dt.yaml:
cpu@0: compatible:1: 'riscv' was expected
/home/pragneshp/opensource/linux/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dt.yaml:
cpu@0: compatible: ['sifive,e51', 'sifive,rocket0', 'riscv'] is too
long
/home/pragneshp/opensource/linux/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dt.yaml:
soc: compatible:0: 'sifive,fu540-c000' is not one of
['sifive,hifive-unleashed-a00']
/home/pragneshp/opensource/linux/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dt.yaml:
soc: compatible:1: 'sifive,fu540-c000' was expected
/home/pragneshp/opensource/linux/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dt.yaml:
soc: compatible:2: 'sifive,fu540' was expected
/home/pragneshp/opensource/linux/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dt.yaml:
soc: $nodename:0: '/' was expected
/home/pragneshp/opensource/linux/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dt.yaml:
soc: spi@10041000:reg:0: [0, 268701696, 0, 4096, 0, 805306368, 0,
268435456] is too long
/home/pragneshp/opensource/linux/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dt.yaml:
soc: ethernet@10090000:reg:0: [0, 269025280, 0, 8192, 0, 269090816, 0,
4096] is too long
/home/pragneshp/opensource/linux/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dt.yaml:
soc: spi@10040000:reg:0: [0, 268697600, 0, 4096, 0, 536870912, 0,
268435456] is too long


>
> > +
> > +    description:
> > +      Should be something similar to "sifive,<chip>-uart"
> > +      for the UART as integrated on a particular chip,
> > +      and "sifive,uart<version>" for the general UART IP
> > +      block programming model.
> > +
> > +      UART HDL that corresponds to the IP block version
> > +      numbers can be found here -
> > +
> > +      https://github.com/sifive/sifive-blocks/tree/master/src/main/scala/devices/uart
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +      #include <dt-bindings/clock/sifive-fu540-prci.h>
> > +      serial@10010000 {
> > +        compatible = "sifive,fu540-c000-uart", "sifive,uart0";
> > +        interrupt-parent = <&plic0>;
> > +        interrupts = <80>;
> > +        reg = <0x0 0x10010000 0x0 0x1000>;
> > +        clocks = <&prci PRCI_CLK_TLCLK>;
> > +      };
> > +
> > +...
> > --
> > 2.7.4
> >
>
