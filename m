Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D78085059F
	for <lists+linux-serial@lfdr.de>; Mon, 24 Jun 2019 11:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfFXJ1r (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 24 Jun 2019 05:27:47 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42407 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfFXJ1q (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 24 Jun 2019 05:27:46 -0400
Received: by mail-ot1-f66.google.com with SMTP id l15so12792490otn.9
        for <linux-serial@vger.kernel.org>; Mon, 24 Jun 2019 02:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=AAk9DvGkr/opwj2hNwWMHaKfijvTxUE/1cN3yozWlG8=;
        b=WKYZTaAXhZrCEr+0GdDlnX+xdt6WNMSkV6CSsniCCTvl8sDohc4z1elxmvAYakzkSY
         P8ljJ1tuOGimw2Jc/FZfj5AumsPqX9ylNPzwvLcAb9MytX90QGf56TyelNtEIbk2tTMf
         YJXUNCGbLASTO3/MNqqM2BZKC5YMmzpmh/uDShLCf1YLV9/xIHaHAQcwtfVvEbvOteMu
         nv/tt2An9e5h1mfjZVvoKcPxSPjHgBPLY5NqU0mEb67lyf+dY4MkWb8b9JQ3OxC9zm+j
         urZNCZhZ7L/t0rXrv9ruhOnZk50M2jzrxKyEat/0SqBH7mLJnjYHm7YBw2lFkpqIT7CU
         l9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=AAk9DvGkr/opwj2hNwWMHaKfijvTxUE/1cN3yozWlG8=;
        b=uEbt0sFg51lAKMKw/0YslZSCCLzt1A7r/HP/DQeBzmsUVavm82LbBl0SPDxPi7X24O
         XOpqeqmsMHovn0CPXoRevQapozdMisxxMGHsm1bjIk7vERl0jgFPUfNoDcASm5BE1P3t
         SF6fSNRukViV2cHQG7Zz9l2J61cbwQbZ2HsRbzySaIfaGsvIwW2/x2QhkEGPcmrluZJK
         8OafS9AUOLrU5LETrt1hIOq2s5rpBKtHDo1iLb2a3/AcmNjwo3pk3eDxdccDcJz73nA5
         63RJ4NuXUCsKDFONJu487NeKgNykumHBl75/Mpm4snHxQMsosEd56z5tGcqDgTZzErUF
         KkRg==
X-Gm-Message-State: APjAAAUrl9WWIEaDw7HynkLgLziqdrDds4nDTcxL8sl2efQY1QxOtiqM
        nYsrvkvI6bopy4tq3nOywZ4jNjKPQ+2o3lQvFbb7iafE/z4=
X-Google-Smtp-Source: APXvYqzvESpNnOalP6FXj50IArdq93DAsCxdPWoHHgZVqNGpHVNgV8LQSeTpOSV9JPN+ESjbx/DRdxaoRDUsoAvIGsM=
X-Received: by 2002:a9d:6c90:: with SMTP id c16mr44474585otr.307.1561368465786;
 Mon, 24 Jun 2019 02:27:45 -0700 (PDT)
MIME-Version: 1.0
From:   Shyam Saini <mayhs11saini@gmail.com>
Date:   Mon, 24 Jun 2019 14:57:34 +0530
Message-ID: <CAOfkYf4kCTWdjDJSG0=KgZZG7F+HpE+m+RbgLZ=NeczZ5uWPRw@mail.gmail.com>
Subject: junk character issue on minicom and screen
To:     linux-serial@vger.kernel.org
Cc:     Kernelnewbies <kernelnewbies@kernelnewbies.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello everyone,

I'm working on Rockchip rk3399 Nanopc t4 board and I'm trying get serial output
from board using minicom and my board has baudrate 1500000.

I'm using a usb to serial converter. So, when i power on my board minicom starts
to give junk characters.
Minicom version:  2.7.1
USB driver probed : cp210x

But when I use the same setup with my colleagues laptop it gives correct output
(kernel version 4.15.0-52-generic ).

Note that my colleague and i used same setup
Same usb driver probed
Same power adapter
same usb to serial converter wire
same minicom version.
same baudrate

Other thing which i tried is switching kernel version and it turns out
that one of the older
distro kernel on my system (debian 4.9.0-5-amd64 ) is working fine and
it seems like
there is something changed in newer kernel vesions.
Here is the quick summary
4.19.0-4-amd64    -> not working
4.15.0-52-generic -> working
4.9.0-5-amd64      -> working
5.2.0-rc4+             -> not working

Did anyone else faced the similar problem.
Is there any patch available if it is bug ?
Please let me know.

Thanks a lot,
Shyam
