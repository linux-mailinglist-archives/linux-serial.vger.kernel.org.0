Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4A9F127C63
	for <lists+linux-serial@lfdr.de>; Fri, 20 Dec 2019 15:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfLTOU2 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 20 Dec 2019 09:20:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:59352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727347AbfLTOU2 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 20 Dec 2019 09:20:28 -0500
Received: from [192.168.1.20] (cpe-24-28-70-126.austin.res.rr.com [24.28.70.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3952F222C2;
        Fri, 20 Dec 2019 14:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576851628;
        bh=TjXYv2XWlJjKvxWvTY76Dq/6W8AtNpr91zwOv2hzrn8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HVgwDkknfsEJq1Jwdr16JSdjPKuq8dR5FzcrGG4wEyc1QsRDmCk+byUT1vMoYusFi
         dlmBL3x3MJrmhNKgt3/O6+TGkRKdsdcxDuXXTzHYoXAqR3PUapJSHTtRrrCBo9/Mho
         JWKw1Q3iIyVqELQHUHEzJpiOf47vJvbaugS9fMAc=
Subject: Re: [PATCH] serial: ucc_uart: remove redundant assignment to pointer
 bdp
To:     Colin King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linuxppc-dev@lists.ozlabs.org,
        linux-serial@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191220001000.39859-1-colin.king@canonical.com>
From:   Timur Tabi <timur@kernel.org>
Message-ID: <2714d205-245a-a4e1-8335-53405608a286@kernel.org>
Date:   Fri, 20 Dec 2019 08:20:24 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191220001000.39859-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 12/19/19 6:10 PM, Colin King wrote:
> From: Colin Ian King<colin.king@canonical.com>
> 
> The variable bdp is being initialized with a value that is never
> read and it is being updated later with a new value. The initialization
> is redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King<colin.king@canonical.com>

Acked-by: Timur Tabi <timur@kernel.org>

Looks like this bug has been there since day 1.
