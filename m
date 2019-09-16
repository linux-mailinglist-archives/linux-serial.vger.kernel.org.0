Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47273B39CD
	for <lists+linux-serial@lfdr.de>; Mon, 16 Sep 2019 13:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbfIPL5S (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 16 Sep 2019 07:57:18 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35869 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfIPL5S (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 16 Sep 2019 07:57:18 -0400
Received: by mail-wm1-f66.google.com with SMTP id t3so9994357wmj.1
        for <linux-serial@vger.kernel.org>; Mon, 16 Sep 2019 04:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=A8KpKxE5/TCH8dxfTxqIPDIeEF4A15g4Y1Nx2SIGDMM=;
        b=EFCHz3OIRhtn7f84ycqptRsNU7sOugoVct7LGmPkUvlfrHMqotNHm4aA6HgkcJqEru
         4ulzRNPTuYupGcXDbDRNC/6SH1sX0+RD9v6XuhhGyq1rgfMRwPr6AKyMYNZqSVDLVLxx
         gpXl4TsIljDZ79UupeVt5WX/4j0ojl0XJaXllv93W7s2Dz1tqbiybFbUe+FzqVnzylbp
         FBuihxhA9Hrzt5Ab9N6IQXwGKmqFTG8KKga/WRYLbsu4O5DPdieQLw0szr03eGj9VkiL
         qnWZac7IYohHC4cbIsEI1iY5gJX/KI6Ewenp3fLYkqWI2VPJPqPAWmLjLCabIAdIj9mm
         7+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=A8KpKxE5/TCH8dxfTxqIPDIeEF4A15g4Y1Nx2SIGDMM=;
        b=MbjUWMly7kgoAdNmRV16R9lTIbXaOsLww9nwQqHRgUB3Z0ZUDo2iMX1xo2Rfzl+Geq
         2JuQXC73ztGmTsFd5xNkiyi3HodMIZpkZoXteJSOGFIwJZFx4KJwQQWjCfGUPiUstfgB
         SqlO+MZ3HLYT6a1ULuy3wxyhZK5YNtfqFsgjidHLYJkVWbmm8R2fsN/npJoZQxf5Do1/
         bLuGpDpOLYAt8Jx6CHcSeNjD+LESoiMMTWEDgAR7FxY2jbm69fDT/A/MQJK6D6aKumzp
         6qUiByyE1q4RASJkVxGIkgmSnEB+8Vz8STeeV8dM1BdQY35zECTg2rBJ0XsauaPebZyc
         Rcww==
X-Gm-Message-State: APjAAAXxhtMU89fJFgqEs5/BP+ADOyJtv4p924JK5FI0hXTIl1cVVExT
        MWo34cor5N0Zh12Z48kYzXEvKQ==
X-Google-Smtp-Source: APXvYqwvaXAToK3N7Dq6gBnUUF2ouck3zigq8a1VamrYjh9bMW1cIFLpi8bkeIrkaTJxW6vXEmn4gw==
X-Received: by 2002:a7b:c5c5:: with SMTP id n5mr11858939wmk.69.1568635036421;
        Mon, 16 Sep 2019 04:57:16 -0700 (PDT)
Received: from localhost ([195.200.173.126])
        by smtp.gmail.com with ESMTPSA id r20sm1421258wmh.37.2019.09.16.04.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 04:57:15 -0700 (PDT)
Date:   Mon, 16 Sep 2019 04:57:14 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Andreas Schwab <schwab@suse.de>
cc:     Christoph Hellwig <hch@lst.de>, gregkh@linuxfoundation.org,
        jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial/sifive: select SERIAL_EARLYCON
In-Reply-To: <mvmzhjcr2d4.fsf@suse.de>
Message-ID: <alpine.DEB.2.21.9999.1909160456010.7214@viisi.sifive.com>
References: <20190910055923.28384-1-hch@lst.de> <mvm4l1kskny.fsf@suse.de> <20190910070503.GA31743@lst.de> <mvmzhjcr2d4.fsf@suse.de>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1619585291-1568635034=:7214"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1619585291-1568635034=:7214
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 10 Sep 2019, Andreas Schwab wrote:

> On Sep 10 2019, Christoph Hellwig <hch@lst.de> wrote:
>=20
> > On Tue, Sep 10, 2019 at 08:57:37AM +0200, Andreas Schwab wrote:
> >> On Sep 10 2019, Christoph Hellwig <hch@lst.de> wrote:
> >>=20
> >> > The sifive serial driver implements earlycon support,
> >>=20
> >> It should probably be documented in admin-guide/kernel-parameters.txt.
> >
> > How so?  W=D1=96th OF and a stdout path you just set earlycon on the
> > command line without any arguments and it will be found.
>=20
> Doesn't work for me.
>=20
> [    0.000000] Malformed early option 'earlycon'

Try:

    earlycon=3Dsifive,0x10010000

If it works, you should see this message on the kernel console very early=
=20
in the boot:

[    0.000000] earlycon: sifive0 at MMIO 0x0000000010010000 (options '')


- Paul
--8323329-1619585291-1568635034=:7214--
