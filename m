Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA31F0B58
	for <lists+linux-serial@lfdr.de>; Wed,  6 Nov 2019 02:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730571AbfKFBAQ (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 5 Nov 2019 20:00:16 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40110 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729614AbfKFBAQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 5 Nov 2019 20:00:16 -0500
Received: by mail-pg1-f196.google.com with SMTP id 15so15903911pgt.7
        for <linux-serial@vger.kernel.org>; Tue, 05 Nov 2019 17:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:to:cc:user-agent:date;
        bh=pIiIz2ItTZZzpFH82myiUiEAHJe7A+CuDoWHvWiTyeo=;
        b=EdquaqrcYH+pAh+sVkOifPFVKkTyhPOK0Jl9tBrfdZ4G65rMoNhlQYM6I5b8CMlsw3
         swt42RJKEBWkJSnFHzt5zwF9f/5xM6GOFYXNdlkHTPM97DfjLJuJ7yF1Gq9A3qtSMA9J
         lX+sKkatsh8AE1FAZd0uVqbP68151fel3aBzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:to:cc
         :user-agent:date;
        bh=pIiIz2ItTZZzpFH82myiUiEAHJe7A+CuDoWHvWiTyeo=;
        b=avF8HNdSU0TngrJEF+OHponqssKofM8HSANVkTVOiCwGhRpKagjdTfPfHhDpBAiDMl
         mwS+0xNha59ryRlkXKsptYQU1K2ZYcxdRWUZe6HvXEgiOPmbRfnGdAfH2oJh59XtaHyk
         kNXcyLv8CDn1SN3Hi13150d1a/L1n/yOOUjHTfzi17g0H0FBkCHdlWUm1SD3GwkkHjGx
         fwsgj8XdlzQZxNFccPioNc4TsolBxfbCU90W5GXMgY95vfGkyxXXkslRWnT/p1+dL7aW
         bIGMPLirrx7pTSGv3kGB20xMv9X6HmREixp9TdO9Rfz25aHhzzn8uEtMPowJyv7waG9V
         nnQw==
X-Gm-Message-State: APjAAAVOSDOg66FrB+/r8KpYXBZr09VOJ9q9TqkHDmeUdrz5sO8h6toU
        FZGnj3SxIrGjFaNnmzV2vuP4kQ==
X-Google-Smtp-Source: APXvYqyEBQ8gM3ICvnA0/Vi8tr28bW+OnYoccIDQURlnZ5qTR4tDYqk2vNth+OTrJuyi0c7kCIrqIg==
X-Received: by 2002:a63:5125:: with SMTP id f37mr37765519pgb.98.1573002014320;
        Tue, 05 Nov 2019 17:00:14 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b82sm20863155pfb.33.2019.11.05.17.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 17:00:13 -0800 (PST)
Message-ID: <5dc21b1d.1c69fb81.8f924.e6e1@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191105171705.GB2815774@kroah.com>
References: <1572947835-30600-1-git-send-email-akashast@codeaurora.org> <20191105171705.GB2815774@kroah.com>
Subject: Re: [PATCH v4 1/2] tty: serial: qcom_geni_serial: IRQ cleanup
From:   Stephen Boyd <swboyd@chromium.org>
To:     Akash Asthana <akashast@codeaurora.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        mgautam@codeaurora.org
User-Agent: alot/0.8.1
Date:   Tue, 05 Nov 2019 17:00:12 -0800
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Quoting Greg KH (2019-11-05 09:17:05)
> On Tue, Nov 05, 2019 at 03:27:15PM +0530, Akash Asthana wrote:
> > @@ -1307,7 +1307,21 @@ static int qcom_geni_serial_probe(struct platfor=
m_device *pdev)
> >       port->handle_rx =3D console ? handle_rx_console : handle_rx_uart;
> >       if (!console)
> >               device_create_file(uport->dev, &dev_attr_loopback);
> > -     return uart_add_one_port(drv, uport);
> > +
> > +     ret =3D uart_add_one_port(drv, uport);
> > +     if (ret)
> > +             return ret;
>=20
> What is going to remove the sysfs file you just created above (in a racy
> way, it's broken and needs to be fixed, but that's a different issue
> here...)?
>=20
>=20
> > +
> > +     irq_set_status_flags(uport->irq, IRQ_NOAUTOEN);
> > +     ret =3D devm_request_irq(uport->dev, uport->irq, qcom_geni_serial=
_isr,
> > +                     IRQF_TRIGGER_HIGH, port->name, uport);
> > +     if (ret) {
> > +             dev_err(uport->dev, "Failed to get IRQ ret %d\n", ret);
> > +             uart_remove_one_port(drv, uport);
> > +             return ret;
>=20
> Does this remove the sysfs file?
>=20

The loopback file isn't documented. It isn't removed when the driver is
removed either. Can we just remove the whole thing? It would be nicer if
that sort of thing was supported in the tty layer somehow. Is it?

