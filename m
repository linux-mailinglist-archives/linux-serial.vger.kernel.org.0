Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37BF1B8D32
	for <lists+linux-serial@lfdr.de>; Fri, 20 Sep 2019 10:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408330AbfITIuf (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 20 Sep 2019 04:50:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46889 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2405464AbfITIuf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 20 Sep 2019 04:50:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568969434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bMQmh6bt7SEPSQlVPTv16Vvaa2lPPh/g7BO6VdZsR2I=;
        b=Ujadd8i25j7JWBb7GJRS8Q9iEZ6A8NS9OGlBAjVeEknuAT0HEny7tVKaK9i6nUe/5LLMvF
        ts2bJPE86r/bWTN8OHxvJldxgiqE8OFo9joMNP2R549Uxa71L9qSDCcdQb9sfFiC9KflTb
        r/SxSVXHIbCILsE6udxENVWuEm7ufM0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-wT7V1jqZOZiqvClqt8tipA-1; Fri, 20 Sep 2019 04:50:28 -0400
Received: by mail-ed1-f71.google.com with SMTP id n12so3728580edr.22
        for <linux-serial@vger.kernel.org>; Fri, 20 Sep 2019 01:50:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uphOpbAgrdy43BfB/41YtawX2S+90uCA4NiyJq9P2Bw=;
        b=fFQmSPga8vir2K6uSKSOoOXPaiEh3FcDSNu55pKV4Uw+XAfFFePcrdx39RWBuzYF70
         y1KV++SyR8ZhkXt/QqBZO95Zmg/VUlb8OvcQGo0+GviNWHyI1akj7l3E6WxXNqPhDj+V
         ugGOwkGn9gWMQ+MapqZvwXsUEgeFOYlHYMcCMfTKFmEZFWQJ60thV26OdXDtoU9E1wxj
         rs522DaXeLqhvyzvfjq4pxiMR0/NTqeGpFFO/PbRY70zHJlJPoHL4U+CTRIj5z9AlmDi
         vCWbHTplemSjekOUp5qHO3XHoWaPTTacKSAA1SoUbQ8r0fTO+imosuNGXVuhRlU5SHSY
         4Dcw==
X-Gm-Message-State: APjAAAWU8aAei0sON0AYcn7aL6f+8C4SwDBbpYdtgdy+03239oeKhFpC
        LPNGlOIzQ0ZhH+FRBrb5ClGJUGRkTxP78WfF+UMoAjqUHcP7qHt0ez5s+yi5HB9Z4d782PCHbMt
        H4SrFPnZGvjqW5PZ8ozFso1oN
X-Received: by 2002:a17:906:e290:: with SMTP id gg16mr7984105ejb.176.1568969426871;
        Fri, 20 Sep 2019 01:50:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxm86r4nDmfGip9Js8Gt2Qa8FhAg8sYxIqzoTYIfqodB2gnkK5U+MAWev/tBSho/seaeE31pg==
X-Received: by 2002:a17:906:e290:: with SMTP id gg16mr7984089ejb.176.1568969426677;
        Fri, 20 Sep 2019 01:50:26 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id z39sm210440edd.46.2019.09.20.01.50.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2019 01:50:25 -0700 (PDT)
Subject: Re: [PATCH] serdev: Add ACPI devices by ResourceSource field
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-serial@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190919195624.1140941-1-luzmaximilian@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <79c9533f-882d-f2b2-b6f3-b94fa49b4367@redhat.com>
Date:   Fri, 20 Sep 2019 10:50:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190919195624.1140941-1-luzmaximilian@gmail.com>
Content-Language: en-US
X-MC-Unique: wT7V1jqZOZiqvClqt8tipA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Maximilian,

Interesting patch. Some comments about the i2c situation below.

Also I will give this a test-run on some of the existing devices
which rely on the instantiation of serdev devices for ACPI
devices which are childs of the uart device.

On 19-09-2019 21:56, Maximilian Luz wrote:
> When registering a serdev controller, ACPI needs to be checked for
> devices attached to it. Currently, all immediate children of the ACPI
> node of the controller are assumed to be UART client devices for this
> controller. Furthermore, these devices are not searched elsewhere.
>=20
> This is incorrect: Similar to SPI and I2C devices, the UART client
> device definition (via UARTSerialBusV2) can reside anywhere in the ACPI
> namespace as resource definition inside the _CRS method and points to
> the controller via its ResourceSource field. This field may either
> contain a fully qualified or relative path, indicating the controller
> device. To address this, we need to walk over the whole ACPI namespace,
> looking at each resource definition, and match the client device to the
> controller via this field.
>=20
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
> ---
> This patch is similar to the the implementations in drivers/spi/spi.c
> (see commit 4c3c59544f33e97cf8557f27e05a9904ead16363) and
> drivers/i2c/i2c-core-acpi.c. However, I think that there may be an
> issues with these two implementations: Both walk over the whole ACPI
> namespace, but only match the first SPI or I2C resource (respectively),
> so I think there may be problems when multiple SPI or I2C resources are
> defined under the same ACPI device node (as in second or third SPI/I2C
> resource definitions being ignored).

Right, so from the i2c side of things, the story with multiple
I2cSerialBusV2 resources is that normally we want to instantiate
only 1 kernel "struct device" for 1 ACPI "Device()" definition.

If a single I2C chip/device listens on multiple addresses then
usually the other addresses can be derived from the first one and
the device-driver can get a handle to access the other addresses by
using e.g. i2c_new_dummy or i2c_new_secondary_device.

With that said of course there are exceptions where vendors get
creative and put multiple I2cSerialBusV2 resources in a single
ACPI "Device()" even though they point to separate chips.

For this we have some special handling in:
drivers/platform/x86/i2c-multi-instantiate.c

Also note how drivers/platform/x86/i2c-multi-instantiate.c maps the
original ACPI HID as e.g. "BSG1160" to per device match strings,
because if there are multiple I2cSerialBusV2 resources and they
point to separate chips, then we need something to get the right
driver to bind to each I2cSerialBusV2 address, so the normal
modalias of e.g. acpi:BSG1160 is no good, we need a different modalias
for each I2cSerialBusV2 address.

Another way of looking at this is a typical _CRS for a device with
*SerialBusV2 resources will also have 1 or more Interrupt resources
and 1 or more GPIO resources. We are not instantiating separate
"struct device"-s in the kernel for each of those, since all the
resources together describe a single device, so we instantiate e.g.
an i2c_client and then the i2c_driver's probe method calls e.g.
platform_get_irq() to get the IRQ(s).

Given the above I think you may want to also limit your patch to
only instantiate a "struct device" for the first UARTSerialBusV2
in an ACPI "Device()"'s  .

I hope this sheds some clarity on the (muddy) situation wrt
I2cSerialBusV2 handling.

Regards,

Hans

