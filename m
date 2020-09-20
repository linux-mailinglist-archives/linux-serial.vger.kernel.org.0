Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3770271486
	for <lists+linux-serial@lfdr.de>; Sun, 20 Sep 2020 15:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgITN1q (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sun, 20 Sep 2020 09:27:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:43376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726306AbgITN1q (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 20 Sep 2020 09:27:46 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8789F20EDD;
        Sun, 20 Sep 2020 13:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600608466;
        bh=d/AhPlXzKn283CBhxrBvQLk4f05mqXcvXC6Tknq+TR0=;
        h=Date:From:To:Cc:Subject:From;
        b=C474BhnYiU+lHFmExApdS3dfiAw8yh8+qKIjp6cKmoaoJPTHpAIX6XyXefcSpgq+3
         DVbNe+zakvW4ibU2Db1i/JH5aVKgYzNBm4xyuiCLfv/ThVfYFsEYElZee92NurtZGE
         lzTEls95+iJu4C2cIR1Ity+n5KtSlUh0akenTk0E=
Date:   Sun, 20 Sep 2020 15:28:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver fixes for 5.9-rc6
Message-ID: <20200920132811.GA2844860@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The following changes since commit f75aef392f869018f78cfedf3c320a6b3fcfda6b:

  Linux 5.9-rc3 (2020-08-30 16:01:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.9-rc6

for you to fetch changes up to ec0972adecb391a8d8650832263a4790f3bfb4df:

  fbcon: Fix user font detection test at fbcon_resize(). (2020-09-16 14:35:51 +0200)

----------------------------------------------------------------
TTY/Serial/fbcon fixes for 5.9-rc6

Here are some small TTY/Serial and one more fbcon fix for 5.9-rc6

They include:
	- serial core locking regression fixes
	- new device ids for 8250_pci driver
	- fbcon fix for syzbot found issue

All have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Johan Hovold (2):
      serial: core: fix port-lock initialisation
      serial: core: fix console port-lock regression

Tetsuo Handa (1):
      fbcon: Fix user font detection test at fbcon_resize().

Tobias Diedrich (1):
      serial: 8250_pci: Add Realtek 816a and 816b

 drivers/tty/serial/8250/8250_pci.c | 11 ++++++++++
 drivers/tty/serial/serial_core.c   | 44 +++++++++++++++++---------------------
 drivers/video/fbdev/core/fbcon.c   |  2 +-
 include/linux/serial_core.h        |  1 +
 4 files changed, 33 insertions(+), 25 deletions(-)
