Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 519AE29218
	for <lists+linux-serial@lfdr.de>; Fri, 24 May 2019 09:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389056AbfEXHzM (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 24 May 2019 03:55:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:37144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388911AbfEXHzM (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 24 May 2019 03:55:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5FFF20879;
        Fri, 24 May 2019 07:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558684511;
        bh=erVr97GltBdW+TY/NQm3CwstjOX12OJL5JWbo8L3z/M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ooze/Bz3O1ArZ5k1Nc3dNnwR9RhM3sbE5nT/GAoApphuLee3CF6EH2a6pzps8j965
         2EKg64aoGaL94YD+f/Ok4Vf00YRtiX3cXOYST+mnUSLAG8QlqIiNGigJ/HMrWgu2oT
         ZwP32BVgt/yKx7kp1pmyajJ+mOsTkT7ILYvIqdkM=
Date:   Fri, 24 May 2019 09:55:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Claire Chang <tientzu@chromium.org>
Cc:     changqi.hu@mediatek.com, linux-serial@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: serial: add documentation for Rx
 in-band wakeup support
Message-ID: <20190524075508.GA31438@kroah.com>
References: <20190521084701.100179-1-tientzu@chromium.org>
 <20190521084701.100179-2-tientzu@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521084701.100179-2-tientzu@chromium.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, May 21, 2019 at 04:47:00PM +0800, Claire Chang wrote:
> Signed-off-by: Claire Chang <tientzu@chromium.org>
> ---

I can not take patches without any changelog text at all.  Part of
writing a good patch is actually describing why you are making a change.

thanks,

greg k-h
