Return-Path: <linux-serial+bounces-12837-lists+linux-serial=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-serial@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLzqOUuXpmltRgAAu9opvQ
	(envelope-from <linux-serial+bounces-12837-lists+linux-serial=lfdr.de@vger.kernel.org>)
	for <lists+linux-serial@lfdr.de>; Tue, 03 Mar 2026 09:09:47 +0100
X-Original-To: lists+linux-serial@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 448751EA974
	for <lists+linux-serial@lfdr.de>; Tue, 03 Mar 2026 09:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00E433083E0C
	for <lists+linux-serial@lfdr.de>; Tue,  3 Mar 2026 08:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5221D386C2E;
	Tue,  3 Mar 2026 08:07:29 +0000 (UTC)
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8FD386C29
	for <linux-serial@vger.kernel.org>; Tue,  3 Mar 2026 08:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772525249; cv=none; b=O32DL+OLzi+sX+gHcpDOb2lsPy+phUDkf1qXAhzLHnQwvsoI1Y/VMcwN1sV01C2FAZN70ECjtcqpWp7tL6wSpxH5gg4KSHZ7KOZBgu8Zaam6qk1jXP4wQZme35TpHzZ9NPeM+QZlhjta9rUDKEsCRqlKixhUJ1IPjukshuS7n9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772525249; c=relaxed/simple;
	bh=Oh3tXpsx+QCNbHNTgWm6Cjr2HzH5WnWb4OxgLqw/My8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NxFGvPD0k8zI4OBe7gpz9GSDt+1OA/UDDsNx0q0b8fAbF7FS06UZ+GupOdrfqmD/X2Ffdigt6SKZRyKfdEiL29UuFOZ0SLQC8YRQ8MGPbkxPHP44v5YMQa0ibm7XWJ2kemeOPxOT3Vj1os4vrj+CY8pMm4PoYO/qrkH3n/p3SMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-679c5ed0942so77203204eaf.1
        for <linux-serial@vger.kernel.org>; Tue, 03 Mar 2026 00:07:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772525247; x=1773130047;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oviuPl5RmRyl2KpaZ8AaGZ4C5yAr5Fb5kKNpRgZG6jE=;
        b=Fa4EMnC2zlo3bnFjs9hC2GBjrUlbfd6Hae3UqUBy50QVNwqqE+f0gDmFO8VkAC7g41
         yYsOW/f/svA3ZIYtjAbvv4IdweSar+ePXLRDG44dr8ScU5WzqRWHalLUCievWlMUAjri
         S84jxHGEV/5RHeGjvD6sk2J8SPC5lHsFvsBAL+qJDQQlngGy0v89BhBU+niINNlQvOD0
         4WFMFvUnXX096fOEPVlSPZY08Rs8xlBIrK7IgE2Yvnfgwq7BzNhK7amMCsFhNRIySjB/
         sWId6mR8STyOXgGli6Uw1swSwfTV110oK7zUCd/VYH9ENEAriJYokNlRAtq2cXl0KEpV
         RsNQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2d2gnSO8FHWneIRW0PKfBIpZfz64ko4DevMk0eJmUd1nbfUe/g/BrQfsEbECdB6sDki9aNzJZJQxJLJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA4GEGxdn6JGqlk2C9Hfd24giaVzUOoXtXQfy4lV3bU4g98pPG
	Hd2FMv/GxhnpEzwK2z4X2GK6UDYscELvl6yqzYt4Yb79f4hSDrIucXP2Ey26OqiOP+UOQTktUhv
	nRvb9P+6V1+o89QcqpKwQ0cMBLhlNZWKhbmDDqQ35OzIS6kbZUr1jcim6qG4=
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:450f:b0:676:c2a1:ef12 with SMTP id
 006d021491bc7-679faf0cb9emr6767834eaf.42.1772525247013; Tue, 03 Mar 2026
 00:07:27 -0800 (PST)
Date: Tue, 03 Mar 2026 00:07:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69a696be.050a0220.21ae90.000a.GAE@google.com>
Subject: [syzbot] Monthly serial report (Mar 2026)
From: syzbot <syzbot+lista6742188c23171793101@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 448751EA974
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-12837-lists,linux-serial=lfdr.de,lista6742188c23171793101];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-serial@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.903];
	TAGGED_RCPT(0.00)[linux-serial];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,googlegroups.com:email,goo.gl:url]
X-Rspamd-Action: no action

Hello serial maintainers/developers,

This is a 31-day syzbot report for the serial subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/serial

During the period, 0 new issues were detected and 0 were fixed.
In total, 18 issues are still open and 48 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 3827    Yes   possible deadlock in console_lock_spinning_enable (5)
                  https://syzkaller.appspot.com/bug?extid=622acb507894a48b2ce9
<2> 3214    Yes   KMSAN: uninit-value in n_tty_receive_buf_standard
                  https://syzkaller.appspot.com/bug?extid=559c7fe4b8bac56d38c2
<3> 1193    Yes   BUG: soft lockup in tx
                  https://syzkaller.appspot.com/bug?extid=5e87db90e68fbc4707c6
<4> 283     Yes   KMSAN: uninit-value in n_tty_receive_buf_closing (3)
                  https://syzkaller.appspot.com/bug?extid=dd514b5f0cf048aec256
<5> 243     Yes   INFO: task can't die in show_free_areas
                  https://syzkaller.appspot.com/bug?extid=8f41dccfb6c03cc36fd6
<6> 121     Yes   possible deadlock in tty_buffer_flush (3)
                  https://syzkaller.appspot.com/bug?extid=52cf91760dcb1dac6376
<7> 55      No    KMSAN: uninit-value in n_tty_lookahead_flow_ctrl (2)
                  https://syzkaller.appspot.com/bug?extid=290abdcd4f509377a0eb
<8> 5       No    KASAN: slab-out-of-bounds Write in do_con_write (3)
                  https://syzkaller.appspot.com/bug?extid=8e9c1abac3ceb45abffe
<9> 4       Yes   possible deadlock in n_tty_flush_buffer
                  https://syzkaller.appspot.com/bug?extid=d84934b4184d7f9a1aed

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

