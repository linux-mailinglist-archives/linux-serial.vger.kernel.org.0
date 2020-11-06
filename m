Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4727A2A8D75
	for <lists+linux-serial@lfdr.de>; Fri,  6 Nov 2020 04:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbgKFDT4 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 5 Nov 2020 22:19:56 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:7463 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgKFDT4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 5 Nov 2020 22:19:56 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CS5Gw3PcHzhcjW;
        Fri,  6 Nov 2020 11:19:52 +0800 (CST)
Received: from [10.174.177.149] (10.174.177.149) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Fri, 6 Nov 2020 11:19:53 +0800
Subject: Re: [PATCH v2] serial: txx9: add missing platform_driver_unregister()
 on error in serial_txx9_init
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jiri Slaby <jirislaby@kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20201103073341.144512-1-miaoqinglang@huawei.com>
 <20201103074533.GA2504333@kroah.com>
From:   Qinglang Miao <miaoqinglang@huawei.com>
Message-ID: <7c860bb7-d587-59b6-f4e3-02c9e497244a@huawei.com>
Date:   Fri, 6 Nov 2020 11:19:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20201103074533.GA2504333@kroah.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.149]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



�� 2020/11/3 15:45, Greg Kroah-Hartman д��:
> On Tue, Nov 03, 2020 at 03:33:41PM +0800, Qinglang Miao wrote:
>> Add the missing platform_driver_unregister() before return
>> from serial_txx9_init in the error handling case when failed
>> to register serial_txx9_pci_driver with macro ENABLE_SERIAL_TXX9_PCI
>> defined.
>>
>> Fixes: ab4382d27412 ("tty: move drivers/serial/ to drivers/tty/serial/")
>> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
>> ---
>>   drivers/tty/serial/serial_txx9.c | 3 +++
>>   1 file changed, 3 insertions(+)
> 
> What changed from v1?  Always put that below the --- line.
> 
> Please fix up and send v3.
> 
> thanks,
> 
> greg k-h
> .
Hi Greg,

Sorry about that. I've resent a new v3 patch showing the changes.

Thanks.
> 
