Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E928724490
	for <lists+linux-serial@lfdr.de>; Tue,  6 Jun 2023 15:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237571AbjFFNhy (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 6 Jun 2023 09:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237655AbjFFNhx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 6 Jun 2023 09:37:53 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6CF2EE6B;
        Tue,  6 Jun 2023 06:37:51 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 8B5F480AE;
        Tue,  6 Jun 2023 13:37:50 +0000 (UTC)
Date:   Tue, 6 Jun 2023 16:37:49 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] serial: core: don't kfree device managed data
Message-ID: <20230606133749.GK56720@atomide.com>
References: <ZH7tsTmWY5b/4m+6@moroto>
 <ZH8xwKuI9WqRUu5H@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH8xwKuI9WqRUu5H@smile.fi.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

* Andy Shevchenko <andriy.shevchenko@linux.intel.com> [230606 13:16]:
> On Tue, Jun 06, 2023 at 11:26:25AM +0300, Dan Carpenter wrote:
> > The put_device() function will call serial_base_ctrl_release() or
> > serial_base_port_release() so these kfrees() are a double free bug.
> 
> ...
> 
> These labels are also called without device being even added.
> So, this is not good enough as far as I can tell.

I guess you mean the possibe error returned from the call to
serial_base_device_init()?

If serial_base_device_init() fails, we return error and end up doing
the put_device().

We have serial_base_device_init() call device_initialize(), is that
not enough for put_device()?

Regards,

Tony
