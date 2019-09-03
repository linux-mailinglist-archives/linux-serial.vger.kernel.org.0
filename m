Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4684DA6682
	for <lists+linux-serial@lfdr.de>; Tue,  3 Sep 2019 12:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbfICKZs (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 3 Sep 2019 06:25:48 -0400
Received: from mail-vs1-f41.google.com ([209.85.217.41]:35786 "EHLO
        mail-vs1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbfICKZq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 3 Sep 2019 06:25:46 -0400
Received: by mail-vs1-f41.google.com with SMTP id b11so5401182vsq.2
        for <linux-serial@vger.kernel.org>; Tue, 03 Sep 2019 03:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=A/FqgofbgK2/f1LqZLQTR0v29nbaGE4CV//5hAzs3aQ=;
        b=pCwMXyPkb53hQiGL6qsG0t9hIY8oGTosbgqvUxl3FS3qegUqnPZjbW0F9tBKZ868P+
         uwv8amR41s3OhkiIAChcS1StphNtO2YYhxP5g41PI6FqILI00bDRVskdR91KLRbDFcvM
         Z2kzxTTOnvDDUxKBItXJUAIQ+2wAkszSkVDg3tqXH1Kf47x2df+zZMwlda4f/KvKK+dh
         xtieOXRoMyPaOPEurSUR72WuSFdD+fLUN5EG5SOhu9OI+gdUwjChN2UDsJT6Xjwoj2M5
         fXCky49AzBC0+OJp+JskMsZl5MYJ6Ax/LUCVp4wiCda+hyReo8gr/wXi0h0gs+KZmOOP
         bm+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=A/FqgofbgK2/f1LqZLQTR0v29nbaGE4CV//5hAzs3aQ=;
        b=WfXB1Bg1xruvV9FuR1ZnqaCtfIKKV9zhm34aS8Uucf4Eei2UDMa2zOivBlpPkd52QV
         VElhMBTlWPjPkGXTx05Bgx/SC/Gq275xR4YT1I4FjfGwFfucaiPbhDAPH+bbRniK62bp
         H7Kx9EVN4voIBKvC179TfTk/cDiiKtnlg/wxGZm+hLyXHp8NvmZ7vuakuTsbd7yvulfo
         CfcFwPT/zJTYEsYoDOkbJybCHbo/eGhrWeJQOTWB73/zv9gZlDkiXuQsJVEX+3eAyVrs
         R/d4zTPZ7i4BatStLL4uyy9u5ClkEz4cN4Z34Anw31nTw26Ord0nmt103TvGknbMJCEW
         ZpwA==
X-Gm-Message-State: APjAAAWNQXLbWCznP5FUCHz6MaaYnF4059P0Y6wU90y5QYNMdRhckAlQ
        jg0474TjKQNfHmRNa78b9NPlz+mLJUm1LL4EMCWd9LTC
X-Google-Smtp-Source: APXvYqzC38QiAaTGhskbG++x/TT/APdo1ExewooIX5mfN4VlK8LR4utP8WEQILaBKrA21DUxAJ0GRg0E9n/20n2V50w=
X-Received: by 2002:a67:dd97:: with SMTP id i23mr1824376vsk.131.1567506345119;
 Tue, 03 Sep 2019 03:25:45 -0700 (PDT)
MIME-Version: 1.0
From:   Temp Sha <temp.sha@gmail.com>
Date:   Tue, 3 Sep 2019 15:55:32 +0530
Message-ID: <CANe=CUka=VPOQSyvu5pS8oe9hV3acjdp7OZXVB=TZMCyKeQy5g@mail.gmail.com>
Subject: tty_ldisc_lock hangs at reboot
To:     linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

My linux box with kernel version 4.14.30 gets hung at  tty_ldisc_lock
while executing reboot command. The terminal freezes from where I have
executed reboot, however other terminals are still accessible via ssh.
Following is the stack trace of tty_ldisc_lock. Can any one help me in
fixing this?


/root # cat /proc/2725/stack

[<ffffffffb533318d>] tty_ldisc_lock+0xd/0x30
[<ffffffffb5333568>] tty_ldisc_hangup+0xa8/0x1d0
[<ffffffffb532b950>] __tty_hangup+0x130/0x290
[<ffffffffb5335486>] disassociate_ctty.part.3+0x36/0x230
[<ffffffffb504d225>] do_exit+0x6f5/0xa60
[<ffffffffb504e17e>] do_group_exit+0x2e/0xa0
[<ffffffffb504e1fb>] SyS_exit_group+0xb/0x10
[<ffffffffb5001797>] do_syscall_64+0x57/0x240
[<ffffffffb5600071>] entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[<ffffffffffffffff>] 0xffffffffffffffff


Thanks,
Ravi
