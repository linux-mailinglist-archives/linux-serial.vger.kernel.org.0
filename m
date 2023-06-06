Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E9A7248FF
	for <lists+linux-serial@lfdr.de>; Tue,  6 Jun 2023 18:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbjFFQYN (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 6 Jun 2023 12:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233287AbjFFQYM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 6 Jun 2023 12:24:12 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E39AC1726;
        Tue,  6 Jun 2023 09:23:36 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 35F3F80AE;
        Tue,  6 Jun 2023 16:23:36 +0000 (UTC)
Date:   Tue, 6 Jun 2023 19:23:35 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] serial: core: don't kfree device managed data
Message-ID: <20230606162335.GN56720@atomide.com>
References: <ZH7tsTmWY5b/4m+6@moroto>
 <20230606122843.GJ56720@atomide.com>
 <ZH8x3eNGB6DBg96L@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH8x3eNGB6DBg96L@smile.fi.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

* Andy Shevchenko <andriy.shevchenko@linux.intel.com> [230606 13:17]:
> On Tue, Jun 06, 2023 at 03:28:43PM +0300, Tony Lindgren wrote:
> > * Dan Carpenter <dan.carpenter@linaro.org> [230606 08:26]:
> > > The put_device() function will call serial_base_ctrl_release() or
> > > serial_base_port_release() so these kfrees() are a double free bug.
> > > 
> > > Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
> > > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > 
> > Thanks for catching it:
> > 
> > Reviewed-by: Tony Lindgren <tony@atomide.com>
> 
> Be careful, we can now get memory leaks :-)

I'll start doing Reviewed-by-my-hazy-understanding :)

Regards,

Tony
