Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D50BC215D63
	for <lists+linux-serial@lfdr.de>; Mon,  6 Jul 2020 19:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbgGFRoK (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 6 Jul 2020 13:44:10 -0400
Received: from muru.com ([72.249.23.125]:60904 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729740AbgGFRoJ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 6 Jul 2020 13:44:09 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 648BC80FE;
        Mon,  6 Jul 2020 17:45:02 +0000 (UTC)
Date:   Mon, 6 Jul 2020 10:44:06 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Anatoly Pugachev <matorola@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2] serial: core: Initialise spin lock before use in
 uart_configure_port()
Message-ID: <20200706174406.GT53169@atomide.com>
References: <20200706143548.63985-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706143548.63985-1-andriy.shevchenko@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

* Andy Shevchenko <andriy.shevchenko@linux.intel.com> [200706 14:36]:
> Tony, can you also test that this doesn't change anything for the PM case for
> OMAP?

Still works for me just fine. Feel free to add:

Tested-by: Tony Lindgren <tony@atomide.com>
