Return-Path: <linux-serial+bounces-12559-lists+linux-serial=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-serial@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNpxNVoceWmPvQEAu9opvQ
	(envelope-from <linux-serial+bounces-12559-lists+linux-serial=lfdr.de@vger.kernel.org>)
	for <lists+linux-serial@lfdr.de>; Tue, 27 Jan 2026 21:13:14 +0100
X-Original-To: lists+linux-serial@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 145CE9A42A
	for <lists+linux-serial@lfdr.de>; Tue, 27 Jan 2026 21:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF1313019513
	for <lists+linux-serial@lfdr.de>; Tue, 27 Jan 2026 20:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FC332721D;
	Tue, 27 Jan 2026 20:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Q0dtVsDA"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B18625
	for <linux-serial@vger.kernel.org>; Tue, 27 Jan 2026 20:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769544791; cv=none; b=azwtcKVs8xaTcJ3kP1+ZFt5HyvrsdIAAIphA2M0OoCptCygKnHqx2aI8PDMb70anLJ4qrbP3BXmdTkUmtk4OSTrcBKTy/X89ENjj4IcBYgH4Tt/c3C3Ex7qstjWMWtrlsMI8OX1DrdJd1CKgu+ANvMuuX8B7hqEQCj5Pbyd/9Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769544791; c=relaxed/simple;
	bh=IYa4gzKcTqYnhir/bviw2BDALYF8BbbyFzNBvwXRIsg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uObro6yAqIpF7Zw4M3cg9jDwisAOpRl8NjpCQ+Lgnw4bjuVv5LXAQJJDvwcpEr4i/OnYc4HKsRHjoB38NaB5/hdV2rXt/yS2o2Mj4hvHkb4tZkKGUcEss1kzbd+3cZuVZDMQ0tAwfglbU6wGq/CwYRsGmZPHMcHHF7j9TFcL3xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Q0dtVsDA; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a7786d7895so40752745ad.1
        for <linux-serial@vger.kernel.org>; Tue, 27 Jan 2026 12:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769544789; x=1770149589; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=IYa4gzKcTqYnhir/bviw2BDALYF8BbbyFzNBvwXRIsg=;
        b=Q0dtVsDAeos3XKA6Jr4NFDlLKe+QTTYXsAk9MCOlrSdcn0qW3GOk9W9il7Du0OOJ2i
         b5iliFdFjJ72AueCx7tpYHZdW1R8/iD54/7tNcM0nkJduQtMC6jeo4EwSSE0P6N0VbPN
         RoE2gak/Pe0uOCYxqGn/m4Axwq/gZLY99PoJalc4LnB/ZdswT8zFSxtGLORQwGcrRPj7
         OMKWd2FjmsDExiLIkrVUZkXNUfHbkLWIIyHa1ynxcKemg07xpPdSV8EYFz+eoWEfoxxG
         6XjM86IxhpktyLox6I9cFy1B8US9IVGe3rJo3UItG4J7OJboe+e+wmoWK1WT+gLRZCKg
         OI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769544789; x=1770149589;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IYa4gzKcTqYnhir/bviw2BDALYF8BbbyFzNBvwXRIsg=;
        b=jkNxbmTb6lNWqsS5utzA6TH3yePRaPrB3PrQjZ+sy6bJhjS9jiGudUm1zJ+VPEat0L
         I8Eki4f8qGCmfz5U+74Vp8kByxv8Gd6XurlJWhcvLjVFAhycGdYZNNpRhkEs3pboyy1E
         68+4hyFH/VCGWvuw8KBTG/enBf2LSaKiYzZgITXt4Gzrqokbj6+7nMqBag+j/vPkRmuT
         B+cmhwKap+YhLQ3qQF+o1aCTRN4tsdSzEh99/6CGsH9/XHFXvTwAGjxDW0E+vEDM2HuV
         ZCqbaXBG0tV1cAT0+CGklFU+ft+8aX9C6ksGa1r1NZTH+4h7jBfgOodPnsETNrBdRWte
         CVvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXP0rXlrr5Wn9FDJRitfE06US6FDHDSDXCM+PvCVoIpOs5Zib2CqM0nZwaMGaWmjUvO+/c3H7IlrcDHuEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbQhLrEpWXfDazCFMSbS3KISktaouc4aHJi1I1bjHb9DmeaPSq
	5SGJGDQDDfgL57IyGOOwstVdCCeVJLUCX15JZx4NdYOShyHB5o5IK7XpVFL9bTDYdsOqT8NbAdp
	nJ8SXrbE=
X-Gm-Gg: AZuq6aLh1HRSjjltFq+H6pYLiiDmUWIFqRAdvYgV2kBbifE/IqzO1C/mEpb+oWGricn
	lavohWygrRchBnabmPoKiTg4hkbHp9hL8gfoJzuUuAJGV1kzJwZFHCzpRLyzOOw4BD25p0lifrl
	QLdjhFL0d+p2LFvcuuFE8uqCP2Y+FtK8zwxohOpxWOXAhFW6u2wHQibVkgBoUuuJPx3gGaemhcm
	2+ZmC/eyPJ6gDChhh7SEytBKK82ZvXSeu04wMy2D/r9littk2rMOZdVMKhHEEo4+DWrRcvZHPOt
	7t0mBLHHdrlvfEwcd9JeRIgvzkZr50q0wnWl9/AVOWbXAxfxJ4xMWkLwtmjiJ0mfSe5frnHVQqO
	xLf/FJNEDV+vmSfkSU59sOFXu8LwO9lYisG3CUrjacjkM2uAWo1oxUQk8RKJs5/duJvzHbjPbyR
	HobJhQeA9o
X-Received: by 2002:a17:903:1b0d:b0:2a7:7c66:f3d1 with SMTP id d9443c01a7336-2a870d78e73mr31913995ad.26.1769544788698;
        Tue, 27 Jan 2026 12:13:08 -0800 (PST)
Received: from localhost ([71.212.200.220])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b414f7csm1854295ad.35.2026.01.27.12.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 12:13:08 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Kendall Willis <k-willis@ti.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
Cc: d-gole@ti.com, vishalm@ti.com, sebin.francis@ti.com, msp@baylibre.com,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Kendall Willis
 <k-willis@ti.com>
Subject: Re: [PATCH v2] serial: 8250: omap: set out-of-band wakeup if wakeup
 pinctrl exists
In-Reply-To: <20260116-uart-wakeup-v2-1-0078ae9996e4@ti.com>
References: <20260116-uart-wakeup-v2-1-0078ae9996e4@ti.com>
Date: Tue, 27 Jan 2026 12:13:07 -0800
Message-ID: <7hecna6ch8.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-12559-lists,linux-serial=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[khilman@baylibre.com,linux-serial@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-serial];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 145CE9A42A
X-Rspamd-Action: no action

Kendall Willis <k-willis@ti.com> writes:

> In TI K3 SoCs, I/O daisy chaining is used to allow wakeup from UART when the
> UART controller is off. Set UART device as wakeup capable using out-of-band
> wakeup if the 'wakeup' pinctrl state exists and the device may wakeup.
>
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
> Signed-off-by: Kendall Willis <k-willis@ti.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

