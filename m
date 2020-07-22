Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D64A2291C7
	for <lists+linux-serial@lfdr.de>; Wed, 22 Jul 2020 09:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731580AbgGVHLe (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 22 Jul 2020 03:11:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:57856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727096AbgGVHLe (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 22 Jul 2020 03:11:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B309206F5;
        Wed, 22 Jul 2020 07:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595401893;
        bh=Qq1JCrzfULqcOMGKug19xkzcyJpWj4fO4NHT0pDzsvs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jrqJnq6bYanfGKt2tciRbAai+wfqcrokv6kyAQU9ceTOOBGjSqSLjbkN1U1yp45FC
         3QbZUnQ4dUbycZDigjqcEQci7LNfUSJ+3z3kkiEf7FhNumfaVSqYsPVHWXcd3CZ0p+
         A4EAiFrfUXObJZD8YjAX0AWTBvAg1Zqhs3nRt8nk=
Date:   Wed, 22 Jul 2020 09:11:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johnson CH Chen =?utf-8?B?KOmZs+aYreWLsyk=?= 
        <JohnsonCH.Chen@moxa.com>
Cc:     Jiri Slaby <jirislaby@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Victor Yu =?utf-8?B?KOa4uOWLnee+qSk=?= <victor.yu@moxa.com>,
        Danny Lin =?utf-8?B?KOael+aUv+aYkyk=?= <danny.lin@moxa.com>
Subject: Re: [PATCH] tty: Add MOXA NPort Real TTY Driver
Message-ID: <20200722071140.GA2769446@kroah.com>
References: <HK2PR01MB328134FB2EF5F9D1E381BDA3FA610@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
 <20200714073609.GA688099@kroah.com>
 <HK2PR01MB32815CE2F455B909EA32F406FA7F0@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
 <20200716072305.GA970724@kroah.com>
 <HK2PR01MB32817A21FEDDC410F2822640FA790@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <HK2PR01MB32817A21FEDDC410F2822640FA790@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jul 22, 2020 at 07:04:00AM +0000, Johnson CH Chen (陳昭勳) wrote:
> Hi Greg,
> 
> Thanks for your response!
> 
> > > > > +	unsigned long flag;
> > > > > +	unsigned char cmd_buffer[84];
> > > > > +	unsigned char rsp_buffer[84];
> > > >
> > > > You seem to have two "static" buffers here, for your device, that 
> > > > you semi-randomly write to all over the place, but I can't find 
> > > > any locking or coordination between things that prevents multiple 
> > > > commands from not just overwritting each other.
> > > >
> > > For cmd_buffer[], we use npreal_wait_and_set_command() to make sure 
> > > cmd_buffer[] is safe to be written by checking "cmd_buffer[0] == 0".
> > 
> > And what locks are protecting you there?
> > 
> > > For rsp_buffer[], we use npreal_wait_command_completed() to make 
> > > sure rsp_buffer[] is desired by checking rsp_buffer[0] and rsp_buffer[1].
> > > Command_set and command should be checked. Besides, rsp_buffer[] is 
> > > got from user space by "NPREAL_NET_CMD_RESPONSE" in 
> > > npreal_net_ioctl().
> > 
> > Again, what locking is really handling this?
> > 
> 
> It's better to protect cmd_buffer[84] and rsp_buffer[84] by locking completely. They are safe because NPort driver should be worked with NPort daemon before, and NPort daemon is designed to be simple.

I'm sorry, but I do not understand this answer at all.  Something can be
"simple" and still be totally wrong :)

Without locking, this code is broken.

thanks,

greg k-h
