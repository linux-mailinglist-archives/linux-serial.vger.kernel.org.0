Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 911763677C1
	for <lists+linux-serial@lfdr.de>; Thu, 22 Apr 2021 05:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbhDVDK5 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 21 Apr 2021 23:10:57 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17022 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbhDVDK4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 21 Apr 2021 23:10:56 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FQj5L6t88zPtLX;
        Thu, 22 Apr 2021 11:07:18 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.72) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.498.0; Thu, 22 Apr 2021
 11:10:17 +0800
Subject: Re: [PATCH 1/1] dt-bindings: serial: Add label property for pl011
To:     Rob Herring <robh@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210415073105.3687-1-thunder.leizhen@huawei.com>
 <20210420200246.GA3717650@robh.at.kernel.org>
 <fa6c6079-8061-5774-8252-31956ac84ae2@huawei.com>
 <CAL_JsqKggh0XDCHg8E694Zjuz2yiJ6tkxHDBDsMM3Y_XiZxypA@mail.gmail.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <6491648e-aab1-72cb-c766-5c4eff331412@huawei.com>
Date:   Thu, 22 Apr 2021 11:10:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKggh0XDCHg8E694Zjuz2yiJ6tkxHDBDsMM3Y_XiZxypA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.72]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 2021/4/21 21:53, Rob Herring wrote:
> On Wed, Apr 21, 2021 at 4:38 AM Leizhen (ThunderTown)
> <thunder.leizhen@huawei.com> wrote:
>>
>>
>>
>> On 2021/4/21 4:02, Rob Herring wrote:
>>> On Thu, Apr 15, 2021 at 03:31:05PM +0800, Zhen Lei wrote:
>>>> When there is more than one pl011 serial port present, the label property
>>>> allows a custom name to be used for briefly describe the usage or position
>>>> of each serial port.
>>>>
>>>> Without this "label" property, many dtbs_check warnings similar to the
>>>> following are reported:
>>>> arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dt.yaml: \
>>>> serial@ffd74000: Additional properties are not allowed ('label' was unexpected)
>>>>         From schema: Documentation/devicetree/bindings/serial/pl011.yaml
>>>
>>> I think this should go into serial.yaml instead.
>>
>> Yes，But if I add "label: true" into serial.yaml, it doesn't work. I haven't figured out why.
> 
> Change the 'additionalProperties: false' to 'unevaluatedProperties: false'.

Wow, it works. I admire you so much. You're a master.

> 
>> By the way, should "$ref: /schemas/serial.yaml#" be replaced with "$ref: /schemas/serial/serial.yaml#"?
> 
> Oh, yes! Looks like it should be fixed for the other serial schemas
> too. There is a /schemas/serial.yaml schema from dt-schema which
> predates the kernel one, but it just has the $nodename. The kernel one
> is much more complete.

All right, I'll fix them all.

> 
> Rob
> 
> .
> 

