Return-Path: <linux-serial+bounces-12877-lists+linux-serial=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-serial@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAXlLu6urmkSHwIAu9opvQ
	(envelope-from <linux-serial+bounces-12877-lists+linux-serial=lfdr.de@vger.kernel.org>)
	for <lists+linux-serial@lfdr.de>; Mon, 09 Mar 2026 12:28:46 +0100
X-Original-To: lists+linux-serial@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 493A3237EEE
	for <lists+linux-serial@lfdr.de>; Mon, 09 Mar 2026 12:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E635F3085327
	for <lists+linux-serial@lfdr.de>; Mon,  9 Mar 2026 11:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9EA39B497;
	Mon,  9 Mar 2026 11:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FzkPjDyH"
X-Original-To: linux-serial@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD34139A05F;
	Mon,  9 Mar 2026 11:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773055488; cv=none; b=rLj6F/Og2emTWbpBd5h5yqt7+rJLVdiB3F8rkm7tDVJke2EmD0Tgcut0ajkNkL38E9GJ9utGGcpSjZGtSmjSB5UGefStJ1pqeM71J10rx7ucx4Y45xn/X1u8/rHG+ztoGcRLoJrU0qgKZK7tZ6kAUnB7uM1vPhAz0x1vd/6uaSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773055488; c=relaxed/simple;
	bh=CH7QD5IBbHvptdXvBjbcev7GA9k8Wi2PYsnbl5+pvwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KM9vhrURy6jaBY74aBGcAuUmldgmOexebzQiTikE4LejgbLiEGBawBTIFlA6/BuBw3pOMBqtc8VtAQEoQKoryRU3C+iDlnoJUInAuKga9XzdHNnR1hTXy+fY0qBG52tUecQIZ/HE0gF+X57xSEBT0igVbACgW3xoDtj2jXquJ0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FzkPjDyH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 115A0C4CEF7;
	Mon,  9 Mar 2026 11:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773055488;
	bh=CH7QD5IBbHvptdXvBjbcev7GA9k8Wi2PYsnbl5+pvwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FzkPjDyHe01FadWpeYuqLvECY/ktaweHhD/cIFCugR4mhK5k5bFwMp0DGGogV5t9t
	 KJKRT2FmTYvRTo8+kZDx78WRM0WThJ+HIsDLLBz+sQpJXvXz7CGrRHV+qICVDkmHhF
	 AubvLklzS5yfAwz9lPF0Qi7nRdd50wP3X9QjPGl8=
Date: Mon, 9 Mar 2026 12:24:46 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Julian Braha <julianbraha@gmail.com>
Cc: jcmvbkbc@gmail.com, rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com, conor+dt@kernel.org,
	robh+dt@kernel.org, jirislaby@kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: remove drivers for espressif esp32
Message-ID: <2026030922-zippy-gloater-6487@gregkh>
References: <20260309111848.1516412-1-julianbraha@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309111848.1516412-1-julianbraha@gmail.com>
X-Rspamd-Queue-Id: 493A3237EEE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12877-lists,linux-serial=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,infradead.org,linux.intel.com,kernel.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.508];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-serial@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-serial,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 11:18:48AM +0000, Julian Braha wrote:
> Following the conversation here:
> https://lore.kernel.org/all/20260308131412.1102749-1-julianbraha@gmail.com/
> 
> There was an agreement to delete these drivers for now.

As this is going to be in the changelog, perhaps summarize that
agreement and write more here?

thanks,

greg k-h

