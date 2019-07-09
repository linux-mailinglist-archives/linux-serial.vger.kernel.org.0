Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60A9D63C64
	for <lists+linux-serial@lfdr.de>; Tue,  9 Jul 2019 22:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbfGIUEQ (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 9 Jul 2019 16:04:16 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42371 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbfGIUEP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 9 Jul 2019 16:04:15 -0400
Received: by mail-io1-f65.google.com with SMTP id u19so45849681ior.9;
        Tue, 09 Jul 2019 13:04:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+sg0UyNjWzyl9UoPX5uT2MaLOsmSi9S3hgZlVeDp1RI=;
        b=SyOtVM8Wt2E3ItX17f+TMB9g4/x384vLN/4f3F+vvbMIzl3cy4PGBE2nGNmOhGcarf
         AmGiDW12tAguLWHnqRHhqHbrT1g91kJrQD9yTavToo3GzTXM/2XcdBoT/QMxlUABKOwS
         pvvQakvksPJPMtwBdyc9o6qwNCxYZ/TXYIb7Ak0E4eJ/mJPtoCUW3irbm1DbH5ccsrM3
         FUvV1G5jC1uHiXThp7k01sOd0ybyluqfZBuqJvKHgv7z4TsWaK5gFY2SiSyJjvyzkQyZ
         XRj1zWYKk3E9klijgpUMe9oLX6jBfECLy/3aqR2YBe2GY/ergbwrCoxKQ2kefPDDB4W4
         DwKQ==
X-Gm-Message-State: APjAAAXWtVYX2cyTJOJJPAwEwqd864NIdnLOpxHqgvFew3UVBwDNFH7w
        HpKWPnis1vTjs2bN79pwG7XiVZEyIQ==
X-Google-Smtp-Source: APXvYqwNBbbM+5EwluWGAGRnJzyxhFhXIpqQVpCldduopah8wyZu2MowBNaCukNHrB2XA+YLzVEGuQ==
X-Received: by 2002:a02:5a89:: with SMTP id v131mr30764937jaa.130.1562702654827;
        Tue, 09 Jul 2019 13:04:14 -0700 (PDT)
Received: from localhost ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id e188sm18828101ioa.3.2019.07.09.13.04.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 13:04:14 -0700 (PDT)
Date:   Tue, 9 Jul 2019 14:04:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Claire Chang <tientzu@chromium.org>
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org,
        mark.rutland@arm.com, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, drinkcat@chromium.org,
        changqi.hu@mediatek.com, linux-mediatek@lists.infradead.org,
        Claire Chang <tientzu@chromium.org>
Subject: Re: [PATCH v2] dt-bindings: serial: add documentation for Rx in-band
 wakeup support
Message-ID: <20190709200413.GA31193@bogus>
References: <20190619084110.136713-1-tientzu@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619084110.136713-1-tientzu@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, 19 Jun 2019 16:41:10 +0800, Claire Chang wrote:
> To support Rx in-band wakeup, one must create an interrupt specifier with
> edge sensitivity on Rx pin and an addtional pinctrl to reconfigure Rx pin
> to normal GPIO in sleep state. Driver will switch to sleep mode pinctrl and
> enable irq wake before suspend and restore to default settings when
> resuming.
> 
> Signed-off-by: Claire Chang <tientzu@chromium.org>
> ---
> changes in v2:
> just document 'interrupts' instead of 'interrupts-extended'
> 
>  .../devicetree/bindings/serial/mtk-uart.txt         | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 

Applied, thanks.

Rob
