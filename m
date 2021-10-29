Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2248843F6C5
	for <lists+linux-serial@lfdr.de>; Fri, 29 Oct 2021 07:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbhJ2Fqu (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 29 Oct 2021 01:46:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:42594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231774AbhJ2Fqu (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 29 Oct 2021 01:46:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A0FE661151;
        Fri, 29 Oct 2021 05:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1635486262;
        bh=xrGfr+YKDLpSMwpo040DjCF6Kp2zkwY+/2Gr4wkToJU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ali5QJeRggzI7ygSahDjqPxOaCoJC1NkTLTaPLhLEa/D+pvIL28WylpB/CXmbdHuK
         fC60kzwuK0T07KFchzCmU8qQyYFK5dMTYrvaSq58kWZKAM7EgESw6npvkyhM86xSv9
         BVKv0u+14I3Q1OvrrA1d3JjDftb20qR1qBxEYoPc=
Date:   Fri, 29 Oct 2021 07:44:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     cgel.zte@gmail.com
Cc:     jirislaby@kernel.org, johan@kernel.org, macro@orcam.me.uk,
        fancer.lancer@gmail.com, andrew@aj.id.au, pali@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jing Yao <yao.jing2@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] drivers: tty: replace snprintf in show functions with
 sysfs_emit
Message-ID: <YXuKMo14CCM1iHMG@kroah.com>
References: <20211028101350.14172-1-yao.jing2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028101350.14172-1-yao.jing2@zte.com.cn>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Oct 28, 2021 at 10:13:50AM +0000, cgel.zte@gmail.com wrote:
> From: Jing Yao <yao.jing2@zte.com.cn>
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>

Please fix your broken "robot" before submitting any more patches to the
Linux kernel project.

good luck!

greg k-h
