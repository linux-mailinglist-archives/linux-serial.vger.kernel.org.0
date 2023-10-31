Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0E77DCB27
	for <lists+linux-serial@lfdr.de>; Tue, 31 Oct 2023 11:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343993AbjJaKwy (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 31 Oct 2023 06:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344000AbjJaKww (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 31 Oct 2023 06:52:52 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B245ED
        for <linux-serial@vger.kernel.org>; Tue, 31 Oct 2023 03:52:50 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 2BC0B809C;
        Tue, 31 Oct 2023 10:52:49 +0000 (UTC)
Date:   Tue, 31 Oct 2023 12:52:47 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Thomas Richard <thomas.richard@bootlin.com>
Cc:     Kevin Hilman <khilman@kernel.org>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, linux-serial@vger.kernel.org,
        gregory.clement@bootlin.com, u-kumar1@ti.com, d-gole@ti.com,
        thomas.petazzoni@bootlin.com
Subject: Re: [PATCH] serial: 8250_omap: Set the console genpd always on if no
 console suspend
Message-ID: <20231031105247.GC57044@atomide.com>
References: <20231017130540.1149721-1-thomas.richard@bootlin.com>
 <7hfs213u0r.fsf@baylibre.com>
 <20231024045109.GT27774@atomide.com>
 <7hjzrbj29t.fsf@baylibre.com>
 <20231025064131.GZ27774@atomide.com>
 <75b6cda8-c809-409b-8be9-ad8a4db63c14@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75b6cda8-c809-409b-8be9-ad8a4db63c14@bootlin.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

* Thomas Richard <thomas.richard@bootlin.com> [231031 10:15]:
> Please find below the logs of the test you asked me.

OK great thanks!

> I added the call of pm_runtime_get_usage_count at the end of the suspend
> function.
> The console is attached on 2800000.serial, it has usage_count=4.
> Other serial has usage_count=3.

So as suspected, it seems the power domain gets force suspended
somewhere despite the usage_count.

Regards,

Tony
