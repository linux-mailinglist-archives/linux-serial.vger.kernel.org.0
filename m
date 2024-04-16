Return-Path: <linux-serial+bounces-3516-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A79D08A750B
	for <lists+linux-serial@lfdr.de>; Tue, 16 Apr 2024 21:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D91E11C21675
	for <lists+linux-serial@lfdr.de>; Tue, 16 Apr 2024 19:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731F21384BE;
	Tue, 16 Apr 2024 19:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="ocvdGf4E"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2771384AD
	for <linux-serial@vger.kernel.org>; Tue, 16 Apr 2024 19:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713296518; cv=none; b=gOcyb626UMiyw2ZDAckzzGV4Z/FVDQzK4dz3Yl9YuYD3eu6UwDm9wlLTwLTRba09H0s2r3waB7pXDgfoLED5my0Rv5Z5aqlgYTvb1NI61YuNSZeNKAr8lEfl6XXo90Xz0hEQ/6oKWKq/tLfviTHaGExB/gxghZ2lpPcIwKr4flc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713296518; c=relaxed/simple;
	bh=iL4rWnJp0n1pRBBWexdnCQY80fm8TPTXAXJ/+V7Fk+8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p3osAyFAv4ZjShkgI3m0lxNkuKFyKxP+3ViWVmRUpDWokiWMp0J9uPfilUUWB6/wzNm3lVhxaS3a33EkD+AHeq//nd8G6OYYTrC4wDWwWBMrj5OOXEP6uMYIeZZ5DC+TWWIUeNy2LbmUXGQDwf0w4HlvQIJkR+ByO4cXeBX1AwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=ocvdGf4E; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1713296513; x=1713555713;
	bh=iL4rWnJp0n1pRBBWexdnCQY80fm8TPTXAXJ/+V7Fk+8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ocvdGf4EKL/4NxviAUU9FjB0BjEholGrv5bFr8U/mdC8ykKXKuMU0zCLuwjTdq31R
	 aKjJ68wsTrL+fZfq/pYVmrR6sfFnLBMkGYNdwrwilk28UzIliisL4eape0KxoVq4e6
	 h0yFG3l4jjnIo6wGv8K43T9om0ArcpML+QzJyIlGlw0n4oNwChMKeYaXJaHq7Pau8i
	 SQlOeElg1RS1DGLkUQlr4p4ynV7UNWokSQNCK1ZHf7fSsGHcuF/SO8Zfhrk5OQuxtE
	 fqQ3WMVtPLeBWhcXd91zuLAwneV+PMRTv6hOfrbEYDHinwq+Lv78noJScICJ+SNv/t
	 gGnTJu15BsF8Q==
Date: Tue, 16 Apr 2024 19:40:40 +0000
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
From: Michael Pratt <mcpratt@pm.me>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Wander Lairson Costa <wander@redhat.com>, =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Vamshi Gajjela <vamshigajjela@google.com>
Subject: Re: [PATCH v2 2/3] serial: 8250: Store whether fifo device is enabled
Message-ID: <n0nkVtqY6EGqUjpCbbDoUDPXNp4OYV5ylxThOVO8GMZauTuBZdXEqQVK73km-Jg2By_XlSB6GMmYa_plyzPgbIO6BovdNEhwtiHosAHy2Lk=@pm.me>
In-Reply-To: <Zh7PBwJ_r2OzES1y@smile.fi.intel.com>
References: <20240416182741.22514-1-mcpratt@pm.me> <20240416182741.22514-3-mcpratt@pm.me> <Zh7Jqf2sJNw1mVyJ@smile.fi.intel.com> <TYV02sftzpleM60PqVjM3niI3BqS03AyOPPAg0urAoBKyhgGGQyq1OSkZQM8aZ70Q-KaT7-lYiHl9xH-wjcdsMNvKPiJZDsvwC1uN5uEn7E=@pm.me> <Zh7PBwJ_r2OzES1y@smile.fi.intel.com>
Feedback-ID: 27397442:user:proton
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Tuesday, April 16th, 2024 at 15:18, Andy Shevchenko <andriy.shevchenko@l=
inux.intel.com> wrote:

>=20
>=20
> On Tue, Apr 16, 2024 at 07:09:52PM +0000, Michael Pratt wrote:
>=20
> > On Tuesday, April 16th, 2024 at 14:55, Andy Shevchenko andriy.shevchenk=
o@linux.intel.com wrote:
>=20
> > > > @@ -3392,6 +3392,8 @@ void serial8250_console_write(struct uart_825=
0_port *up, const char *s,
> > >=20
> > > > + up->fifo_enable =3D use_fifo;
> > >=20
> > > This seems incorrect / not the only one place to assign this. What if=
 the
> > > console not enabled at compile time? What if it's not enabled at boot=
 time?
> >=20
> > This is 8250 specific, and currently, it's the only place there
> > where it's decided whether or not to use the fifo device
> > by checking a bunch of flags and values.
>=20
>=20
> Exactly, as initial commit is related to the kernel console only.
> While your code, IIUC (correct me, if I'm wrong) is for any use of the po=
rt.
>=20
> > If you're suggesting that these checks are moved out of this function s=
omewhere else,
> > I would probably agree with that, but let's save that idea for the futu=
re...
>=20
>=20
> Not really (again, IIUC above), as console can be not enabled, and hence
> serial8250_console_write() never been called and you will have false impr=
ession
> that there is no FIFO in use.

Ah ok, I understand now...

So there are cases where the function with the checks will never be called,
yet the device itself will be configured the same way and the struct member=
 I am adding
will still be instantiated with value of 0 and never be set elsewhere... an=
d because
it is declared in a major struct "uart_8250_port", it appears to apply to a=
 larger scope
compared to the way it is actually being used...
(or at the very least, the name "fifo_enable" would be misleading).

Thanks for pointing that out, I'll take a deeper dive into the file...


>=20
> --
> With Best Regards,
> Andy Shevchenko

--
MCP

