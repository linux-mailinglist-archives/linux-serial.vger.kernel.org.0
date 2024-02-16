Return-Path: <linux-serial+bounces-2291-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sy.mirrors.kernel.org (unknown [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DE185773F
	for <lists+linux-serial@lfdr.de>; Fri, 16 Feb 2024 09:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F940B21004
	for <lists+linux-serial@lfdr.de>; Fri, 16 Feb 2024 08:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02E71BDE6;
	Fri, 16 Feb 2024 08:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RhP1J26n"
X-Original-To: linux-serial@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28E91BC4B
	for <linux-serial@vger.kernel.org>; Fri, 16 Feb 2024 08:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708070433; cv=none; b=U9HVneA37f4W+Eh5M6XH5fP3mSS8qkChbSs1hGDnFi5Tro8dvpwKMoUzBOOko9pS2ssVniokdVj1jCfDTiAf5y90CeBBnI14VLGqk0n20qwhz8BiYrRBQCw9aw1ECCAnThqV1oExuGD506iIuOdo8IDGHN0Q340fzKTr7hboRZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708070433; c=relaxed/simple;
	bh=Ap0hhSVhCcUi+ugheKg7fHGNULFldbyGXWaIBynCIwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IPjP1/AaAbhFwLoiZ4EpkaBe/ziHM9xCRB2ETjVFUcbwZmKCF20rbP7UPYjYMjGv+PX0Tr3lorKQAkD2H4DGZOLCQHspNu34Y73LBKjPNF5f2LX/GLMEToCvwmgQv7fSglP7CgwoPSerDZnogDpAiuZ3Fk8tiftTS1eua9S2gdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RhP1J26n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708070430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lf9jFY+y8CayXQz2V+yS9ViGyyGoBfGEuY3heLM9Fu0=;
	b=RhP1J26nxEFjoS2Mz8dT8b9Kaid3nnQkbv1r1R1S3wtBpIsEkhmWGJbfXMBZZFhI5UT1ZT
	hZsdFNQm1A8fdZv3YBGpof6Qj/eGYaCX5TrzdHmFMNt1A57bXxLxLd4FDIXuPlu+O4wuOK
	NfNpH1dz8BzVRYPSrxQk45l0OyCC42s=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-WeKXBOtZPLCGERQPQAbzdg-1; Fri, 16 Feb 2024 03:00:26 -0500
X-MC-Unique: WeKXBOtZPLCGERQPQAbzdg-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7873fd60a11so97553085a.1
        for <linux-serial@vger.kernel.org>; Fri, 16 Feb 2024 00:00:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708070426; x=1708675226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lf9jFY+y8CayXQz2V+yS9ViGyyGoBfGEuY3heLM9Fu0=;
        b=QRlsWn0MOZ/t4Vck4PXd3epNm5i2I/jaI4KFd0tYY9o8OcNKMeSDprZhYM3yXVRFtl
         QDxAfKC8jHnkK0G2cuu5JQravBb43baO49rO/EHp/PEVznBZIxiAb6IimpD0gCHMQtzO
         0iMbjJ9fDfTdVp/zzUaQ4sLwSvQdT8azhpHGncAAUnP8dlmxOi73bZdp60Nysb6jqbdg
         NckDOVPn9lsh1Qba1g6eiS7bjK9wbxmJ9or4Bc5dM8SL0DfAb37iwFZQI93jfJKlAtkD
         kew9Y2xq/73RF/gtVdCoojkixOW7CW5adtlDkF8VMe/HLlTDY1gREnoYBFZC35aSePcu
         LWbg==
X-Forwarded-Encrypted: i=1; AJvYcCXdGRzE/fo4fqaTHbmsBnPCOmi7mTQ9LIl6HXB9SsYcCwFSCurm6/GX2j7XTQBTI4p1nbymtyiTrUmHAhtWeBxIRt1Z6AJ69DMi9LCg
X-Gm-Message-State: AOJu0YwwBRTsHdMyB8XsCxyVR72UnnHzioouXK/H0AsT5jPvbHyHhC9f
	NUOqm2qizix6n7dnMju6Fc+KapZ8xdtLePzaFK+IhGyoywGuxoYHXxDeAxi4UcIGkYbkYiCRVHD
	sUz6wMgO1d0VobEuqFg8kW3eTK6m7+//IXF0QJZw9j/yEeWPPcXk47vKm1F2wNw==
X-Received: by 2002:a05:620a:372a:b0:787:2d4a:e91 with SMTP id de42-20020a05620a372a00b007872d4a0e91mr12380855qkb.12.1708070426060;
        Fri, 16 Feb 2024 00:00:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLG7XvZtlTywNrtd9AYcJ1Px0bo2LO9DGLhh4nIJjj5II6F+o5xx7gYe26QguBGg3mPZZ7zA==
X-Received: by 2002:a05:620a:372a:b0:787:2d4a:e91 with SMTP id de42-20020a05620a372a00b007872d4a0e91mr12380824qkb.12.1708070425766;
        Fri, 16 Feb 2024 00:00:25 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:1b3:a800:4770:9d0:4bac:1782:4637])
        by smtp.gmail.com with ESMTPSA id br37-20020a05620a462500b00787346f1edasm1300756qkb.54.2024.02.16.00.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 00:00:25 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tony Lindgren <tony@atomide.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	John Ogness <john.ogness@linutronix.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Leonardo Bras <leobras@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [RFC PATCH v2 3/4] irq: Introduce IRQ_HANDLED_MANY
