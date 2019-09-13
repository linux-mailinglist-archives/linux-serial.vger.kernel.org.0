Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99576B26C5
	for <lists+linux-serial@lfdr.de>; Fri, 13 Sep 2019 22:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389519AbfIMUkb (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 13 Sep 2019 16:40:31 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43262 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387461AbfIMUka (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 13 Sep 2019 16:40:30 -0400
Received: by mail-pf1-f196.google.com with SMTP id d15so18778252pfo.10
        for <linux-serial@vger.kernel.org>; Fri, 13 Sep 2019 13:40:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=qU9A6qb+veDWW9PC+1djL9KV1hH5r1qd0AwYGNHfhBY=;
        b=qQfWhLaxdHO56wvcR9Qf45O/iRGdDzLrhWNNEHOAD8FLxZrx43uHB1JkXSNvfAX5Uu
         Nm/FqXabI6cFop7b0tcYOVahRasguNjah2hzRR3UNPKu3bjYDXR8DL7G1hzjTFBrBca0
         3j6GJxyf5WuUDdd35g6POG0Zs2YLNnpPqG1bLqRmJXLlxYdNMB+TKFADsHuROgS7jZT3
         sH4xjRF0Wbtclswv55K3Gu/ab78cBSLOrsGfZKqf/IN9vAuLKEFfzAa9Rr5rG5pqYOZt
         LKocfmKhUfQithdiz29xuh89yTdcGFQ5hfBSK15qltHxybVebBOZypwouYDyUwhAIwfD
         Hg7A==
X-Gm-Message-State: APjAAAVXLeqzZwx5opfa/V/1cpuwFVWOnzLVgWbOfyjg3cRTazhBTuQR
        jCDIY1cAyZAz6HCxVBb9ocr7HQ==
X-Google-Smtp-Source: APXvYqwRwn0c+PmiWsgzZC28IXBATIqtHCXXHGwwyRxHek1xZzURFPAkB8G4vkaL2qShC9KYKXBgYA==
X-Received: by 2002:a63:f357:: with SMTP id t23mr45980721pgj.421.1568407227922;
        Fri, 13 Sep 2019 13:40:27 -0700 (PDT)
Received: from localhost (amx-tls3.starhub.net.sg. [203.116.164.13])
        by smtp.gmail.com with ESMTPSA id u65sm33355649pfu.104.2019.09.13.13.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 13:40:27 -0700 (PDT)
Date:   Fri, 13 Sep 2019 13:40:27 -0700 (PDT)
X-Google-Original-Date: Fri, 13 Sep 2019 13:39:43 PDT (-0700)
Subject:     Re: [PATCH] serial/sifive: select SERIAL_EARLYCON
In-Reply-To: <20190910143630.GA6794@lst.de>
CC:     schwab@suse.de, Greg KH <gregkh@linuxfoundation.org>,
        jslaby@suse.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, Christoph Hellwig <hch@lst.de>
From:   Palmer Dabbelt <palmer@sifive.com>
To:     schwab@suse.de, Christoph Hellwig <hch@lst.de>
Message-ID: <mhng-218f6b9f-bfd8-4adb-8147-298989494bcf@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, 10 Sep 2019 07:36:30 PDT (-0700), Christoph Hellwig wrote:
> On Tue, Sep 10, 2019 at 10:18:15AM +0200, Andreas Schwab wrote:
>> > How so?  Wіth OF and a stdout path you just set earlycon on the
>> > command line without any arguments and it will be found.
>> 
>> Doesn't work for me.
>> 
>> [    0.000000] Malformed early option 'earlycon'
>
> That functionality is implemented by param_setup_earlycon and
> early_init_dt_scan_chosen_stdout.  Check why those aren't built into
> your kernel.

OpenEmbedded passes "earlycon=sbi", which I can find in the doumentation.  I 
can't find anything about just "earlycon".  I've sent a patch adding sbi to the 
list of earlycon arguments.
