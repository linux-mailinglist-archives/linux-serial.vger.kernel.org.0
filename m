Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 314A5114CB2
	for <lists+linux-serial@lfdr.de>; Fri,  6 Dec 2019 08:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfLFHjA (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 6 Dec 2019 02:39:00 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7644 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725858AbfLFHjA (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 6 Dec 2019 02:39:00 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6DA0866EB6B8F55B86A0;
        Fri,  6 Dec 2019 15:38:55 +0800 (CST)
Received: from [127.0.0.1] (10.184.52.56) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Fri, 6 Dec 2019
 15:38:48 +0800
Subject: Re: [PATCH] tty: omap-serial: remove set but unused variable
To:     Jiri Slaby <jslaby@suse.com>, Greg KH <gregkh@linuxfoundation.org>
CC:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <huawei.libin@huawei.com>
References: <1575547476-51996-1-git-send-email-wangxiongfeng2@huawei.com>
 <20191205121310.GA389695@kroah.com>
 <64810841-5e07-c346-01f3-dfd40a3f2df0@huawei.com>
 <0d5c4085-a6dc-ae06-34f2-7d4221baa5e9@suse.com>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <c49bc94d-bc75-0b62-c34f-4ee96a35c3a6@huawei.com>
Date:   Fri, 6 Dec 2019 15:38:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <0d5c4085-a6dc-ae06-34f2-7d4221baa5e9@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.52.56]
X-CFilter-Loop: Reflected
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 2019/12/5 20:39, Jiri Slaby wrote:
> On 05. 12. 19, 13:30, Xiongfeng Wang wrote:
>>
>>
>> On 2019/12/5 20:13, Greg KH wrote:
>>> On Thu, Dec 05, 2019 at 08:04:36PM +0800, Xiongfeng Wang wrote:
>>>> Fix the following warning:
>>>> drivers/tty/serial/omap-serial.c: In function serial_omap_rlsi:
>>>> drivers/tty/serial/omap-serial.c:496:16: warning: variable ch set but not used [-Wunused-but-set-variable]
>>>>
>>>> Reported-by: Hulk Robot <hulkci@huawei.com>
>>>> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
>>>> ---
>>>>  drivers/tty/serial/omap-serial.c | 3 +--
>>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
>>>> index 6420ae5..54ee3ae 100644
>>>> --- a/drivers/tty/serial/omap-serial.c
>>>> +++ b/drivers/tty/serial/omap-serial.c
>>>> @@ -493,10 +493,9 @@ static unsigned int check_modem_status(struct uart_omap_port *up)
>>>>  static void serial_omap_rlsi(struct uart_omap_port *up, unsigned int lsr)
>>>>  {
>>>>  	unsigned int flag;
>>>> -	unsigned char ch = 0;
>>>>  
>>>>  	if (likely(lsr & UART_LSR_DR))
>>>> -		ch = serial_in(up, UART_RX);
>>>> +		serial_in(up, UART_RX);
>>>
>>> Shouldn't you be doing something with 'ch'?
>>
>> Sorry, my original thought is trying not to modify the existing logic.
>> I will look into the mechanism to see if I need to check 'ch'.
> 
> The change looks in fact correct, see:
> commit 9a12fcf8b1543c99ffcec3d61db86f0dea52dc9d
> Author: Shubhrajyoti D <shubhrajyoti@ti.com>
> Date:   Fri Sep 21 20:07:19 2012 +0530
> 
>     serial: omap: fix the reciever line error case
> 
> It also says: "This is recommended in the interrupt reset method in the
> table 23-246 of the omap4 TRM."
> 
> The character read is erroneous and should be apparently dropped. But
> you should add a comment about it, though.
> 

Thanks a lot. I will add it in the comment and send another version.

Thanks,
Xiongfeng

> thanks,
> 

