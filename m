Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE88D0C31
	for <lists+linux-serial@lfdr.de>; Wed,  9 Oct 2019 12:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730646AbfJIKGY (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 9 Oct 2019 06:06:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:56990 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726211AbfJIKGY (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 9 Oct 2019 06:06:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9E888AE48;
        Wed,  9 Oct 2019 10:06:22 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list\:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list\:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] Documentation: admin-guide: add earlycon documentation for the sifive serial driver
References: <alpine.DEB.2.21.9999.1910081606370.11044@viisi.sifive.com>
        <CAMuHMdVdPFSU_3VEtO=P73kqLezV5Dmki=N3nxsKibzy-U5pBg@mail.gmail.com>
X-Yow:  My pants just went to high school in the Carlsbad Caverns!!!
Date:   Wed, 09 Oct 2019 12:06:22 +0200
In-Reply-To: <CAMuHMdVdPFSU_3VEtO=P73kqLezV5Dmki=N3nxsKibzy-U5pBg@mail.gmail.com>
        (Geert Uytterhoeven's message of "Wed, 9 Oct 2019 08:56:29 +0200")
Message-ID: <mvmv9syz10h.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Okt 09 2019, Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> I believe risc-v is DT-only, so if chosen/stdout-path is set up

If.  Currently, it isn't.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
