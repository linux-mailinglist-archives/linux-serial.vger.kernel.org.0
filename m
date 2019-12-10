Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3D86118B87
	for <lists+linux-serial@lfdr.de>; Tue, 10 Dec 2019 15:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfLJOwH (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 10 Dec 2019 09:52:07 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46710 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbfLJOwH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 Dec 2019 09:52:07 -0500
Received: by mail-ed1-f66.google.com with SMTP id m8so16172641edi.13;
        Tue, 10 Dec 2019 06:52:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vnMo0Q3LhdLOTfXftmwazBAlZMLfT/1Z0Eq6LrQUqdc=;
        b=adoZTKddLqHvuYyIzQFY1Gx43lt3pjw3kYkZ1J+HKzPnj+gbYU4t1/G0d3c9PAIo51
         gMSab1fBkpepKR0lfFBMC5ibUmOG7AAH1P9sMD+cUNuKrgV/CPBVFG/9FwQGldomW3ny
         Ty9R7YIQPvfvYzVLIW7PvC8DYhe5ozbyLhZXnQZpxKltcQXthlXBS6jVg4tPtKk8eCqm
         6OcOnBrqaSjtWxljxKyqbuMY5nf1/THInhPiDx66/0Rrsw+be/GmH2hsveiqV4+eAubi
         sSQEd0g+JJGZgRl5mplU/9bKOgprc6R9ICTFCiwCsjNfkmah9XjCcHYtYXCqVSCrhzrF
         vbRQ==
X-Gm-Message-State: APjAAAViWlIpwNawOGoHXEtWnWdyaYHOP4upIxO1Hb9ZN8xls5YTcpEz
        C7LUMpP3JDfrmjg0umA7DIQ=
X-Google-Smtp-Source: APXvYqw8E22/mA1z+Pv20fl6fJbN59CqfIhZcA5CUD+tWG45/U1MB8pFtq/LQzK21g3Bfic01PlZWQ==
X-Received: by 2002:a05:6402:17f2:: with SMTP id t18mr40260410edy.9.1575989524821;
        Tue, 10 Dec 2019 06:52:04 -0800 (PST)
Received: from pi3 ([194.230.155.234])
        by smtp.googlemail.com with ESMTPSA id m17sm76622edq.37.2019.12.10.06.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 06:52:04 -0800 (PST)
Date:   Tue, 10 Dec 2019 15:52:02 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
        Hyunki Koo <kkoos00@naver.com>,
        HYUN-KI KOO <hyunki00.koo@samsung.com>,
        Shinbeom Choi <sbeom.choi@samsung.com>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/10] tty: serial: samsung_tty: delete samsung.h
Message-ID: <20191210145202.GD11222@pi3>
References: <20191210143706.3928480-1-gregkh@linuxfoundation.org>
 <20191210143706.3928480-5-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191210143706.3928480-5-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Dec 10, 2019 at 03:37:01PM +0100, Greg Kroah-Hartman wrote:
> There is no need for a .h file for a single .c file, so just move all of
> the content of samsung.h into samsung_tty.c
> 
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Hyunki Koo <kkoos00@naver.com>
> Cc: HYUN-KI KOO <hyunki00.koo@samsung.com>
> Cc: Shinbeom Choi <sbeom.choi@samsung.com>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linux-serial@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/tty/serial/samsung.h     | 144 -------------------------------
>  drivers/tty/serial/samsung_tty.c | 133 +++++++++++++++++++++++++++-
>  2 files changed, 130 insertions(+), 147 deletions(-)
>  delete mode 100644 drivers/tty/serial/samsung.h

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

