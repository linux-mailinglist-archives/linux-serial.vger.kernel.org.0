Return-Path: <linux-serial+bounces-1535-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC5C82EA30
	for <lists+linux-serial@lfdr.de>; Tue, 16 Jan 2024 08:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 547B81F23F8C
	for <lists+linux-serial@lfdr.de>; Tue, 16 Jan 2024 07:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F2B10A36;
	Tue, 16 Jan 2024 07:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fs+wz5Gv"
X-Original-To: linux-serial@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F1B11181
	for <linux-serial@vger.kernel.org>; Tue, 16 Jan 2024 07:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705390721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EfBFl2eOx6dzP8++zlyYwBxQmYQ5RCeNDtKgTlcPQsc=;
	b=fs+wz5GvNF9czjwZpeMl56+kK4cMeSJ3iGoFCcd3FU/PjiPcIEVlCtSw2Yd+vEeKsvjXmD
	t5B+suYgu0n7GjhB6mvkEVl/j1wK6ePuscA0Ckw0ddMBb4lpeiLjf4TGwbUskteAmf2Zdn
	AFLGXhDs38BsNWFf4TTNi19l9AoR8Lc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-A5T5TWzFMJC88rNOftyKWA-1; Tue, 16 Jan 2024 02:38:40 -0500
X-MC-Unique: A5T5TWzFMJC88rNOftyKWA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7816e45f957so1470650585a.1
        for <linux-serial@vger.kernel.org>; Mon, 15 Jan 2024 23:38:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705390720; x=1705995520;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EfBFl2eOx6dzP8++zlyYwBxQmYQ5RCeNDtKgTlcPQsc=;
        b=xVDHDSplX9HrLg/rrhCcDHgelieDZrY71IVDF8drMShGNlfZus80q/QBY09WkIGVYz
         we8cJDXkwvOIdAafHnnGNHNWxGJEE7IGJcdGhuzi16lgiOt6D8jg+V4Djn402D3ej+lL
         E6raxxPyIuhUxdSKB/+g9uDePJtt3/4TxLx+z4J7aoTqKhVK9JwIZsdMwwZaVH7vmy58
         y0xXPeHqajGJs5UxdcRtRfGy1z1At5IkFfPlARH47y1AULZdBNMS7epDefKAKiIuRYcK
         0Dx0zchDlAlk/dn6Qqo9uWw9qf4/to2m1RlVhVRRmhbLQag/RJQIuFzGalJcLoK1yLGU
         qJpw==
X-Gm-Message-State: AOJu0YyyVtRMVMI7BnbEkQtgGskHH2rL+og3e0f7ISy30gUDRxDyl5Rq
	M3VuurjxOf37Zb9IrwMLj1JI0yJ0yqI3X7/9lmSs5fEy/nI+JzcdV2ee8ml4wMb5tXJh+s2Q6TT
	WZ9v8QqDSUdFdBECs+lE12tNLBAwM678E
X-Received: by 2002:ae9:e70c:0:b0:77d:9d58:5467 with SMTP id m12-20020ae9e70c000000b0077d9d585467mr7714863qka.29.1705390720220;
        Mon, 15 Jan 2024 23:38:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFWqf/DygCnGdiywzz4XsNxJmOIjslN7QxsPszTwWbtfzwY8dVLHuuYSFixUOAnf4MwkJmRg==
X-Received: by 2002:ae9:e70c:0:b0:77d:9d58:5467 with SMTP id m12-20020ae9e70c000000b0077d9d585467mr7714855qka.29.1705390719971;
        Mon, 15 Jan 2024 23:38:39 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:1b3:a803:64aa:6db9:6544:60c:9e16])
        by smtp.gmail.com with ESMTPSA id vr28-20020a05620a55bc00b0078199077d0asm3516021qkn.125.2024.01.15.23.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 23:38:39 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Leonardo Bras <leobras@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	John Ogness <john.ogness@linutronix.de>,
	Tony Lindgren <tony@atomide.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/2] Fix serial console for PREEMPT_RT
Date: Tue, 16 Jan 2024 04:38:35 -0300
Message-ID: <ZaYye6YU4mV4SYUV@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116073234.2355850-2-leobras@redhat.com>
References: <20240116073234.2355850-2-leobras@redhat.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Jan 16, 2024 at 04:32:31AM -0300, Leonardo Bras wrote:
> While dealing with a bug that breaks the serial console from qemu (8250)
> after printing a lot of data, I found some issues on this driver on RT
> as well as spurious IRQ behaviors that don't seem to be adeqate for RT.
> 
> Comments:
> Patch #1:
> I found out this driver get an IRQ request for every tx byte, but the
> handler is able to deal with sending multiple bytes per "thread wake up". 
> 
> Since the irqs_unhandled keep growing, and theads_handled don't change
> as often, after some intense load (tx ~300kBytes) the serial will 
> disable the IRQ line for this driver, which ultimately breaks the console.
> 
> My fist solution kept track of how many requests given handler dealt with,
> which got added to theads_handled. On note_interrupt I got the diff from
> theads_handled_last and subtracted that diff from irqs_unhandled.
> 
> This solution required a change in the irqreturn_t typedef and a bunch of
> helpers and defines, as well as adapting the 8250 driver. 
> At the end seemed like a overcomplicated solution for the issue, but it
> can be an alternative if the current solution is considered imprecise.
> 
> Mu cyrrent solution on patch #1 is much simpler, just keeping the
> IRQ enabled as long as the irq_thread deal with any IRQ request before
> irqs_unhandled hitting the limit value.
> 
> Patch #2:
> In RT, the 8250 driver has an issue if it's interrupted while holding the
> port->lock. If the interruption needs to printk() anything, it
> will try to get the port->lock, which is busy, so spin_lock() will try
> to reschedule the interruption, which is in atomic context, and will 
> trigger a bug.
> 
> This bug reproduces quite often, like in 50% of tests I did. 
> 
> The only thing I could think of for fixing this is using in_atomic()
> when PREEMPT_RT=y, so it makes use of the same mechanism as for
> oops_in_progress to avoid getting the lock if it's busy. It's working
> just fine.
> 
> Yeah, I got the warning in checkpath:
> "ERROR: do not use in_atomic in drivers"
> 
> So I need some feedback on what to do to avoid this bug, if not 
> by using in_atomic() at this driver.
> 
> Since this one is linked to the console, any printk will try to get
> this drivers port->lock, and so it's kind of hard to avoid this accesses.
> 
> I though on doing an interface for spin_lock_only_if_can_sleep() but
> it seemed overkill.
> 
> Please provide comments / feedback.
> 
> Thanks!
> Leo
> 
> 
> Leonardo Bras (2):
>   irq/spurious: Reset irqs_unhandled if an irq_thread handles one IRQ
>     request
>   serial/8250: Avoid getting lock in RT atomic context
> 
>  drivers/tty/serial/8250/8250_port.c | 2 +-
>  kernel/irq/spurious.c               | 8 ++++++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> 
> base-commit: 052d534373b7ed33712a63d5e17b2b6cdbce84fd
> -- 
> 2.43.0
> 

Resent this one with the correct order / patches.


