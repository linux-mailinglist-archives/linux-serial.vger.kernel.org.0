Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C58552D0584
	for <lists+linux-serial@lfdr.de>; Sun,  6 Dec 2020 15:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgLFOfU (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sun, 6 Dec 2020 09:35:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:44196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgLFOfU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 6 Dec 2020 09:35:20 -0500
Date:   Sun, 6 Dec 2020 15:35:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607265279;
        bh=2BI+PVbk96bzKsPChSzoaMlRkPHiTc0E+D8IRlvJFHI=;
        h=From:To:Cc:Subject:From;
        b=CpseQiXVUsdH9OofAnTkPsu926Sg/q6y4o9QIPmeaMpA88hse5s33049jALahG3ag
         1Ag2qAiNJ53iDMzEhbLh1CjIZWqNN7DL4JDTYgGQl79MdKxfjGtyWX1cPLlrHLzkmQ
         G5dUaP8iJuC/6Ji+nLSwG16kx8HsVJ/KP7uF6/jU=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY fixes for 5.10-rc7
Message-ID: <X8zsR9l1TDdgzYMi@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The following changes since commit 418baf2c28f3473039f2f7377760bd8f6897ae18:

  Linux 5.10-rc5 (2020-11-22 15:36:08 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.10-rc7

for you to fetch changes up to c8bcd9c5be24fb9e6132e97da5a35e55a83e36b9:

  tty: Fix ->session locking (2020-12-04 17:39:58 +0100)

----------------------------------------------------------------
TTY fixes for 5.10-rc7

Here are two tty core fixes for 5.10-rc7.

They resolve some reported locking issues in the tty core.  While they
have not been in a released linux-next yet, they have passed all of the
0-day bot testing as well as the submitter's testing.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Jann Horn (2):
      tty: Fix ->pgrp locking in tiocspgrp()
      tty: Fix ->session locking

 drivers/tty/tty_io.c      |  7 ++++++-
 drivers/tty/tty_jobctrl.c | 44 +++++++++++++++++++++++++++++++-------------
 include/linux/tty.h       |  4 ++++
 3 files changed, 41 insertions(+), 14 deletions(-)