Date: Fri, 16 Feb 2024 04:59:45 -0300
Message-ID: <20240216075948.131372-5-leobras@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240216075948.131372-2-leobras@redhat.com>
References: <20240216075948.131372-2-leobras@redhat.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

In threaded IRQs, some irq handlers are able to handle many requests at a
single run, but this is only accounted as a single IRQ_HANDLED when
increasing threads_handled.

In order to fix this, introduce IRQ_HANDLED_MANY, so the returned value of
those IRQ handlers are able to signal that many IRQs got handled at that
run.

Is scenarios where there is no need to keep track of IRQ handled, convert
it back to IRQ_HANDLED.

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 include/linux/irqreturn.h | 23 ++++++++++++++++++++++-
 kernel/irq/chip.c         | 10 ++++++++--
 kernel/irq/handle.c       |  3 +++
 kernel/irq/manage.c       |  4 ++++
 4 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/include/linux/irqreturn.h b/include/linux/irqreturn.h
index d426c7ad92bfd..204030696676c 100644
--- a/include/linux/irqreturn.h
+++ b/include/linux/irqreturn.h
@@ -7,14 +7,35 @@
  * @IRQ_NONE:		interrupt was not from this device or was not handled
  * @IRQ_HANDLED:	interrupt was handled by this device
  * @IRQ_WAKE_THREAD:	handler requests to wake the handler thread
+ * @IRQ_HANDLED_MANY:	interrupt was handled by this device multiple times
+ *			should be the only bit set in the first 3 bits, and
+ *			carry a count > 1 in the next bits.
  */
 enum irqreturn {
 	IRQ_NONE		= (0 << 0),
 	IRQ_HANDLED		= (1 << 0),
 	IRQ_WAKE_THREAD		= (1 << 1),
+	IRQ_HANDLED_MANY	= (1 << 2),
+	IRQ_RETMASK		= IRQ_HANDLED |	IRQ_WAKE_THREAD | IRQ_HANDLED_MANY,
 };
 
-typedef enum irqreturn irqreturn_t;
+#define IRQ_HANDLED_MANY_SHIFT (3)
+
+typedef int irqreturn_t;
 #define IRQ_RETVAL(x)	((x) ? IRQ_HANDLED : IRQ_NONE)
+#define	IRQ_RETVAL_MANY(x)							\
+({										\
+	__typeof__(x) __x = (x);						\
+	irqreturn_t __ret;							\
+	if (__x == 0)								\
+		__ret = IRQ_NONE;						\
+	else if (__x == 1)							\
+		__ret = IRQ_HANDLED;						\
+	else									\
+		__ret = IRQ_HANDLED_MANY | (__x << IRQ_HANDLED_MANY_SHIFT);	\
+	__ret;									\
+})
+
+#define IRQ_HANDLED_MANY_GET(x)	((x) >> IRQ_HANDLED_MANY_SHIFT)
 
 #endif
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index dc94e0bf2c940..233cf22a5b771 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -482,8 +482,14 @@ void handle_nested_irq(unsigned int irq)
 	raw_spin_unlock_irq(&desc->lock);
 
 	action_ret = IRQ_NONE;
-	for_each_action_of_desc(desc, action)
-		action_ret |= action->thread_fn(action->irq, action->dev_id);
+	for_each_action_of_desc(desc, action) {
+		irqreturn_t ret = action->thread_fn(action->irq, action->dev_id);
+
+		if ((ret & IRQ_RETMASK) == IRQ_HANDLED_MANY)
+			ret = IRQ_HANDLED;
+
+		action_ret |= ret;
+	}
 
 	if (!irq_settings_no_debug(desc))
 		note_interrupt(desc, action_ret);
diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index 9489f93b3db34..bfc6e3e43045a 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -162,6 +162,9 @@ irqreturn_t __handle_irq_event_percpu(struct irq_desc *desc)
 			      irq, action->handler))
 			local_irq_disable();
 
+		if ((res & IRQ_RETMASK) == IRQ_HANDLED_MANY)
+			res = IRQ_HANDLED;
+
 		switch (res) {
 		case IRQ_WAKE_THREAD:
 			/*
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 5bc609c7b728c..e684c7107ff90 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1192,6 +1192,8 @@ irq_forced_thread_fn(struct irq_desc *desc, struct irqaction *action)
 	ret = action->thread_fn(action->irq, action->dev_id);
 	if (ret == IRQ_HANDLED)
 		irq_add_handled(desc, 1);
+	else if ((ret & IRQ_RETMASK) == IRQ_HANDLED_MANY)
+		irq_add_handled(desc, IRQ_HANDLED_MANY_GET(ret));
 
 	irq_finalize_oneshot(desc, action);
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
@@ -1213,6 +1215,8 @@ static irqreturn_t irq_thread_fn(struct irq_desc *desc,
 	ret = action->thread_fn(action->irq, action->dev_id);
 	if (ret == IRQ_HANDLED)
 		irq_add_handled(desc, 1);
+	else if ((ret & IRQ_RETMASK) == IRQ_HANDLED_MANY)
+		irq_add_handled(desc, IRQ_HANDLED_MANY_GET(ret));
 
 	irq_finalize_oneshot(desc, action);
 	return ret;
-- 
2.43.2


