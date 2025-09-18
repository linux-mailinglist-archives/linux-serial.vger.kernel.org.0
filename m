Return-Path: <linux-serial+bounces-10731-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D433AB527AB
	for <lists+linux-serial@lfdr.de>; Thu, 11 Sep 2025 06:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E58F91C21984
	for <lists+linux-serial@lfdr.de>; Thu, 11 Sep 2025 04:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D942417C6;
	Thu, 11 Sep 2025 04:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L9l6WgOm"
X-Original-To: linux-serial@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E0425228D
	for <linux-serial@vger.kernel.org>; Thu, 11 Sep 2025 04:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757565218; cv=none; b=OFlrHo2OP2dS5lTmpaEIgQ3yAUWqrO4w7jiE2l6tvtihJKwn31oi+w8qWtcxyfGv30ft8RIrskcT78Lltj1Yqcop0QKPVnbExabW2gJrbNl/c3ikUVZ/vh4g5TQHh+QH/97EenmmBHRjU0/z9r13QDHzw8ZD1TsvUblHd4h3my0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757565218; c=relaxed/simple;
	bh=6Em4YRvhzUdiai6MIke/qRQ6ZKbGJwjjHbIVhAuggC0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZiWwkR5Z892GxRWBXcdx6mRSmWjH/3rPm/1/eLm7I+puJwx45BFyTma0/9LE2Teve6lUlvyvbY8kyYy+j/XOAvVLRO5jRKYa5gEoVKwOV39Pj6f88rUI6gwpvyqyAJrFvcKTz3C3olyQcdX0j5K7Mq4fPb+kJO8vlQ5RTxDFf/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L9l6WgOm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B2IV7c008188
	for <linux-serial@vger.kernel.org>; Thu, 11 Sep 2025 04:33:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=DOg+t76LDtT
	Tfe4i4G48ZKjea2te61QR8gT2wG09EKo=; b=L9l6WgOmgm6VnseHYqhBp74pn4d
	k1mxDB9Pfsaa2pj5E///GeblD+rJEedqBzPkJzbWmC7sZm8PCyJWJk/EouKallZp
	yP42Lfa2x+ySFSA+F2uFhPi2CHfIp2/jaVA6jzjSF3lhWgoJECCjril9dXS+KAAn
	8Sz41nx1aFyOiArHoMYQ1KWzpJtaii3obDMFlWMMZFSDtkGjd60RyBkiBtuSSKKc
	wrkj0hkiOO1MrhWJr874F/gvanr4GXq7PuISZ/P9MPxXFogZTNGnsVowh8iirrgF
	/r2cZanOm3WoIbzTRybpWzAnQq3gOYBL9XNfnXQYN/kZB+BFCC3ZWmB/30g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490aapph16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Thu, 11 Sep 2025 04:33:35 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24456ebed7bso5032605ad.0
        for <linux-serial@vger.kernel.org>; Wed, 10 Sep 2025 21:33:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757565214; x=1758170014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DOg+t76LDtTTfe4i4G48ZKjea2te61QR8gT2wG09EKo=;
        b=NvDxCTniHxUMNNtlcykyu2MRRrsSyBuLnK0S6UIf55kUk3xTuMI5Op0wpMgWAItfhH
         cwu3Q8XZHFBtfQYSRQ2KVLjrJhmfMQ1LrJ82Heriim3PJmVkPCewgbpfwyHUDW30hR5K
         eW2952xVufpTG+gcuQqv213vTqvWOqxfwi8u06RAX27hFbSMYewp2/aO3j3eC1C81jg9
         xar9+6UCI/wQmcXshbxLoj0ZNkLgkUpk0Rm9b14EBeVr2w4jz/Wm0zABMiyqj6hJ9U8Y
         5BY5oWOr6w7BG8lSucwJIj+UunkmIl2KXaCGLVKMm+SAMtlCK+vEIw64GhHvJXxmYtSF
         5yQw==
X-Forwarded-Encrypted: i=1; AJvYcCUct2QHY92Cl5Dw5VgYOaOgVnPPXFs8JVm/RJlQzFcvQvLqse82TM6VC03WpzERst4YmyVPk/mhAUQhNdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRzCeKA84NG9D28jnojaj3eURnlA+nJNYUfhBN5PwE63TD3jbS
	/yTpCBXuan0nZ7GxZ8+ngZ+EdgpgkqHMwX9zqel8H0S0N2FwOZj3w5cf7CokZsYrxUj9XWnd4N2
	QDwHXC8CxMTd+udMlwD4NcJBTjvNBGNYwqjwVsK60VZ9zNxoUqgZ0Ym8ndV/fg5H0LGU=
X-Gm-Gg: ASbGnct3UGjzQGPENE8tFu3p7E5gi72Wq8yD1ZssMjjb0ayMoKNnoOOdpyd/f8kcmrA
	S6f4Vw8LgVBCMH6RJeXn9n3wkii/ReSwcGlKxdgHylpwysmek4hJB5lAKp8JZPSknKbXs1XZj4F
	bsuqJu2GYz5su5zP5rPhRBfpVEM8lP0WmTZkfq6ajcsWD78LW2kVI7QAcOvBEm8h/Z0YWn4yxK0
	kzwWwbI4ypCb4MgZvsakqwuQeiQkWCcA/EBw0B30xZXD6rWpSLzub7gqNfTmUMKlLgWXfjsM/4D
	czy6mSSrunq6/bJy661BZC3R/SSc6euzatC3LPC0a0xP9lpJrinSjowWoNvI37oWdhG6d62afbA
	H
