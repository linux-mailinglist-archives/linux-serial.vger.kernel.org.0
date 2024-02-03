Return-Path: <linux-serial+bounces-2060-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55279847E5A
	for <lists+linux-serial@lfdr.de>; Sat,  3 Feb 2024 03:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3EE51F2279B
	for <lists+linux-serial@lfdr.de>; Sat,  3 Feb 2024 02:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A59823DE;
	Sat,  3 Feb 2024 02:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CjL1dJsd"
X-Original-To: linux-serial@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468C3613A
	for <linux-serial@vger.kernel.org>; Sat,  3 Feb 2024 02:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706926869; cv=none; b=R32kYdYcWxR3SzXszunyXYnwU5YznhufUYGItTAX6tL5REwgA0BHUVI/QnxmnAjpR97WjRbGVQJkIAHhTK7VLsGvHc6PureoVoxDDMpDFwHvIUVPrfd/lfI0qnXbBh99mkNEfXMmhbS9PaMyRSQh4x72qAb+aJb+lyGAYdds+8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706926869; c=relaxed/simple;
	bh=wPUk1BPhWZU4IVetHCywU4mKyGrBFvnVln1QytgmoUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:References; b=BeXKFB5jUc5llLLmheTsprNtmm46Om9DChWgKYfVDPnZwDhPbm1PJZb5/a8a6cc/bh/ch1+BWYNho+x+PflX1Xpxrs7hVnNxtOvN9/oiusBeWz8DqkTHfNTotNkuDNDzSZ63+8tuJfkT+tu76veJSRVy/8Gh/zvNJq/T6KSuyVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=CjL1dJsd; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240203022056epoutp039d1be7e405e7812a8606baf31e51c343~wOO6eJ-Mr3232232322epoutp037
	for <linux-serial@vger.kernel.org>; Sat,  3 Feb 2024 02:20:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240203022056epoutp039d1be7e405e7812a8606baf31e51c343~wOO6eJ-Mr3232232322epoutp037
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706926856;
	bh=VKWOrraSGT+Gzd2NQjMMwCtPcf85H8O4/u9KpUJECSg=;
	h=From:To:Cc:Subject:Date:References:From;
	b=CjL1dJsdRZ3NKEh8TMsCUnpw5c+vgfe1igpulgJSZOzhK8FIPoCu/az9UGCmUkuxm
	 9HA3mc0FKdhRM3uFexhl8jl9Y8U1toKJP/FPBgtDYfTtDCobK6+58kqM07uP683jGi
	 kCB+ku1mu0jbdXIzXU7Z/H5keyRqlo8CqL9xq+AA=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240203022055epcas5p2ff1cb017c7ea0a608c725fc0a6238787~wOO6CSq8Q0473604736epcas5p2q;
	Sat,  3 Feb 2024 02:20:55 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4TRbwQ1dWPz4x9Ps; Sat,  3 Feb
	2024 02:20:54 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	5A.A2.19369.603ADB56; Sat,  3 Feb 2024 11:20:54 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240202212456epcas5p15589813cd79526e9d0c444082e2f0e51~wKMe2a4fu2319923199epcas5p1c;
	Fri,  2 Feb 2024 21:24:56 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240202212456epsmtrp225338eb9a31b5ce02096033e4d2a6fea~wKMe1srJ10549205492epsmtrp2Z;
	Fri,  2 Feb 2024 21:24:56 +0000 (GMT)
