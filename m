Return-Path: <linux-serial+bounces-3730-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 121F88ACBC6
	for <lists+linux-serial@lfdr.de>; Mon, 22 Apr 2024 13:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 439611C229D6
	for <lists+linux-serial@lfdr.de>; Mon, 22 Apr 2024 11:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFE81465A4;
	Mon, 22 Apr 2024 11:14:20 +0000 (UTC)
X-Original-To: linux-serial@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F0C146595;
	Mon, 22 Apr 2024 11:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713784460; cv=none; b=mj/SCzSU/ZKKgADpguc/kmBpk7Lk3iPIrwlOjjAKQjlZMO0OTBhbwI50LGA8Tw86z564dS9rd30PyzFnfgKiPG/Jxn+KX8ZBacsblm5g/mm/xtISJQVzGS12uU629oxMCZxOkxxNs3PqrL2DpKy2pTXr+I/lA3pGrr6OPhbfYyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713784460; c=relaxed/simple;
	bh=XdM9JYJh7vwnARlcJo0VQR1tNERuNcRdVHmW7MTtKw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LS78cNb+fhPJd9b6eWjpyLuUog4Y33hJm0G78mimKxTCIq8buIqk+piHPzf+FKjACxHyP/RAkP6kcJIXsPGGRfKHFMOp/N/yJ2EX7/s6eSo323VXu6+/UO94onovOZna2mqVwfeYjVmc38HqvNklA1831ttVnfz58XpyFJ5J74s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: rBQPvDklQx6ZEg+iRwiOBQ==
X-CSE-MsgGUID: P4vTdR1MR5SBGKfbfzBqVw==
X-IronPort-AV: E=McAfee;i="6600,9927,11051"; a="9194173"
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="9194173"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 04:14:20 -0700
X-CSE-ConnectionGUID: 0FBRhyGuRVeat8H0yfpwxg==
X-CSE-MsgGUID: R5bIlut3TfWzcHL0R8Qkhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="24009683"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 04:14:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1ryrcf-00000001d6T-3s8o;
	Mon, 22 Apr 2024 14:14:09 +0300
Date: Mon, 22 Apr 2024 14:14:09 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Konstantin Pugin <rilian.la.te@ya.ru>
Cc: krzk@kernel.org, conor@kernel.org, lkp@intel.com, vz@mleia.com,
	robh@kernel.org, jcmvbkbc@gmail.com, nicolas.ferre@microchip.com,
	manikanta.guntupalli@amd.com, corbet@lwn.net, ychuang3@nuvoton.com,
	u.kleine-koenig@pengutronix.de, Maarten.Brock@sttls.nl,
	Konstantin Pugin <ria.freelander@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Lech Perczak <lech.perczak@camlingroup.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v5 2/3] dt-bindings: sc16is7xx: Add compatible line for
 XR20M1172 UART
Message-ID: <ZiZGgWTrj5jL3ujn@smile.fi.intel.com>
References: <20240420182223.1153195-1-rilian.la.te@ya.ru>
 <20240420182223.1153195-3-rilian.la.te@ya.ru>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240420182223.1153195-3-rilian.la.te@ya.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Apr 20, 2024 at 09:22:05PM +0300, Konstantin Pugin wrote:
> From: Konstantin Pugin <ria.freelander@gmail.com>
> 
> EXAR XR20M1172 UART is mostly register-compatible with NXP SPI UARTs.
> It will be handled by same driver, so, it makes sense to add DT
> definition for these block into driver's documentation.

Still Description is missing the part about Exar involvement here...
OTOH, not a DT guy here and you got the Ack:s, so feel free to ignore
my comment.

-- 
With Best Regards,
Andy Shevchenko