X-Received: by 2002:a17:902:d4d0:b0:25c:718:103e with SMTP id d9443c01a7336-25c07181344mr11953485ad.14.1757565214205;
        Wed, 10 Sep 2025 21:33:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPw1//ZVt+iheHquxaZ5YbXEJk3lIzvUDWdJ3kz7+gJhuLOwoAA0GVIuvq2MXtauftFCP+uA==
X-Received: by 2002:a17:902:d4d0:b0:25c:718:103e with SMTP id d9443c01a7336-25c07181344mr11953065ad.14.1757565213690;
        Wed, 10 Sep 2025 21:33:33 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3a84a46csm4323975ad.91.2025.09.10.21.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 21:33:33 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
To: andi.shyti@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, broonie@kernel.org,
        johan+linaro@kernel.org, dianders@chromium.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: [PATCH v7 4/6] i2c: qcom-geni: Load i2c qup Firmware from linux side
Date: Thu, 11 Sep 2025 10:02:54 +0530
Message-Id: <20250911043256.3523057-5-viken.dadhaniya@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250911043256.3523057-1-viken.dadhaniya@oss.qualcomm.com>
References: <20250911043256.3523057-1-viken.dadhaniya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=eMETjGp1 c=1 sm=1 tr=0 ts=68c2511f cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=9JGZuxy38fRfBSF6gCkA:9 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: Pkw3XQnrSpdjTGzn4sl1OCiPERwKR4vY
X-Proofpoint-ORIG-GUID: Pkw3XQnrSpdjTGzn4sl1OCiPERwKR4vY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAwMCBTYWx0ZWRfX55sM9OW4hGPd
 w6p0i40CBCSZ1nqzjg+w0k1amYezX3u3+SQSG3SuD2h/NJmMzpjzjNqIKtYpT2TTlr7vhfRlM9D
 JMltN8Obv8FRIy8Z8nXrYwBQqo1jANkx5t5a2+iaTtiejVLka1m+I+1EBD0YOlrNDz/+P6QoyFl
 +1o7CcMveUcHbMIMNwc5Vd6wZTwzzcArOWpYbNLaX3h5lNPRBPw/sJJcjpp7vEkax4D6mDaUmA3
 0WfgEqkMXQFNeJfp4m8qy3fS/7sofGSGh7wu9XJavPfxmzDZjQc5kctBIghLzeMi3+AGXFuQTAT
 9iW/ZOvapGipJ9+wxbAoLUno9UGmmddt/m+znq5V+rCeOVwtEHJwJNTHnBAMTh1/FxZYnkwK2n+
 n/zaDJ87
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1011 adultscore=0
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060000

Add provision to load firmware of Serial engine for I2C protocol from
Linux Execution Environment on running on APPS processor.

Acked-by: Andi Shyti <andi.shyti@kernel.org>
Co-developed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
Dependencies:

This patch depends on patch 3 of this series.

v6 -> v7:

- No change.

v6 Link: https://lore.kernel.org/all/20250822072651.510027-5-viken.dadhaniya@oss.qualcomm.com/

v5 -> v6:

- Added Acked-by tag.

v5 Link: https://lore.kernel.org/linux-i2c/20250624095102.1587580-4-viken.dadhaniya@oss.qualcomm.com/

v4 -> v5:

- Updated the email domain from 'quic' to 'oss'.

v4 Link: https://lore.kernel.org/all/20250503111029.3583807-4-quic_vdadhani@quicinc.com/

v3 - >v4:

- Add a patch dependency note.

v3 Link: https://lore.kernel.org/linux-arm-msm/20250303124349.3474185-8-quic_vdadhani@quicinc.com/

v2 -> v3:

- Load firmware only if the protocol is invalid.

v2 Link: https://lore.kernel.org/linux-arm-msm/20250124105309.295769-7-quic_vdadhani@quicinc.com/

v1 -> v2:

- No change.

v1 Link: https://lore.kernel.org/linux-arm-msm/20241204150326.1470749-6-quic_vdadhani@quicinc.com/
---
---
 drivers/i2c/busses/i2c-qcom-geni.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index ff2289b52c84..95a577764d5c 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -870,7 +870,13 @@ static int geni_i2c_probe(struct platform_device *pdev)
 		goto err_clk;
 	}
 	proto = geni_se_read_proto(&gi2c->se);
-	if (proto != GENI_SE_I2C) {
+	if (proto == GENI_SE_INVALID_PROTO) {
+		ret = geni_load_se_firmware(&gi2c->se, GENI_SE_I2C);
+		if (ret) {
+			dev_err_probe(dev, ret, "i2c firmware load failed ret: %d\n", ret);
+			goto err_resources;
+		}
+	} else if (proto != GENI_SE_I2C) {
 		ret = dev_err_probe(dev, -ENXIO, "Invalid proto %d\n", proto);
 		goto err_resources;
 	}
-- 
2.34.1


