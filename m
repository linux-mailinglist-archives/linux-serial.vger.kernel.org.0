Return-Path: <linux-serial+bounces-12688-lists+linux-serial=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-serial@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4N1/Iatvi2mRUQAAu9opvQ
	(envelope-from <linux-serial+bounces-12688-lists+linux-serial=lfdr.de@vger.kernel.org>)
	for <lists+linux-serial@lfdr.de>; Tue, 10 Feb 2026 18:49:31 +0100
X-Original-To: lists+linux-serial@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CE611E19F
	for <lists+linux-serial@lfdr.de>; Tue, 10 Feb 2026 18:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D445303AB4C
	for <lists+linux-serial@lfdr.de>; Tue, 10 Feb 2026 17:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB672342539;
	Tue, 10 Feb 2026 17:49:27 +0000 (UTC)
X-Original-To: linux-serial@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89397632;
	Tue, 10 Feb 2026 17:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770745767; cv=none; b=BmuVJS2KkqnYIgmTdUNvz5FhMYU0CGb01Ygo/63nn0XEtZMQEpFlnv8LEAyg1K9uoCjwNPCyGfL5GEXfu/GznUVTn2veF6ErUTy2LAlcAQhmDNMWsUMA2/a+Nv8+MueKo0nDjW+ysKmxhU3Flm3Sxn4L2LQCM9CracipDABEMhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770745767; c=relaxed/simple;
	bh=7c4y4t3lj29gJJ/4ONdBMiHrkNB0uObQpg6UITtIWdY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=s+hAM82Ecjn7fm6wnm00DoiQAiap9bDYEIzLWCqSPJ1hP1sF1hks1dXwdKbEbfIy+s/nb2aoRm56T9jq3Ijp+6zs0gDMqoS6lRL46/qe46TiGrmlvVttJODmzFCMbW7VrhGjg80hAzMVN9T78AHACXFyE3jte6qcyvuL/tmb390=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 6781092009C; Tue, 10 Feb 2026 18:49:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 626FE92009B;
	Tue, 10 Feb 2026 17:49:17 +0000 (GMT)
Date: Tue, 10 Feb 2026 17:49:17 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Sheng Yu <yushenglive@gmail.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, jirislaby@kernel.org, 
    linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] serial: 8250: add CONFIG_SERIAL_8250_PROBE_BAUD
 option
In-Reply-To: <20260209042643.565418-1-yushenglive@gmail.com>
Message-ID: <alpine.DEB.2.21.2602101736150.63149@angie.orcam.me.uk>
References: <20260209042643.565418-1-yushenglive@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[orcam.me.uk];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-12688-lists,linux-serial=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[macro@orcam.me.uk,linux-serial@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-serial];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,angie.orcam.me.uk:mid]
X-Rspamd-Queue-Id: 13CE611E19F
X-Rspamd-Action: no action

On Sun, 8 Feb 2026, Sheng Yu wrote:

> Currently, the 8250 driver defaults to 9600 baud if no console options
> are provided via the command line. This can result in garbled output if
> the firmware or bootloader has already initialized the UART to a
> different speed.

 FWIW this seems like a generic option that shouldn't be limited to 8250 
hardware, i.e. for drivers/tty/serial/Kconfig and to be named accordingly, 
as there's nothing specific to the 8250 in it.  Then individual drivers 
could opt in via a dependency where feasible (i.e. the baud rate generator 
setting being readable) and someone actually did it, such as you for the 
8250 driver.  This could be mentioned in the option description so as not 
to confuse people with configurations featuring multiple serial device 
drivers.

  Maciej

