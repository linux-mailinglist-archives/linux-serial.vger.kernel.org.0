Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4E083E8E
	for <lists+linux-serial@lfdr.de>; Wed,  7 Aug 2019 03:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfHGBII (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 6 Aug 2019 21:08:08 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54864 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727532AbfHGBII (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 6 Aug 2019 21:08:08 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EB744C981C2EC0C83DA2;
        Wed,  7 Aug 2019 09:08:06 +0800 (CST)
Received: from [127.0.0.1] (10.133.217.137) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Wed, 7 Aug 2019
 09:08:03 +0800
Subject: Re: [PATCH v1 1/9] serial: 8250_dw: Use a unified new dev variable in
 remove
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-serial@vger.kernel.org>
References: <20190806094322.64987-1-andriy.shevchenko@linux.intel.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <67ea2bb0-2cc3-6629-725f-1e298633e826@huawei.com>
Date:   Wed, 7 Aug 2019 09:08:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190806094322.64987-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.217.137]
X-CFilter-Loop: Reflected
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>

On 2019/8/6 17:43, Andy Shevchenko wrote:
> The commit 2cb78eab2376 ("serial: 8250_dw: Use a unified new dev variable in
> probe") introduced a local dev variable in ->probe(). Do the same in ->remove()
> in order to prepare for sequential patches.
> 
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/tty/serial/8250/8250_dw.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index 284e8d052fc3..7b559f969f61 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -667,8 +667,9 @@ static int dw8250_probe(struct platform_device *pdev)
>  static int dw8250_remove(struct platform_device *pdev)
>  {
>  	struct dw8250_data *data = platform_get_drvdata(pdev);
> +	struct device *dev = &pdev->dev;
>  
> -	pm_runtime_get_sync(&pdev->dev);
> +	pm_runtime_get_sync(dev);
>  
>  	serial8250_unregister_port(data->line);
>  
> @@ -680,8 +681,8 @@ static int dw8250_remove(struct platform_device *pdev)
>  	if (!IS_ERR(data->clk))
>  		clk_disable_unprepare(data->clk);
>  
> -	pm_runtime_disable(&pdev->dev);
> -	pm_runtime_put_noidle(&pdev->dev);
> +	pm_runtime_disable(dev);
> +	pm_runtime_put_noidle(dev);
>  
>  	return 0;
>  }
> 

