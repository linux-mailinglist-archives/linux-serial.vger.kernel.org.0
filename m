Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB4A3A7DA5
	for <lists+linux-serial@lfdr.de>; Tue, 15 Jun 2021 13:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhFOLzP (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 15 Jun 2021 07:55:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:33120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229557AbhFOLzP (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 15 Jun 2021 07:55:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 300A060FF0;
        Tue, 15 Jun 2021 11:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623757990;
        bh=G6G3rTmA17FnDODK+NDCyXEJwmmqmtURHHqp5JfBdcQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uzSnQNKFiGrzza1zG/I/TvQxMt0jeQDADFh06Q01ZyFkRl4qCPQ5sD8UNNRFt2BgQ
         7fsLy5xR+HebMsE7Y9I7RXJ8Y5EC/m5I1+CeWXK6ATsPdByNZOCX/DiDvCnSnXQqnC
         1EfX54ivnPD/OOm2NBtrosM8pdzGf6f79n5fKqqM=
Date:   Tue, 15 Jun 2021 13:53:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alex Nemirovsky <alex.nemirovsky@cortina-access.com>
Cc:     Jason Li <jason.li@cortina-access.com>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] dt-bindings: serial: Convert Cortina-Access UART
 to json-schema
Message-ID: <YMiUpK/+PjsoCU1W@kroah.com>
References: <20210509184519.15816-1-alex.nemirovsky@cortina-access.com>
 <20210509184519.15816-2-alex.nemirovsky@cortina-access.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210509184519.15816-2-alex.nemirovsky@cortina-access.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, May 09, 2021 at 11:45:17AM -0700, Alex Nemirovsky wrote:
> From: Jason Li <jason.li@cortina-access.com>
> 
> Convert the Cortina-Access UART binding to DT schema format.
> 
> Signed-off-by: Jason Li <jason.li@cortina-access.com>
> ---
>  .../serial/cortina-access,serial.yaml         | 46 +++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
>  MAINTAINERS                                   |  6 +++

You are also adding a MAINTAINERS entry here, which is not listed in the
changelog text, so I couldn't take it anyway :(

greg k-h
