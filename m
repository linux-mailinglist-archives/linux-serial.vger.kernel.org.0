Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDD03C7DC
	for <lists+linux-serial@lfdr.de>; Tue, 11 Jun 2019 11:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405130AbfFKJ54 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 11 Jun 2019 05:57:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:34368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405110AbfFKJ5z (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 11 Jun 2019 05:57:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B885212F5;
        Tue, 11 Jun 2019 09:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560247074;
        bh=eFCAHMLYlPjeQ8c+JvvAxqMT9R3MdGhbByLH97UfvJU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LGslM1TEI3C3raaQkUxlJCYHwCoTbTLehEc9OnKEYrHOC8KVowmCp2mVMkOFOj007
         m6vxMypK8cGrU/YDP2TGKjak2NV1pwfEwo6YjEM/BMsRKl3C1HB+6AP0ZEu6KXSsSO
         68Y3OHK2YZn1lGSmRaae9H7Igy8Rv9j4zVljsf3s=
Date:   Tue, 11 Jun 2019 11:57:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Claire Chang <tientzu@chromium.org>
Cc:     changqi.hu@mediatek.com, linux-serial@vger.kernel.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: serial: add documentation for Rx
 in-band wakeup support
Message-ID: <20190611095752.GA24058@kroah.com>
References: <20190527083150.220194-1-tientzu@chromium.org>
 <20190527083150.220194-2-tientzu@chromium.org>
 <CALiNf2_Kuu9agO31Wg2X4uUa0EHWYL=qG5RLQ=catn8M9XDKGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALiNf2_Kuu9agO31Wg2X4uUa0EHWYL=qG5RLQ=catn8M9XDKGQ@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jun 11, 2019 at 05:53:54PM +0800, Claire Chang wrote:
> (cc-ed device tree maintainers and mailing list)
> 
> The second patch in this series[1] is already in tty-next[2].
> 
> Sorry for not cc-ing device tree maintainers/mailing list at the beginning.
> I can resend this patch if needed.

Please do, as it is not here for them to review :(

greg k-h