X-AuditID: b6c32a50-9e1ff70000004ba9-2e-65bda3061007
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	0B.43.18939.8AD5DB56; Sat,  3 Feb 2024 06:24:56 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
	[107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240202212455epsmtip1c148fc79a26232a10e5b2b1a89409868~wKMdBvRWu2776927769epsmtip1C;
	Fri,  2 Feb 2024 21:24:54 +0000 (GMT)
From: Tamseel Shams <m.shams@samsung.com>
To: alim.akhtar@samsung.com, linux-fsd@tesla.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, Tamseel Shams <m.shams@samsung.com>
Subject: [PATCH 1/2] serial: samsung: honor fifosize from dts at first
Date: Sat,  3 Feb 2024 02:54:47 +0530
Message-Id: <20240202212448.74840-1-m.shams@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBKsWRmVeSWpSXmKPExsWy7bCmhi7b4r2pBs3XOC0ezNvGZrFm7zkm
	i/lHzrFaNC9ez2bxbq6MRd+Lh8wWmx5fY7V4+Crc4vKuOWwWM87vY7I4s7iX3eJu62J2i9a9
	R9gdeD02repk87hzbQ+bx/65a9g9Ni+p9+jbsorR41/TXHaPz5vkAtijsm0yUhNTUosUUvOS
	81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgG5VUihLzCkFCgUkFhcr6dvZ
	FOWXlqQqZOQXl9gqpRak5BSYFOgVJ+YWl+al6+WlllgZGhgYmQIVJmRnzNtkVLCIp+LF7LQG
	xq1cXYycHBICJhKtN66xdTFycQgJ7GGUWHP3MyOE84lR4t+eOcxwzs1bU1m7GDnAWhr2B0HE
	dzJK/O/bxAThtDJJbJ68kw2kiE1AU+L4eW6QuIjAJkaJaVPfgk1iFjjDKHGhYz0zyHJhATeJ
	/rnLwGwWAVWJ30/3sILYvAIWEhO3nWCEOFBeYvWGA2DNEgL32CV2r+9ghUi4SCxYc58ZwhaW
	eHV8CzuELSXx+d1eNgg7XWLuw14mCLtAYtmu71A19hIHrsxhAbmUGejS9bv0IcKyElNPrQMr
	Zxbgk+j9/QSqlVdixzwYW1Hi/+5+qDHiEu9WTIE6x0PiwA8IW0ggVmLjwXOsExhlZyFsWMDI
	uIpRKrWgODc9Ndm0wFA3L7UcHlHJ+bmbGMFJUCtgB+PqDX/1DjEycTAeYpTgYFYS4Z0gvDdV
	iDclsbIqtSg/vqg0J7X4EKMpMNAmMkuJJucD03BeSbyhiaWBiZmZmYmlsZmhkjjv69a5KUIC
	6YklqdmpqQWpRTB9TBycUg1M4b2+Bixhfya/2F8lOyfRcFXgPunXLDeMjeQf5p7WvHrqXPkE
	SbfmK5PXb9m3z0RW7GFP5JmtAX72T1YH1zC5iJ6+/32B1eXp+6vu+51+PE9BWGLvlyUPbkYv
	UL7z8KWC2FEd19T85R2d1exGh1hEmbz27fprUOPp9XLHK9dpQpf8py3lD/y83+PId/uo8uac
	BKdYh8f1peF3Nu5ZevaT3gOGj5JcTS+D7jtMf5hyn+ePUSj3DhWDoj5TkRk6G6Rmi7xZFDmP
	9fWEczYR8xSDeKf92l66OknbfuZvq0WLZom6nLrfmf/L/o1k1d/wXe0x5VN/fUpLlGXQNOHW
	TZrgFrBiyeIYV/umzH7LFv0mJZbijERDLeai4kQAzgomOgsEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHLMWRmVeSWpSXmKPExsWy7bCSnO6K2L2pBo3TzSwezNvGZrFm7zkm
	i/lHzrFaNC9ez2bxbq6MRd+Lh8wWmx5fY7V4+Crc4vKuOWwWM87vY7I4s7iX3eJu62J2i9a9
	R9gdeD02repk87hzbQ+bx/65a9g9Ni+p9+jbsorR41/TXHaPz5vkAtijuGxSUnMyy1KL9O0S
	uDLmbTIqWMRT8WJ2WgPjVq4uRg4OCQETiYb9QV2MXBxCAtsZJR4tfcvWxcgJFBeXmPZrPyOE
	LSyx8t9zdoiiZiaJP3vvsIA0swloShw/zw0SFxHYxShx/1gbK4jDLHCJUeL1x5+sIN3CAm4S
	/XOXMYPYLAKqEr+f7gGL8wpYSEzcdgJqg7zE6g0HmCcw8ixgZFjFKJpaUJybnptcYKhXnJhb
	XJqXrpecn7uJERyEWkE7GJet/6t3iJGJg/EQowQHs5II7wThvalCvCmJlVWpRfnxRaU5qcWH
	GKU5WJTEeZVzOlOEBNITS1KzU1MLUotgskwcnFINTAWuN32+SZ32a78qvrytWafj5ZyN/H6+
	D+Q+cVo9+KbYOFW8ya27QL+nLju/Szi3+Ninuwr3ij/lJzucKemd/7XE+9zMBUqrC3j9ymoK
	Z9pM8/39zHyDQtNdz/4rMhk3PeUf5wsYmOYd+CYbXvKbd33Kby+27t1a1w9uCIme4nPsv3/p
	OdYQHZWMf8vOv/cV9fo+daFAq0RZzIdHt4+Ueuof/PGfeb7dGUf55YdS7f13185KY5WbttDw
	TrG/e1zISqUzsyoT7y912z/Zuu5g+oILl1deSjlx+XD7/xs8fRWL+VuuartvmmT/NNq6UW/m
	Zr1vDV0m7+/Yizh/qFYLcl63T5Sz7NXEwEcsR3yClViKMxINtZiLihMBVCpzwLECAAA=
X-CMS-MailID: 20240202212456epcas5p15589813cd79526e9d0c444082e2f0e51
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240202212456epcas5p15589813cd79526e9d0c444082e2f0e51
References: <CGME20240202212456epcas5p15589813cd79526e9d0c444082e2f0e51@epcas5p1.samsung.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Currently for platforms which passes UART fifosize from DT gets
override by local driver structure "s3c24xx_serial_drv_data",
which is not indentded. Change the code to honor fifosize from
device tree at first.

Signed-off-by: Tamseel Shams <m.shams@samsung.com>
---
 drivers/tty/serial/samsung_tty.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 71d17d804fda..e4c4c9f4f9b0 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -1990,8 +1990,7 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
 	}
 
 	if (np) {
-		of_property_read_u32(np,
-			"samsung,uart-fifosize", &ourport->port.fifosize);
+		ret = of_property_read_u32(np, "samsung,uart-fifosize", &ourport->port.fifosize);
 
 		if (of_property_read_u32(np, "reg-io-width", &prop) == 0) {
 			switch (prop) {
@@ -2009,10 +2008,13 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (ourport->drv_data->fifosize[index])
-		ourport->port.fifosize = ourport->drv_data->fifosize[index];
-	else if (ourport->info->fifosize)
-		ourport->port.fifosize = ourport->info->fifosize;
+	if (ret) {
+		if (ourport->drv_data->fifosize[index])
+			ourport->port.fifosize = ourport->drv_data->fifosize[index];
+		else if (ourport->info->fifosize)
+			ourport->port.fifosize = ourport->info->fifosize;
+	}
+
 	ourport->port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_SAMSUNG_CONSOLE);
 
 	/*
-- 
2.17.1


