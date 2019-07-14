Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD5267E6F
	for <lists+linux-serial@lfdr.de>; Sun, 14 Jul 2019 12:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbfGNKEb (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sun, 14 Jul 2019 06:04:31 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:32019 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726799AbfGNKEb (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 14 Jul 2019 06:04:31 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 45mj0K1nkzz11;
        Sun, 14 Jul 2019 12:03:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1563098593; bh=b55Smskg5DSJu0yatEPxdF1r5jieshPWzUTXl1Bc9Mw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g8WypDtgCWOpXSb9qWjkVUrZTJd/LvH4BnYikKeujMuOWrNPBZ6MTueNHKRprG1Xl
         9Y96Gt4CPzAjrG2p1H8fGsPCM763aFolgSR53Yf1Y9U7ZQNXJmw+rWeXgBsldjI8xe
         SJW1vNeeZzyGuaSmpTE8W2GYpnTHbU1HT2EsYelFP/z87ryiG5ZGhY1F3zGuhbjz5y
         1e8BYAIqtrSI/osL9zm1UPDOM0S+x+3G37n7QeHnYeqGAEtr/z06JcCHQPs+KSnSol
         l6pSx2Re6Ncby+1vUUer82PdISs7fFq+HpRsK/9BA1uYnXiWrno0QSipDlZfB66Ha9
         5V+wpG49lHexQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.100.3 at mail
Date:   Sun, 14 Jul 2019 12:04:26 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Ladislav Michl <ladis@linux-mips.org>
Cc:     linux-usb@vger.kernel.org, linux-serial@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 0/5] usb: gadget: u_serial: Fix and cleanup
Message-ID: <20190714100426.GA24183@qmqm.qmqm.pl>
References: <20190713210853.GA25753@lenoch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190713210853.GA25753@lenoch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, Jul 13, 2019 at 11:08:53PM +0200, Ladislav Michl wrote:
> Following patchset makes console work (patch 1 and 4) for an AT91SAM9G20
> board connected to xhci_hcd and does some cleanup.
> Tested with "console=ttyS0,115200n8 console=ttyGS0" on kernel command line
> and following inittab:
> console::respawn:/sbin/getty -L 115200 ttyS0 vt100
> console::respawn:/sbin/getty -L 115200 ttyGS0 vt100
> 
> However there is an issue remaining:
> Disconnect triggers WARN_ON in gs_close:
[...]

Hi,

Can you try a patchset I sent some time ago [1] if it fixes your case?

Best Regards,
Micha³ Miros³aw

[1] https://www.spinics.net/lists/linux-usb/msg177537.html
