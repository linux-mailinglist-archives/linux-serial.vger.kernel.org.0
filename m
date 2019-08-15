Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A412D8F4EB
	for <lists+linux-serial@lfdr.de>; Thu, 15 Aug 2019 21:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731487AbfHOTnC (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 15 Aug 2019 15:43:02 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42575 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730148AbfHOTnC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 15 Aug 2019 15:43:02 -0400
Received: by mail-qk1-f196.google.com with SMTP id 201so2778429qkm.9
        for <linux-serial@vger.kernel.org>; Thu, 15 Aug 2019 12:43:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nqku9j7PFIyYJaH3H6X7cyTOKpVgC7neN3eCM3hiIg4=;
        b=V3T7Deak33iGbNb1DYwF5+R3dkMKQfKCVPdMG/M3ZX5ehVTTfb422KjfjNx1UPQoEv
         wY/DsE32DTDJJ3lNTpxEMyqaN8L1bjo63kPmDLIFBKouBrdz2l1aRDrJw5FZSaUc7m25
         oFb5WMXYxnHXHyQa37mgHoHb6DipYFUYI+3bUJMWVay1xCedBdG1HrAJwGEb0Tn0QgKO
         NhCSF1zI31alH0Eyke7BCDoanJVg8MdGXRvadKvvSrQZB33PhHQcecE7e5qySeR1ZFWc
         kkyzfb2w5sfUAHIHq5NuXN+rsaY4g8FuLN7+4sODkzKo6gSnmyF/pU4sfa+rmhCgS64Y
         +ywA==
X-Gm-Message-State: APjAAAWjtniE+Yyget7b6kJ3MQfm7oyS9KgGZ9/7IlIybYPD8yhLM6xE
        lAzkmvna9uiMRDImjsUmSPolg/se6Gvt9hrti2k=
X-Google-Smtp-Source: APXvYqwIC7ylDlx6oFt32w5GNE9QqCZXG4mqi0E+ejX4xxOCaTqv1RNNMB5OF5VQ+fn8iQep/KsCAH9fHbv8vklbQ3k=
X-Received: by 2002:a37:4ac3:: with SMTP id x186mr5500643qka.138.1565898181627;
 Thu, 15 Aug 2019 12:43:01 -0700 (PDT)
MIME-Version: 1.0
References: <201908160045.ql5LACNr%lkp@intel.com> <20190815193157.GE30437@kroah.com>
In-Reply-To: <20190815193157.GE30437@kroah.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 15 Aug 2019 21:42:45 +0200
Message-ID: <CAK8P3a3mi9wmWmDiwo52oOOeFhCnbnLppEGK5vcwbOpyv_wZ=w@mail.gmail.com>
Subject: Re: [tty:tty-testing 84/90] drivers/tty/serial/lpc32xx_hs.c:447:14:
 sparse: sparse: incompatible types for 'case' statement
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Aug 15, 2019 at 9:32 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Aug 16, 2019 at 12:21:48AM +0800, kbuild test robot wrote:
> > Hi Arnd,
> >
> > First bad commit (maybe != root cause):
> >
> > tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
> > head:   92770c07234fb9e097ceb512e4bb29aca750075c
> > commit: 5dce8eccb54355ea42918b651f1085e54b2c5f2f [84/90] serial: lpc32xx_hs: allow compile-testing
> > reproduce:
> >         # apt-get install sparse
> >         # sparse version: v0.6.1-rc1-7-g2b96cd8-dirty
> >         git checkout 5dce8eccb54355ea42918b651f1085e54b2c5f2f
> >         make ARCH=x86_64 allmodconfig
> >         make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
> >
> > If you fix the issue, kindly add following tag
> > Reported-by: kbuild test robot <lkp@intel.com>
>
> Given that there are at least 3 issues with this patch, I'll go drop it
> from my tty-testing branch now :(

Sorry about that. In version 1 of the lpc32xx series I had explained that
they would have to get merged in sequence because of the dependencies.

I've applied all 13 to the arm/soc branch now after Sylvain confirmed
that he considers the series ready.

       Arnd
