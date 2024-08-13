Return-Path: <linux-serial+bounces-5481-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 082E7950520
	for <lists+linux-serial@lfdr.de>; Tue, 13 Aug 2024 14:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A4DE1C21F21
	for <lists+linux-serial@lfdr.de>; Tue, 13 Aug 2024 12:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A97319D070;
	Tue, 13 Aug 2024 12:34:28 +0000 (UTC)
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2779C19D060
	for <linux-serial@vger.kernel.org>; Tue, 13 Aug 2024 12:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723552468; cv=none; b=fli0N8KXlZhsg6rHTjcuzeMGXshyFb95jK8c5jSdTRRZ63bwFRH2p/w9quHkeN03VjuoRl7pfAVhLpM06bsCsTO0t/cXaMvdIFVZu/MJlvpwbja5z3hicgamj0c136FsWDv7gRZdYZqMacaF/IjrVxYJgtZgYXgCFbpuJuiReiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723552468; c=relaxed/simple;
	bh=MWYYWzrLBsyhsepfViZZe+n7+XEy4XisBYxo3KCbwNg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ppY4VGLO+DrHteswpGgMeE5n6mcgNfnYnnT2A3BdxNse5ABxKsf6OM7TkjZ0ehAbY6puMBMydoIjupG6NCOCIHOCTHVjLvS3nB5fXtUcnEBrm9fBMaRLUTmV5lVKajvWyZ8WVGv4SpWbdDe3PzUiixvwVU+svABRmy/wBACi39w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81f7fb0103fso670315439f.0
        for <linux-serial@vger.kernel.org>; Tue, 13 Aug 2024 05:34:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723552466; x=1724157266;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3+Ln620VT8KH54iQCrLjkomNkv6MG80t0C+1+yo30Yg=;
        b=DmTAb0I1sbt1FRwpkgcjzl8ejytmoRl9IiY4f3W6OTsNSuiWxJV8XA1tC8p/9H4ABU
         wIR4D0RMUheNDG6AY+rCbfxLJVl5rGsx5N1iXH6XV2/BVZUU10wCzF95vZJ30udqo3NP
         b66NDq31mKEXe6msHwfWsOeRzp0GVWRtYqz6h4RdPP6cXx9cudgBrdx1pkQsqLJqUsly
         33Po1PmVyARsaTHMY8d1xuJR0dRqdc2anWCqCrFlqmETl2OuqmIancxdCfLgYms5b3Ob
         YsQy87jVS3HpvIz7Fgb0N1SznKWlvi6YiOK8Ix87D02TnoTJ0Wc1KiYoNG5HQBm35bHa
         emLA==
X-Forwarded-Encrypted: i=1; AJvYcCXKHj6FhY3EkJJSoH/WxWm9F9lWq9DMPirO69hHi36EhwRUXnIu0PZFf2BX8c6WgqScKJFpVuvswmEoP9idllgNezVVCSwXOC2G1Con
X-Gm-Message-State: AOJu0Yz3eRJ0stWdUcolG25O22te6YR/+i50Zq/uZbvXx7G7E9T0iUoK
	eN1aBs8STywTyPn0SDag5nVQYnCVd5SR5QvMs1iFZi11RosAZuP85C0wpZCXf8Uil5eBNSiAPXs
	Oe/KW1/+SzD5L6yeRTszU9ONotLTaWC7YOCHo3zHzLLpwggdLkvLEu1w=
X-Google-Smtp-Source: AGHT+IG3UXOsj7iMlJPd1YaGKTgrI5WP18qFBGO56hVK54vUBxVZD+3+WCWnv+apxl+45UkIn8nKCfEWOmoKOaIfDmC4Py0tCjDB
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218b:b0:396:256a:2e01 with SMTP id
 e9e14a558f8ab-39c48c1647dmr1582815ab.1.1723552466282; Tue, 13 Aug 2024
 05:34:26 -0700 (PDT)
Date: Tue, 13 Aug 2024 05:34:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000813aa7061f8fd478@google.com>
Subject: [syzbot] Monthly serial report (Aug 2024)
From: syzbot <syzbot+list6032cdf2de475380d173@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello serial maintainers/developers,

This is a 31-day syzbot report for the serial subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/serial

During the period, 2 new issues were detected and 0 were fixed.
In total, 16 issues are still open and 42 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 288     Yes   KMSAN: uninit-value in n_tty_receive_buf_standard
                  https://syzkaller.appspot.com/bug?extid=559c7fe4b8bac56d38c2
<2> 141     Yes   INFO: task can't die in show_free_areas
                  https://syzkaller.appspot.com/bug?extid=8f41dccfb6c03cc36fd6
<3> 4       No    KMSAN: uninit-value in gsmld_receive_buf
                  https://syzkaller.appspot.com/bug?extid=2f64914d6a3a8ce91bdd
<4> 2       No    KMSAN: uninit-value in n_tty_lookahead_flow_ctrl (2)
                  https://syzkaller.appspot.com/bug?extid=290abdcd4f509377a0eb

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

