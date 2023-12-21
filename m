Return-Path: <linux-serial+bounces-1119-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C041481B9F8
	for <lists+linux-serial@lfdr.de>; Thu, 21 Dec 2023 15:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E539288B74
	for <lists+linux-serial@lfdr.de>; Thu, 21 Dec 2023 14:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B112360BD;
	Thu, 21 Dec 2023 14:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHN1ce4Q"
X-Original-To: linux-serial@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BCA360AD;
	Thu, 21 Dec 2023 14:56:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25831C433C8;
	Thu, 21 Dec 2023 14:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703170573;
	bh=oJ3Y2DXjf19FXfTDs0TOYdiw24+AEE+V6ErTf9COcFI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=HHN1ce4QcQBYZTHygoj+j8SHGWGnHBnMyNfrf1f3CZKvauEi6YzTrXly8ON1/jG2M
	 NfmvUh9DwdvCYuwtphGqfilTpDDgmu8sId0FUY9hDeBNetb6nhbisfWZVLzHBj4KRk
	 jnd6dLzxOGmsXRCSMYKTGrH0HMTrhtciIQShHRVIc/PCIq1NAKzRCRm9h8zrirWwIz
	 RoISTjVo++gXkb2nubiHwNPSTtLINBzX9coNvOoTEnDQQFbokOBkt5Bd6BCrtVc8Oo
	 Uk99ZyXC/7tr6RFRIqjZIH7lFq5daEb6LKfAqrniJYltg24l0rosXkLHDT3HaZutG7
	 eKVSQucv/pNxw==
From: Lee Jones <lee@kernel.org>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Chunyan Zhang <chunyan.zhang@unisoc.com>
Cc: devicetree@vger.kernel.org, linux-serial@vger.kernel.org, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Orson Zhai <orsonzhai@gmail.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
 LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20231215085630.984892-2-chunyan.zhang@unisoc.com>
References: <20231215085630.984892-1-chunyan.zhang@unisoc.com>
 <20231215085630.984892-2-chunyan.zhang@unisoc.com>
Subject: Re: (subset) [PATCH 1/4] dt-bindings: mfd: sprd: Add support for
 UMS9620
Message-Id: <170317057088.609072.12273953468254083847.b4-ty@kernel.org>
Date: Thu, 21 Dec 2023 14:56:10 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3

On Fri, 15 Dec 2023 16:56:27 +0800, Chunyan Zhang wrote:
> Add bindings for Unisoc UMS9620 system global registers which provide
> register maps for clocks.
> 
> 

Applied, thanks!

[1/4] dt-bindings: mfd: sprd: Add support for UMS9620
      commit: 5fa295f5cd1e9995e914b75c7d7948808af95ca4

--
Lee Jones [李琼斯]


