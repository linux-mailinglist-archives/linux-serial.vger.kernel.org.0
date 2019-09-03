Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0DCA672A
	for <lists+linux-serial@lfdr.de>; Tue,  3 Sep 2019 13:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbfICLOC (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 3 Sep 2019 07:14:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728490AbfICLOC (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 3 Sep 2019 07:14:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B64D422CF8;
        Tue,  3 Sep 2019 11:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567509241;
        bh=7jB7jzt/13Vpy08LwVGagAlPF7Qv2FkfYnKDsbxYUuw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NIbpu24HIuuJ1lZw/Pg6/PIlJ7XfaeLABXBK0hg5K1TMyjjLsl39FkrwEmUU4X/BH
         9Y4dJm87E7iVeUcThndFE8EABnsc9xpn+Oe2Ju+UQjqNBr4JSsv6eMtthfloL4OCjy
         dvp5ZdI0+hNkybj1FtXAUdGCggkRnfI1uoH+8KLg=
Date:   Tue, 3 Sep 2019 13:13:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Temp Sha <temp.sha@gmail.com>
Cc:     linux-serial@vger.kernel.org
Subject: Re: tty_ldisc_lock hangs at reboot
Message-ID: <20190903111358.GA28823@kroah.com>
References: <CANe=CUka=VPOQSyvu5pS8oe9hV3acjdp7OZXVB=TZMCyKeQy5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANe=CUka=VPOQSyvu5pS8oe9hV3acjdp7OZXVB=TZMCyKeQy5g@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Sep 03, 2019 at 03:55:32PM +0530, Temp Sha wrote:
> Hi,
> 
> My linux box with kernel version 4.14.30 gets hung at  tty_ldisc_lock
> while executing reboot command. The terminal freezes from where I have
> executed reboot, however other terminals are still accessible via ssh.
> Following is the stack trace of tty_ldisc_lock. Can any one help me in
> fixing this?

4.14.30 is 111 releases old (it came out in March of 2018).  Please
update to something more realistic as odds are this might be fixed in
4.14.141 which is the latest 4.14.y release.

And if it does not work there, please test the latest 5.2 tree to see if
it is resolved there.  If so, we can work to find the commit that
resolves the issue and then backport it.

thanks,

greg k-h
