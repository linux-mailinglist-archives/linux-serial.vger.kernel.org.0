Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 008AEB34C6
	for <lists+linux-serial@lfdr.de>; Mon, 16 Sep 2019 08:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729949AbfIPGm6 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 16 Sep 2019 02:42:58 -0400
Received: from verein.lst.de ([213.95.11.211]:42531 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729950AbfIPGm6 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 16 Sep 2019 02:42:58 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2B61668B05; Mon, 16 Sep 2019 08:42:54 +0200 (CEST)
Date:   Mon, 16 Sep 2019 08:42:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     schwab@suse.de, Christoph Hellwig <hch@lst.de>,
        Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH] serial/sifive: select SERIAL_EARLYCON
Message-ID: <20190916064253.GA24654@lst.de>
References: <20190910143630.GA6794@lst.de> <mhng-218f6b9f-bfd8-4adb-8147-298989494bcf@palmer-si-x1e>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-218f6b9f-bfd8-4adb-8147-298989494bcf@palmer-si-x1e>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Sep 13, 2019 at 01:40:27PM -0700, Palmer Dabbelt wrote:
> OpenEmbedded passes "earlycon=sbi", which I can find in the doumentation.  
> I can't find anything about just "earlycon".  I've sent a patch adding sbi 
> to the list of earlycon arguments.

earlycon without arguments is documented, although just for ARM64.
I can send a patch to update it to properly cover all DT platforms
in addition.
