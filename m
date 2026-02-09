Return-Path: <linux-serial+bounces-12676-lists+linux-serial=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-serial@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKf2C5NdimkWJwAAu9opvQ
	(envelope-from <linux-serial+bounces-12676-lists+linux-serial=lfdr.de@vger.kernel.org>)
	for <lists+linux-serial@lfdr.de>; Mon, 09 Feb 2026 23:20:03 +0100
X-Original-To: lists+linux-serial@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 928D5115061
	for <lists+linux-serial@lfdr.de>; Mon, 09 Feb 2026 23:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5543A303CC01
	for <lists+linux-serial@lfdr.de>; Mon,  9 Feb 2026 22:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248A530FC11;
	Mon,  9 Feb 2026 22:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="gPJT5lg/"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA023081D2
	for <linux-serial@vger.kernel.org>; Mon,  9 Feb 2026 22:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770675413; cv=pass; b=UkcxrWbrXzKG3m4t8jpCjKn3IwQFiVapacI5ygM+u46wJJguJf6HOuyIt8Gqsk7FzMilrGqCyBNcMFfc+ttp+dnan+Rue/+/Vmr8wYqmee1ppAV3om3yI3lFGMYo/7Wybagvh77NzTakDy26dwCNm2WPmj37hoIDSycNoCcoLo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770675413; c=relaxed/simple;
	bh=vZNWuHTz1b4dbqUo0JhBGtJ3efYqVaRB651Yqhx+M9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nnUTzP3F3mZug37WeWc+u//eRZKiCAC6JyX6Omt+SZmecrBtP+587HbB06AGmbIkHI+5gIvyJ0Pq6gxBbVc+nuLirsZLiWPNyO/43du3dARoW2DJKYnlZjN374F7UbHIhAxsrYJ2C4ZrWYa0p9uOQvJK+f/Y1Rd2I3taCex61Jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=gPJT5lg/; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a929245b6aso30176225ad.0
        for <linux-serial@vger.kernel.org>; Mon, 09 Feb 2026 14:16:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770675411; cv=none;
        d=google.com; s=arc-20240605;
        b=HwIaKpUcDFKtyS3hQ9hG0BSZflpNp3BuQ2hyNfzuYKiCud5Y0E8wHp1lQEPQbXTMK4
         w1sbsnlGTMflHhe9DiSWu7dDxKFHLTdEE6MEOMngtgY34E4XQmD4qP/SCWPdkFaQxpbz
         KXdP07Zu6Tgy369XVsVmUmUmxzDtX7BWKz1kqDtqffB4OqqrASo8yfcGy2ImYyS47OdG
         MEKgB5Sr1fgq0VcisCdl4ABtsmIT4YBYcw6agWEL6dGU308EAa1qhXUDvQSZb/Et5HgE
         87gTmCng/vEKqFy7L30sw/AzwCTvm5LNwk0Y2zA26T3fVPEsohQPok6DqES/FfS6E8Sd
         W2fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vZNWuHTz1b4dbqUo0JhBGtJ3efYqVaRB651Yqhx+M9I=;
        fh=slwF98KjxHoNk2kUJwnkAfkivb6GCE3ZPo/4PejIy2g=;
        b=fVOGrrlTto/LwYWkOL2bXrCeiNBORer9yh7CMwtjNQY7bg6WABklzYrK+DMfNHkg7g
         I5nxOHRSaEq+7vIZLsmkcwevZsSGXMibpH188G5Q8B7jf2hZ3qMMy+EJtS1HgzChTPcE
         GqCPVj7WXGIl9ynfyMzEbLsHjLitGdsM45C3xRXrclByPEpNmGs3ThvGDWw7Iay43DCF
         eXH/PTluCHsevL5KAxRUDmthNmgtbmcz83OIY0bOw7FJWnIKSpr9P4hUjW1+O/tzrSoW
         pgjbh7JYzaCmU7YHKNmOunilVqRjkdG9lCqVWo7Xdvs8ROWlnWQjIClcFqOGXHV7DLwL
         aqHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1770675411; x=1771280211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZNWuHTz1b4dbqUo0JhBGtJ3efYqVaRB651Yqhx+M9I=;
        b=gPJT5lg/k/GgXqvbN/qi+RX5OOjcMA+VCgtygBw82eKVaSIpWAfJGXOWVJ7GncXmxn
         kq+l5Z2j7f7riXjt9V3L1Rsw7cud0FM8sJ0sQP286AXObKhPTWxs2Jf2PFZc6vZvhsbI
         N+hggCvYzH2zigd8LcbusLV2kR25e5m9RI1KfKDzTzpdX2ajym2X5/PcqU6DvNJtUV2Q
         7LmZOuUsoyd3zC01ZlakA+zNYwTMhgLCpnwgy88nwtmFTA6ciP5PI6Pq9ib//zn961AX
         2F40/yEauf5XoO02X5u6hlM8ZvmsvG6shG+WFCJjvEWucCSk85WILPHKjwFaSoPqn0ub
         gNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770675411; x=1771280211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vZNWuHTz1b4dbqUo0JhBGtJ3efYqVaRB651Yqhx+M9I=;
        b=ADLoVmAVAhvlI44ufAK8bWouce6ETJaCIFpbhQTLtyPRcHz3suuXi5ItghVBtJM+1G
         hqv9Im57Q1/APvNDOGnN9Uk3dRFWxNdOFLO08fDlqxnhkiJjMS1C1EZYncrFOa1sMPr3
         qGGnWIfJvf8GrqpQCqPm4MZGNmllpcg9kClrYUKU/tRZVji95SGy/MbBGCVr0oOinWZB
         mtJIpv2fepDOW3m0X7EyHTXql6C9k+legdDByLZ5BjjYVvyVNZ1ktp8Q/IFuPFBlsFLP
         HIMKejv0UEPOmsZwVU3jviPCuuObkpExA3CgJQwh0rF6jZ22WKYBrOqtor8kjb6VTz95
         GALQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUPQjUdMQAU03aObl9h5YFp2zimSOeO/tT7Rxly0yVxVUAnhUMtLVgYxsPgc46wLYRwjNSGLboVb2MBjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHXgzHs7KEc+8hFrqflxI75BwlziJ9WYa9GEqwT0kb0r4y2Nzo
	jY4ErQ17861ValZ/djUX7rasPajvFjm5DyMN+tzg1EuMBouj4gnjarenj9aZqkhI+aTadV24Qie
	KL3tvTxQZlLlQj/8lQPwH5vo5lqGvOEE=
