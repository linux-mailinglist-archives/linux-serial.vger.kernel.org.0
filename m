Return-Path: <linux-serial+bounces-6273-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D3898622F
	for <lists+linux-serial@lfdr.de>; Wed, 25 Sep 2024 17:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 836D528B3B5
	for <lists+linux-serial@lfdr.de>; Wed, 25 Sep 2024 15:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A294175AD;
	Wed, 25 Sep 2024 15:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUMVe0MM"
X-Original-To: linux-serial@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054AA18638
	for <linux-serial@vger.kernel.org>; Wed, 25 Sep 2024 15:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727276417; cv=none; b=rLkkE9QNK6qQSlDWFQKWJ2lIx+WL/qbScyfCK4CaBMx6vxCuHgHLnTR51ktwQkPEA2nXY+RB0dpcsIBcntk5guw/0tVZAAIO3KcP6PT8W2oMPmGIWtZsnnkRzwqJyMBkHKIRoD5JORjhxD+pWxgt8WU7NciJo07uTJn2VHkI7fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727276417; c=relaxed/simple;
	bh=xRAD8g3EraXXjYIIoq15LcTLkpwMHw/Hh4Jf/6khsx4=;
	h=MIME-Version:Content-Type:From:To:Message-ID:In-Reply-To:
	 References:Subject:Date; b=m8DC9xwMITak5DvZQISVo81MMud14NtTJzk3gDMVP1aoNJl/oteEVwxMt/XG+VRtMd6WOiLjjg4Fa8GACjnDZCBN6MkIi2KyCtuFSfhDdbDVwswHkotWfeZ2eUAsLpBnjx98xYn/pIfSO7L6hPx0d/z7Ulaui1hPMrADlFDboHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUMVe0MM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB37BC4CEC9;
	Wed, 25 Sep 2024 15:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727276416;
	bh=xRAD8g3EraXXjYIIoq15LcTLkpwMHw/Hh4Jf/6khsx4=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=VUMVe0MM6bpFKD/nOonI6Dfs9KzGPvrOKnSfxdeE+YZ07aX0vwAGYw5lWtoT0IZRC
	 8aQu9Ka3Z03yfNYezGIWqe7AwpqHQ/sEWwcLPCWaVwmiom9jg/g+AatJUs1WlsYxsM
	 lUjCbn2jvoDn+y/g79hkHnDDm5ELI8mbKT0pPImrT1j2/THvfipHOJWua12gRDnCWX
	 VhSuWXVheJLauNFEdGIzai0SrA1HvwBYsxRcv7Y6WU9XzjuK5Cgqj/v7Vv67PB7qzS
	 H0k1ZMkKMWB3tnb8+nd6wzzxFRiKXLSSHKTT7aREZHxq4rjSC90sP8WRCY8KksGtSz
	 yLPBFv9/BktSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A0913809A8F;
	Wed, 25 Sep 2024 15:00:20 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
From: Bugspray Bot <bugbot@kernel.org>
To: helpdesk@kernel.org, linux-serial@vger.kernel.org, peter@korsgaard.com, 
 konstantin@linuxfoundation.org
Message-ID: <20240925-b219324-0ef4db10f475@bugzilla.kernel.org>
In-Reply-To: <20240925-cute-viper-of-skill-a55aae@lemur>
References: <20240925-cute-viper-of-skill-a55aae@lemur>
Subject: Re: Bouncing maintainer: Peter Korsgaard (XILINX UARTLITE SERIAL
 DRIVER)
X-Bugzilla-Product: kernel.org
X-Bugzilla-Component: Helpdesk
X-Mailer: bugspray 0.1-dev
Date: Wed, 25 Sep 2024 15:00:20 +0000 (UTC)

Hello:

This conversation is now tracked by Kernel.org Bugzilla:
https://bugzilla.kernel.org/show_bug.cgi?id=219324

There is no need to do anything else, just keep talking.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


