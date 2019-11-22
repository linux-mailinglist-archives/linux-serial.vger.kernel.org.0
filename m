Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFCC107174
	for <lists+linux-serial@lfdr.de>; Fri, 22 Nov 2019 12:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfKVLd7 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 22 Nov 2019 06:33:59 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7167 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726563AbfKVLd7 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 22 Nov 2019 06:33:59 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7E1134FD29F0237A331A;
        Fri, 22 Nov 2019 19:33:53 +0800 (CST)
Received: from [127.0.0.1] (10.173.221.225) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Fri, 22 Nov 2019
 19:33:48 +0800
From:   Chen Wandun <chenwandun@huawei.com>
Subject: Re: [PATCH] {tty: serial, nand: onenand}: remove variable 'ufstat'
 set but not used
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <jslaby@suse.com>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1574421159-113624-1-git-send-email-chenwandun@huawei.com>
 <20191122111410.GA2024666@kroah.com>
Message-ID: <62b2cfc1-416c-f7c7-3029-6dd7ad12ea46@huawei.com>
Date:   Fri, 22 Nov 2019 19:33:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191122111410.GA2024666@kroah.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.221.225]
X-CFilter-Loop: Reflected
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 2019/11/22 19:14, Greg KH wrote:
> On Fri, Nov 22, 2019 at 07:12:39PM +0800, Chen Wandun wrote:
>> Fixes gcc '-Wunused-but-set-variable' warning:
>>
>> drivers/tty/serial/samsung_tty.c: In function s3c24xx_serial_rx_chars_dma:
>> drivers/tty/serial/samsung_tty.c:549:24: warning: variable ufstat set but not used [-Wunused-but-set-variable]
>>
>> Signed-off-by: Chen Wandun <chenwandun@huawei.com>
> 
> Your subject line is really odd, can you please fix that up and resend?
I check the git log of drivers/tty/serial/samsung_tty.c,
it seem like the subject line should be:
{tty: serial, nand: onenand}: samsung: remove variable 'ufstat' set but not used

Is that OK?

Thanks
Chen Wandun
> 
> thanks,
> 
> greg k-h
> 
> .
> 

