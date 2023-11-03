Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6347DFEE5
	for <lists+linux-serial@lfdr.de>; Fri,  3 Nov 2023 06:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjKCFkJ (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 3 Nov 2023 01:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKCFkI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 3 Nov 2023 01:40:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37E01AC
        for <linux-serial@vger.kernel.org>; Thu,  2 Nov 2023 22:40:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D8DC433C8;
        Fri,  3 Nov 2023 05:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698990002;
        bh=s1MgJrMGWw3Xwqz1bPK13NGrZ9gpGHe35VsPgJPUing=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k2zR1xVlfbFd2QR2Q3iRNDsQ3ZZDzBuSa6yKJOF46MAdclosIz0H9BHZg/Umf3RaF
         R4xpznVOHZqze0y49JnT7+VH2hAJ6OFej/b7s1reDh7HIqQ/NELd0oUJNDJqv3x1Vv
         eRUl7x7sXD7Ww8vjnsFu/kIXUUFkzvQ/2/lr+oAc=
Date:   Fri, 3 Nov 2023 06:39:59 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     m.brock@vanmierlo.com
Cc:     linux-serial@vger.kernel.org
Subject: Re: tldp serial-howto subscribe link
Message-ID: <2023110336-antiviral-gooey-91c5@gregkh>
References: <b20a6176a3c83d2ac5bb708f458e7b89@vanmierlo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b20a6176a3c83d2ac5bb708f458e7b89@vanmierlo.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Nov 02, 2023 at 06:00:29PM +0100, m.brock@vanmierlo.com wrote:
> Hello,
> 
> On the TLDP Serial HOWTO page 22.4 Serial Mailing List it says to mail to
> majordomo@vger.kernel.org to subscribe.
> However the link behind the visible text links to majordomo@vger.rutgers.edu
> This looks very dodgy to me.
> https://tldp.org/HOWTO/Serial-HOWTO-22.html

Please submit a change to the TLDP author, nothing we can do about it,
sorry.

greg k-h
