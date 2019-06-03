Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3727432F33
	for <lists+linux-serial@lfdr.de>; Mon,  3 Jun 2019 14:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfFCMIJ (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 3 Jun 2019 08:08:09 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38291 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbfFCMIJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 3 Jun 2019 08:08:09 -0400
Received: by mail-lj1-f194.google.com with SMTP id o13so15924952lji.5
        for <linux-serial@vger.kernel.org>; Mon, 03 Jun 2019 05:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=SK2NA08wvoo1tSA/J3P5mAjS8SActECm07OLSfKI2rY=;
        b=Bk+uCgOGZ7h4tsb1MciVUPnvH4QSg8VJrxQ3eLE3BWg/AaCXFnsaa0EJSHH/5wJDte
         56TTnk/zgglt+NdLtxehcxZ34Vzua91J7ZojZ2IPK1bYoUJ8bRF60G1fHVNh/WAnqbOX
         EdPBEYOaDwWvqRU4dGWYlwhjqDybKB6D+78kVBv13wjCXEWs0s0MeRFcBJwbot8xny41
         JHz6UbJL5WYD+i2D9D+JfE1+xyPB9mW6jus9/WCWnkupUbGb6dT+1A1yv0Vhjf7+kl/h
         kNP4m/y4vz+7ER+4yV6gY+0aqNBVVXwgm/WQnNZ8mypK5zKTaFHoh/uCzLHtHXvy8Our
         MZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=SK2NA08wvoo1tSA/J3P5mAjS8SActECm07OLSfKI2rY=;
        b=lAiklNBfFZ6Z4E0DAzfip+K7rEHiI/SenkxEZ1Ibx0G789Rrz++7Rs1kKQTCcWEyOb
         4UGEEL6CcdUbGzlTWIax0PT+dozf1ONpxjegY97VIbYqi6yb9Co402sWcN09boYurKuZ
         M6ohVTpAGh2aatT6+PiClARN7wgTlZd/rh4kxs5aT2NpubcX7tzpqaBRngw1j1TyEdz3
         CKBXcyQOqOYjeDaLX6qkzi+rg4BLqdCKzapNwHBchc+h1F38fGrjjCo8ceB/c1Sj6V3p
         s5u6B7X0j5r/c6ZH0ZU9BZ0ZK2C5pEbxLH07d9c2SiTtt6sqm3ry+4Rux0VnAlpYWtW+
         OnPw==
X-Gm-Message-State: APjAAAV8b9Nj8zmt+0ht6vqNVAexxCgrbJpm1f32OWvZoMAZGBpKo661
        40w/8ZbqsbcAnG93frv+epQErZKdex8=
X-Google-Smtp-Source: APXvYqx3Lep4XvvL0AbXmOCbNW+9lnAXyEbBNBpOHLBCrnJNhPEiZPgeNmXkrsUIBFgw532hOpYMqw==
X-Received: by 2002:a2e:9142:: with SMTP id q2mr13856955ljg.18.1559563687471;
        Mon, 03 Jun 2019 05:08:07 -0700 (PDT)
Received: from osv ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id k7sm3102726ljc.92.2019.06.03.05.08.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 05:08:06 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 2/8] serial: imx: fix breaking RTS/CTS handshake by mctrl change
References: <20190530152950.25377-1-sorganov@gmail.com>
        <20190530152950.25377-3-sorganov@gmail.com>
        <20190530203931.n6b22ktbzuyg67sd@pengutronix.de>
        <87woi7ur1g.fsf@javad.com>
        <20190531062809.nacg54russc3wvcz@pengutronix.de>
        <20190531135438.bqrpek6niddnrqmo@shell.armlinux.org.uk>
        <87r28ea2qa.fsf@javad.com>
        <20190601161256.4zuhqzrdskjdymu5@pengutronix.de>
        <20190601193436.irs6sdknz755uyem@shell.armlinux.org.uk>
Date:   Mon, 03 Jun 2019 15:08:06 +0300
In-Reply-To: <20190601193436.irs6sdknz755uyem@shell.armlinux.org.uk> (Russell
        King's message of "Sat, 1 Jun 2019 20:34:36 +0100")
Message-ID: <875zpm7ty1.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Russell King - ARM Linux admin <linux@armlinux.org.uk> writes:

[...]

> If we want the kernel to stop reading the FIFO, we would have to add
> additional complexity to a lot of serial drivers, and a capability
> which tells the kernel that they support this behaviour - why do we
> want individual drivers to have to implement this?

How does it work when no handshake is configured? Drivers continue to
read FIFOs/TxDs and drop data when software buffers are full, spending
CPU cycles on nothing?

-- Sergey
