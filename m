Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB173B4C65
	for <lists+linux-serial@lfdr.de>; Sat, 26 Jun 2021 06:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhFZENu (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sat, 26 Jun 2021 00:13:50 -0400
Received: from angie.orcam.me.uk ([78.133.224.34]:60060 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbhFZENt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 26 Jun 2021 00:13:49 -0400
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 43C349200B4; Sat, 26 Jun 2021 06:11:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 3FEDF9200B3;
        Sat, 26 Jun 2021 06:11:26 +0200 (CEST)
Date:   Sat, 26 Jun 2021 06:11:26 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] serial: 8250: Fixes for Oxford Semiconductor 950
 UARTs
Message-ID: <alpine.DEB.2.21.2106260539240.37803@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

 Here's v2 of the outstanding fixes for Oxford Semiconductor 950 UARTs, 
comprising an chip-specific clock handling implementation for accurate 
baud rate selection including higher baud rates and FIFO rx trigger level 
configuration.

 NB I have since had an opportunity to check what transceiver chips have 
been used with the option card I have been experimenting with, and they've 
turned out to be the Zywyn ZT3243F, specified for up to 1Mbps, so no 
surprise they eventually gave up as the rates I have tried increased, and 
quite interesting it was only at 4Mbps that they did it.

 Please apply.

  Maciej
