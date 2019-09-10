Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84189AE41A
	for <lists+linux-serial@lfdr.de>; Tue, 10 Sep 2019 08:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406537AbfIJG5l (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 10 Sep 2019 02:57:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:56886 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406535AbfIJG5k (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 Sep 2019 02:57:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CE142AC18;
        Tue, 10 Sep 2019 06:57:38 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        paul.walmsley@sifive.com, linux-serial@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial/sifive: select SERIAL_EARLYCON
References: <20190910055923.28384-1-hch@lst.de>
X-Yow:  My EARS are GONE!!
Date:   Tue, 10 Sep 2019 08:57:37 +0200
In-Reply-To: <20190910055923.28384-1-hch@lst.de> (Christoph Hellwig's message
        of "Tue, 10 Sep 2019 07:59:23 +0200")
Message-ID: <mvm4l1kskny.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sep 10 2019, Christoph Hellwig <hch@lst.de> wrote:

> The sifive serial driver implements earlycon support,

It should probably be documented in admin-guide/kernel-parameters.txt.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
