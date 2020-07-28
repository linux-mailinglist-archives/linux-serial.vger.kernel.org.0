Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA0023141B
	for <lists+linux-serial@lfdr.de>; Tue, 28 Jul 2020 22:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbgG1Uky (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 28 Jul 2020 16:40:54 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:50086 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728430AbgG1Uky (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 28 Jul 2020 16:40:54 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id F165D1C0BEB; Tue, 28 Jul 2020 22:40:52 +0200 (CEST)
Date:   Tue, 28 Jul 2020 22:40:52 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "Johnson CH Chen (???L??)" <JohnsonCH.Chen@moxa.com>
Cc:     Jiri Slaby <jirislaby@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: [PATCH] tty: Add MOXA NPort Real TTY Driver
Message-ID: <20200728204052.GE1012@bug>
References: <HK2PR01MB328134FB2EF5F9D1E381BDA3FA610@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HK2PR01MB328134FB2EF5F9D1E381BDA3FA610@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi!

> +	  This driver can also be built as a module. The module will be called
> +	  npreal2 by setting M.

Odd wording...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
