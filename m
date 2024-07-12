Return-Path: <linux-serial+bounces-5010-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D62392F8A8
	for <lists+linux-serial@lfdr.de>; Fri, 12 Jul 2024 12:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB090B21887
	for <lists+linux-serial@lfdr.de>; Fri, 12 Jul 2024 10:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E391158DB3;
	Fri, 12 Jul 2024 10:05:23 +0000 (UTC)
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25EE157A74
	for <linux-serial@vger.kernel.org>; Fri, 12 Jul 2024 10:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720778723; cv=none; b=kgtQt155WUw+uMgkLzPP8ed9PPkYGVH42Vt2Jv60M2FxqMoX3DFaJh4yb+SJqxp+YLQYqt6gDE/L0R2Yx7WshwGiXPsnydxaDL65ChCx6IURjEyGj/RA5evfGw1t4ALczf7XHN+Wz51rltCZjODZgobL+OFwj29Wt4hmas+E8bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720778723; c=relaxed/simple;
	bh=cnp/jBauw5TdNqTWXgohodyEGsjA86x4uCkuOKVGfRE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=G9uOasjv9/yKiFl4bZNRbyNabphMF3MfMBSOOj+yVYoCfciZHkbzMlFaWNXTyexEp94tkS4p1ZS807CNPr8kauHsxmxE9wuI3QxgmzXxdenx78EQT9fzKEGFBqXoegsuGx/U2KylgkJmD6U4PuMvqmCr9FLItMOhtXfqmds8BJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7f664993edbso202076339f.2
        for <linux-serial@vger.kernel.org>; Fri, 12 Jul 2024 03:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720778721; x=1721383521;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iyg9rhejF8Qe5A3voFgG9tU6Ju6NThvDf3tGPwmTcgg=;
        b=DyBRtZAPDRhRwwnEPR1Uumsd2p2ZfWBVqBP/qHYKk0mNt3pBwQ8+CtDwJK+uWYZOlw
         y+wXhrqwikp7vLe7xnR5PlRiQaq951j+K3uZ6qcmaFtwQ8P85CtCKFsY7BEMiFRGisT6
         +dQlT/SZZXYo9lVNTQMMwVoqJQvqajEjHgH5Hzf7qi14vCjmRYHZU178f4PO2qY1KtUq
         arv5US1nfobx255iKpqaXduGXJguJj2KZoUWVssAe9G4BUknBs8HwAYBCK9D7FA3yLho
         iiW+arSJE7QfrzQtZHgbhJxjSaKN70Ht98ll0hb9wOFERbQT/JJKInAvQFCz1ZthtwZg
         WHoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVT2ShC+pSVao2X+UeW/eOvcUOf98kYeRzwzvlHhQXwx4CU7VbFnIjsOPZf5oz08CzcR+NTFY6/V8hMgNo7DJuolaBz4kRKptMBm0IF
X-Gm-Message-State: AOJu0Yx4SbuUgo903tKUAF72uBijDQAzShgEf/kS4Bm1Asi8IpwAbut3
	ofJz++/r6FLDOd1Eo5wjmeWnr0vzLo8QiZX9kDVE56FiUdDoR9JsSPpLh9Xbo6aukQ8Ngj4jTsH
	G3/8j24SSHsm+SDcpr1Uay6iN+pe5SACrVrg7xF2XjaCW5f96hQLacOs=
X-Google-Smtp-Source: AGHT+IFFBk/W1SQSv0kMIAhACc/3QzDzQ1IHiTDda01MIv9ZAbtoVD6gv6Et4UAM+5UIVNANJhxXnWsOn0amnEVcYvFYxkoWdGnx
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:24d5:b0:4c0:a8a5:81f5 with SMTP id
 8926c6da1cb9f-4c0b2b331c3mr891446173.4.1720778721119; Fri, 12 Jul 2024
 03:05:21 -0700 (PDT)
Date: Fri, 12 Jul 2024 03:05:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000068db93061d0a0468@google.com>
Subject: [syzbot] Monthly serial report (Jul 2024)
From: syzbot <syzbot+list7b2f8c4a3e5b92bb88db@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello serial maintainers/developers,

This is a 31-day syzbot report for the serial subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/serial

During the period, 0 new issues were detected and 0 were fixed.
In total, 16 issues are still open and 42 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 114     Yes   INFO: task can't die in show_free_areas
                  https://syzkaller.appspot.com/bug?extid=8f41dccfb6c03cc36fd6
<2> 67      Yes   BUG: soft lockup in tx
                  https://syzkaller.appspot.com/bug?extid=5e87db90e68fbc4707c6
<3> 39      No    INFO: task hung in filemap_fault (6)
                  https://syzkaller.appspot.com/bug?extid=cbbcd52813dd10467cfe
<4> 13      Yes   KASAN: slab-use-after-free Read in tty_write_room (2)
                  https://syzkaller.appspot.com/bug?extid=2a81fdd5c6ddffee3894
<5> 6       Yes   INFO: task hung in paste_selection (2)
                  https://syzkaller.appspot.com/bug?extid=275e275bd3f536725dd8

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

