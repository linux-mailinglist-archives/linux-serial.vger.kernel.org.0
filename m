Return-Path: <linux-serial+bounces-12824-lists+linux-serial=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-serial@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJ+1L2VzpWkNBgYAu9opvQ
	(envelope-from <linux-serial+bounces-12824-lists+linux-serial=lfdr.de@vger.kernel.org>)
	for <lists+linux-serial@lfdr.de>; Mon, 02 Mar 2026 12:24:21 +0100
X-Original-To: lists+linux-serial@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF8F1D76AD
	for <lists+linux-serial@lfdr.de>; Mon, 02 Mar 2026 12:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FD0A306160D
	for <lists+linux-serial@lfdr.de>; Mon,  2 Mar 2026 11:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E4F36308F;
	Mon,  2 Mar 2026 11:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="hA/l9mY9"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACBF3624D2
	for <linux-serial@vger.kernel.org>; Mon,  2 Mar 2026 11:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772450529; cv=none; b=IwAaSbKhvqLrqPiWzCdW94HHAmEVwdMlihY/86dbFjB0TBspaVl/3vBcY2x2sQCEyPR19JxXfnQnqWEcVOOQAOssNlLB7NmNMq722T8MeycZS/oxESbqxYna9mRm7PkSfG142RO3F892Xn+bFtrSyi4lBr18XUmjG/pnGf4M9IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772450529; c=relaxed/simple;
	bh=to/yxjGiw472A4w/ZG9L65B9irkFq8+kpamX0PwYXGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s6EooMvIQYYzSKiVfDTj/BPJ9+hJoJMoiGZ9Z0Rp8ElCoJIAekLj0BEGEh7HhJRnjLMkL64a8vEBoh6ur0BqSIJMz3PhG4FYN3IX37gE69kw4eGiwBCYiXW2+gN5+CxHGFVdMvEAuq8bs7pjZRJ9ONkxHP7cfb6jSVn3Fhx6RV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=hA/l9mY9; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48371bb515eso66268935e9.1
        for <linux-serial@vger.kernel.org>; Mon, 02 Mar 2026 03:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1772450526; x=1773055326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QOxR18o2+9ulYS4r73qXsZYgHJUpIGAEfbN7mi92aLE=;
        b=hA/l9mY9+sPJtrOeUv4fy4/o0mHnE5p/ulkXMbzB6jYdBNjEkROdCVi0Mx1p0bxAUS
         4GGvk/wlxvYP3/Ym6XEZYzGwN5ez0E27/AcIDCOay/KA/9uWJZuyTiwX56cGiHulakdE
         arZSRh//NnI0479BIEXTbiwYUUcagWai2wW0+F0baQgCwAeeSIO8yonEl/FAkmejimVh
         ljQqCJ+spXhLAyky3GTJNfaYhs+kjSEvbnv3KqfTKn1xxmu22yJAiF98/JoJDmUzHZoc
         MOV2CNLkorlzlvb0OALEa5nReobkDHldQoRpEiDBhNn3Dhd60XlyBVgRSbVWkFg/Dkhr
         Fixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772450526; x=1773055326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QOxR18o2+9ulYS4r73qXsZYgHJUpIGAEfbN7mi92aLE=;
        b=B4hxnJS+Tbovg3I3dgK+ZHz/PtO5nfBqWxCpkM4Y8pBcBAKjGPQ9yW6yVVgm0kywvk
         gcv6HUS/uT0l9oPPNFkfkTc8uOtgUYSxhU5cdQOp3idIIT6prEN30vQmrZqi8UwiE2jw
         Ah7gOWHeausaTee2UU3datoJowNWu3uV2FwzELn+d5TkhHCrGBwMipcSdCM9VSQy682/
         N+eTvRD0S9QAv48c//1Y9ZHRyTi8RNtfF++RaRgHRztTvH5rShsHjPEPbgyvizDkleVY
         Anwv8uXLi5vRqc68rACruGPuTqaciB17+pik0yHTcMHtsgutLZdbxYl/GqIoG3Uh24H2
         po8w==
