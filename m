Return-Path: <linux-serial+bounces-7325-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3299FBDFB
	for <lists+linux-serial@lfdr.de>; Tue, 24 Dec 2024 14:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2495118858F3
	for <lists+linux-serial@lfdr.de>; Tue, 24 Dec 2024 13:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CD71DC9B1;
	Tue, 24 Dec 2024 13:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="mlRc18MN"
X-Original-To: linux-serial@vger.kernel.org
Received: from pv50p00im-tydg10011801.me.com (pv50p00im-tydg10011801.me.com [17.58.6.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357201D7E4F
	for <linux-serial@vger.kernel.org>; Tue, 24 Dec 2024 13:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735045650; cv=none; b=psv7TpsZtL/SBUVKhAn/6AyCA2cO1I8D8WMS6kHUdrwX7MhYMCWWpcEskuAJ60oY0WIWN0lRSpK2Mq6x3hkaEpPkW7wS0050Z6ep9oyCoyvXYWfpC5ZfkgWgwCN6bRCldXJ6cl4IsgHLAFEqn0xZkNM1sWYpIrXILk04DVgJC0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735045650; c=relaxed/simple;
	bh=du5/ftyRjKLUfPZd/szdooM5XW6i4xzQRbWIrcUh308=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iDAWORa4Sf1hnaeysiGXoHq/eUD7aiUHR9G52Y6FZT4uVwIf9MAt5SsiSOGLe8aThXHzaztOYbzMzcWSbj8DmcoHPadw59/lfw0Xk/HbNE2wF/Jizbojj7So8NyKQNL2OHdnMHhdaQC/3yfnMj4XXElTt6E7IvTuRU9tY/TkgqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=mlRc18MN; arc=none smtp.client-ip=17.58.6.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1735045647;
	bh=fjLiDQz2EA02/KHL6k3RgDa4UQ3Pcch4jpnBR7GO06Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=mlRc18MNiU+E4p8iehNbH9U13lO0AA4K25/A4B20Yu84c1MXS3gPy8oSzlI5qcejJ
	 pEhhk1HJvtvQLZyfv32dKhtCmYb8PKU9sri2HRuS01yKtYto8Dv8RYNNUn5tm5T+iV
	 wGyws9gCsxuZVRI/eLGwPmVmGAiGfq3SrfEp4Ngcjrp3gt0EY2qOGaxb2avsu/fBwQ
	 pRnWKQ4pZYKNlmU8bgLqlT3bNwqx++2fvx1kKv8CZyTrNc6Bufso3jNldUFa3KzVVU
	 qCxCB9jmgkh1FjK5v+MIXgcdFYxFcYKehhHJ7hAeA3e2lKMPNmlwa+8AXPfeQ1jwis
	 /UUlWG4s0Lh4A==
Received: from [192.168.1.25] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-tydg10011801.me.com (Postfix) with ESMTPSA id 7B7A6800314;
	Tue, 24 Dec 2024 13:07:12 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 24 Dec 2024 21:05:02 +0800
Subject: [PATCH v5 03/12] bus: fsl-mc: Constify fsl_mc_device_match()
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241224-const_dfc_done-v5-3-6623037414d4@quicinc.com>
References: <20241224-const_dfc_done-v5-0-6623037414d4@quicinc.com>
In-Reply-To: <20241224-const_dfc_done-v5-0-6623037414d4@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 James Bottomley <James.Bottomley@HansenPartnership.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
 Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 nvdimm@lists.linux.dev, linux-sound@vger.kernel.org, 
 sparclinux@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-cxl@vger.kernel.org, linux1394-devel@lists.sourceforge.net, 
 arm-scmi@vger.kernel.org, linux-efi@vger.kernel.org, 
 linux-gpio@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-mediatek@lists.infradead.org, linux-hwmon@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-remoteproc@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-usb@vger.kernel.org, linux-serial@vger.kernel.org, 
 netdev@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: W_133WuM_T8La2BcXe-Uxx8z8NIKfrAG
X-Proofpoint-ORIG-GUID: W_133WuM_T8La2BcXe-Uxx8z8NIKfrAG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-24_05,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1015 mlxscore=0
 spamscore=0 mlxlogscore=891 malwarescore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412240113
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

fsl_mc_device_match() does not modify caller's inputs.

To prepare for constifying API device_find_child() later.

Constify this comparison function by simply changing its
parameter types to const pointer.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/bus/fsl-mc/dprc-driver.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/fsl-mc/dprc-driver.c b/drivers/bus/fsl-mc/dprc-driver.c
index 4b68c84ef485055c9b300b4f7912a20f959b8ac1..11c8fadcf85148b4e4ea6b97b7efb6d4ddf22d3c 100644
--- a/drivers/bus/fsl-mc/dprc-driver.c
+++ b/drivers/bus/fsl-mc/dprc-driver.c
@@ -22,8 +22,8 @@ struct fsl_mc_child_objs {
 	struct fsl_mc_obj_desc *child_array;
 };
 
-static bool fsl_mc_device_match(struct fsl_mc_device *mc_dev,
-				struct fsl_mc_obj_desc *obj_desc)
+static bool fsl_mc_device_match(const struct fsl_mc_device *mc_dev,
+				const struct fsl_mc_obj_desc *obj_desc)
 {
 	return mc_dev->obj_desc.id == obj_desc->id &&
 	       strcmp(mc_dev->obj_desc.type, obj_desc->type) == 0;

-- 
2.34.1


