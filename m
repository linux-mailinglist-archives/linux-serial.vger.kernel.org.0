Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCA7637FE
	for <lists+linux-serial@lfdr.de>; Tue,  9 Jul 2019 16:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbfGIOfa (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 9 Jul 2019 10:35:30 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45056 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfGIOfa (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 9 Jul 2019 10:35:30 -0400
Received: by mail-io1-f66.google.com with SMTP id g20so22510604ioc.12;
        Tue, 09 Jul 2019 07:35:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lwKfxQYrNRix0RZpaeVKxAuscBcsaH2KK8rGZ1jsPCc=;
        b=ocRzfiRgXIva0JauHKxvl0Qx4lxvrR0xCAKBGt//mP8ageVe/80cST9MYCFCplvhOV
         H0VO1yuRgbruHYe7tqRsV7eO2SSKomX9bmC3Y6YukRyeHB7XM/npKs4jcOHNJqkoR7Su
         BoS/pe0AFdEnLBOHeLEKQbGmBVX6P099jVa/n//lom9YA97T1G7YAXHt44zd6yAzpal6
         HV5uZx/iUCWzlg+Sm1mqivE3tTOHalyGlizL1f3FNN7KBA1S70u9nY+t5ToMIB2xjta9
         56V4HaflRlt8/Yg9jdz2CHRJDdSVUK6MOhUyWs2noBH9vh3WGu0yBf+k0M7o1ci/TyKC
         AJCQ==
X-Gm-Message-State: APjAAAU1qH2n6lfS2Dy9AhiuHHzrX0bTBsHlsji/HsJgz+QtMDd4uRB8
        WN33mz39uAg69hJ5bL8yVg==
X-Google-Smtp-Source: APXvYqxycFxWOrP0VFA297PFQw08U0eQrnQU3S4DTJhbrCNZVKI7ILJJDrcU1R51khX7qQdXozwvCg==
X-Received: by 2002:a5e:8e4a:: with SMTP id r10mr6692177ioo.100.1562682929485;
        Tue, 09 Jul 2019 07:35:29 -0700 (PDT)
Received: from localhost ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id n2sm14065735ioa.27.2019.07.09.07.35.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 07:35:28 -0700 (PDT)
Date:   Tue, 9 Jul 2019 08:35:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Erwan Le Ray <erwan.leray@st.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-serial@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Erwan Le Ray <erwan.leray@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Bich Hemon <bich.hemon@st.com>
Subject: Re: [PATCH v3 01/10] dt-bindings: serial: stm32: add wakeup option
Message-ID: <20190709143527.GA5489@bogus>
References: <1560433800-12255-1-git-send-email-erwan.leray@st.com>
 <1560433800-12255-2-git-send-email-erwan.leray@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560433800-12255-2-git-send-email-erwan.leray@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, 13 Jun 2019 15:49:51 +0200, Erwan Le Ray wrote:
> Add a note for enabling wakeup capabilities of usart
> 
> Signed-off-by: Bich Hemon <bich.hemon@st.com>
> Signed-off-by: Erwan Le Ray <erwan.leray@st.com>
> 

Reviewed-by: Rob Herring <robh@kernel.org>
