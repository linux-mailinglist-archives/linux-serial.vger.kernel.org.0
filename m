Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37B9820A97D
	for <lists+linux-serial@lfdr.de>; Fri, 26 Jun 2020 02:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgFZABv (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 25 Jun 2020 20:01:51 -0400
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:37904 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgFZABu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 25 Jun 2020 20:01:50 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 844572059C8E;
        Fri, 26 Jun 2020 08:01:48 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bAkzo2msYY5V; Fri, 26 Jun 2020 08:01:48 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 649EA20020FC;
        Fri, 26 Jun 2020 08:01:48 +0800 (HKT)
Received: from [10.128.2.32] (unknown [124.217.188.20])
        by s01.gtsys.com.hk (Postfix) with ESMTPSA id 31F4CC01B7A;
        Fri, 26 Jun 2020 08:01:48 +0800 (HKT)
Subject: Re: rk3399: uart2 crippled signal on tx @115200
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
To:     linux-arm@lists.infradead.org, linux-serial@vger.kernel.org
Cc:     Jack Lo <jack.lo@gtsys.com.hk>
References: <4d7fde0a-58f0-485f-41e6-2cb0b36decbc@gtsys.com.hk>
Message-ID: <d5a0c84f-aa87-459b-fc48-4d635ef17318@gtsys.com.hk>
Date:   Fri, 26 Jun 2020 08:01:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <4d7fde0a-58f0-485f-41e6-2cb0b36decbc@gtsys.com.hk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 18/6/2020 6:10 pm, Chris Ruehl wrote:
> Hi,
> 
> I run into a strange thing on our customized RK3399-LPDDR4 using the UART2 
> @115200 the
> console spits bad charters. Checking the signal at the TX explains the reason, 
> the rising edge
> is very slow, (we checked with the scope).
> Set the GPIO4_C4 to pcfg_pull_up_20am not working.
> 
> Kernel: 5.4.40-rt
> Uboot: 2020-4
> 
> The strange observation:
> U-boot TPL boot , return to Boot-rom and the 1st
> lines from SPL (show uboot version) have a sharp rising edge as expected.
> 
> Anyone?  I don't know anymore.
> 
> Regards
> Chris


Solved. rk3399 io_domain problem supply 3.3v for all rails.
one was configured for 1.8v and that confused the rk808 had
reverence voltage on the uart block 2.5v not 1.5v.

all good now.

Chris
