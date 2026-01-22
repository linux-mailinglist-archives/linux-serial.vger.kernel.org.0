Return-Path: <linux-serial+bounces-12492-lists+linux-serial=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-serial@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UN0vL+lscWkPHAAAu9opvQ
	(envelope-from <linux-serial+bounces-12492-lists+linux-serial=lfdr.de@vger.kernel.org>)
	for <lists+linux-serial@lfdr.de>; Thu, 22 Jan 2026 01:18:49 +0100
X-Original-To: lists+linux-serial@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFAA5FDF8
	for <lists+linux-serial@lfdr.de>; Thu, 22 Jan 2026 01:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DA429369E74
	for <lists+linux-serial@lfdr.de>; Thu, 22 Jan 2026 00:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38FB27CCF2;
	Thu, 22 Jan 2026 00:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+lJX4yZ"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4791127EC80
	for <linux-serial@vger.kernel.org>; Thu, 22 Jan 2026 00:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769041122; cv=none; b=Lz08CcRHFpZ2IIXBVkccUYWnDVfqyacIHCVmj40KHe1dWzP2hVB00Ru9R20nBVQa2H2we1Ms3bTSfzkLTqitgKrTvRqy5SAEsC+CJm6l11bjBBAgOo1yco984chMgSPcQNcFoqhAy+O8r1SYodfvMHrfME6vmLlyNiD0ZG3Emco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769041122; c=relaxed/simple;
	bh=iuzvtx9kOTb0huJ+lhAz1IToNhc/QNH+QeLzaFIfu9I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SGyWLMso1t9m2mEZWM48OR+fmeJEPktFnOBp6mDJ2FdIY1xD1UJBo6dlQbh0xJtItHJQYpzNW0vrLAT862xs/6trCzu0TMkvyRCgRGeJKYVaXNplFl2GEW09b1kqLmXfek6bP511BjfUD1paQ7CiQSQ9XVm51ZLjoxus9IEUX0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+lJX4yZ; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c6113524690so115660a12.1
        for <linux-serial@vger.kernel.org>; Wed, 21 Jan 2026 16:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769041120; x=1769645920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iuzvtx9kOTb0huJ+lhAz1IToNhc/QNH+QeLzaFIfu9I=;
        b=Y+lJX4yZgkHOn5NTuzPRvCPx9tPJ4UYzrnxqABD70WkyPQXSCxcT/qjf3zfXoSiufg
         71h7MT6UhsR1KpMIyzmMzVKnkYsY/ZibVe6+jFK4Ncscw78twuaeawkmEJGNsUfyrkI0
         XhATmln2n+TXNGt6DI5IeRHyfjOKb3EMTPTnOCYSP8YlrPRktrOx3m613Qap6MELNS8t
         8wriY8392Z7jvc2h+a7byPhegajhLyj5exRfsTxruUnisH4vQ/MYJW028uWZIoAh9Jjd
         n+v7FHY8oLdECXgrgpF5aD3y+X7cZNxD6cbbUMP1CupAoX4WmPOpzdxnVcutpuHBeUEn
         MA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769041120; x=1769645920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iuzvtx9kOTb0huJ+lhAz1IToNhc/QNH+QeLzaFIfu9I=;
        b=SXsvtPMjQbJL1kTgqsP3jElNYpsQYQiYqTsO0LO/SE15mq/ntLDQ87m6ENZwfhT2wm
         zsIfF3w5o3zAEwPbU1xoQvoiwyCB9I2lBp5iUAo9iNn/A/1z9ak29yzMjLnGcHerL72N
         TUeonhrCjYmq9LwHh0mne26RAF5CNWN9C3WUy0sm3J5tah4fo+oFoGdxoeYbQrehhu1f
         tP1zmuxkq2ZO9nQWGN4iDXISj+uNOEa3fQ2W7AVxLb31SdFFZb7krBtegmzgFiVr9y+J
         cXQkyH9/70xNgO1WguVeTLmF9seoWBzaYF1xyhPIgTvikm2vYOBjnfyfR2mpA+RUHa5t
         SIGA==
X-Forwarded-Encrypted: i=1; AJvYcCXNeLMpn2LBCuld6A31pvOPB0QW15OA0Vyc95JEPjiOhr8mFmo7gORegwBIem+wpSzRJ5Ukfv+H+FaQuOE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+sG1gvPThmVBs0/jKQdx4CWMXmunMdEru4rADQs7u8Pfoo+zv
	vAw8SCSdaKBEhflRhA9Xa55RtA/OwVQtRJL9kL0+t3SyDWJsZny4scIB
X-Gm-Gg: AZuq6aKeXltnDkdrF5H3Gs9C0xgJxtC/UYYa65T+HeCVPdFNryU2/aO9XmnyVWnRsCv
	mUx9jqFe7pWr4UUMTHEdOLtjyaf55p5aiPmsg6hu3LoBCo6qAEtGWove3CC66SvY54lrK8O9xi7
	4JRMqcGI3FTWTdlwBde+NNxNsTq/lpgmgFS+4Yyfqr+sbgOlYc3U6ac2MXHEL940MKcB340+RZa
	2d2UwjrhL++akSeogqgwu65xf2rVfLwW2rnNkOLkXbwextszmoE5Xj8aV7E2zFwb7gmh02dFUOt
	ne0EHQAobLjru4ktI6ppPwZfl3Yldx78DES61wZKMVb7fHamx2853tcpUdKihPnmUhvjVa0RSst
	Wpv0L/4KrohNcd7qPdWR6Nv9O/+1yE9cT8Vmxnc4c7RSDvfm9cDkwh0eA75jcz/XnPrfhNv4tWZ
	QwwnCEEvkZszOC2vrhQUY=
X-Received: by 2002:a17:903:1746:b0:2a7:a5b3:bf4f with SMTP id d9443c01a7336-2a7a5b3c0fcmr33705195ad.34.1769041120499;
        Wed, 21 Jan 2026 16:18:40 -0800 (PST)
Received: from localhost.localdomain ([58.29.79.238])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a71941c56bsm166270735ad.92.2026.01.21.16.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 16:18:40 -0800 (PST)
From: Lee Yongjun <jun85566@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] serial: 8250_pci: Fix uninitialized variable use in pci_oxsemi_tornado_get_divisor
Date: Thu, 22 Jan 2026 09:18:17 +0900
Message-Id: <20260122001817.53355-1-jun85566@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2026012141-arrival-mounted-0d49@gregkh>
References: <2026012141-arrival-mounted-0d49@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-12492-lists,linux-serial=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_NEQ_ENVFROM(0.00)[jun85566@gmail.com,linux-serial@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-serial];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6BFAA5FDF8
X-Rspamd-Action: no action

Hi Greg,

Thanks for the clarification.

I agree that this case cannot occur in practice and the current code is
fine as-is. I will drop this patch.

Thanks,

Lee Yongjun

Hi Greg,

Thanks for the clarification.

I agree that this case cannot occur in practice and the current code is
fine as-is. I will drop this patch.

Thanks,

Lee Yongjun

