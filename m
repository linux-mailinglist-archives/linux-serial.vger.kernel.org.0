Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D812F248A95
	for <lists+linux-serial@lfdr.de>; Tue, 18 Aug 2020 17:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgHRPwd (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 18 Aug 2020 11:52:33 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:38626 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728344AbgHRPwG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 Aug 2020 11:52:06 -0400
Received: by mail-il1-f195.google.com with SMTP id 77so18006567ilc.5;
        Tue, 18 Aug 2020 08:52:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RWrMVtISM3XsfgJH5aOXfatld7zUPSy+cKjr1bTQ/Nc=;
        b=HbBc/MhQWCL1oUeQZmsUgQB/u1HXGNp29zvS/fggLrOuCLxtCsG7rSmjegmsiqDHFe
         2YIK4TA6aZiI3pxtRJ6FdYu0YvD0s4lwSW10ARojuCJj1MfsaftvIMUqVY501xTFpYG6
         VoSfV/037AeVgMad5qoIFUKbqxhASuG3VrOrfV4topv8QJieI7jOeSXq0ytScM+9zVc2
         JDhKhjdCgnp1RveOghK41l+OUPM/e8h2PS7+aSTiESXKus+syfAlOl3xEkfIo908ahWr
         jFV+0Zc51QUY99fmDlpMXwGwXmcq0n+1dFoD4fQnlS43XlMUqFwKC8lyaGBLLoHD8oo3
         mEaQ==
X-Gm-Message-State: AOAM531OQuWXCUKl8U+PTor7QyvDVFws5eYtiDwxLUWyBnf5+SnsPUFK
        /bx0hNaSRhNrZ4mpsWvizMoyTQABeg==
X-Google-Smtp-Source: ABdhPJyryqwKNqf3hcMBEuVLUQwnAaNHFmTH44QlioCKElBC48gLiTKFfOT+6vf3WkwFfIh+EGOyyA==
X-Received: by 2002:a05:6e02:147:: with SMTP id j7mr968720ilr.109.1597765921964;
        Tue, 18 Aug 2020 08:52:01 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id w9sm11056305iop.2.2020.08.18.08.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 08:52:01 -0700 (PDT)
Received: (nullmailer pid 3527382 invoked by uid 1000);
        Tue, 18 Aug 2020 15:52:00 -0000
Date:   Tue, 18 Aug 2020 09:52:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     mturquette@baylibre.com, shawnguo@kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        kernel@pengutronix.de, sboyd@kernel.org, fugang.duan@nxp.com,
        s.hauer@pengutronix.de, festevam@gmail.com,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com,
        linux-serial@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH V3 2/5] dt-bindings: clock: Update i.MX23 example
Message-ID: <20200818155200.GA3527350@bogus>
References: <1597721685-9280-1-git-send-email-Anson.Huang@nxp.com>
 <1597721685-9280-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597721685-9280-2-git-send-email-Anson.Huang@nxp.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, 18 Aug 2020 11:34:42 +0800, Anson Huang wrote:
> Update the i.MX23 clock example to align with MXS AUART binding doc to
> avoid below build error:
> 
> Documentation/devicetree/bindings/clock/imx23-clock.example.dt.yaml:
>    serial@8006c000: clocks: [[4294967295, 32]] is too short
> Documentation/devicetree/bindings/clock/imx23-clock.example.dt.yaml:
>    serial@8006c000: 'dmas' is a required property
> Documentation/devicetree/bindings/clock/imx23-clock.example.dt.yaml:
>     serial@8006c000: 'dma-names' is a required property
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> no change.
> ---
>  Documentation/devicetree/bindings/clock/imx23-clock.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Applied, thanks!
