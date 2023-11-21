Return-Path: <linux-serial+bounces-6-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 363877F22D4
	for <lists+linux-serial@lfdr.de>; Tue, 21 Nov 2023 02:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E436D2812AC
	for <lists+linux-serial@lfdr.de>; Tue, 21 Nov 2023 01:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8120C17D0;
	Tue, 21 Nov 2023 01:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jBGjblu3"
X-Original-To: linux-serial@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F6D1C03
	for <linux-serial@vger.kernel.org>; Tue, 21 Nov 2023 01:06:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A06F5C433C8;
	Tue, 21 Nov 2023 01:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700528777;
	bh=WydedWHI5hgSzmjYaAgFcEvQrWisnvd0Tah1sl3VwoE=;
	h=Date:From:To:Subject:From;
	b=jBGjblu3qk1lrdPkx59RMSYuiY8P5AzRs0mYBoqbpigGFxSif6/z2yn5GaIkfD+4W
	 ctUJF3hwg7iIJDIDDshoKBWgwufEtcVce6kLgp1Si3AnKddRR9LMRYX2xBJeD5NQ6k
	 wITe0VH3P8hGFucOxCaMI3/l+hhfTjE1WnTxhFfc=
Date: Mon, 20 Nov 2023 20:06:16 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: linux-serial@vger.kernel.org
Subject: PSA: this list has moved to new vger infra (no action required)
Message-ID: <20231120-sly-thankful-lyrebird-cd52b7@nitro>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello, all:

This list has been migrated to new vger infrastructure. No action is required
on your part and there should be no change in how you interact with this list.

This message acts as a verification test that the archives are properly
updating.

If something isn't working or looking right, please reach out to
helpdesk@kernel.org.

Best regards,
-K

