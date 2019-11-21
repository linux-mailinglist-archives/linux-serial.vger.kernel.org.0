Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0420104C4E
	for <lists+linux-serial@lfdr.de>; Thu, 21 Nov 2019 08:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfKUHV1 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 21 Nov 2019 02:21:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:34886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbfKUHV0 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 Nov 2019 02:21:26 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF2FD20872;
        Thu, 21 Nov 2019 07:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574320886;
        bh=o22Hi13qhmwZwPmKcq3ZrnZnV5e0srKRPAqCcT43rXU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZgrIzQRwbUOEyVKz/MI1dgBCGcwoGLTPXQdb42swkYHrCwBdUPmblMC4Q/DJ93Veh
         cUKtZrTXsDTe9I6cWhSejkX8CdoTBtJILLyI+lPcBM0hSB7aTJfcGq/VGYp5CThpEU
         qjna1vkbpGfMBVXtEw5SY+46ppjlCfrcHrc2M9o0=
Date:   Thu, 21 Nov 2019 08:21:24 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
        linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2] tty: Fix Kconfig indentation
Message-ID: <20191121072124.GA356838@kroah.com>
References: <1574306408-20021-1-git-send-email-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574306408-20021-1-git-send-email-krzk@kernel.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Nov 21, 2019 at 04:20:08AM +0100, Krzysztof Kozlowski wrote:
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
> 	$ sed -e 's/^        /\t/' -i */Kconfig
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. Fix also 7-space and tab+1 space indentation issues.

Same here, I already applied v1, so this one does not apply :(
