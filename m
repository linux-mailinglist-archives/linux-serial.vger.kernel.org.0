Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8295DFF5
	for <lists+linux-serial@lfdr.de>; Wed,  3 Jul 2019 10:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfGCIgI (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 3 Jul 2019 04:36:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:36314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbfGCIgI (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 3 Jul 2019 04:36:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18C392189E;
        Wed,  3 Jul 2019 08:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562142967;
        bh=6wSqtYqIVYb1OypSTGHHLHYkGeKt99UNNmqYXBxj1SU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HYSKu+RAjFF/kni50sk4diUFqMok7o+eWdX8JiqR1vMJUhlBhU+iC/TFFUu1D2pzO
         IB7AYJdiL7fZOW1XD+riMH7o015ihe87Jv/qjyriOs3oeftwBXzxJ+cka2q2xMb4D/
         KiNtFToKYW8JAYVMzyUOdLJtwpt4hSijOYt4agEs=
Date:   Wed, 3 Jul 2019 10:36:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     jeyentam <je.yen.tam@ni.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/2] PCI: Add NI-Serial PXI/PXIe+485 device IDs
Message-ID: <20190703083605.GA8996@kroah.com>
References: <20190703072516.34199-1-je.yen.tam@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703072516.34199-1-je.yen.tam@ni.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jul 03, 2019 at 12:25:16AM -0700, jeyentam wrote:
> Add NI PXIe-RS232, PXI-RS485 and PXIe-RS485 device IDs.
> 
> Signed-off-by: jeyentam <je.yen.tam@ni.com>
> ---
>  include/linux/pci_ids.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

You have read the comment at the top of this file, right?  If so, why
are you adding these entries?

> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 70e86148cb1e..7fad4794789f 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -1027,7 +1027,9 @@
>  #define PCI_DEVICE_ID_SUN_TOMATILLO	0xa801
>  #define PCI_DEVICE_ID_SUN_CASSINI	0xabba
>  
> +/* NI-Serial Device IDs */
>  #define PCI_VENDOR_ID_NI		0x1093

That's a vendor id, not a serial device id.

thanks,

greg k-h
