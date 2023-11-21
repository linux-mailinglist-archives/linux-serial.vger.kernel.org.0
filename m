Return-Path: <linux-serial+bounces-7-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0467F24E6
	for <lists+linux-serial@lfdr.de>; Tue, 21 Nov 2023 05:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F5141C21083
	for <lists+linux-serial@lfdr.de>; Tue, 21 Nov 2023 04:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0495580F;
	Tue, 21 Nov 2023 04:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpCbXpl3"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B522FDC;
	Mon, 20 Nov 2023 20:46:10 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-507a3b8b113so7325103e87.0;
        Mon, 20 Nov 2023 20:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700541969; x=1701146769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=caEKODLYD8G56ZBu+Ji81b5D6XsHS3BHDDu1vj7HIIk=;
        b=FpCbXpl3Ny9Cd9b7d7Nxx2gUr0n3BrVd+SguUUkA+9kkZ02/8P6abmxGPD+GQgNoZ0
         cvUjjSVePg5EP8mLv2+sWxAM6Muf4yJb3s2unEVZm7fkr47kikS7Um5DUlTvkdMvMGal
         EK/IiBcjKv4NNWCNh7l1scX3Pcs8dVBQtgF4hzxvTizWIh+katcE42s+Hi+kWcUXftZ8
         erDYk/PCJl/QUqrl3OLLoprZrb0tbPBCPY36xTbH2IYx43TIgvKPnUOnDvW+8bfc59qm
         h/+hGTj9RFKZX3oOtIfvr1fRD0JlxfgF3zIXpMOASHGA8e7JNS5cIVCsc+OAHoSDXbAp
         03cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700541969; x=1701146769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=caEKODLYD8G56ZBu+Ji81b5D6XsHS3BHDDu1vj7HIIk=;
        b=bFxxNNYIK2rz82US8sH9Mky+iMmR2M2hKKdfetQa7xVRjhoWDhN8XIBrJ/EQnNv8O/
         OOrqD7KanAri6y1i1dB9znyT+xalbIvR9M9mj6f0Lda1a8hYdWhx1RyFIOEwx1zo6Gmj
         cr081OR+uc7GMlJgBVgH/zJK1MgZxx6HVs7c9QyETEpj/sh/F9GXpybP2QpFo4XCDoHT
         f7nG9Gmod449Yia5GzFc9/NJwxF0e1XrsTxD2hpY4CExWw3PLnRLw/DqnmdgHUisKaIM
         ksXWVeekwUxEXG947k9Q+5GtTzddKtA3LDWeYzUhXnd5RCbxzVGX58ZdXvkUy/6v/Uro
         55OA==
X-Gm-Message-State: AOJu0YyhTXesSLy5ddYRBebKrpsJUvSBBgQCr9CWREiRh2L0jj0MpXH5
	4lKObCn1xJxL6WbzO9LIdn/AVnfXDhaDT0cacAs=
X-Google-Smtp-Source: AGHT+IE8RnabTJxxdEhNU0aOmrkKMzryDkJQy163sLFdLj3j2itVGDLUp8RoRvYMJ/E3cYf9Lr2i6uguoD1OIvOodkY=
X-Received: by 2002:ac2:43a5:0:b0:501:c406:c296 with SMTP id
 t5-20020ac243a5000000b00501c406c296mr6562165lfl.31.1700541968641; Mon, 20 Nov
 2023 20:46:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231106152428.3641883-1-sean.anderson@seco.com>
In-Reply-To: <20231106152428.3641883-1-sean.anderson@seco.com>
From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Date: Tue, 21 Nov 2023 10:15:56 +0530
Message-ID: <CAKfKVtEqNn77K5JwOmc5B3+-fj0P0LtjcpUpN03hht7Pj75zYw@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: uartlite: Document uartlite_data in
 kernel-doc style
To: Sean Anderson <sean.anderson@seco.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Korsgaard <jacmet@sunsite.dk>, kernel test robot <yujie.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 6, 2023 at 8:55=E2=80=AFPM Sean Anderson <sean.anderson@seco.co=
m> wrote:
>
> Use @ and - to conform with kernel-doc style.
>
> Reported-by: kernel test robot <yujie.liu@intel.com>
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>

Reviewed-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>

