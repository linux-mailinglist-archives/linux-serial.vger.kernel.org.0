Return-Path: <linux-serial+bounces-3225-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB419899D75
	for <lists+linux-serial@lfdr.de>; Fri,  5 Apr 2024 14:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E54A1F24053
	for <lists+linux-serial@lfdr.de>; Fri,  5 Apr 2024 12:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5BA16D307;
	Fri,  5 Apr 2024 12:46:22 +0000 (UTC)
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF9816C862
	for <linux-serial@vger.kernel.org>; Fri,  5 Apr 2024 12:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712321182; cv=none; b=j7SXlZJO6LFvBcY1sNS4xkDYBFPN5dhYiCDDj/rzLMMBLNI6hgJj8zPOvPxiJQn2Rjo8s0fqJnBZjYU9AStQ/3SI8w88x5BkxXb6O2xFFf7ld/8jO4z2qR/x2YdIXLazo+cloZ+uJpJZ3PRgLeQvFLotZJkY1xOdiFfxlBWsYcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712321182; c=relaxed/simple;
	bh=TzuAvaDxx2jfqrDe2Jq2/7JXP4PxC8E2It4y4YV7UG0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pV5T9OqVET4EzoosY7HgVEqLH772loQ4wShhtYmVxXXFY+5UmjH0XQ86zLoZPVZdrQeECj6oDKOHhYOGEGw0moxJxfyT1MDtF+qulflVMocwPgdZ7FhZkzXHpDpJjMG56hcfpW+V6BhMxK6tCHlplHh9l2vt2/BZvQviIHo0CII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cbf0ebfda8so206037439f.0
        for <linux-serial@vger.kernel.org>; Fri, 05 Apr 2024 05:46:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712321180; x=1712925980;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DZFJE9UvxeAoobKH7stsE4IX2cg9gqXNdpmLrHc9THA=;
        b=BoP1u8pU7gYo8SfmhnIOPCvv3sE2NEllJEUVRFQEN9JMczUS3oioxto2Wz95Z9PZ+9
         dehk0MKr0ziHOxZ6X+JH7c1tI2H2ylnwkZO3PeJcs42QarVmbBagsXaAFKZnltohaBxx
         q7pN6OJSK5+9rXn7Zi0a1SVnTIJkuL+a3YXb9ZCE2Rqvw2wUbd0UF1RqjpZ9APqKpF4+
         cgygYtrA0tZpm8sC+lLRMmwc2B8ieWZzkLaOFDdFBEE+nhJoKWUiEKQboUsWKNnq9qnC
         AX6QQu+oJ1Pm1vkRUvPhUCGryyNpb4Jo5JpNaEkCOJgJXob+jPhBqlD8BL/X7b4bh/Bm
         56zw==
X-Forwarded-Encrypted: i=1; AJvYcCUAc192xiFePDwCoUSS0sL3qETg2uH6SrGUXVfEJkPGdifeR2RkCmJ3EVSPqKHRb9OWswYiIpfkmg26MMpleqteoCG9lWc4/CaXDjoO
X-Gm-Message-State: AOJu0Yw2K0aArO6AFqr0z2KJFoLkB5F5Fk0zoecMvW3ricBPLaxiqKDm
	QH6oIR2pb4nfTNSqNx8esp20gQo1fP7/FHVP2tOpnB97FdXVAPnMLCZfFHVx+CL+Ap72JjrJayw
	ncTnyztpraU67x76GUldTbAKbvQUnVcGzwvLXuYliOz6yAW6N+f278sw=
X-Google-Smtp-Source: AGHT+IFnd1Xo+MV8KNzliwJSjIfYT+jDuA0ciAoNioe4t085EcYpfvppOT6g+WweSE7Ch0inROf04OHDyIG/oLOlECttwafu7ufC
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cdae:0:b0:369:fba0:e97d with SMTP id
 g14-20020a92cdae000000b00369fba0e97dmr90725ild.3.1712321180244; Fri, 05 Apr
 2024 05:46:20 -0700 (PDT)
Date: Fri, 05 Apr 2024 05:46:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b0ab81061558d779@google.com>
Subject: [syzbot] Monthly serial report (Apr 2024)
From: syzbot <syzbot+list047751094a40ab426596@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello serial maintainers/developers,

This is a 31-day syzbot report for the serial subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/serial

During the period, 0 new issues were detected and 0 were fixed.
In total, 14 issues are still open and 40 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 5923    Yes   BUG: sleeping function called from invalid context in console_lock (2)
                  https://syzkaller.appspot.com/bug?extid=dbac96d8e73b61aa559c
<2> 146     Yes   general protection fault in serial8250_tx_chars
                  https://syzkaller.appspot.com/bug?extid=837b8c9032c053262db8
<3> 62      Yes   BUG: soft lockup in tx
                  https://syzkaller.appspot.com/bug?extid=5e87db90e68fbc4707c6
<4> 55      Yes   INFO: task can't die in show_free_areas
                  https://syzkaller.appspot.com/bug?extid=8f41dccfb6c03cc36fd6

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

