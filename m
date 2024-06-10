Return-Path: <linux-serial+bounces-4557-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8E59021C1
	for <lists+linux-serial@lfdr.de>; Mon, 10 Jun 2024 14:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD83B1C20FEC
	for <lists+linux-serial@lfdr.de>; Mon, 10 Jun 2024 12:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C4B80BF0;
	Mon, 10 Jun 2024 12:41:34 +0000 (UTC)
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4CC80045
	for <linux-serial@vger.kernel.org>; Mon, 10 Jun 2024 12:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718023294; cv=none; b=EIeFyNluzx+kyTGH6Ag4VjwuhwxNNyF/DlMtCGsD9s0mGO9Mhbb2rMMLxULCczGAG80ULI9Ecf5v8GZhTCAGI+SJaoj/K4TR1udlUnTETDSDRcV9Ea9gAKOavxvM6Id+vheDO7JIWZINQbP1Utty3LU3SmhBEtzga7Z+6BXJpgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718023294; c=relaxed/simple;
	bh=i5SCnc4e0NZWw/VPS0pUJHwWndBGQjsodMsy6pvjrQk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QpvUZVqjBD2F0aulX4pKTo+pQUWdca+PtPG8MM8obRBKCqq5qEoQPNKywcM6XD1s0MH3Gg167TcpxjPfbL7zbUwJAK4ZBilUQx2b1BZbN7evlNoPIk3XkRxoUv7JlMLac3EjYjJICAosrWvmq8HnLlh7I7NCugLb3MgbwjrVqMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7e94cac3c71so519185639f.2
        for <linux-serial@vger.kernel.org>; Mon, 10 Jun 2024 05:41:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718023292; x=1718628092;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=64UVeaXcU6rsnutkNGl0Kz48RxK483/d1dkAYlFr9oo=;
        b=hlBX5SvyAht3G94WeKGrO3TypFxO4RVMYyR0Xaq4UOuTfq+cuLdi1+ngVzv/g0TOFO
         R6kBkbWhx9GIcCsIaBjUhX61DPoh9UeGbQZ0aUAgtEHgIIDXTRJgRx8rmyrDRcw3KUos
         K/Db9xv0fk42CiTVcsf9xTgmJ/xsGAutn6suL1icSWNOtMRWM6Fj/+3hQPZdZeK0HzI5
         H74wDbburKkf5lyZz+9VXPbgguYn7B2PFLjaxc2Wux7rAbi5ow9hgiXmTFfHk5eGYaFC
         IrrhFrvt2VD64boW2AYH28tH1E2dhOte4+xPwwv4sBgNeGgib2GCkO6KU1uRewTVKvC0
         bB7g==
X-Forwarded-Encrypted: i=1; AJvYcCU85yJ2BosdLYZrdbrhksn0wYaMhx//Z2BlvXx7134GucqXCB9e9fSyqsPogO5eqCfP04YaoqaJN34Bl/zsaryOK7JTT6TQ3R5niS3A
X-Gm-Message-State: AOJu0Yw1OlWrVl6E/mjiZHWCWBTEfhYeNjSagpsercF9EZPLwAa0NOFY
	Kbiil4X8a7AkGHlDb8mFrtRoWTvRu+6XgvpVcuNpEcr7qrbX01lFmdOVydUENR5zBZ+q1kDkscJ
	mbI9Jo7um2NgOZEg16CeVuW7zjsYyztefasONSHzsvlNo8A2RMpeGPD8=
X-Google-Smtp-Source: AGHT+IG+u4Iz7HCAOZu7wuHlIut3kfzPhMSERAfOihfD2YZeVQUKpeFV9CJ30GeUc+1nHZzBbvRPTCL3NxIVz23EGS9Pr4V18m/1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8919:b0:4b9:b15:5984 with SMTP id
 8926c6da1cb9f-4b90b155d3amr363281173.4.1718023291856; Mon, 10 Jun 2024
 05:41:31 -0700 (PDT)
Date: Mon, 10 Jun 2024 05:41:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000006f7e5061a887861@google.com>
Subject: [syzbot] Monthly serial report (Jun 2024)
From: syzbot <syzbot+list346a89a10f85c497d0e8@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello serial maintainers/developers,

This is a 31-day syzbot report for the serial subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/serial

During the period, 1 new issues were detected and 0 were fixed.
In total, 15 issues are still open and 42 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 213     Yes   KMSAN: uninit-value in n_tty_receive_buf_standard
                  https://syzkaller.appspot.com/bug?extid=559c7fe4b8bac56d38c2
<2> 91      Yes   INFO: task can't die in show_free_areas
                  https://syzkaller.appspot.com/bug?extid=8f41dccfb6c03cc36fd6
<3> 46      Yes   possible deadlock in uart_write (2)
                  https://syzkaller.appspot.com/bug?extid=57cc2f20a84cb4346354
<4> 5       No    WARNING in uart_write
                  https://syzkaller.appspot.com/bug?extid=a38f8e1908608d337bb3

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

