Return-Path: <linux-serial+bounces-3979-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1008B9DAF
	for <lists+linux-serial@lfdr.de>; Thu,  2 May 2024 17:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F7F91C21EB5
	for <lists+linux-serial@lfdr.de>; Thu,  2 May 2024 15:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A7415B13D;
	Thu,  2 May 2024 15:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bP3v/spu"
X-Original-To: linux-serial@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86C415B14D;
	Thu,  2 May 2024 15:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714664645; cv=none; b=FLWR2ppvHfZV9bVG1CDdlr9jJIYg5EntQ4pDSo2wAfLcOKyykvRZIdXuPN7SzC6uuDOZ+uWnj3L54xN0f9JTs7wbThWRBghsDNPmDkl9NIbv5tLcdVmU0sI8gQpMVshVeIiLBbMYW9tFdbJ7rqLBhc+d5YCaQbthln6HOFvCLaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714664645; c=relaxed/simple;
	bh=xh4y8j04z59/8X1Tg3qhrjwIBeBWw7wpTCRNn/GaHfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JW0YZysDE5UG4J7LxKE1/J+47PqU5KYxzaASMt1GIcNT0ySzk7DhmCcXVA8pDBO4aID8qLCcuNUTHBRbPuyWID4iPViXsTNPuS/py/ksA5dD5Npzt8Xaj47Ukl8T/JJDKR0gNsYCNf0HBGomnSo7q8+isH9GSgoXqq0eJ2aLMH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bP3v/spu; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714664644; x=1746200644;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xh4y8j04z59/8X1Tg3qhrjwIBeBWw7wpTCRNn/GaHfU=;
  b=bP3v/spuhJS4+LBQIl5BIDdl9CRYICPX7MufiGxUmX9A5pHfsWz70dCi
   T9N/Hp0ozIGDyY3A18uYF04gRVc+L+xtMCdspa/GKxlZbcsLoPLzbOUOZ
   3+fw3g+YZ5CS+6sVxVxhljHWJZUvYeB7FYdkuL2dO9HxgTvWau7I5cSba
   ffiuyvTIeDLcVfj6qbVI3W2oPimfpc9lF1x/btzwyNs3unoXt6UrzdyPL
   zOKEmBw511nGwJGbosVdOrhc1VOyRyhnNjd4ErA2krATSSfTrBXKirPv9
   fghIEDjnRe4vCTDXpcFa3SO351P90uauRzHR6RqLfnQIg8xvqzgCFKbJ6
   w==;
X-CSE-ConnectionGUID: 3sc//M3wRdmD2XsZJpOIdg==
X-CSE-MsgGUID: /+4Vzhz0Q1qBn4I9f2zIxg==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="10296349"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10296349"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 08:44:03 -0700
X-CSE-ConnectionGUID: /CdbWWBLQFO+s2GkNM8hWw==
X-CSE-MsgGUID: /kBsAxPnT222dZF7RJdavw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="31767231"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 08:44:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s2YbH-00000003Mn2-18qx;
	Thu, 02 May 2024 18:43:59 +0300
Date: Thu, 2 May 2024 18:43:59 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <parker@finest.io>
Cc: Parker Newman <pnewman@connecttech.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 03/13] serial: 8250_exar: Kill CTI_PCI_DEVICE()
Message-ID: <ZjO0v9i0-adEM9Nq@smile.fi.intel.com>
References: <20240502144626.2716994-1-andriy.shevchenko@linux.intel.com>
 <20240502144626.2716994-4-andriy.shevchenko@linux.intel.com>
 <20240502111314.63d66b54@SWDEV2.connecttech.local>
 <ZjOxQWc1OtGWatKC@smile.fi.intel.com>
 <20240502113610.01881f3b@SWDEV2.connecttech.local>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502113610.01881f3b@SWDEV2.connecttech.local>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 02, 2024 at 11:36:10AM -0400, Parker Newman wrote:
> On Thu, 2 May 2024 18:29:05 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, May 02, 2024 at 11:13:14AM -0400, Parker Newman wrote:

...

> > Above I added current code of these macros, can you elaborate how it's incorrect?
> 
> Sorry, you are correct. I was mixed up.

No problem. And since you are here, can you tell me what type of EEPROM is
connected to the chip in your case?

-- 
With Best Regards,
Andy Shevchenko



