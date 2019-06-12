Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 201CF42EBF
	for <lists+linux-serial@lfdr.de>; Wed, 12 Jun 2019 20:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbfFLSdK (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 12 Jun 2019 14:33:10 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:43885 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfFLSdK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 12 Jun 2019 14:33:10 -0400
Received: from [192.168.1.110] ([95.115.5.111]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N2lzA-1ie8Ge2hga-013AP5; Wed, 12 Jun 2019 20:33:08 +0200
Subject: Re: RFC: can we get rid of ->request_port() boilerplate ?
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
References: <999dbc29-8254-7168-1fa0-7caf03bb6d77@metux.net>
 <20190611185252.GA3951@kroah.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <4a26310b-13b6-180a-1b07-a94c1859a266@metux.net>
Date:   Wed, 12 Jun 2019 20:33:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190611185252.GA3951@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:yhxKkYpAbXahYoZFDnK8zIo/tFamugXqUgzJt5LG0vugCpHbJ/t
 gR81JlFSDAmQC0lzjPEjqnSTZhCaSoitaP9RIhzB1yIUzPrdb1FAskz3sO8IS5ky+gd/2uR
 cdyhoZhact0DzD08YFDeDDQUDoz/SXapjKWC8rxbTALXN3tp7KmJ6Kph1BM2ZEniFlRYTdQ
 klc78Ufcfx1jYrt4KvwxA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VkkYKDvQSSo=:/XoCDugq/2T7sBGgYX81wb
 WjlZ0qHb//Jjr9AShVWZi+O4cFzIvdCsivPnKsYsuFixAoQqpuCOs3qCc2VK2y38d6CeMujis
 MQOlO4+sAtoSwYY9ph6NniLotpTLNG2v7pX5NPGmRhvXdu97umQD52OucTWiV4e4a29QcDypi
 r7BLsb0M4ZaVOtgRbBwthW/5ihM5sUBPPnQIYiJwJoZA0Yo20/9lJpfpQfE2ydsLe4AzfC8CA
 M2YJtKl2Vj41ineSyUAT3QwFTn+jsvKclY1l7gWgbptKgwN1VX1OcBnB2qjktPAa7+Kbx0Vqu
 BAzXPRPm4WBypJhDNZYQPeKJQVIBX5DNzmJ6JTEx0IX2jz1gy0PyipKxIv0QfYfQ+UVMOZv/D
 AqiO9S8P10nV++7y+c9FXug3pWNa3gz6brguj2L4OqvdbkdzFLAx4f0OJ2oBrNxr0VuSgj0RE
 0JZHiuB6LW6SAqA+Inzkq9GbkKeugyOeQGVxoWiZp37mcJq/TD9ESm2v1Fx/Qf9GJ4KaHkstb
 XNn5Ehuk1mscQAM6QB0SdLlJ0OzdcPACnDPoNoXotKTDSsY+oJ71L/Won8rJnXInG9Uk/IqWk
 jZPEJoclycQhwEqBnGPGMAxdo23+kaVCHGUe/SqXOnQxfqZtstIn7XTDmeHjxKDcUFkVfRall
 evt6zPmbAoM1gI/hjx758pWbW/YKggJOLqxh+6/OleoBtlO3lrnBd8untRHVJeGCropaF7o5F
 oLDEoPkr5sKrXIHvjbeaKOmxZod8PAbni640VDIppfgakhH+FJErowaezC0=
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 11.06.19 20:52, Greg KH wrote:

Hi,

>> What's your oppinion on that ?> > Why would this help anything?
I just had the naive idea that more compact code was easier to maintain.
At least in other areas of the kernel, there seems to be a tendency of
moving repeated code patterns into helpers.

>> If you like, I can prepare some patches and post them here.> > kernel development is done with actual patches, almost never with
"would> this be a good idea", as you never know if it will or not until
you> actually do the work.

I've made the experience that certain maintainers seem to be quite
reluctant of changing anything, if it doesn't fix any actual bug,
so I've preferred to ask first, before wasting much time on something
that won't be accepted anyways :o


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
