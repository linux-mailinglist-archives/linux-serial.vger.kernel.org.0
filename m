Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 261B930D18
	for <lists+linux-serial@lfdr.de>; Fri, 31 May 2019 13:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfEaLNE (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 31 May 2019 07:13:04 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:58684 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfEaLNE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 31 May 2019 07:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xKwYum+NdkBywT3KdX8GLgUjDsYEDJi/LhH01e2YoKs=; b=YpOF1AmbgiMNCQAooVDALqb9p
        q6WcY2prqOXPzTArJB7zxCR4ywAW58HHokF3tRPIvi00uZuMdNRswKovvLoqY+jX6fSt+b9VFsHnq
        82SzIEXRe4UxCIQfzd8PMT91+pYke3Jw5lNcksWVvWG34VwgmB40QyMpt9cAnobG/WCXtDM39aTbG
        kcfM2+7A4YbjC1sJlKYlQUucthphYhOoKqCHk2rxkCFQUl1v55dzfHae4lGSPVHt/gUU9r8j/gSnF
        lbOHTxBfqG/A5J7S1JpNkCaaGWMAjSRt/Ge0P3OWa3IJRDUwodR6Bx1mViJOSL10wJ+FYDYxo0hnv
        d2HEjccYQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52740)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hWfT2-0000OD-2J; Fri, 31 May 2019 12:13:00 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hWfSz-0006FD-82; Fri, 31 May 2019 12:12:57 +0100
Date:   Fri, 31 May 2019 12:12:57 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH 0/6] Convert sa1100 serial to use mctrl gpios
Message-ID: <20190531111257.27hor6xgb3nsdghg@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This series takes the next step along the path of cleaning up and
modernising the sa11x0 code, concentrating on the sa1100 serial
driver.  At the end of this conversion, we are left with collie
being the only platform that uses the old platform data get_mctrl
and set_mctrl methods.  As the locomo code is also used with PXA,
this is left for a future cleanup.

The first patch was previously acked quite some time ago.

I'm intending to send this to arm-soc.

 arch/arm/mach-sa1100/assabet.c  |  91 +++++++++++----------------------
 arch/arm/mach-sa1100/badge4.c   |   2 -
 arch/arm/mach-sa1100/h3xxx.c    |  64 ++++-------------------
 arch/arm/mach-sa1100/hackkit.c  |  48 ------------------
 arch/arm/mach-sa1100/neponset.c | 109 +++++++++++-----------------------------
 drivers/tty/serial/Kconfig      |   1 +
 drivers/tty/serial/sa1100.c     |  42 ++++++++++++++--
 7 files changed, 106 insertions(+), 251 deletions(-)


-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
