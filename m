Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 720767DD73
	for <lists+linux-serial@lfdr.de>; Thu,  1 Aug 2019 16:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731817AbfHAOIb (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 1 Aug 2019 10:08:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:39036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731756AbfHAOIa (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 1 Aug 2019 10:08:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB90F216C8;
        Thu,  1 Aug 2019 14:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564668510;
        bh=1JyIuK4+07z6r13siyUfFBNIhbSOLStvyEv7aTDiL0A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=StxsIr6kJab04Mv9+dIISaCW/YlcJEl4jG36/0vq1ghI0VDL1estEscC9HdwV7Ryo
         lk253CwRrVHhvp6pmUpMEXKeRisNnD72x1zxZCVk8dMlisZ/99kbMUJ2x51u9S8p4e
         lhSfUxcSOKqPQQmWavnemeulitgk4N1O8AktIVtA=
Date:   Thu, 1 Aug 2019 16:08:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     robh+dt@kernel.org, linux-amlogic@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [RFC 8/9] dt-bindings: serial: meson-uart: convert to yaml
Message-ID: <20190801140825.GC31375@kroah.com>
References: <20190801135644.12843-1-narmstrong@baylibre.com>
 <20190801135644.12843-9-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801135644.12843-9-narmstrong@baylibre.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Aug 01, 2019 at 03:56:43PM +0200, Neil Armstrong wrote:
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---

I can't take patches without any changelog text, sorry.

greg k-h
