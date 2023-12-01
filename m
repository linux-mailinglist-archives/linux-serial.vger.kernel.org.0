Return-Path: <linux-serial+bounces-351-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE15800EE4
	for <lists+linux-serial@lfdr.de>; Fri,  1 Dec 2023 16:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3071AB20FC9
	for <lists+linux-serial@lfdr.de>; Fri,  1 Dec 2023 15:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E464AF81;
	Fri,  1 Dec 2023 15:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cesnet.cz header.i=@cesnet.cz header.b="RYHXQIaP"
X-Original-To: linux-serial@vger.kernel.org
X-Greylist: delayed 185 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 01 Dec 2023 07:59:19 PST
Received: from office2.cesnet.cz (office2.cesnet.cz [IPv6:2001:718:ff05:10b::237])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2404E10D0;
	Fri,  1 Dec 2023 07:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
	s=office2-2020; t=1701446356;
	bh=NlYWjLxPgga+B6qXor9bK7J/rZPEyiB4nWhkpLB9Hb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RYHXQIaPlyRkFm3RtNjmTLNaa5JBy9v13O/VPSc73TOp/6/bCFbKcKd2ky739Qlrz
	 CLtd0DeqZJTC/2Agn62NB8AjKrjhvIKUtJY9C+cIdhwwnE66tCxh2AdtzpFNUaOWo4
	 xMpe4X5pZ4A+ztXIPvYQnubcvMGk3JYgR2TefPg50O1BGCfXOc/vv7KvFcovUSAuOp
	 G2O4mx5na+mIFTmI8SVgyuoXcQtlJhIkr5NQtk1MVhM2pYLHuK7ZDcq7lG4jLYj4MI
	 JDDAed2RuhS15e6r9nHEdQUwtp+2V+/UGeSoiDQ8MaKDTON+CQ/NvKvUH086q5VYf+
	 RuQ25/QwcSeqQ==
Received: from localhost (tlha232.cesnet.cz [IPv6:2001:718:1:6::134:232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by office2.cesnet.cz (Postfix) with ESMTPSA id 62624118007E;
	Fri,  1 Dec 2023 16:59:12 +0100 (CET)
From: =?iso-8859-1?Q?Jan_Kundr=E1t?= <jan.kundrat@cesnet.cz>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: <gregkh@linuxfoundation.org>,
 <jirislaby@kernel.org>,
 <hvilleneuve@dimonoff.com>,
 <linux-kernel@vger.kernel.org>,
 <linux-serial@vger.kernel.org>
Subject: Re: [PATCH 6/7] serial: max310x: add macro for max number of ports
Date: Fri, 01 Dec 2023 16:59:12 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <ddbc67dd-f8a3-4a6a-954a-bee49260ecab@cesnet.cz>
In-Reply-To: <20231130191050.3165862-7-hugo@hugovil.com>
References: <20231130191050.3165862-1-hugo@hugovil.com>
 <20231130191050.3165862-7-hugo@hugovil.com>
Organization: CESNET
User-Agent: Trojita/unstable-2022-08-22; Qt/5.15.10; wayland; Linux; 
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On =C4=8Dtvrtek 30. listopadu 2023 20:10:48 CET, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>
> Add macro to hold the maximum number of UART ports per IC/device.
>
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Reviewed-by: Jan Kundr=C3=A1t <jan.kundrat@cesnet.cz>
Tested-by: Jan Kundr=C3=A1t <jan.kundrat@cesnet.cz>

> ---
>  drivers/tty/serial/max310x.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> index f3a99daebdaa..58dd5cc62014 100644
> --- a/drivers/tty/serial/max310x.c
> +++ b/drivers/tty/serial/max310x.c
> @@ -30,6 +30,7 @@
>  #define MAX310X_MAJOR=09=09=09204
>  #define MAX310X_MINOR=09=09=09209
>  #define MAX310X_UART_NRMAX=09=0916
> +#define MAX310X_MAX_PORTS=09=094 /* Maximum number of UART ports per IC. *=
/
> =20
>  /* MAX310X register definitions */
>  #define MAX310X_RHR_REG=09=09=09(0x00) /* RX FIFO */
> @@ -1502,7 +1503,7 @@ static const struct max310x_if_cfg=20
> __maybe_unused max310x_spi_if_cfg =3D {
>  static int max310x_spi_probe(struct spi_device *spi)
>  {
>  =09const struct max310x_devtype *devtype;
> -=09struct regmap *regmaps[4];
> +=09struct regmap *regmaps[MAX310X_MAX_PORTS];
>  =09unsigned int i;
>  =09int ret;
> =20
> @@ -1605,7 +1606,7 @@ static int max310x_i2c_probe(struct=20
> i2c_client *client)
>  =09const struct max310x_devtype *devtype =3D
>  =09=09=09device_get_match_data(&client->dev);
>  =09struct i2c_client *port_client;
> -=09struct regmap *regmaps[4];
> +=09struct regmap *regmaps[MAX310X_MAX_PORTS];
>  =09unsigned int i;
>  =09u8 port_addr;
> =20


