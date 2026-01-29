Return-Path: <linux-serial+bounces-12596-lists+linux-serial=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-serial@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFN6D9NJe2kdDQIAu9opvQ
	(envelope-from <linux-serial+bounces-12596-lists+linux-serial=lfdr.de@vger.kernel.org>)
	for <lists+linux-serial@lfdr.de>; Thu, 29 Jan 2026 12:51:47 +0100
X-Original-To: lists+linux-serial@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE6CAFD08
	for <lists+linux-serial@lfdr.de>; Thu, 29 Jan 2026 12:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83EB33039CB1
	for <lists+linux-serial@lfdr.de>; Thu, 29 Jan 2026 11:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6723876B7;
	Thu, 29 Jan 2026 11:51:31 +0000 (UTC)
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E866385516
	for <linux-serial@vger.kernel.org>; Thu, 29 Jan 2026 11:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769687491; cv=none; b=CXiDBl3j9L/KyMCO/TdVz9iFQel0HyuWRvHeRYvYiIpi3PzfoNf3jZj5jHuOT75iJqO+bwuCLJ76HAYXJxL8Oy0HYtU7yM7T21CtnrOY0xZM33WVjq+6pXVihgns3sAnsNsi9ao/i0misFzVfSp0WhexYFWqoOSDmbEnR/EbApg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769687491; c=relaxed/simple;
	bh=lIUDlXObb5uEF//k43KhXjonJY7/eMR3MoOZwQ+ASjw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Zw/wKvF3FKxeBtUXteUn6OZEQUxMRK6UGmrvodgue0Q4aD69W6cq5mPOOz7P1WvMPqeVX2pVA1UiOI60faGMmyDorjFzSpxCb3Fl8FqFNEgvoObJk5nE2+d9dOqQTM+1fslYBhW0rybtBwK32thfJEnn8elEcW1O+q7WhoMp2cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-3ff590953b1so2542203fac.2
        for <linux-serial@vger.kernel.org>; Thu, 29 Jan 2026 03:51:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769687488; x=1770292288;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m0NG2LGgo/HRDPw+ohIUZo78HxQ4jjxW86wJXLvVSKY=;
        b=AF4p67XSb/+agqjXOh1mzduWPaaeUMlV4uijul9VfbMW/9SFeIJtIS1kZ6yNhPC4TL
         XwemHlrfJs8+aXwP/MjGjp4DjMVYVVyukcdRt/fmtn9rWGpEmTESIRUG9H8/txwkqm+/
         8KYhk8oB7ID+j0nsBtx8sR29SNZaEW8H8Nc9qolAabW0n51AmlkB8gdx6SbdJ0iBhYy+
         q//KxpZRfyeZ0Twb4nfp0juvxVwIXzA70eFI9Q2hH7/i0ISH9rx1brEkilXIRPgHNDkd
         PfInLWSv2yoCLv0YXClcYzIzLHB15eAPetu5GSEKquvjfosXY9ZcWiTEhhhNf4oLR8lR
         frSg==
X-Forwarded-Encrypted: i=1; AJvYcCW1fiDPsBHqllxshaxrHFviclybJISDF5k/MB8gyS+5HE7ABEhuet9k9EEvofhODRmF+dJ1e1wzbNdOBc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX7nWrrdwS8MXpcTqQQvHOLrr3Elozx7iEu2wbLw6zrInMx4Ui
	xSQSWjhrhUeoOLhkZdUClb15UJKyVuCV/N0Ov/fRUyoYqEHF9RbhVEczsxOtH7DFLGhaqH5kbrx
	sqp4hw32DNwJFHepqTeVgFpzq8X8cF44VydNfuxH3DZ9nSJveJJlS+N9QhV8=
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:488c:b0:663:3ad:4c2d with SMTP id
 006d021491bc7-66303ad4c73mr1541410eaf.60.1769687488551; Thu, 29 Jan 2026
 03:51:28 -0800 (PST)
Date: Thu, 29 Jan 2026 03:51:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <697b49c0.a70a0220.9914.001b.GAE@google.com>
Subject: [syzbot] Monthly serial report (Jan 2026)
From: syzbot <syzbot+listac358ce31459004989d9@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-12596-lists,linux-serial=lfdr.de,listac358ce31459004989d9];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-serial@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-serial];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,goo.gl:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,googlegroups.com:email]
X-Rspamd-Queue-Id: 8FE6CAFD08
X-Rspamd-Action: no action

Hello serial maintainers/developers,

This is a 31-day syzbot report for the serial subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/serial

During the period, 1 new issues were detected and 0 were fixed.
In total, 15 issues are still open and 45 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  3669    Yes   possible deadlock in console_lock_spinning_enable (5)
                   https://syzkaller.appspot.com/bug?extid=622acb507894a48b2ce9
<2>  3002    Yes   KMSAN: uninit-value in n_tty_receive_buf_standard
                   https://syzkaller.appspot.com/bug?extid=559c7fe4b8bac56d38c2
<3>  265     Yes   KASAN: slab-use-after-free Read in tty_write_room (2)
                   https://syzkaller.appspot.com/bug?extid=2a81fdd5c6ddffee3894
<4>  261     Yes   KMSAN: uninit-value in n_tty_receive_buf_closing (3)
                   https://syzkaller.appspot.com/bug?extid=dd514b5f0cf048aec256
<5>  238     Yes   INFO: task can't die in show_free_areas
                   https://syzkaller.appspot.com/bug?extid=8f41dccfb6c03cc36fd6
<6>  120     Yes   possible deadlock in tty_buffer_flush (3)
                   https://syzkaller.appspot.com/bug?extid=52cf91760dcb1dac6376
<7>  53      No    KMSAN: uninit-value in n_tty_lookahead_flow_ctrl (2)
                   https://syzkaller.appspot.com/bug?extid=290abdcd4f509377a0eb
<8>  18      Yes   INFO: rcu detected stall in console_callback
                   https://syzkaller.appspot.com/bug?extid=32af18ae7b894a681f2d
<9>  6       Yes   INFO: task hung in paste_selection (2)
                   https://syzkaller.appspot.com/bug?extid=275e275bd3f536725dd8
<10> 3       No    possible deadlock in stop_tty
                   https://syzkaller.appspot.com/bug?extid=7ca5a40e8164fe2609fd

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

