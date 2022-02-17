Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAE94BA470
	for <lists+linux-serial@lfdr.de>; Thu, 17 Feb 2022 16:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242458AbiBQPd0 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 17 Feb 2022 10:33:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiBQPd0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 17 Feb 2022 10:33:26 -0500
X-Greylist: delayed 302 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Feb 2022 07:33:11 PST
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7147562F
        for <linux-serial@vger.kernel.org>; Thu, 17 Feb 2022 07:33:09 -0800 (PST)
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <lnx-linux-serial-6@m.gmane-mx.org>)
        id 1nKihR-0002Nn-GV
        for linux-serial@vger.kernel.org; Thu, 17 Feb 2022 16:28:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-serial@vger.kernel.org
From:   Grant Edwards <grant.b.edwards@gmail.com>
Subject: Opening already open serial port now sets RTS and DTR?
Date:   Thu, 17 Feb 2022 15:28:00 -0000 (UTC)
Message-ID: <sulpi0$85i$1@ciao.gmane.io>
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

It used to be that opening a serial port only set RTS and DTR if it
was a "first open". If the port was already open, subsequent opens
didn't mess up RTS and DTR. This was a very useful behavior in the
embedded world where RTS and DTR are often used to power and or
control things (reset lines, mode controls, line driver enables,
etc.).

This seems to have changed, and now _every_ open sets RTS and DTR even
if the port was already open and RTS and DTR had already been put in
the desired state.

Is there no longer any way to open an already-open serial port without
changing the state of RTS and DTR?

What was the reasoning for breaking user-application backwards
compatiblity like that?

--
Grant


