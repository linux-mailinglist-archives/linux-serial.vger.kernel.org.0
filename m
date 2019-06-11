Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 355B23CAF9
	for <lists+linux-serial@lfdr.de>; Tue, 11 Jun 2019 14:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbfFKMSP (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 11 Jun 2019 08:18:15 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37275 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728159AbfFKMSP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 11 Jun 2019 08:18:15 -0400
Received: by mail-qt1-f195.google.com with SMTP id y57so14206385qtk.4
        for <linux-serial@vger.kernel.org>; Tue, 11 Jun 2019 05:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g5i49l4VfJcEzoWbFwIf3HpGCD6+/0Z2WJ63n1g5Dzs=;
        b=lHy7l5iuNJJVbYGg8Pr0qdGaYDIgmTC+o3rhUwXxq6E9ILKH7VCOaCqdgmCNguSS67
         vt8hDhDUDyKbztEdmsIKJkY9vPCRWlvo1bCPp2rQMKZ5aUd8ySk5+c8Jxu5mnklh0jCI
         P+S51JBU0KBY570Wejx5bk/w9W8LJJO1ipYAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g5i49l4VfJcEzoWbFwIf3HpGCD6+/0Z2WJ63n1g5Dzs=;
        b=kF+WszCgvQGBo1k/fEV0GfozB824OQt6tBtUabPysrpdKr44tLZc/xLsieH/cLQR9u
         zC0fB/DFIkGEKQcAzKWbrn25NFSPfMJyYDlumvkLMzXhYpYocj39MBthcCOskfSkT6TL
         2N6XB0QdAYcgmSkLaVDYN9zWw1lQXCbUDeUph720rk8RWQZL4Q0yorlmemwgF+2ELqM5
         6EQ/43wPw5VMq/xHJJw8CZ6u8G6Uaoj8ZKbExjol91wVcYy5z/pcsoGMVJXMMgHa1GIs
         /tdKnDvvrH7tAttMzH2EaW1G/zLLI15s2LlMvDl8HpnMzl/R5q+F/jb/BkZFtMCSv7iD
         Xarg==
X-Gm-Message-State: APjAAAXq18mT8aqrAUegpM3K/oxrRBpy0xDHG9LLcO+5fApSexkNFGuo
        nKfIhOYhbrJSBEkOCU3sxTGxpaHkjGQ=
X-Google-Smtp-Source: APXvYqwWVY42NK5KurGcmXY4kA51xa0o1sooEROkS4KCMDrKetrYS7qZOcimhNnALKF84KkP/f3bMQ==
X-Received: by 2002:ac8:34ce:: with SMTP id x14mr65137506qtb.33.1560255493870;
        Tue, 11 Jun 2019 05:18:13 -0700 (PDT)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com. [209.85.160.172])
        by smtp.gmail.com with ESMTPSA id v72sm5629221qkb.0.2019.06.11.05.18.11
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 05:18:12 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id s15so14152272qtk.9
        for <linux-serial@vger.kernel.org>; Tue, 11 Jun 2019 05:18:11 -0700 (PDT)
X-Received: by 2002:ac8:7346:: with SMTP id q6mr46465019qtp.380.1560255491256;
 Tue, 11 Jun 2019 05:18:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190527083150.220194-1-tientzu@chromium.org> <20190527083150.220194-2-tientzu@chromium.org>
 <CALiNf2_Kuu9agO31Wg2X4uUa0EHWYL=qG5RLQ=catn8M9XDKGQ@mail.gmail.com> <20190611095752.GA24058@kroah.com>
In-Reply-To: <20190611095752.GA24058@kroah.com>
From:   Claire Chang <tientzu@chromium.org>
Date:   Tue, 11 Jun 2019 20:17:59 +0800
X-Gmail-Original-Message-ID: <CALiNf2-79LEg+dvSqQK8kVkf99ARLwy9uLCmJNgq-vJO9r0a9g@mail.gmail.com>
Message-ID: <CALiNf2-79LEg+dvSqQK8kVkf99ARLwy9uLCmJNgq-vJO9r0a9g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: serial: add documentation for Rx
 in-band wakeup support
To:     Greg KH <gregkh@linuxfoundation.org>
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

resent here: https://patchwork.ozlabs.org/patch/1113768/
sorry for the inconvenience
