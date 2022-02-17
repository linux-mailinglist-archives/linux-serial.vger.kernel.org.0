Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383904BA66B
	for <lists+linux-serial@lfdr.de>; Thu, 17 Feb 2022 17:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236533AbiBQQvH (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 17 Feb 2022 11:51:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243451AbiBQQvG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 17 Feb 2022 11:51:06 -0500
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B4E293B60
        for <linux-serial@vger.kernel.org>; Thu, 17 Feb 2022 08:50:52 -0800 (PST)
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <lnx-linux-serial-6@m.gmane-mx.org>)
        id 1nKjzX-0003hl-79
        for linux-serial@vger.kernel.org; Thu, 17 Feb 2022 17:50:51 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-serial@vger.kernel.org
From:   Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: Opening already open serial port now sets RTS and DTR?
Date:   Thu, 17 Feb 2022 16:50:45 -0000 (UTC)
Message-ID: <sulud5$d35$1@ciao.gmane.io>
References: <sulpi0$85i$1@ciao.gmane.io> <Yg5rmQxl0AKCyez2@kroah.com>
User-Agent: slrn/1.0.3 (Linux)
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2022-02-17, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Thu, Feb 17, 2022 at 03:28:00PM -0000, Grant Edwards wrote:
>> It used to be that opening a serial port only set RTS and DTR if it
>> was a "first open". [...]

>> This seems to have changed, and now _every_ open sets RTS and DTR
>> even if the port was already open and RTS and DTR had already been
>> put in the desired state.
>
> When did it change?

I'm not sure. It's been a couple years since the last time I
personally used something that relied on the "old" behavior.

> Any chance you can do 'git bisect' to track it down?

Unfortunately, it would take a lot of work to get set up to do that.

I can probably try the past half-dozen or so Ubuntu distros (I'm not
sure how far back I can go with available hardware). I'll check around
with colleagues to see if we have any existing installations that are
using on the old behavior.

> And what hardware are you using here?

I've tried a couple different FTDI USB devices (FT232R single port and
FT4232H quad port). I've also tried a 16550A motherboard UART. I
believe that both FTDI and 16550 used to set RTS/DTR only on "first
open".

> Different hardware works differently in this way at times.

Which is the "expected correct" behavior?

--
Grant


