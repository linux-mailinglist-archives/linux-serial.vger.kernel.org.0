Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7B9242EF6
	for <lists+linux-serial@lfdr.de>; Wed, 12 Aug 2020 21:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgHLTPF (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 12 Aug 2020 15:15:05 -0400
Received: from static.214.254.202.116.clients.your-server.de ([116.202.254.214]:42228
        "EHLO ciao.gmane.io" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbgHLTPE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 12 Aug 2020 15:15:04 -0400
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <lnx-linux-serial-6@m.gmane-mx.org>)
        id 1k5wDG-0004Ig-FX
        for linux-serial@vger.kernel.org; Wed, 12 Aug 2020 21:15:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-serial@vger.kernel.org
From:   Sergey Organov <sorganov@gmail.com>
Subject: Re: Serial raw mode. Bug in serial driver in Linux kernel? Is documentation correct?
Date:   Wed, 12 Aug 2020 22:09:30 +0300
Message-ID: <rh1epa$guv$1@ciao.gmane.io>
References: <CA+ww9hwAzFHCYhkQUev2_VBN=8gMsxBcnExG53_gCkC6++-ScA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Cc:     Petr Slansky <slansky@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Petr Slansky <slansky@gmail.com> writes:

> Hi Linux-Serial,
>
> I was fixing "pirate-loader" for BusPirate device, firmware loader utility.
> The design followed documentation for serial communication for "row"
> serial mode but it was not working. I modified flags and utility works
> now but my modification doesn't match documentation. That is strange
> from my point of view. Have I discovered a bug in the kernel? Could
> you check??
>
> Details are here, second comment, the long one:
> https://github.com/BusPirate/Bus_Pirate/issues/140
>
> This is the core of my fix, I changed CSIZE flag:
>
>         cfmakeraw(&g_new_tio);
>
> -       g_new_tio.c_cflag |=  (CS8 | CLOCAL | CREAD);
> -       g_new_tio.c_cflag &= ~(PARENB | CSTOPB | CSIZE);

You got a bug right here. Just swap these 2 lines. You should first
clear CSIZE bits, then set CS8 size.

-- Sergey Organov

