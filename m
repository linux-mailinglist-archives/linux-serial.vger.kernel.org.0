Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6DD131E2E5
	for <lists+linux-serial@lfdr.de>; Thu, 18 Feb 2021 00:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhBQXEX (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 17 Feb 2021 18:04:23 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:52695 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbhBQXEW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 17 Feb 2021 18:04:22 -0500
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 2F1FB3A413A
        for <linux-serial@vger.kernel.org>; Wed, 17 Feb 2021 22:54:57 +0000 (UTC)
X-Originating-IP: 37.173.76.174
Received: from windsurf.home (unknown [37.173.76.174])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 64B9EC0002;
        Wed, 17 Feb 2021 22:53:49 +0000 (UTC)
Date:   Wed, 17 Feb 2021 23:53:45 +0100
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Alexander Shiyan <shc_work@mail.ru>
Cc:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH] Revert "serial: max310x: rework RX interrupt handling"
Message-ID: <20210217235345.7326201b@windsurf.home>
In-Reply-To: <20210217080608.31192-1-shc_work@mail.ru>
References: <20210217080608.31192-1-shc_work@mail.ru>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello,

On Wed, 17 Feb 2021 11:06:08 +0300
Alexander Shiyan <shc_work@mail.ru> wrote:

> This reverts commit fce3c5c1a2d9cd888f2987662ce17c0c651916b2.
> 
> FIFO is triggered 4 intervals after receiving a byte, it's good
> when we don't care about the time of reception, but are only
> interested in the presence of any activity on the line.
> Unfortunately, this method is not suitable for all tasks,
> for example, the RS-485 protocol will not work properly,
> since the state machine must track the request-response time
> and after the timeout expires, a decision is made that the device
> on the line is not responding.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Thanks for the feedback. Should we switch between one mode and the
other depending on whether RS232 or RS485 is used ? Or is there some
appropriate user-space interface to ask the UART driver to tweak this
kind of configuration ?

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
