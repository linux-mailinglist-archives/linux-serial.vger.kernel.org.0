Return-Path: <linux-serial+bounces-186-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E0B7F6867
	for <lists+linux-serial@lfdr.de>; Thu, 23 Nov 2023 21:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C792AB20D48
	for <lists+linux-serial@lfdr.de>; Thu, 23 Nov 2023 20:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA341C26;
	Thu, 23 Nov 2023 20:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J/IYGv0y"
X-Original-To: linux-serial@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9A64D586;
	Thu, 23 Nov 2023 20:19:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C4C7C433C7;
	Thu, 23 Nov 2023 20:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700770794;
	bh=UuTLzGGuH9YcnubjdF1BCJM+K4+61EnWHvDrzsYsIjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J/IYGv0y33AVuo6lVGfICAh9QGCeCF05WduzQig+AWwMeM7xMbDEiE049+6LzaOoR
	 vCfuf8Qyw4nfPp/Rm9M2b1iG9OSOokB5gWsSjAHpDRCU0D+3aOrtwDN1sfJpeFtR6p
	 bPHgaCBJvKCfquudN2B/3zcOdVZADe4nUm4aI0Qg=
Date: Thu, 23 Nov 2023 20:19:45 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-usb@vger.kernel.org, Matt Turner <mattst88@gmail.com>,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 00/17] tty: small cleanups and fixes
Message-ID: <2023112321-veto-trapping-ca47@gregkh>
References: <20231121092258.9334-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121092258.9334-1-jirislaby@kernel.org>

On Tue, Nov 21, 2023 at 10:22:41AM +0100, Jiri Slaby (SUSE) wrote:
> This is a series to fix/clean up some obvious issues I revealed during
> u8+size_t conversions (to be posted later).

I applied most of these except the last few, as I think you were going
to reorder them, right?

thanks,

greg k-h

