Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09EE2163F1
	for <lists+linux-serial@lfdr.de>; Tue,  7 May 2019 14:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfEGMqo (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 7 May 2019 08:46:44 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7177 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726159AbfEGMqo (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 7 May 2019 08:46:44 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1A7661B7AE2A7B4CAF6B;
        Tue,  7 May 2019 20:46:41 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Tue, 7 May 2019
 20:46:35 +0800
Subject: Re: [PATCH v2] serial: 8250_of: Use of_device_get_match_data()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-serial@vger.kernel.org>
References: <20190430184559.35206-1-andriy.shevchenko@linux.intel.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <bcf90dda-b0ca-74df-1d9d-661aca56eb02@huawei.com>
Date:   Tue, 7 May 2019 13:46:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190430184559.35206-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 30/04/2019 19:45, Andy Shevchenko wrote:
> Use of_device_get_match_data() to simplify the code a bit.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Tested-by: John Garry <john.garry@huawei.com>


