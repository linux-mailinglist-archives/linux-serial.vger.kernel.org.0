Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9F49130C9
	for <lists+linux-serial@lfdr.de>; Fri,  3 May 2019 16:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfECO5f (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 3 May 2019 10:57:35 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55220 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbfECO5f (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 3 May 2019 10:57:35 -0400
Received: by mail-wm1-f65.google.com with SMTP id b10so7487149wmj.4
        for <linux-serial@vger.kernel.org>; Fri, 03 May 2019 07:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OVZXpzX2/H9jJjV5448BfKXXASMqgdrpjS+oYJ8297Y=;
        b=qit253pzGtgooiEkFUJx2wIpCZOrs8Jzw6T/TbRhiCCv80wliQo2+jB4wjOh+RhON4
         spKjMPrNXkt7ZTGpTUK1K+0EaPMJ5OfsbTf8fv7qGbhLNJxC3Jprx/tsNl53GwhPGcyL
         BDhWowzQgcNiQfWFOZ7S7oFzs77CP+s7GEw9ZN/0aqmiCzO02DZdue/jU8euL/lA+uP3
         IQx4BmTMD99s/O+5b7kHvoc5A45SjOth1dyJsnhLyO50WOn/JVw+nfJZxYcm13HVQAth
         DYsXcV4n10T/JL8bCFSdKYKhvPwtTJiM7+mb+hzYxMA66TFsBfMv0ftNkXJBfZzLdQ4F
         haGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OVZXpzX2/H9jJjV5448BfKXXASMqgdrpjS+oYJ8297Y=;
        b=iAHVbDK/S1g3q+6TulQtGJATB+v+lb6GDgvkE/mX9MUNy6g3bS6VhTkY6f4Ahacz1w
         qQfqvOiQb8TIGzI5cfUhjdKwXW7eaGdIkaML5mvLbMpJBC8b7L5iTy51n66GEYOiMnFm
         K+7m5bjnyHP00CnyqmyIv6B5G5trge6CwKE19SPbpJR8iIQarLoh8xLFFYUeVyNmN4N1
         sKdjD+4QY6Bg51e67T9fhL3RNRPAmqrs9bq1rhn6Ie5RiLjlN9XvLbhqs/yjFdQw2T5X
         Zw2YU0yZU1EgazqtNujvv4zT/SB5/vbqERVRIpfoxqsge3wrcEaSupw/WB0vkL+WJ570
         Jiog==
X-Gm-Message-State: APjAAAXibeeFewOaw6A1wTGl28oDorxUwexcrZOHtLo0vLn6iZ0QmuS0
        aD/nbA52juiLKVLiJTvv9Wd7ckpP
X-Google-Smtp-Source: APXvYqxpxu72IgW60NhqEV3BpchcjLpGVjf0O+cAR1IdxgNdqDNaomB6ICmVJeKRq4xv2vkVrcB86g==
X-Received: by 2002:a1c:a541:: with SMTP id o62mr6501122wme.22.1556895449548;
        Fri, 03 May 2019 07:57:29 -0700 (PDT)
Received: from ?IPv6:2a00:23c5:f786:ec00:1128:f7da:df35:f704? ([2a00:23c5:f786:ec00:1128:f7da:df35:f704])
        by smtp.googlemail.com with ESMTPSA id s145sm3748527wme.38.2019.05.03.07.57.28
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 07:57:29 -0700 (PDT)
Subject: Re: [PATCH] serial: 8250: Fix TX interrupt handling condition
To:     Rautkoski Kimmo EXT <ext-kimmo.rautkoski@vaisala.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
References: <1556280367-28685-1-git-send-email-ext-kimmo.rautkoski@vaisala.com>
 <20190429141915.GB12903@kroah.com>
 <HE1PR06MB30986E007789F2DAB69F2E33B4350@HE1PR06MB3098.eurprd06.prod.outlook.com>
From:   Ian Arkver <ian.arkver.dev@gmail.com>
Message-ID: <d4bc7860-c54b-571f-a4f9-1785fade15a1@gmail.com>
Date:   Fri, 3 May 2019 15:57:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <HE1PR06MB30986E007789F2DAB69F2E33B4350@HE1PR06MB3098.eurprd06.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi.

On 03/05/2019 13:10, Rautkoski Kimmo EXT wrote:
> 
> 
>> -----Original Message-----
>> From: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
>> Sent: Monday, 29 April, 2019 17:19
>> To: Rautkoski Kimmo EXT <ext-kimmo.rautkoski@vaisala.com>
>> Cc: linux-serial@vger.kernel.org
>> Subject: Re: [PATCH] serial: 8250: Fix TX interrupt handling condition
>>
>> On Fri, Apr 26, 2019 at 12:06:13PM +0000, Rautkoski Kimmo EXT wrote:
>>> Interrupt handler checked THRE bit (transmitter holding register
>>> empty) in LSR to detect if TX fifo is empty.
>>> In case when there is only receive interrupts the TX handling
>>> got called because THRE bit in LSR is set when there is no
>>> transmission (FIFO empty). TX handling caused TX stop, which in
>>> RS-485 half-duplex mode actually resets receiver FIFO. This is not
>>> desired during reception because of possible data loss.
>>>
>>> The fix is to use IIR instead of LSR to detect the TX fifo status.
>>> This ensures that TX handling is only called when there is really
>>> an interrupt for THRE and not when there is only RX interrupts.
>>>
>>> Signed-off-by: Kimmo Rautkoski <ext-kimmo.rautkoski@vaisala.com>
>>> ---
>>>   drivers/tty/serial/8250/8250_port.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/tty/serial/8250/8250_port.c
>> b/drivers/tty/serial/8250/8250_port.c
>>> index d2f3310..91ca0ca 100644
>>> --- a/drivers/tty/serial/8250/8250_port.c
>>> +++ b/drivers/tty/serial/8250/8250_port.c
>>> @@ -1875,7 +1875,7 @@ int serial8250_handle_irq(struct uart_port *port,
>> unsigned int iir)
>>>   			status = serial8250_rx_chars(up, status);
>>>   	}
>>>   	serial8250_modem_status(up);
>>> -	if ((!up->dma || up->dma->tx_err) && (status & UART_LSR_THRE))
>>> +	if ((!up->dma || up->dma->tx_err) && (iir & UART_IIR_THRI))
>>>   		serial8250_tx_chars(up);
>>
>> This feels wrong to me, can someone else test this to verify that it
>> really does work properly?  I don't have access to any 8250 devices at
>> the moment :(
>>
>> thanks,
>>
>> greg k-h
> 
> Thanks for checking this. There is indeed a problem with the patch. Interrupt ID in Interrupt Identification register is actually 3 bits, so the check should be different: ((iir & UART_IIR_ID) == UART_IIR_THRI)
> 
> I'll send v2 of the patch soon.

Rather than switching to the IIR which can have other meanings for 
devices with FIFOs (eg. FIFO space avail), or may be flaky (see 
UART_BUG_THRE), could you continue to use the LSR THRE bit but also 
check for up->ier & UART_IER_THRI. This is set in __start_tx and cleared 
in __do_stop_tx.

It's really just doing in software what the IIR hardware should in 
theory be doing for a regular 8250.

Disclaimer: I don't have any such devices either.

Regards,
Ian

> 
> BR,
> Kimmo
> 
