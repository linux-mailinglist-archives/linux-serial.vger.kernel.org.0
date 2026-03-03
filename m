Return-Path: <linux-serial+bounces-12836-lists+linux-serial=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-serial@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIvuLaOUpmnmRQAAu9opvQ
	(envelope-from <linux-serial+bounces-12836-lists+linux-serial=lfdr.de@vger.kernel.org>)
	for <lists+linux-serial@lfdr.de>; Tue, 03 Mar 2026 08:58:27 +0100
X-Original-To: lists+linux-serial@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3243A1EA75C
	for <lists+linux-serial@lfdr.de>; Tue, 03 Mar 2026 08:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AEEC308A8A8
	for <lists+linux-serial@lfdr.de>; Tue,  3 Mar 2026 07:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72953806BD;
	Tue,  3 Mar 2026 07:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bELU7dWB"
X-Original-To: linux-serial@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30CF3845BF;
	Tue,  3 Mar 2026 07:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772524548; cv=none; b=tbMTg4xDNBsO0COGJX2ilgsS4z7o/RwaCwNHa1lOA7hd/CV7TYVemuB4pYoOi8WZGxfGdMx9Q4kzUqZ1FAYF/MHRZAW45tdLS4jsWFgtaofR/J4XnIz91u3o44edxtsdhyzIf58S/K9pohM6hCVhRTL60AoqJYMEt/qCMBFX2LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772524548; c=relaxed/simple;
	bh=70vxsRqAp55/Ool8JqEn7vUwCFPnjaK2mspvxSAHIno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifXO0POOTh1DYk0S40FYCbdT+cePFGddWXNk3MOM5zzY/8TQQHr86DTHlF973ET5ihsUXUvrWRaFI/twf9xP5Az2lTsmTqD419jc/M3LtlarCSzSSI50Pc026Qson02Rq30nzbX6xpinQIAm55LcL/cmcGmNnelIJMkTl4AVXkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bELU7dWB; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772524546; x=1804060546;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=70vxsRqAp55/Ool8JqEn7vUwCFPnjaK2mspvxSAHIno=;
  b=bELU7dWBFZKQGrQAyAGXPD2iiDpJlacpAVnhCOb5yFDcD1JAMMFBIcW1
   CUoXrhn9y4V3OaWBL+LoULq3FOudxSgJ+xdeyhXTXYitZK4qPIfm/wcXx
   v5Igj4x5RsM/4JyFXIjGtyAR/L90oGy6zwBRsonoWjcNeYSNWyTdAJaEN
   ZcEVXKeleJ+hKdXGal78DykVLUpoDgvLNxHEJjxiCXArEb6t+SMPmqINp
   GLu3IrP+NEpX8r5sw3QaOY34tU8VVUT06NBXKDvz8lTA0cKeROeOFQ0dq
   AX+vv7GNAtMEorMW13t66x9KDV7ooQCXFywdV57tFMdZB2/19708F31mB
   g==;
X-CSE-ConnectionGUID: cVNMiwJBStOOiLIxGNM0XA==
X-CSE-MsgGUID: 61h1vLKxSzGRyrC+OeZvuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="90947165"
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="90947165"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 23:55:45 -0800
X-CSE-ConnectionGUID: jxO+nR71TNWWd8bWPtExdg==
X-CSE-MsgGUID: uqOkaZHdTvOgbu3Fs4oQoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="218028354"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.196])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 23:55:43 -0800
Date: Tue, 3 Mar 2026 09:55:40 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v1 1/1] serial: 8250_port: Drop duplicate NULL check
Message-ID: <aaaT_LiDbWX-ifK1@ashevche-desk.local>
References: <20260302152738.2498579-1-andriy.shevchenko@linux.intel.com>
 <c1500ee2-d609-4c66-b301-2b081722eef9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1500ee2-d609-4c66-b301-2b081722eef9@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Queue-Id: 3243A1EA75C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12836-lists,linux-serial=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-serial@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-serial];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,ashevche-desk.local:mid]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 06:25:29AM +0100, Jiri Slaby wrote:
> On 02. 03. 26, 16:27, Andy Shevchenko wrote:
> > serial8250_release_dma() is NULL-aware, no need to check this in the caller.
> > While at it, make sure DMA won't be used again, by NULLifying the pointer.

> >   	synchronize_irq(port->irq);
> > -	if (up->dma)
> > -		serial8250_release_dma(up);
> > +	serial8250_release_dma(up);
> > +	up->dma = NULL;
> 
> Shouldn't serial8250_release_dma() NULL it instead, so the callers need not
> to bother?

I copied what 8250_omap is doing. But we can do what you suggested I think.

-- 
With Best Regards,
Andy Shevchenko



