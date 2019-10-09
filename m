Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9959FD114B
	for <lists+linux-serial@lfdr.de>; Wed,  9 Oct 2019 16:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731434AbfJIObU (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 9 Oct 2019 10:31:20 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43013 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731083AbfJIObU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 9 Oct 2019 10:31:20 -0400
Received: by mail-io1-f67.google.com with SMTP id v2so5378579iob.10
        for <linux-serial@vger.kernel.org>; Wed, 09 Oct 2019 07:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=pKB7Ijnwk47zF1Sui8uqCszhqTFAlw2ztEvx8myXms8=;
        b=htQS71038oSKVcTiOiVBOPZdKlFBEupsi5wTlAWKgcmpPZsoGM+chhV5THF95PQDNU
         0/0Z2dbhHOSz6tOXL1Yl5rrkVlFrJksyHWU0SyopxFJpF7f8SbQ/Kb9WqvJm3njgsWIT
         HInMDSyhVGUD1TmbdaXL84YyIKOcLKkDHiyNE8Zz3pZ/85bOpTHJJYC1Ll+vUsmqF1T7
         TGPR2iFI4IKoj8vtpa6x2DQGg/8a/Fr9v2oMHrHeFRpK7X40bVdS8zmotwCkGZnzyRE8
         OFgih4WKih5Cx9AUvmozvkzfQqPbJj2uKDV2r1JpciuQiC0E4JVJWyh1Y9OW5/hqWiik
         sOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=pKB7Ijnwk47zF1Sui8uqCszhqTFAlw2ztEvx8myXms8=;
        b=re2HOuHiX9kht4O3IC5cy8IOPbNm2Ecv3yUU3YWZW4h5AH8uXj+le259Nt/ogKp2LP
         sZjsSDVrxRJO/VMl8RDuDP9rVpdKXgdZ+M4zzjlfTnrQVjR3o+6yWBqC++wYz40StH19
         Hg0bJXmtLyHceoy/4p9XUPD/FrAwIgrMsjqIhmTNyqaxXjgblDWQibiolIOPQf0L/uzK
         eGbNSMeY2JaeZXGnVsSAhSo/hwTwdPK5/PWvEeh8VhlDIMgfKPkMMd8rEuGnWsID2IwL
         ya7syunNXHQfPAWLCqH+jyF9U3+DRtKvVddkzsEfKndih0dvPeO9N/69Q/1QwWNd8hK2
         qsLA==
X-Gm-Message-State: APjAAAUKSe7GxO+IMNe0u1T55ZA6cRIAKf+ITQv40uTraMHAt3R5xTLI
        jAI218ueYy4mWbfcog1mts7HZw==
X-Google-Smtp-Source: APXvYqxbDM6b4U2rzv0BGL/QF62gtvZXMwLwAcbvx/3w5WEHhaoahcynYrpIG1KyHIdJKvv4G99y9Q==
X-Received: by 2002:a02:a156:: with SMTP id m22mr3333754jah.62.1570631479110;
        Wed, 09 Oct 2019 07:31:19 -0700 (PDT)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id x12sm1044888ioh.76.2019.10.09.07.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 07:31:18 -0700 (PDT)
Date:   Wed, 9 Oct 2019 07:31:16 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Andreas Schwab <schwab@suse.de>, Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] Documentation: admin-guide: add earlycon documentation
 for the sifive serial driver
In-Reply-To: <CAMuHMdVh=CUXKwnXee067cRccVBDVuwWpo1wP7crAaCFA=y2Tw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.9999.1910090720290.11044@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.1910081606370.11044@viisi.sifive.com> <CAMuHMdVdPFSU_3VEtO=P73kqLezV5Dmki=N3nxsKibzy-U5pBg@mail.gmail.com> <mvmv9syz10h.fsf@suse.de> <CAMuHMdVh=CUXKwnXee067cRccVBDVuwWpo1wP7crAaCFA=y2Tw@mail.gmail.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Geert,

On Wed, 9 Oct 2019, Geert Uytterhoeven wrote:

> On Wed, Oct 9, 2019 at 12:06 PM Andreas Schwab <schwab@suse.de> wrote:
> > On Okt 09 2019, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > I believe risc-v is DT-only, so if chosen/stdout-path is set up
> >
> > If.  Currently, it isn't.
> 
> IC. So isn't it better to fix that, instead of pointing people to more obscure
> legacy solutions?

There's nothing that's RISC-V specific about the SiFive serial IP or 
its driver.  So the issue of whether RISC-V is DT-only or not probably 
shouldn't impact whether we document that the SiFive serial driver 
supports earlycon.

best regards,

- Paul
