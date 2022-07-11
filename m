Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04FD55D67F
	for <lists+linux-serial@lfdr.de>; Tue, 28 Jun 2022 15:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239524AbiF0MIX (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 27 Jun 2022 08:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240483AbiF0MHp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 Jun 2022 08:07:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4775DF0E
        for <linux-serial@vger.kernel.org>; Mon, 27 Jun 2022 05:06:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63781B801BF
        for <linux-serial@vger.kernel.org>; Mon, 27 Jun 2022 12:06:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A88AEC341C7;
        Mon, 27 Jun 2022 12:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656331596;
        bh=EYuoS1lL2IJYGfEIZNc7+1Wt4msTbpvVkFnpUDH2KWc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MlFF1Hx44WnGtJIJkjdP/9LKPG0hHmhpaYGRZOiXBKq4R+rCyoWPRp2KiCswzaTq5
         7ANAmMtv765WbuwIgYOYOnFq36VbOQ5+0gseWAD3KioFhh8lINWrkrsja3rQmwqAix
         hLZsBtJ8T7HF3MU+NDycIjrzPSyyZsvSRtk+zCOE=
Date:   Mon, 27 Jun 2022 14:05:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     cael <juanfengpy@gmail.com>
Cc:     jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com,
        benbjiang@tencent.com, robinlai@tencent.com,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v5] tty: fix hang on tty device with no_room set
Message-ID: <YrmdEJrM3z6Dbvgn@kroah.com>
References: <YqmmdRynrDSzNL0W@kroah.com>
 <1655291821-19676-1-git-send-email-juanfengpy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1655291821-19676-1-git-send-email-juanfengpy@gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jun 15, 2022 at 07:17:01PM +0800, cael wrote:
> From: caelli <juanfengpy@gmail.com>

Can you please use the name you use to sign legal documents as the
number of different names being used and written here is totally
confusing.  Please use your native language if that's an issue, that
would be best.

Also, why not use your corporate email address as the From: and
signed-off-by line also?  That is preferred, and in this case, I'm going
to ask for it given the confusion that has happened so far in this
thread in the past.

thanks,

greg k-h