X-Gm-Gg: AZuq6aKk6Y2p7Dsgvk0oa44gN27kTICf7otOE0lqV/bxA2UNVUUPQmB6dpzcTK5te/d
	RmA2vessRUbbfsm7i86I3l3FE/k5r/MQkpXZ3gpkAEBlYnvf21oxuhpcomRG7GDDi/JFhpj4UXm
	JZaI6235cIaMiL2GEy0HgEg1adJLjDZ3sa6RnJPnFQt6z/r4TYLKL7EW4off8mLBgTHEQXvKANy
	VhLyxsGNV3jrDvT4llzyvWuQYE7mrWLMojOwZTNhHuvYCRBVa8OQ041GQqG85RTtUXkEcZqTCTv
	uQoIuzEAE0ZzuT+/MEkgvYe7R0SM
X-Received: by 2002:a17:903:1b24:b0:2a9:62ce:1c12 with SMTP id
 d9443c01a7336-2a962ce2047mr97146675ad.53.1770675411337; Mon, 09 Feb 2026
 14:16:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205-a9-baisc-dts-v1-0-1212b46f95a7@amlogic.com> <20260205-a9-baisc-dts-v1-1-1212b46f95a7@amlogic.com>
In-Reply-To: <20260205-a9-baisc-dts-v1-1-1212b46f95a7@amlogic.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Mon, 9 Feb 2026 23:16:40 +0100
X-Gm-Features: AZwV_QhquR0hlfJ-1NnFo_9al9F-KxCRrVsi-UMsb1efCpkm7v4Q1O8T8O58qzI
Message-ID: <CAFBinCBMQNrFdAdhoxPCfJi-SU1kdhovmaJ6K9WwEQuiMfhQ-g@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: arm: amlogic: add A311Y3 support
To: xianwei.zhao@amlogic.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[gmail.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[googlemail.com];
	TAGGED_FROM(0.00)[bounces-12676-lists,linux-serial=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martinblumenstingl@gmail.com,linux-serial@vger.kernel.org];
	DKIM_TRACE(0.00)[googlemail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-serial,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,amlogic.com:email,googlemail.com:dkim]
X-Rspamd-Queue-Id: 928D5115061
X-Rspamd-Action: no action

On Thu, Feb 5, 2026 at 7:04=E2=80=AFAM Xianwei Zhao via B4 Relay
<devnull+xianwei.zhao.amlogic.com@kernel.org> wrote:
>
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>
> Add bindings for the Amlogic BY401 board, using A311Y3 Soc from
> Amlogic A9 family chip.
>
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

