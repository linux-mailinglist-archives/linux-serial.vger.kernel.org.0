Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEBFB339086
	for <lists+linux-serial@lfdr.de>; Fri, 12 Mar 2021 15:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhCLO6j (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 12 Mar 2021 09:58:39 -0500
Received: from smtp.wifcom.cz ([85.207.3.150]:37862 "EHLO smtp.wifcom.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231216AbhCLO6J (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 12 Mar 2021 09:58:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=eaxlabs.cz; s=mail;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=+ODlebsRi7UBFpuw2Qtf/wIJy/tAExCwWIBFL8tLU1Q=;
        b=Rwth2iPK6Sr8Mw/yowD1aORpKm/YGYY+WsbT/roHiNKs8ztdxtsdghyfGUUc768u1EkUHjsbkK7l1wj6txrBx5Mif+8eGbqaIubiy2yZF4Sy2cFZmfxctiF4yc2RbCGBPbxfV4cpbmxsOI98tUfGnTc7aZlzboHbbdOW+acyFCg=;
Subject: Re: [PATCH v6 1/2] dt-bindings: serial: Add rx-tx-swap to stm32-usart
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Le Ray <erwan.leray@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        fabrice.gasnier@foss.st.com, linux-arm-kernel@lists.infradead.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org
References: <YEsjMJae3cGOdyjG@kroah.com>
 <20210312102713.27776-1-devik@eaxlabs.cz>
 <1615559009.788146.2976052.nullmailer@robh.at.kernel.org>
From:   Martin DEVERA <devik@eaxlabs.cz>
Message-ID: <e1cee5c4-8802-bf6b-be06-e453af559e62@eaxlabs.cz>
Date:   Fri, 12 Mar 2021 15:56:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1615559009.788146.2976052.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-Wif-ss: -2.9 (--)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 3/12/21 3:23 PM, Rob Herring wrote:
> On Fri, 12 Mar 2021 11:27:12 +0100, Martin Devera wrote:
>> Add new rx-tx-swap property to allow for RX & TX pin swapping.
>>
>> Signed-off-by: Martin Devera <devik@eaxlabs.cz>
>> Acked-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
>> ---
>> v6:
>>    - add version changelog
>> v5:
>>    - yaml fixes based on Rob Herring comments
>>      - add serial.yaml reference
>>      - move compatible from 'then' to 'if'
>> v3:
>>    - don't allow rx-tx-swap for st,stm32-uart (suggested
>>      by Fabrice Gasnier)
>> v2:
>>    - change st,swap to rx-tx-swap (suggested by Rob Herring)
>> ---
>>   .../devicetree/bindings/serial/st,stm32-uart.yaml  | 29 ++++++++++++++--------
>>   1 file changed, 19 insertions(+), 10 deletions(-)
>>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/serial/st,stm32-uart.yaml:81:12: [warning] wrong indentation: expected 10 but found 11 (indentation)
>
> dtschema/dtc warnings/errors:
>
> See https://patchwork.ozlabs.org/patch/1451861
>
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
Yoy are right, there is one extra space. But for some reason the check 
doesn't
find it:
$ make dt_binding_check 
DT_SCHEMA_FILES=Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
   CHKDT Documentation/devicetree/bindings/processed-schema-examples.json
   SCHEMA Documentation/devicetree/bindings/processed-schema-examples.json
/home/devik/.local/lib/python3.9/site-packages/dtschema/schemas/serial/rs485.yaml: 
duplicate '$id' value 'http://devicetree.org/schemas/serial/rs485.yaml#'
   DTEX Documentation/devicetree/bindings/serial/st,stm32-uart.example.dts
   DTC 
Documentation/devicetree/bindings/serial/st,stm32-uart.example.dt.yaml
   CHECK 
Documentation/devicetree/bindings/serial/st,stm32-uart.example.dt.yaml

$ git describe
v5.12-rc2-2-g2f2a4a95dd38

$ pip3 show dtschema
Name: dtschema
Version: 2021.2.1

Any idea why ?

Thanks, Martin

