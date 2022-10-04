Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A795F4ABD
	for <lists+linux-serial@lfdr.de>; Tue,  4 Oct 2022 23:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiJDVOm (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 4 Oct 2022 17:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiJDVOk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 4 Oct 2022 17:14:40 -0400
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D9A190
        for <linux-serial@vger.kernel.org>; Tue,  4 Oct 2022 14:14:34 -0700 (PDT)
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <lnx-linux-serial-6@m.gmane-mx.org>)
        id 1ofpFI-000847-Me
        for linux-serial@vger.kernel.org; Tue, 04 Oct 2022 23:14:32 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-serial@vger.kernel.org
From:   Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: kernel 5.19.8: "Oxford Semiconductor Ltd OXPCIe952 Dual Native
 950 UART" gets wrong baudrate (PCI ID 1415:c158)
Date:   Tue, 4 Oct 2022 21:14:28 -0000 (UTC)
Message-ID: <thi7nk$tpq$1@ciao.gmane.io>
References: <ef8fd762-88cf-548a-0599-17d939ad3a57@control.lth.se>
 <YyA9maUOlPIExIUd@kroah.com>
 <ff41c70a-767a-45b8-f993-1f70ad3d9254@control.lth.se>
 <thi5m6$j7r$1@ciao.gmane.io>
User-Agent: slrn/1.0.3 (Linux)
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2022-10-04, Grant Edwards <grant.b.edwards@gmail.com> wrote:

> I just ran into what I think is the same problem when upgrading from
> 5.10.76 to 5.15.68 (sorry I don't have any intermediate kernel
> versions to test with). This is an oxford quad 950 board that has
> worked flawlessly for many years. Now the baud rates are all wrong.
>
> [...]

After reading through the thread a third time, I tried enabling
CONFIG_SERIAL_8250_16550A_VARIANTS in my 6.15.69 kernel, and my	quad
Oxford board works again.

The first two times I read through the thread I misunderstood the statement

    Can you please confirm that you have the
    CONFIG_SERIAL_8250_16550A_VARIANTS option disabled (default to
    "off" for x86 only)?

as meaning that you should disable that option as a prerequisite to
making it work. So I checked to make sure it was disabled (it
was). Yes, it's obvious now what was meant was that having it disabled
explains the previous observations.

--
Grant








