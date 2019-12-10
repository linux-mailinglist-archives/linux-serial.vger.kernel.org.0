Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28AA9118B7F
	for <lists+linux-serial@lfdr.de>; Tue, 10 Dec 2019 15:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfLJOuj (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 10 Dec 2019 09:50:39 -0500
Received: from mail-ed1-f45.google.com ([209.85.208.45]:41450 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbfLJOuj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 Dec 2019 09:50:39 -0500
Received: by mail-ed1-f45.google.com with SMTP id c26so16195477eds.8;
        Tue, 10 Dec 2019 06:50:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K5Q8z1lZuFpZiVpIxPLlK/TX3uShRnvwUeaP79l8aCQ=;
        b=pXDB9N2U+NF3eawcyFQGbcJo+HQjlckrI3gYejQdia9gHm26jndAATRMSX6wxt1Ob8
         tKPhm8cm0omBfywCyhXD7AQfb/LmQJ3gjzpNUsyQ9iKWEce0Sp4w78sz38mwMbMRFqxB
         m2dbNSZaH6Y98SKZzI0qaFScgesoJriWWFy7LKJ+UNCDFW5vYcFlaLQOtZImT5bJ9wJg
         KniOTahFMWAcbQB3LvSrsdwW2UxLUMZyxW/rqaqw22K2ShPxXF4lOS/txuG+rdtgiH0q
         GBQMmB88+ARRV+zJAdlhAzhTkASglImqXQfLE1H8R7n3Cr5xsmkrNMUx4lTZkMSiVPgG
         w5cg==
X-Gm-Message-State: APjAAAXD5EA4/j1PyU4tKGAEC2Cl21HI8vtRnvMMrM681QAKLnuhUuQl
        VDGGQ9cMs1wKP5vtqYNBZRs=
X-Google-Smtp-Source: APXvYqwuN01ZSvEFWiSad17awZBF1YnGwKo55xzlbJfwiNjZIBopYV+8aRQtqJcQFqLeXFumyKiHsg==
X-Received: by 2002:a17:906:1354:: with SMTP id x20mr4101913ejb.279.1575989437156;
        Tue, 10 Dec 2019 06:50:37 -0800 (PST)
Received: from pi3 ([194.230.155.234])
        by smtp.googlemail.com with ESMTPSA id dd17sm88984edb.9.2019.12.10.06.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 06:50:36 -0800 (PST)
Date:   Tue, 10 Dec 2019 15:50:34 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
        Hyunki Koo <kkoos00@naver.com>,
        HYUN-KI KOO <hyunki00.koo@samsung.com>,
        Shinbeom Choi <sbeom.choi@samsung.com>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/10] tty: serial: samsung.h: remove reset_port callback
 from struct s3c24xx_uart_info
Message-ID: <20191210145034.GC11222@pi3>
References: <20191210143706.3928480-1-gregkh@linuxfoundation.org>
 <20191210143706.3928480-4-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191210143706.3928480-4-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Dec 10, 2019 at 03:37:00PM +0100, Greg Kroah-Hartman wrote:
> The callback was never set, nor called, so remove the pointer entirely
> from struct s3c24xx_uart_info.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

