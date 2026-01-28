Return-Path: <linux-serial+bounces-12589-lists+linux-serial=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-serial@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIE7Jt0vemlq3wEAu9opvQ
	(envelope-from <linux-serial+bounces-12589-lists+linux-serial=lfdr.de@vger.kernel.org>)
	for <lists+linux-serial@lfdr.de>; Wed, 28 Jan 2026 16:48:45 +0100
X-Original-To: lists+linux-serial@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF85AA4767
	for <lists+linux-serial@lfdr.de>; Wed, 28 Jan 2026 16:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BABEE305A233
	for <lists+linux-serial@lfdr.de>; Wed, 28 Jan 2026 15:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E722322A3F;
	Wed, 28 Jan 2026 15:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dJqIRXRe"
X-Original-To: linux-serial@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAE5310771;
	Wed, 28 Jan 2026 15:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615107; cv=none; b=pJNz8jJGRNF08Oa4ZO7vn2eoUlWEauMRfZdam4ajRxgdenVTD2wy7MtuHLG58ITAAYazv1pLrInjuIVMKniGyo0KEmJLcTHVt5jHnKBF/GVxRPiOEH4KKBXLmoZnR3m4XHFveeNVPaOV7La0O91NirdpSCuPICkjMxqhqIRaFbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615107; c=relaxed/simple;
	bh=Hq4ghYWGfXXjqkO3CDoMOn7g6bXdQJy2aBy/83LNvh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y25vahW5/nQVOJSYySRXgQ50pzWK7yuCM1WUk5uyiNWWfiok2oail0B29LBzQYaVE3XHJ288QdbLSGyZZ3KBeoZ5mkeiGxiZjgbQC5/2dwFuG+/7QzNd2hF3c/XIQ3/0j6QDQ8Kx72Li2qVMB8Xw+yhvtePWfeM+9u7RX/HYFl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dJqIRXRe; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769615106; x=1801151106;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Hq4ghYWGfXXjqkO3CDoMOn7g6bXdQJy2aBy/83LNvh0=;
  b=dJqIRXReTeXSfNkEvcSB6k7mPakfCjMu6fTdAfE/GfsUYubG0DQJmVy2
   clpsaof+gW7zqUls2UjYALVjwdGwNgJTWule2I5dWNsDfwkAJrpsS3Dz7
   glYCExzQP6nb7pn2vSwtefkcwwLGW3shvUKeCchLM7ha2qDxLGgb7iv1h
   cN5/TaRNK4UQN0zZ0RNnn8lhyY1FFtAKuuJCVi6s+dS+lDzm8TgjprcXJ
   7fcpyQFodOU5CxB/UZJ57QovVzZjOd5y2jHMWmetTvv/LRxGhbf2zPvY9
   hSBenQ2R7im1I0G8DUz+9zTCCNQMAD3YxANTqTRd1EFSfsPMP0wfAoSxe
   Q==;
X-CSE-ConnectionGUID: rjSMdgAWTcyxm9vIo1rpGQ==
X-CSE-MsgGUID: lhJbmFhLTfW8PVi3Xw+ZXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="81463335"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="81463335"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 07:44:57 -0800
X-CSE-ConnectionGUID: bDJTu45wRIOJaRvU2kwvRw==
X-CSE-MsgGUID: y+E5wqvTRAOcbcnfVDk5zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="207911922"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.57])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 07:44:56 -0800
Date: Wed, 28 Jan 2026 17:44:53 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] serial: 8250_port: Drop duplicate NULL check
Message-ID: <aXou9dAiTdhzuqrn@smile.fi.intel.com>
References: <20260128142726.128175-1-andriy.shevchenko@linux.intel.com>
 <c2f50f9e-fc4c-dc6f-8bc7-8cc758c741dc@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c2f50f9e-fc4c-dc6f-8bc7-8cc758c741dc@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12589-lists,linux-serial=lfdr.de];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-serial@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-serial];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smile.fi.intel.com:mid,intel.com:email,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CF85AA4767
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 05:09:31PM +0200, Ilpo JÃ¤rvinen wrote:
> On Wed, 28 Jan 2026, Andy Shevchenko wrote:

...

> > -	if (up->dma)
> > -		serial8250_release_dma(up);
> > +	serial8250_release_dma(up);
> > +	up->dma = NULL;
> 
> Seems reasonable safeguard,

Note, 8250_omap does the same for last 3 years.

> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Thanks!


-- 
With Best Regards,
Andy Shevchenko



