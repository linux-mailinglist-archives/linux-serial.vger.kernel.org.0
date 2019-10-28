Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFF61E7034
	for <lists+linux-serial@lfdr.de>; Mon, 28 Oct 2019 12:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfJ1LOR (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 28 Oct 2019 07:14:17 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56099 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfJ1LOR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 28 Oct 2019 07:14:17 -0400
Received: by mail-wm1-f66.google.com with SMTP id g24so8978295wmh.5
        for <linux-serial@vger.kernel.org>; Mon, 28 Oct 2019 04:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ykgWVY0EjnFdn520xL6BzsoXioCZ7w2IMu3KRuijaw8=;
        b=KfhaN0tkEF+b06jtdcdQ1TLwxPOFeXJJ485CTzLtE/JUhcZLivhsDZqYAnLqQKmZos
         fhjQL9PW3u33hGNYIVNGWkWs2Ie+UKLKFDzdZR35fw1eVLCU7dIGGsSZIfv7rYIQSqDu
         2OIQDSXyTjlUzj8WVQwlP4lisXxWjqDIEtOp8lJ65JTA1XvFWubMsZ1s9HOSboSelT1X
         j0BFq770oBgZTcb4WgzYcfBFdbgL/AjNtGkkAp3URxEpF6aunIeF0d70cgB5T3LBvXLi
         9mOJptpMmdIL72u/LXtmkyaF8oxPsVfTq9xdo7dGQhlncAM1c4x9w9/eO/9Mw3kGbF/l
         6ixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ykgWVY0EjnFdn520xL6BzsoXioCZ7w2IMu3KRuijaw8=;
        b=OrjzhLjBEYx5Yx9UAOV+UTenVPRN0jTFClUjEhqZI4HLDLZBQYZZYvl7rCbyEfldKc
         FAIybSy8aX9j9nk/0t6CgeGtVYDL1TiSBxG/gbQBcVfb9dbHVJf6AGtkywHRdj9YNYD/
         GnYh54TA3Mdm31SNw88h5iR3aVITPco9Qj+JIuN/BDsP9t3VnaEjANHVCAL+YJKM0QpA
         mmZRmwbvKCGds0DJMB6eqJcHg+Nx0VuJOzbQ8jUEo4fwSckutHuPlX6/fN169uHQRYNQ
         l12IWnngyBJ9lFEmeOA6eMvjoJHo3fQrcE2hybw/1MuXyI9Jjj1ze673imkUYgkraEfl
         3nkQ==
X-Gm-Message-State: APjAAAWG2nWZPYhzPXmZoaKzPCea7l8Oqg9c8KpUAqeLjlbc6EYtacvn
        FizBNc6ELJgHgy0CBw+hQ6d2ahvrc9dnSYv4BDE=
X-Google-Smtp-Source: APXvYqzA8O2X19urvhRMhg1mzugtiu3bsRkDZ6ZYHwjspJUJD4pV/UOkbZ7Rv6k7zhtlvWYWcm9j/3z+7BMY+oHd/6U=
X-Received: by 2002:a1c:2b83:: with SMTP id r125mr14073322wmr.110.1572261254965;
 Mon, 28 Oct 2019 04:14:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAEXMXLRBpQcSq3SrvL4LkG8_7S0CWJFGqRCnjywjbUEPZg9XxQ@mail.gmail.com>
 <CAEXMXLSty8v1K_yaxoAnoMEny=XYn2ngUdCPi_0uTqy5NTViAQ@mail.gmail.com>
 <CAGm1_ksE038XOzqXHw6iSAxq8mCegM8Ej8cdPvP5Tu_EBouSLQ@mail.gmail.com>
 <CAEXMXLSCW33wCho-7damt-aem0Z76xypr-AHY0zmR5T8PwLS7A@mail.gmail.com>
 <CAEXMXLSkNXPYQtzLtnxTzeVAL5MvafsG1yUZHjn8Stg-UZyT=g@mail.gmail.com>
 <CAGm1_ksD6UDdW-3B4KkkoP1QYhp307YMyzf-GPx1Vu1oCFka+A@mail.gmail.com>
 <CAGm1_ksb7tG3xux1yery5qya7UAGYyMBz0xbVgG6pKxaR2Nf3A@mail.gmail.com>
 <CAEXMXLTJbTRfiASo6Dk=0Lp1iBc4Svv4dw1L+FNi3itoo9e+eQ@mail.gmail.com> <CAGm1_ksCumyMWQRAbE8DRoNgO1Y6ScZbaE01hW49_f7s07iu3A@mail.gmail.com>
In-Reply-To: <CAGm1_ksCumyMWQRAbE8DRoNgO1Y6ScZbaE01hW49_f7s07iu3A@mail.gmail.com>
From:   =?UTF-8?Q?Nuno_Gon=C3=A7alves?= <nunojpg@gmail.com>
Date:   Mon, 28 Oct 2019 12:14:03 +0100
Message-ID: <CAEXMXLQjkP76W0O_J_jAnqzX4deodE7cThwa9yysmmAxue7Jew@mail.gmail.com>
Subject: Re: Regression since 4a96895f74c9633b51427fd080ab70fa62b65bc4
To:     Yegor Yefremov <yegorslists@googlemail.com>
Cc:     linux-serial@vger.kernel.org, Stefan Roese <sr@denx.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Oct 28, 2019 at 12:12 PM Yegor Yefremov
<yegorslists@googlemail.com> wrote:
> Just curious. What baud rate were you using?

B3500000

(3.5Mbps)

Thanks,
Nuno
