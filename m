Return-Path: <linux-serial+bounces-206-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 007997F7470
	for <lists+linux-serial@lfdr.de>; Fri, 24 Nov 2023 13:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFA22281D4D
	for <lists+linux-serial@lfdr.de>; Fri, 24 Nov 2023 12:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B7B24218;
	Fri, 24 Nov 2023 12:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jo5utnEH"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0AA193;
	Fri, 24 Nov 2023 04:58:31 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2809748bdb0so403836a91.0;
        Fri, 24 Nov 2023 04:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700830711; x=1701435511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75yoMjRCfMCs1tFne3RBs4pKvNnXjN/9OD4+CQf96SM=;
        b=jo5utnEHo4+rRRehxqXwFhlKIt9YytSb1vHZ5Ioya40T6LbHf9FKZftlDzv8rFy8+M
         jiKgmizf/MzjG0rgGPnM+82mgvYFJcQ4jNGbCL+Wab3Wr5Ieec3EcWehxcWK5SEODryT
         3ufVTNcMfhi/TzZmrnHELGSw5XpKlFCbVrzDYnn/VM9sETuz9h0OLMOS+67YwUm32h3h
         gKWfGiMeBRBOW8RxMhFKpJBDvGewPowyg/SqAiQw2lChH2qtMkh1iE5nEdqREzB5XS5+
         MpMHwlc1dbvm5sSraSj77bmoH2oxica9ttTECXIO5nl5eaPOVT9RuZI0A3hj1omcchUi
         hSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700830711; x=1701435511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=75yoMjRCfMCs1tFne3RBs4pKvNnXjN/9OD4+CQf96SM=;
        b=kMLFXkUtIpi6uhm1CSMCDBvXM7XJfmgOyijF7A61SV58+/5JsWf5r4aL5IJzwD+unP
         XfDlhztNItdY5LXarzoSyqkUVuK9WdYEo0JDlwH6Zvhye5+NY2M2o+kyOq3rQP7RY/n3
         fVASxfOmAjSRnTVGv7TEitbK0x0HYo+7nCuNamgXgwVvAvihqhQyIJKBXgLTKtX1jD4s
         iF+9km0NhXnV/IaMbyUBwNIXhCucNWlAMEgPQqoHq0mQLObNyA+lRIuft7Rk2LFIq62F
         KbJvmfjbIGUZ8jr72DGIkPbQgF3szRSdv8LDlliNo4A5jEFv0JOz3JzQMG6mpteiunqU
         Gu/A==
X-Gm-Message-State: AOJu0YykR12DkNxxOD3Zcz5BHMNLmBRrvQngUv2ed6Xqud37SNgGCoJ6
	QPeNwxAIRBSeDFQsHmHG9pocK0S3FGm5fm0VrgWqyvBLzUc=
X-Google-Smtp-Source: AGHT+IEMsxB74TR4lZftjaujl2AV+WMLj732Gt8q7aYd1oPnh7Qvd8iW4ygm5fUJ2Z9GDK3Uf2Qv60nL57E5XSYErBo=
X-Received: by 2002:a17:90a:f695:b0:27d:2762:2728 with SMTP id
 cl21-20020a17090af69500b0027d27622728mr2580201pjb.0.1700830710880; Fri, 24
 Nov 2023 04:58:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2023100450-charger-disregard-9683@gregkh> <AM0PR09MB2675934BBFB6E1DA8E0F626295B8A@AM0PR09MB2675.eurprd09.prod.outlook.com>
In-Reply-To: <AM0PR09MB2675934BBFB6E1DA8E0F626295B8A@AM0PR09MB2675.eurprd09.prod.outlook.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 24 Nov 2023 09:58:19 -0300
Message-ID: <CAOMZO5AgDjwUeePO4ibUeKkpf-YV9v=Dws0S01HMERdDf85yoQ@mail.gmail.com>
Subject: Re: [PATCH v2] serial: imx: fix tx statemachine deadlock
To: Paul Geurts <paul_geurts@live.nl>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com, 
	u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Fri, Nov 24, 2023 at 9:55=E2=80=AFAM Paul Geurts <paul_geurts@live.nl> w=
rote:
>
> When using the serial port as RS485 port, the tx statemachine is used to
> control the RTS pin to drive the RS485 transceiver TX_EN pin. When the
> TTY port is closed in the middle of a transmission (for instance during
> userland application crash), imx_uart_shutdown disables the interface
> and disables the Transmission Complete interrupt. afer that,
> imx_uart_stop_tx bails on an incomplete transmission, to be retriggered
> by the TC interrupt. This interrupt is disabled and therefore the tx
> statemachine never transitions out of SEND. The statemachine is in
> deadlock now, and the TX_EN remains low, making the interface useless.
>
> imx_uart_stop_tx now checks for incomplete transmission AND whether TC
> interrupts are enabled before bailing to be retriggered. This makes sure
> the state machine handling is reached, and is properly set to
> WAIT_AFTER_SEND.
>
> Fixes: cb1a60923609 serial: imx: implement rts delaying for rs485

One nit: the correct format for the Fixes tag is:

Fixes: cb1a60923609 ("serial: imx: implement rts delaying for rs485")

And no blank line is needed between the Fixes and Signed-off-by line.

> Signed-off-by: Paul Geurts <paul_geurts@live.nl>

