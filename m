Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D562A3C7B2
	for <lists+linux-serial@lfdr.de>; Tue, 11 Jun 2019 11:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404989AbfFKJyI (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 11 Jun 2019 05:54:08 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44969 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404425AbfFKJyH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 11 Jun 2019 05:54:07 -0400
Received: by mail-qk1-f196.google.com with SMTP id w187so7192231qkb.11
        for <linux-serial@vger.kernel.org>; Tue, 11 Jun 2019 02:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+38Lbr9rNUhSKar2BeR7VlIqBZLydDsxiHIDtpA/c3A=;
        b=Z4JEhv0f3lRlQOqp16GGJPy7vo+ohK7tFrcMiCjMmz3xt4glhA5S+gKoiZ10q4U7Gq
         kUj80uBjld/wT8KgyE/nkAdzUVxWtd1fMxSeJF/zhLirggcLf1bzM0qSEv4PyfNfF4WQ
         yjnvzv8OZ2q6+VPAPB99Q+99/573fTz64YGzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+38Lbr9rNUhSKar2BeR7VlIqBZLydDsxiHIDtpA/c3A=;
        b=dydBHgVAk1ymYzeDrrLj6Q7oxWsWJhrcCwnRWHC3HQZ8lS/6dfSn5PauiYpPj7AKpS
         RgkA6Nw3zUwGFuNf4VdJqgcZnsWmaNh76WGRNQ69zrRHY57v9OPAztB2RSZvYlxVerUX
         xsOTs8GZsfuWotbdQNeFxj0CnwSHVAcSdT9t393S2bGoYTtDm7fBUj52TD/P9kEvWjd0
         U4DahHLLVUpTP7A912UM2wgZQqpO3+GqxSTpcMmOd4aKE/Skym5TR2ipB5odlaKLzKze
         fbpr7hUXq6pt/+iXyhE09QMPkAb6mgKfX4X2yAy2OoMF8Hz9zUsjcaAwsOZwi1JF3s8C
         ts4A==
X-Gm-Message-State: APjAAAUTLE2iAoVknzJwXSyuQDNaHcOz82O3zB2dMePAEYRY0uBxv9u6
        F6IjG2/03NjjdSC43tkmmzMQX81Xu/o=
X-Google-Smtp-Source: APXvYqzkp9KzGTzD2BD04Aj6qf/nYNM6qavkbcS9u1PX2iFZDn2d7HcHBLVtXPYPqowoVeK7Nf6nsg==
X-Received: by 2002:ae9:ed48:: with SMTP id c69mr58472758qkg.114.1560246846622;
        Tue, 11 Jun 2019 02:54:06 -0700 (PDT)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com. [209.85.160.181])
        by smtp.gmail.com with ESMTPSA id v9sm6577157qti.60.2019.06.11.02.54.05
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 02:54:05 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id h21so13700679qtn.13
        for <linux-serial@vger.kernel.org>; Tue, 11 Jun 2019 02:54:05 -0700 (PDT)
X-Received: by 2002:ac8:28e2:: with SMTP id j31mr23670135qtj.274.1560246845373;
 Tue, 11 Jun 2019 02:54:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190527083150.220194-1-tientzu@chromium.org> <20190527083150.220194-2-tientzu@chromium.org>
In-Reply-To: <20190527083150.220194-2-tientzu@chromium.org>
From:   Claire Chang <tientzu@chromium.org>
Date:   Tue, 11 Jun 2019 17:53:54 +0800
X-Gmail-Original-Message-ID: <CALiNf2_Kuu9agO31Wg2X4uUa0EHWYL=qG5RLQ=catn8M9XDKGQ@mail.gmail.com>
Message-ID: <CALiNf2_Kuu9agO31Wg2X4uUa0EHWYL=qG5RLQ=catn8M9XDKGQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: serial: add documentation for Rx
 in-band wakeup support
To:     gregkh@linuxfoundation.org
Cc:     changqi.hu@mediatek.com, linux-serial@vger.kernel.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

(cc-ed device tree maintainers and mailing list)

The second patch in this series[1] is already in tty-next[2].

Sorry for not cc-ing device tree maintainers/mailing list at the beginning.
I can resend this patch if needed.

Thanks.

[1] https://patchwork.kernel.org/patch/10962299/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/log/?h=tty-testing
