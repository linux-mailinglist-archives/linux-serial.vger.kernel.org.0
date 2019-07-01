Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C858F17953
	for <lists+linux-serial@lfdr.de>; Wed,  8 May 2019 14:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbfEHMWK (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 8 May 2019 08:22:10 -0400
Received: from mx.socionext.com ([202.248.49.38]:8119 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728469AbfEHMWJ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 8 May 2019 08:22:09 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 08 May 2019 21:22:07 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 603886117D;
        Wed,  8 May 2019 21:22:07 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 8 May 2019 21:22:07 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id D14B81A04E1;
        Wed,  8 May 2019 21:22:06 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
        by yuzu.css.socionext.com (Postfix) with ESMTP id BCB33121BCE;
        Wed,  8 May 2019 21:22:06 +0900 (JST)
Subject: Re: [PATCH v3] serial: Add Milbeaut serial control
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <1555555916-22251-1-git-send-email-sugaya.taichi@socionext.com>
 <20190426191515.757e6015@alans-desktop>
From:   "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Message-ID: <93002681-37f8-cb12-725c-48c1695d29a0@socionext.com>
Date:   Wed, 8 May 2019 21:22:05 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190426191515.757e6015@alans-desktop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

Thank you for pointing out.

On 2019/04/27 3:15, Alan Cox wrote:
> O
>> +static void mlb_usio_set_termios(struct uart_port *port,
>> +			struct ktermios *termios, struct ktermios *old)
>> +{
>> +	unsigned int escr, smr = MLB_USIO_SMR_SOE;
>> +	unsigned long flags, baud, quot;
>> +
>> +	switch (termios->c_cflag & CSIZE) {
>> +	case CS5:
>> +		escr = MLB_USIO_ESCR_L_5BIT;
>> +		break;
>> +	case CS6:
>> +		escr = MLB_USIO_ESCR_L_6BIT;
>> +		break;
>> +	case CS7:
>> +		escr = MLB_USIO_ESCR_L_7BIT;
>> +		break;
>> +	case CS8:
>> +	default:
>> +		escr = MLB_USIO_ESCR_L_8BIT;
>> +		break;
>> +	}
>> +
>> +	if (termios->c_cflag & CSTOPB)
>> +		smr |= MLB_USIO_SMR_SBL;
>> +
>> +	if (termios->c_cflag & PARENB) {
>> +		escr |= MLB_USIO_ESCR_PEN;
>> +		if (termios->c_cflag & PARODD)
>> +			escr |= MLB_USIO_ESCR_P;
>> +	}
> 
> If you don't suport CMSPAR then clear that bit in termios as well
> 

OK, clear the bit because of not supported.

>> +	/* Set hard flow control */
>> +	if (of_property_read_bool(port->dev->of_node, "auto-flow-control") ||
>> +			(termios->c_cflag & CRTSCTS))
>> +		escr |= MLB_USIO_ESCR_FLWEN;
> 
> That's just broken. The termios bits are the definitive things for the
> port, and in addition even if they are forced you need to correct the
> termios data.
> 
> You might want to control flow control *at boot* with an OF property but
> doing it post boot is just busted.
> 

Ah, Yes.
I think OF property should not be here, and it may only be used to determine
the characteristics of the port.
I try to make a fixes patch.

Thanks,
Sugaya Taichi


> Alan
> 

