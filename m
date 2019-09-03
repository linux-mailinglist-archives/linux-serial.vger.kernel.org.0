Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA25FA678D
	for <lists+linux-serial@lfdr.de>; Tue,  3 Sep 2019 13:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbfICLiw (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 3 Sep 2019 07:38:52 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:32976 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbfICLiv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 3 Sep 2019 07:38:51 -0400
Received: by mail-vk1-f193.google.com with SMTP id q186so2248085vkb.0
        for <linux-serial@vger.kernel.org>; Tue, 03 Sep 2019 04:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mih0raQbf39yzsoFYWOdK+d/n5vUXOa3hJC47gB5UJw=;
        b=NmixfVQZB9V/cZ3d4WtZSBlyEMDe7nr1Ar4lULy31Zs+LsvZegRIFI+apbVq1qp6Aa
         jT9AOFcdqxb+xwR0rWK8Kn/Zf5hHZq5h+L/LRNvgdqJH9hu/UiTq9B0e5Jg3kXBv6/qq
         p3+BP9WlFBPwhn4wkjKsa7sm3XgkVXrp31T3qv04BhlBtGaG0kNrp4qp3N/XC4Rj7wnA
         TgUDUwL1ePpuLEKeulaqhOI6fUcMKLhk7KqT+h+4nxAc3W1Q8RWDE0VI7mlIxyRXbAlv
         HomfYAMJXLhorIEJe1fMZ8Fqyy0QVMtLjJKJQFvyJk5Bou5ySMMfUGyZFPOH7evmPrDG
         E0TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mih0raQbf39yzsoFYWOdK+d/n5vUXOa3hJC47gB5UJw=;
        b=F5TyO8Fk6aPJ3BXiTTkMtMmm+4KbwODzMW6zTxPqFTg0Fnswz/upuN1QuNf+nYRZ4s
         BXawd5cIQumuaAnFqPYd16hvAFFkIZjZGs1a5128zu2iQtrwU6tTcsd4AAGIN3qccgnh
         NKFqRHQtKO06Gg0Ux8496RLRlsp7QKjVrssZjxFxW+EcC6K7oI1MZx95P+Dav9ACtZkw
         lk1G1jdVNUJ5afS1EeDWTDDoH17Gmt7XMti/CLmlf0HlEoe8DUAsGlZkag5iJNlu0tII
         AuAE7vO5Ddztpz4rbjRJPcEEcDjeshsfOa1dwR9t9sKhlnb2HFmVw7mOtrlpiH4YoReq
         cMXQ==
X-Gm-Message-State: APjAAAVvCQEcuTlGvgrBEOqLpeyaxsXBxECXLcwV9lxa6gC7LB8bFfTP
        xmvfuGh+59eavHIMycOl+feLH7T03UQd4/MHlIRy2Q==
X-Google-Smtp-Source: APXvYqwK7IASDv4vaW1zBfIexfD+io3ltACzuUHjg1WjPf3bMa+vjZDeb4M4GqVYo1dqnJBn7sgHwiPm7zLIlxlafOo=
X-Received: by 2002:a05:6122:5a:: with SMTP id q26mr289628vkn.63.1567510730847;
 Tue, 03 Sep 2019 04:38:50 -0700 (PDT)
MIME-Version: 1.0
References: <CANe=CUka=VPOQSyvu5pS8oe9hV3acjdp7OZXVB=TZMCyKeQy5g@mail.gmail.com>
 <20190903111358.GA28823@kroah.com>
In-Reply-To: <20190903111358.GA28823@kroah.com>
From:   Temp Sha <temp.sha@gmail.com>
Date:   Tue, 3 Sep 2019 17:08:37 +0530
Message-ID: <CANe=CUmJXkJVAoe7rtmUirya71zjJ=G-JPkkUPBU4aJzbNo8MQ@mail.gmail.com>
Subject: Re: tty_ldisc_lock hangs at reboot
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Can it be anything with busybox implementation of reboot command? I am
using similar other customized linux device with same kernel but some
changes in busybox (not sure what) where reboot is working perfectly
fine.
I just need to know how can I proceed in this case to fix? Upgrading
kernel version will not be possible for me.

thanks,
ravi

On Tue, Sep 3, 2019 at 4:44 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Sep 03, 2019 at 03:55:32PM +0530, Temp Sha wrote:
> > Hi,
> >
> > My linux box with kernel version 4.14.30 gets hung at  tty_ldisc_lock
> > while executing reboot command. The terminal freezes from where I have
> > executed reboot, however other terminals are still accessible via ssh.
> > Following is the stack trace of tty_ldisc_lock. Can any one help me in
> > fixing this?
>
> 4.14.30 is 111 releases old (it came out in March of 2018).  Please
> update to something more realistic as odds are this might be fixed in
> 4.14.141 which is the latest 4.14.y release.
>
> And if it does not work there, please test the latest 5.2 tree to see if
> it is resolved there.  If so, we can work to find the commit that
> resolves the issue and then backport it.
>
> thanks,
>
> greg k-h
