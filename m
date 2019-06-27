Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7305657BC8
	for <lists+linux-serial@lfdr.de>; Thu, 27 Jun 2019 08:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfF0GPX (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 27 Jun 2019 02:15:23 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33873 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfF0GPX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 27 Jun 2019 02:15:23 -0400
Received: by mail-lj1-f195.google.com with SMTP id p17so1074913ljg.1
        for <linux-serial@vger.kernel.org>; Wed, 26 Jun 2019 23:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=c8Ro+1sz0fJk4GvPtJI06vg3od+9PHgCXEuwxWQvRMI=;
        b=lUDG8pAvDccmT6uAnH7QNeff14G7sguproj73GIfBcVdC4yboikr0UX8H+6shQFejj
         +RUl/rApW0IlKXqqj7bvpwJwGgyT0w+W64SuU2K0vtOsQxwZPMj3VByqPkpJ5mCYBH8K
         4/6m4yrF7eMMOF0hHonQhLWxatww6lKL/xmfXTDX5bUScofynRv9NKCdg/O+ubmq2efc
         nKVHfgCZCJaRIHOyBrsV5o1NKukK0KSPlztbG4n9Ls9B88NhOTG7QVxoZ/D2oRA7NQYz
         52T8+bYxkdlop5CtygjX7949fMu5uw0SV6BVgws3QxxKwxleC8zn5CdXnqz9ib4Ob+o0
         ko2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=c8Ro+1sz0fJk4GvPtJI06vg3od+9PHgCXEuwxWQvRMI=;
        b=f1xUrjF1NZhok61nlMB6fhl1OpE00XK9ku4Lkeyd2NCUZJNtNW4Fx90JKSiHhzOYiq
         C4wO7WcKbxPGmMUeZiM6CeOXXwYdQLMdUtqr6NlxipGx9GJ3wuHa6ya/jtvo/BiuvEHm
         Wi5cZQA1Txde3bj/9w3eDYjMIfqgia1oSGiBQ/GLAdM6b0mO0eU/timxI9sJ5MLMmkeH
         /CNe6WPOQccrtmUBM1b+CGmfV/smhXPXL/sE/1rfkwYB9/q46IZ+VK1glpHr4eTwnrqU
         GnUJwX4jH8YI/z53ktqO83mtAY0QQLT9SR80ofi2926sq8GJ8T2tcJCHTOj8vPLR6MD6
         Qyrw==
X-Gm-Message-State: APjAAAWt87GvMWY3fd13DGMJXP9KmgHSHpFDHU//7Rqx7D8B4xIEiDls
        t3vsy5WJqYFNuUkqgFswiNw=
X-Google-Smtp-Source: APXvYqxSo1JskesriVou2jf2BX7fNXJE47AL9FBximlWQ57Ug61BHiK+UIsbLvXgOvpGCv0NwiRbHQ==
X-Received: by 2002:a2e:80d6:: with SMTP id r22mr1400616ljg.83.1561616121388;
        Wed, 26 Jun 2019 23:15:21 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id m17sm181953lji.16.2019.06.26.23.15.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 23:15:20 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v2 4/7] serial: imx: set_termios(): preserve RTS state
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
        <1561558293-7683-1-git-send-email-sorganov@gmail.com>
        <1561558293-7683-5-git-send-email-sorganov@gmail.com>
        <20190627054040.fmox5woti4gztmat@pengutronix.de>
Date:   Thu, 27 Jun 2019 09:15:20 +0300
In-Reply-To: <20190627054040.fmox5woti4gztmat@pengutronix.de> ("Uwe
        \=\?utf-8\?Q\?Kleine-K\=C3\=B6nig\=22's\?\= message of "Thu, 27 Jun 2019 07:40:40
 +0200")
Message-ID: <874l4bk0zr.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:

> On Wed, Jun 26, 2019 at 05:11:30PM +0300, Sergey Organov wrote:
>> imx_set_termios() cleared RTS on every call, now fixed.
>
> Is this a real problem, or something you noticed by looking at the code?
> I think I already asked that in a previous round, if so this should at
> least be explained in more detail in the commit log.

Yes, it was real observed problem. Every call to set_termios from user
space (through tcsetattr() function) cleared RTS.

> Also please note that this is about the UCR2_CTS flag. (It is, isn't
> it? I don't understand it after staring at the code for a while.)

"CTS" in iMX terms means what everybody else calls "RTS"! Please notice
how they are used in the entire driver, e.g.:

		if (mctrl & TIOCM_RTS) {
			ucr2 |= UCR2_CTS;


> Assuming this is a real fix, it would be great if this patch came first
> in the series (i.e. before the cleanups) and would be more straight
> forward to understand.

I rather believe that pre-cleanups actually make the fix more
straightforward to understand.

Thanks!

-- Sergey
