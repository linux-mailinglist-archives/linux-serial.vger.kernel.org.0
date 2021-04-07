Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E67357279
	for <lists+linux-serial@lfdr.de>; Wed,  7 Apr 2021 18:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347798AbhDGQ4h (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 7 Apr 2021 12:56:37 -0400
Received: from thorn.bewilderbeest.net ([71.19.156.171]:41927 "EHLO
        thorn.bewilderbeest.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354403AbhDGQ4g (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Apr 2021 12:56:36 -0400
Received: from hatter.bewilderbeest.net (unknown [IPv6:2600:6c44:7f:ba20::7c6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 8E0D1187;
        Wed,  7 Apr 2021 09:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1617814575;
        bh=tLsAzb4i+D0tHvFBkFiYQRURgrJ6ldDUceF5S9p3Lcs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cKG2oYmQSpuqwag1Pf2GiaevvuxrJjNxMrJbyl32waUHhoxaKS0SFLd2SvT2OtfOM
         hO3TaY7+itpDV1HEcyEWcYoMQYTnFUEVxggySVa6TWZgKUPxJM3MfOzmc3SJ7DHUOh
         FAV5ZAWCm9vH+MuStTVP11xStVMMn3DDuRlXduPc=
Date:   Wed, 7 Apr 2021 11:56:04 -0500
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joel Stanley <joel@jms.id.au>, openbmc@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Andrew Jeffery <andrew@aj.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        - <devicetree@vger.kernel.org>, linux-serial@vger.kernel.org
Subject: Re: [PATCH v4 1/4] dt-bindings: serial: 8250: deprecate
 aspeed,sirq-polarity-sense
Message-ID: <YG3kJC+6gLC6RzzQ@hatter.bewilderbeest.net>
References: <20210402182724.20848-1-zev@bewilderbeest.net>
 <20210402182724.20848-2-zev@bewilderbeest.net>
 <YG3NR4bGRjIGZhgx@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YG3NR4bGRjIGZhgx@kroah.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Apr 07, 2021 at 10:18:31AM CDT, Greg Kroah-Hartman wrote:
>On Fri, Apr 02, 2021 at 01:27:21PM -0500, Zev Weiss wrote:
>> This property ties SIRQ polarity to SCU register bits that don't
>> necessarily have any direct relationship to it; the only use of it
>> was removed in commit c82bf6e133d30e0f9172a20807814fa28aef0f67.
>
>Please write that as:
>	c82bf6e133d3 ("ARM: aspeed: g5: Do not set sirq polarity")
>

Ack, will do.

>> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
>> Reviewed-by: Joel Stanley <joel@jms.id.au>
>> ---
>>  Documentation/devicetree/bindings/serial/8250.yaml | 1 +
>>  1 file changed, 1 insertion(+)
>
>What changed from previous versions?  That always goes below the ---
>line.
>

I included an overview of that in the cover letter 
(https://lore.kernel.org/openbmc/20210402182724.20848-1-zev@bewilderbeest.net/); 
is it desirable to also have that duplicated in the individual patches 
in the series?


Zev
Zev

