Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29F11DC30
	for <lists+linux-serial@lfdr.de>; Mon, 29 Apr 2019 08:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfD2GuW (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 29 Apr 2019 02:50:22 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:41225 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727173AbfD2GuW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 29 Apr 2019 02:50:22 -0400
Received: from [192.168.1.110] ([77.9.18.117]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M9Ezx-1hO0GD3dVH-006Rqh; Mon, 29 Apr 2019 08:50:18 +0200
Subject: Re: serial drivers polishing
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-serial@vger.kernel.org
References: <1556369542-13247-1-git-send-email-info@metux.net>
 <20190428152434.GQ9224@smile.fi.intel.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <86c7ba5b-e8bf-70fc-1eac-6b24b5681233@metux.net>
Date:   Mon, 29 Apr 2019 08:50:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190428152434.GQ9224@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:yPoE8Duf8WDLrme6LtalhtKUtn+D0SVwXYYTLMFxqt0iVMK0qZy
 DKpiqg6fjW1R9Wv6wvSFbWYCAUfBpm4+sq84nYxO8eS5N34pBuTkOhIusgzkc2UdYt0Gz9g
 laQOq/2gTW927/MPaA6nQGi9UGZyS7UycsPl/kMt3fU8372bqV8abLAdwGAWDdPyleAxdBJ
 az5C95F9TMq/bFLLnf55g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:XJeVKavZF18=:Dg5JDzuXLhAM9HLcapEk6N
 YWOC37ErZCt+P+UAzNwUqbBdNSH0kPQ+joLOCQ9NmCI1FABRmA7U0ehxDL5FC1UGTlr8Eom2s
 BRsipzwUGAPuDIv71YEc2mUDNwPRzJyEP4iXNg+tUpOOp+w54bI1okK8XSQSfo9xFQvwMmcQh
 zKMxbI1K2PdAJ2Pm8H+b5uh+HGUYTmdKz9sPXQ/xAyXlqj9B4LXlFEMLGIDjZhEYb1wHSAiJ+
 ySUvH8MfYk9rhoFKyNrEWcjYie5aD/ln3vW6p+A7yA1Lmd62yh8PaTurjl8PrQgy0QO1RspTI
 Sy38vBhdRIZmcnIfpT6cHRoOkCYC+VMWvhDPRKdQfta8ahsD7xNyLOWivSFCFmUg4qi7AIEna
 Z+e1YVLz8xl8P7O5xewT8xE0DA5a+7A2dtCtjRmWP9xX/XItpEvyQRU2X8ZhfpJ42gfGhurnK
 G8leNV/eJ2Z2D6k2ZJzpCtO8IeJYNofqp9NgYGXJATrys0tJm9d7A2hIsmFHxVdBx57h56apv
 LNc0SZ6zrt/68WuVR6LfDSa2pZCTxjoZYRHQ5rMCxs/rjQJUt2t5maVU/3O65y+vxi+RQ10P7
 6qW8/eZdmrut3wU7fC9YP8HgNRSFAv6ykbaaw2XoVpv6L4DxYDLxBz4OpqAnzL+wMGgfChbLz
 6G1iWwq+dXrAEIIe/w1UWCL3hm2eKPQy8fUHQK062P1V+CJA+TzizygS0dFGotmrbQ/5Wev8k
 ldRWVh1+JIv9ySRfR1fo3ssqXOmaL8IFP2nbvPrBGGzKJvbO6d9h8bgTXrY=
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 28.04.19 17:24, Andy Shevchenko wrote:
> On Sat, Apr 27, 2019 at 02:51:41PM +0200, Enrico Weigelt, metux IT consult wrote:
> 
> Thanks for this work.
> 
> I would really appreciate if at some point you would be able to clean up UART
> ->pm() callbacks. If you ever saw my UART runtime PM support series, it will
> need some reduction of ->pm() callbacks and rethink of its implementation.

Haven't seen it yet. Can you give me a pointer ?


--mtx


-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
