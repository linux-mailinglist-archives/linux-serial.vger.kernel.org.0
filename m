Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A10F546630
	for <lists+linux-serial@lfdr.de>; Fri, 14 Jun 2019 19:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfFNRvz (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 14 Jun 2019 13:51:55 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34453 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfFNRvz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Jun 2019 13:51:55 -0400
Received: by mail-qt1-f193.google.com with SMTP id m29so3489299qtu.1;
        Fri, 14 Jun 2019 10:51:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PST035fihKP7qa7V2kxzXv7aujCa26RgBIP4O3/ziZQ=;
        b=pZ3KRfVn0qsDF+MqrNJPWTPBrfl8E3yJ11aIH4sslhjAK8KvkgonzStQTGOIHsEhtj
         fckRk+R0U362vK5N5WyKvoLdrUMJbZDwtzMTIzVN7gzOCmVk8TxUn2tEINjNu67aB1YZ
         2A1gzXk0UCTT7jvxQINJJ1yHCEc+K0iGQD3gpsq9If8hB9+kGM5xkE5AISMJmFzkFFMB
         tUoSsJcjjGmS7Kx3BqNLu65sVjGn0OxuyzNtTzniPZwdDyhzt6Dtu3x8XO831FD7AlGi
         0NIC8x7Qgnv1AQvSY0N887A/xmofXYB4FvkRkdGkHK9+3TlPEVwnmelObcJVXa/dnkfB
         mpKw==
X-Gm-Message-State: APjAAAX7xEfJHgNycBg+FrYKBMmcOS7ibwCLY9zqAOanamURQyjD78Ip
        D5M0nQfcBzijDlor/X90Jw==
X-Google-Smtp-Source: APXvYqwUnd8FPADe8nH6dseR+TRRkfxHm0kmkb3uxoiwjmhMZifbdpbshCoLVh3igT7lLIlcMAitWA==
X-Received: by 2002:a0c:86e8:: with SMTP id 37mr9667182qvg.77.1560534714279;
        Fri, 14 Jun 2019 10:51:54 -0700 (PDT)
Received: from localhost ([64.188.179.243])
        by smtp.gmail.com with ESMTPSA id n5sm2197915qta.29.2019.06.14.10.51.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 10:51:53 -0700 (PDT)
Date:   Fri, 14 Jun 2019 11:51:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Erwan Le Ray <erwan.leray@st.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Erwan Le Ray <erwan.leray@st.com>
Subject: Re: [PATCH 1/1] dt-bindings: stm32: serial: Add optional reset
Message-ID: <20190614175152.GA18378@bogus>
References: <1558711838-21174-1-git-send-email-erwan.leray@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558711838-21174-1-git-send-email-erwan.leray@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, 24 May 2019 17:30:38 +0200, Erwan Le Ray wrote:
> STM32 serial can be reset via reset controller.
> Add an optional reset property to stm32 usart bindings.
> 
> Signed-off-by: Erwan Le Ray <erwan.leray@st.com>
> 

Applied, thanks.

Rob
