Return-Path: <linux-serial+bounces-12679-lists+linux-serial=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-serial@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wO59Nwwbi2nSPwAAu9opvQ
	(envelope-from <linux-serial+bounces-12679-lists+linux-serial=lfdr.de@vger.kernel.org>)
	for <lists+linux-serial@lfdr.de>; Tue, 10 Feb 2026 12:48:28 +0100
X-Original-To: lists+linux-serial@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1227D11A61D
	for <lists+linux-serial@lfdr.de>; Tue, 10 Feb 2026 12:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A39FA300C36B
	for <lists+linux-serial@lfdr.de>; Tue, 10 Feb 2026 11:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05887322B7B;
	Tue, 10 Feb 2026 11:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="Egu39vtF"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CAC32142E;
	Tue, 10 Feb 2026 11:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770724101; cv=none; b=fB7F/CRjeN4uv44TX8u+MiTsJvfnAfQox+eK+ZMGFOZOHmYgs+0cIOKgcLxFXG66jKO7Cbz++AmuB0DgE1nZlmIxV7OFkvXlJk39KnGtzO5NOy28vLOlKVxNC4buWHxiP/qM63hwH4ywUJztmTVhMac3HZwxC+2KYXLa1gIlDuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770724101; c=relaxed/simple;
	bh=+uwvkWK5NfdQs0iII+G4Sfhi8vF2thlIU995AoX+814=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Lpn30Fo7rMIKoSMCx9TVRl/vW7RobbjTG/ub0E4s4f41UlD1zy46qA8EIHv1SDEL0UWUidmuTPNuNr+CaimaMoYc6XhzDkhV10AiXDuYQZix2fGNwojYhpiup5Pk+p2lE2+EMhmHu753mdkm4yZ9rfIeQj/X4fmB6MorqnEBd7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=Egu39vtF; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 96DEA1480214;
	Tue, 10 Feb 2026 12:48:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1770724097; h=from:subject:date:message-id:to:cc:mime-version:content-type;
	bh=4KhYmKsCBYrTSyS7CCAiq0B/cytaIy8zlbS1/jfm5Uk=;
	b=Egu39vtFNsOSiUiHQmU09Wnihsw1RKE33faVf9rSvFW+UhTK22mzyj0CHIW6Lqd4n5GAU4
	AYDrrFhcULlPKgLs0sj9kI9dSEXSJotAmhUE5Py5tLn/xgpv6FmLGXIsy7xJZtNEm1xdkg
	8ddcIdohds0MR0xK95Gpjh8jfSpZonD9zPA1UvO7K6RZNAGfIlca119J2EA3DZKouDiibw
	RLnEwuNYT0ZU8Mg+UVy3rcWecqGPC9DoM4dY2EXYqd6SACjI24wrwFVKX9iPc1q8rJxiyX
	AHJCIHApuHXmhShlkAEHb3kvoCLSdYD6imDfNqUNSjsMbo42Yy6Lt24v5ancFg==
Date: Tue, 10 Feb 2026 12:48:05 +0100
From: Alexander Dahl <ada@thorsis.com>
To: imx@lists.linux.dev
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Roelf-Erik Carsjens <rca@thorsis.com>,
	Josua Mayer <josua@solid-run.com>
Subject: rts-gpios support in fsl_lpuart driver?
Message-ID: <20260210-rearview-hungrily-536a95fc3385@thorsis.com>
Mail-Followup-To: imx@lists.linux.dev, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Roelf-Erik Carsjens <rca@thorsis.com>,
	Josua Mayer <josua@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[thorsis.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[thorsis.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12679-lists,linux-serial=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ada@thorsis.com,linux-serial@vger.kernel.org];
	DKIM_TRACE(0.00)[thorsis.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-serial];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,thorsis.com:mid,thorsis.com:dkim]
X-Rspamd-Queue-Id: 1227D11A61D
X-Rspamd-Action: no action

Hello everyone,

we are currently experimenting with the SolidRun 8XLite SoM featuring
an i.MX 8XLite SoC on a custom base board.  Due to how our peripheral
hardware is connected we need to use rs485 with uart3, which has no
native soc controlled rts line.  On different SoCs you just use
'rts-gpios' in devicetree then, letting the kernel switch this line
through gpio.  Alas it does not work on this SoC, the RTS line is not
switched at all. :-/

According to my analysis the i.MX8 family has different variants using
different uarts with different drivers.  For the variants using the
imx.c driver, you find dts files using rts-gpios, but for variants
using the fsl_lpuart.c driver you find none.

The rts-gpios property is evaluated by the serial core in
`mctrl_gpio_init()` right?  And the actual switching is also done
through that mctrl_gpio interface, right?  As far as I understand the
source code, the serial core calls the .set_mctrl function pointer,
and then it is up to the driver what to do?  Some (like atmel_serial.c
and imx.c) call mctrl_gpio_set() in the function mapped to that
pointer, some (like fsl_lpuart.c) don't.  Correct so far?

Up to this point I'm somewhat confused this is no generic feature in
the core which works for any uart, but there's probably a reason for
that?  Maybe interaction with the actual uart registers in some way?

If it is like described, I'd say the fsl_lpuart driver currently just
does not support this usecase?  Is it possible to implement the
necessary things?  Is anybody already working on that?  I looked in my
mailing list archive and in the imx downstream kernel, but could not
find any hints.

Any advice welcome. :-)

Greets
Alex


