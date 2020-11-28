Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81B8D2C705D
	for <lists+linux-serial@lfdr.de>; Sat, 28 Nov 2020 19:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731497AbgK1Rzy (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sat, 28 Nov 2020 12:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732775AbgK1FCz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 28 Nov 2020 00:02:55 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BE3C0613D1
        for <linux-serial@vger.kernel.org>; Fri, 27 Nov 2020 21:02:52 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id x24so6201905pfn.6
        for <linux-serial@vger.kernel.org>; Fri, 27 Nov 2020 21:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+cY96tswXFUWhDQlszZdQ0Yp/NVqiaNXWKVJf0G/vq0=;
        b=nUuMvFjLdQtXbI8VGvkB7g5V04GILmudOnymKoF9Lb3TiKMCajZfxQmmjT+CH+mP+r
         tOsaQmRduBFJtuV7zv6gY8d2e1wEIcPtHZOJSQquHukTO7FGb7CFSNnfeXdZKDMTwnWF
         8o2NC2p3blyxsT0XwtEGeYjMJHU5uKD7xq4UcY5xS5shuC56XiN3y/ekiHLq1sTPb+dQ
         X9/8dUkpmuHtLtHbwnFrhtXoN7v2pmvFWSfFADZ1Y1d0avYYGB/7G8XqxMo06NqebnSH
         gpPEZiBtdDqg+Jzrn9sOSgOQtw+groUdb+YINOT4fkpYYig4MqqaxqOFCqm2MhrbRyOO
         Wr2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+cY96tswXFUWhDQlszZdQ0Yp/NVqiaNXWKVJf0G/vq0=;
        b=DcLwlUPMZp1wD75qk7VFB9y9G1z8q0PgAjNcjJmdE5Bwli464aLucl+mcFXty9rHiU
         LjUwJ0pcC9i4TnvXYN5ytgsgihw4IqzDbXbrC/gLPi1sYwxTzbaIl5BtYcI/fKgnxkyD
         MnxPkn74eUUk59lJ0/UEz9bb6VYRlWVzUJxrc/fP2u2iaQUT8CwYCey62sRx+WUVGyR8
         Tw36JR5fiIUYaJRfiXdidMnxSUzS7WehathAniO7UocdPoIjIiQIvCckrR4Yl55PyBwI
         /n3AvFyGD7+OdSxt535JfFFqTwc1Xxc8s0LXw0LgktwuIZW8F1rJVbhJP4e9dOwVk0R0
         exYw==
X-Gm-Message-State: AOAM5333AAjkU/u4NHpFzUBQlQS544Uwmj/r6ai8CT871zk+mMkrBHUf
        97xDXk0sfBmdlSluy797onc=
X-Google-Smtp-Source: ABdhPJy4g6zDTXvoVRzRWSUFIKeiCQ/IrymfXj2aW3D1bavmpelH6rQrrFqXL2K5m0Vvus+sa5oCOA==
X-Received: by 2002:a63:df05:: with SMTP id u5mr1471554pgg.73.1606539771821;
        Fri, 27 Nov 2020 21:02:51 -0800 (PST)
Received: from [10.230.28.242] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id z3sm4480491pfn.38.2020.11.27.21.02.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2020 21:02:51 -0800 (PST)
Subject: Re: [PATCH V2] tty: serial: bcm63xx: lower driver dependencies
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20201125081352.25409-1-zajec5@gmail.com>
 <20201125090608.28442-1-zajec5@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <e625953a-333e-7824-7318-fde59de7992d@gmail.com>
Date:   Fri, 27 Nov 2020 21:02:49 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201125090608.28442-1-zajec5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 11/25/2020 1:06 AM, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Hardware supported by bcm63xx is also used by BCM4908 SoCs family that
> is ARM64. In future more architectures may need it as well. There is
> nothing arch specific breaking compilation so just stick to requiring
> COMMON_CLK.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