X-Forwarded-Encrypted: i=1; AJvYcCXW37rD1mBb1Rc6JH+iexDXcX6VdPhnbd7JK3dckVks4twXqTKk2v5nBb+6gBqi+a4xuTHB4nNOQqWvpEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaJkLt9DE8LdaBM4AjF/TL7ypd89LhaOGuaOObVj54OVMJVxZb
	hFEnA2tWpiRrJonS7hYBGhGCd9k/FwWLBiJm2bpEDQNyWzDaMQUPlQKtXQmQAoyHDHA=
X-Gm-Gg: ATEYQzzAvYkwYF7LlH0CykSjf4roSHbXpAVsOH7Juzrz4OstCjRF0c7k7xV8smGq15+
	VbDN7YX6GY3Oc3kn8gBDPIuLAng2HSPJip+C/uZi82G7cDuDc9OhDApVH9zIUSN+cuujm3cm/Cg
	xpPL6O8Esm4TCnv2368AiOcKYBYTy0s12ifMdhG1remlU9rIVeJO9QUVdrqP81Zy83nPnSiG0kY
	dmp7oImMdfoL88rmzNFU5OqMhN1KeE4D2s8H/7LFD0EvvjWjCuTuT2lrmxk2LBNa3c7rEJoVGNl
	4DMXoaJ/yBsekAUkMrQbUXdiNtVhe/9jQtuW+TMcvlA8F+jZ87jo/ETq+afqMDzUkNsih6fCXko
	a8ZvXPSf2b1agXItlsoq9HRaZb8vAs9i9o4DfRcKE4KyPnW/xwX0C23g0UslvR0U1BMQw+QqqtK
	8wQiXDvuyXow2YL2+Bbhtf9h1AIAwO+DHsV6NwQwTHtflSVFkK/IC2MTkie2x+JVVX8lgUbmGb3
	D6CNFr9z36Z9MYQ7PxFkjkqulAFDPG1MlH5MkvLC9E=
X-Received: by 2002:a05:600c:8b53:b0:47e:e91d:73c0 with SMTP id 5b1f17b1804b1-483c9c0bce5mr211979425e9.19.1772450525627;
        Mon, 02 Mar 2026 03:22:05 -0800 (PST)
Received: from fedora (cpe-109-60-83-135.zg3.cable.xnet.hr. [109.60.83.135])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-483bfbb465bsm292493035e9.3.2026.03.02.03.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 03:22:05 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	olivia@selenic.com,
	herbert@gondor.apana.org.au,
	radu_nicolae.pirea@upb.ro,
	richard.genoud@bootlin.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	horatiu.vultur@microchip.com,
	Ryan.Wanner@microchip.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	daniel.machon@microchip.com
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v6 2/6] dt-bindings: rng: atmel,at91-trng: add microchip,lan9691-trng
Date: Mon,  2 Mar 2026 12:20:10 +0100
Message-ID: <20260302112153.464422-3-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302112153.464422-1-robert.marko@sartura.hr>
References: <20260302112153.464422-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sartura.hr,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sartura.hr:s=sartura];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12824-lists,linux-serial=lfdr.de];
	DKIM_TRACE(0.00)[sartura.hr:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robert.marko@sartura.hr,linux-serial@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-serial,dt];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,microchip.com:email,sartura.hr:mid,sartura.hr:dkim,sartura.hr:email,tuxon.dev:email]
X-Rspamd-Queue-Id: 2EF8F1D76AD
X-Rspamd-Action: no action

Document Microchip LAN969X TRNG compatible.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
Changes in v5:
* Pick Reviewed-by from Claudiu

Changes in v3:
* Pick Acked-by from Conor

 Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml b/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml
index f78614100ea8..3628251b8c51 100644
--- a/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml
+++ b/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml
@@ -19,6 +19,7 @@ properties:
           - microchip,sam9x60-trng
       - items:
           - enum:
+              - microchip,lan9691-trng
               - microchip,sama7g5-trng
           - const: atmel,at91sam9g45-trng
       - items:
-- 
2.53.0


