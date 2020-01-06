Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66B0E1318BA
	for <lists+linux-serial@lfdr.de>; Mon,  6 Jan 2020 20:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgAFT3P (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 6 Jan 2020 14:29:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:51326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726701AbgAFT3P (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 6 Jan 2020 14:29:15 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 221D0207FF;
        Mon,  6 Jan 2020 19:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578338954;
        bh=GsjaWd3vqMWUjXih+xrK6n8SzwB57sW+lMBgypOyPHI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nhXyEK/oyQNuy/Yi10/PLF5h1fuRNGtoUcLAx1YqSNIrCU5io0Jd1vZzDmL6qm/1l
         DWvmKJNrLA01J2IIQbcs34OkgRuJizD/IsrgOSI9ar6C9V1QrzJDiKEA+TgbVqAi6L
         PCP1R/QnQ8b85Mb+lqkXHxjmJQiuP5V89rmId0UA=
Date:   Mon, 6 Jan 2020 20:29:12 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rishi Gupta <gupt21@gmail.com>
Cc:     robh+dt@kernel.org, jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] tty: documentation: abi: add ttyvs null modem
 driver sysfs nodes
Message-ID: <20200106192912.GB754821@kroah.com>
References: <cover.1578235515.git.gupt21@gmail.com>
 <7d7c949890c4bdb12ecc9f8b15a5c0a69b7604a8.1578235515.git.gupt21@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d7c949890c4bdb12ecc9f8b15a5c0a69b7604a8.1578235515.git.gupt21@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Jan 06, 2020 at 12:51:55PM +0530, Rishi Gupta wrote:
> The ttyvs driver exposes sysfs files to emulate various serial
> port events. This commit document these files.
> 
> Signed-off-by: Rishi Gupta <gupt21@gmail.com>
> ---
>  .../ABI/testing/sysfs-devices-virtual-tty_ttyvs        | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-devices-virtual-tty_ttyvs
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-virtual-tty_ttyvs b/Documentation/ABI/testing/sysfs-devices-virtual-tty_ttyvs
> new file mode 100644
> index 0000000..69b04e0
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-devices-virtual-tty_ttyvs
> @@ -0,0 +1,18 @@
> +What:		/sys/devices/virtual/tty/ttyvsN/event
> +Date:		January 2020
> +Contact:	Rishi Gupta <gupt21@gmail.com>
> +KernelVersion:	5.5
> +Description:
> +		The ttyvs driver will emulate serial port event; parity error,
> +		framing error, overrun error, asserting or de-asserting break
> +		conditions and ring indication when user space application
> +		writes an event code on this sysfs file.

You did not actually document any of the values read/written to this
file, like you did in your 0/X patch description :(

greg k-h
