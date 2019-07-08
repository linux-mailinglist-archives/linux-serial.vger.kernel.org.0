Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7837C61D81
	for <lists+linux-serial@lfdr.de>; Mon,  8 Jul 2019 13:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbfGHLE4 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 8 Jul 2019 07:04:56 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]:34638 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfGHLEz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 8 Jul 2019 07:04:55 -0400
Received: by mail-qt1-f182.google.com with SMTP id k10so9921252qtq.1
        for <linux-serial@vger.kernel.org>; Mon, 08 Jul 2019 04:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kp23LTJPz/eUy3KAi5g/b/CIcmzamMaEiPQ+c6HxoVY=;
        b=aeq6msnujeCPEJK27xnUjHXSK62m4D7EGwLjU8EGYyVz6AOw/ZP7U520jWvbZmHEu3
         0FIKMnXbYvjtr4rNp59X3BAizblCKThkp7GKtSwxVtJmxxQX8KSPdRAtpVAVxFmaAv2G
         itGjNu0/5DYeUnuDPGBD5txKuzcon7yKPHLKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kp23LTJPz/eUy3KAi5g/b/CIcmzamMaEiPQ+c6HxoVY=;
        b=izy3ib4DMOCQ/iaW7lxNIHdnQQ04vOXXkEexaPuK8MQ9sBHMZ6RdQwkpQyLId/Rpj7
         Lkb2T9i31aSSTlN6q6HI2/AE83pt52DnuQk0poOpRf+RYYKcvMU/UmqpRaBuSBLjB5PV
         YnoA6djiCnRH40DTVQWIjrCQsufNXC2b3i4Ym35iN7WNGxmZJXm+3eGPfl7djumlSKaT
         0pku7SscYoPvKG6URpL/F1HgdcjBZjuL6Ow2Mn5hvGqL1wbX6/OF3AsnBqrTe5gKDtjx
         FwQuGw7L/Jf07HHpQlv/NMFK+z5swXw1mlOSBY0/wFO+oHmiWbPmmWHPfl3X+A+0JIku
         EBVg==
X-Gm-Message-State: APjAAAVC7Xy4iMO/33eEXmL64aQPdg7zF3ZPgaqZGi8LPvb+LMvVDCUg
        JZyur5gLFapQfDVxEvnSRABV0e0GYZA=
X-Google-Smtp-Source: APXvYqyzrYpe8rttVoj6uOJjMy3Gpj0MHIysT/URdi5Z5nhi2kmjcpnMpQUrGJs99LNoswNLMpqQ+Q==
X-Received: by 2002:ac8:290c:: with SMTP id y12mr13211986qty.141.1562583893264;
        Mon, 08 Jul 2019 04:04:53 -0700 (PDT)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com. [209.85.160.171])
        by smtp.gmail.com with ESMTPSA id t80sm7510809qka.87.2019.07.08.04.04.51
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 04:04:52 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id w17so14408082qto.10
        for <linux-serial@vger.kernel.org>; Mon, 08 Jul 2019 04:04:51 -0700 (PDT)
X-Received: by 2002:a0c:9608:: with SMTP id 8mr13983354qvx.98.1562583891554;
 Mon, 08 Jul 2019 04:04:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190619084110.136713-1-tientzu@chromium.org>
In-Reply-To: <20190619084110.136713-1-tientzu@chromium.org>
From:   Claire Chang <tientzu@chromium.org>
Date:   Mon, 8 Jul 2019 19:04:40 +0800
X-Gmail-Original-Message-ID: <CALiNf29kZ+PYx_jZQKRTcvJqOa6qOYpbXNQ9bryYMw6E0_pNfw@mail.gmail.com>
Message-ID: <CALiNf29kZ+PYx_jZQKRTcvJqOa6qOYpbXNQ9bryYMw6E0_pNfw@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: serial: add documentation for Rx in-band
 wakeup support
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        changqi.hu@mediatek.com,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

gentle ping, thanks
