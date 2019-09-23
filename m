Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2173FBAF16
	for <lists+linux-serial@lfdr.de>; Mon, 23 Sep 2019 10:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437515AbfIWIOq (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 23 Sep 2019 04:14:46 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41100 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2437009AbfIWIOq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 Sep 2019 04:14:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569226484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WgjhOA0zyVcAZNXjRIcpen414kkZtL+EdIeyI3wtD/s=;
        b=MS0xVCsz3soc4OPDKadb4rGSO+3Zyw3ppd9J+2735eEVp1YQWIdBC7+LIIuhJzsWdxlVNO
        3a1wpfx6jrMUTJ9ExGxIB/dR5y2FzrmccEMeJY4WUNyBN959/oyA9LdqBGIg/TducXTCYE
        iYQ3DelhbzaOEJWDQIOCU67MqjT6y+8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-rQl1G34iPvWv6CGhKdCN_g-1; Mon, 23 Sep 2019 04:14:43 -0400
Received: by mail-ed1-f71.google.com with SMTP id 34so8993209edf.0
        for <linux-serial@vger.kernel.org>; Mon, 23 Sep 2019 01:14:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SGnsNHhO6VDfdoucoStGXGb4btl6LzMLnLQlg8egQPM=;
        b=FA8en/CSxDEIfwfHd0lnKxuBwRCclkI2D57TYYg8sFbqJR0uhVhuJRCH2zDZML8p9N
         UBjEd46ViVoiZBYL2KLjn1JUVzqYYalTbV0SibkPMVFQAU6Mn+FVGl+eMzOc8pBk3UFf
         vMcsv9/zQcGWCW1drAOK2vrfeNUyvvEMEhFR0KnueMrasDFg24fjb0RAejoszTKGpm8+
         8JigRmeOphXPcJiDwz/TKx+8Kt6ZE8Xe98DBY9RaKUGcHuwc1gJFtH2V0i/JaqZfapzO
         MG7vLE0kUY70DZASiFixQcerbu4VM6g41nufR14+wz11KL8kXHhGoJgqrtNera1Z2EFB
         gr6w==
X-Gm-Message-State: APjAAAWnUKFzRltSMF7d+9o21h4IoTX0ZET+OUvmOqGHTtfj9W2JE679
        skFLZF93HuBcn+yI7KFoeXn8xA0qp31WEWtgj5wosgov2XMxutEIGM2YHTEERB1Wdzbt1cLQH9u
        UkhEhjmOdMlHb11tRF+C3cq9q
X-Received: by 2002:a50:8933:: with SMTP id e48mr35189227ede.51.1569226482500;
        Mon, 23 Sep 2019 01:14:42 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxc5e7k3VAzRdcPID6YxsIF0up8i6QsaNpxbtG6XkJUN3zr6gMWoDf/Moazau7pRW8wC7jlxQ==
X-Received: by 2002:a50:8933:: with SMTP id e48mr35189208ede.51.1569226482339;
        Mon, 23 Sep 2019 01:14:42 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id b16sm1025855eju.74.2019.09.23.01.14.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 01:14:41 -0700 (PDT)
Subject: Re: [PATCH] serdev: Add ACPI devices by ResourceSource field
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-serial@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190919195624.1140941-1-luzmaximilian@gmail.com>
 <50b016a1-ed4a-b848-4658-a05731727d7e@redhat.com>
 <4c2cc8b7-8541-0912-3162-399777dc8dd2@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <8bed7cde-1f59-c5bf-9506-757dd89ad594@redhat.com>
Date:   Mon, 23 Sep 2019 10:14:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <4c2cc8b7-8541-0912-3162-399777dc8dd2@gmail.com>
Content-Language: en-US
X-MC-Unique: rQl1G34iPvWv6CGhKdCN_g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On 23-09-2019 00:29, Maximilian Luz wrote:
> Hi all,
>=20
> On 9/20/19 5:00 PM, Hans de Goede wrote:
>> So as promised I've given this patch a try, unfortunately it breaks
>> existing users of ACPI serdev device instantation.
>>
>> After adding this patch "ls /sys/bus/serial/devices" is empty,
>> where as before it gives:
>>
>> [root@dhcp-45-50 ~]# ls -l /sys/bus/serial/devices/
>> total 0
>> lrwxrwxrwx. 1 root root 0 Sep 20 16:43 serial0 -> ../../../devices/pci00=
00:00/8086228A:00/serial0
>> lrwxrwxrwx. 1 root root 0 Sep 20 16:43 serial0-0 -> ../../../devices/pci=
0000:00/8086228A:00/serial0/serial0-0
>>
>> And since the serdev is missing bluetooth does not work.
>=20
> Thanks to some testing by Hans, it turns out that the reason for this is
> that acpi_walk_resources fails with AE_AML_INVALID_RESOURCE_TYPE for a
> specific device. If anyone is interested, the _CRS of the device in
> question is
>=20
>  =C2=A0=C2=A0=C2=A0 Method (_CRS, 0, NotSerialized)=C2=A0 // _CRS: Curren=
t Resource Settings
>  =C2=A0=C2=A0=C2=A0 {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Name (NAM, Buffer (0x14)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "\\_S=
B.PCI0.SDHB.BRC1"
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 })
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Name (SPB, Buffer (0x0C)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 00=
00 */=C2=A0 0x8E, 0x1D, 0x00, 0x01, 0x00, 0xC0, 0x02, 0x00,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 00=
08 */=C2=A0 0x00, 0x01, 0x00, 0x00
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 })
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Name (END, ResourceTemplate (=
)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 })
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Concatenate (SPB, NAM, Local0=
)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Concatenate (Local0, END, Loc=
al1)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Return (Local1)
>  =C2=A0=C2=A0=C2=A0 }
>=20
> To solve this, I propose ignoring errors that occur when evaluating the
> _CRS method. Note that with the previously discussed change for v2,
> where we will only look at the first device in _CRS, we should be able
> to handle errors from the actual serdev device allocation separately
> (and only ignore AML evaluation errors).
>=20
> Further, I think it might also make sense to move the status and
> already-enumerated checks out of acpi_serdev_register_device to before
> looking at _CRS.

Ack, this is what drivers/i2c/i2c-core-acpi.c is doing and more in general
all ACPI enumeration code always first checks _STA before doing anything
else, so I think it would be best to do this here too.

Actually I think it might be best to fully copy how drivers/i2c/i2c-core-ac=
pi.c
does things.

Regards,

Hans

