Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2A691ECBCF
	for <lists+linux-serial@lfdr.de>; Wed,  3 Jun 2020 10:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725888AbgFCIrZ (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 3 Jun 2020 04:47:25 -0400
Received: from sonic311-30.consmr.mail.ir2.yahoo.com ([77.238.176.162]:37628
        "EHLO sonic311-30.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726241AbgFCIrT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 3 Jun 2020 04:47:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1591174038; bh=DHWwjvUBpNeTFQGb6PyRvau478NLP9fdqM0QeFVpkaI=; h=Date:From:Reply-To:Subject:References:From:Subject; b=VMJYLEgNss3EzIKzlwT7284jRmbUlIJoNqMiYekae2NXXsK5yigrTNWRp1PHzE1/PP8ZQuMouK1dzVvWujG6hgGkaQ0NQsT4maWBuW353qHyAI8JcUtc4k+zvI0TI76BmAdBYswUgyaR76GVXFRmixs/u3INhRkR/7RpRYScjuIyGqr1qyqahiNl0FO1ydqQZjc6HPDmNLg+B7XfIwtdQtKDpay41ZLnkTMspGcIX2F5uapThd4jIOjWVQI06ktcyFelJWRjg5KXVkVYFwFATCDwA97SwsMZkwR+7o455EXRyW1nACgTRE6myanzwEZrFyeB03Dip33jJncpzXsaaw==
X-YMail-OSG: eHxFbBUVM1k1UtQEHigL9Y8caCxpdQBCsnHQrTJPh2u0NpYBltkN4c73.4MPThv
 Xz77.rLsIuJ6u6hWd5VgKJQw5kkiowNJYnctF7sO8OMOEgOm1WRLEH8bB5f5mxTZXF56a0PVxNR9
 5VaEyo9SAv5j3LSnNWjHhCgYnGoD7U4B743Pha7CJJgk4wwCuHB5rvYg7Y6FPcZC4hBRs5b11sAO
 XUgooD1YrzvzzOdcy5Bz_FK0NPh8PkaaZ0AHmQ_jvM9B_SCh7U.YP8AIJWYNB1JaWeiwa9UG5kRG
 OY5uive8I9m6bBrn8uP11ZON8umsmn6jAO7V9UwoYDaF74t41AJyNk._ZsO5ckgy7BTWOIxNnUMF
 t9dpMVKQKFPqJGYFR.akNOkK9b47XtjG1UzPrlukk6cBwiI8D.B2FOP_XksJL9SpC6bunwHHVkcw
 jesynqpaxsLgEC0fKLdgGerPKSNXSP0YGcFq.WloVZSYhgxu.SNLkeuJpfhz0w7AExNgE09sDsga
 Zarf4PMOMwE0LuQR06WUWcFqrpwZUA1U8OIC6ojMlAoHBvIz4MCmCOI01uBDOAuPbDzveZGfGZfm
 14ZpSfnWtKyQQhilH.NsR7Wz7QWVobXauQVSNzGNVYgbEis.cd65nnIfLxALN7eIB9Kf1gbtOsZ0
 BxfRXcdAYPFulD1xjoje__KvHGXV2se6SOyjdiUvsrGQsUeTkHC750im76M3ryZJL6QwVPYIVa81
 rBSTX9px84SWKz2LOOq3yoS1Rns5HMfJ9wkTh6BT2zejmKuh0NXEMuWvHOqMJ.DLivxGpRklGRSt
 CzpteFhCntM.ySZwvDZO7C5vlRbMLEpORn7TelwdZTRYbP329Mc.GkOL3JeUCA6grAw1Vypb8J1l
 TqKIqDFrasiReqbP30luIeuYCQcoR_LiBgjDFRLrgWAPt8p8A9AnKOfc7aeImJCF5IS6K3VOEsNh
 krpKJ3Jd4MAUMxs36oylJlkPCco6qTszIZ0VgyjeY5RXnnQNo5MgFZeMX32Ssujr5XVZwk7.Kj7e
 e_pv_YSokKp_Ywr2Rp3vSkF6ROnQa6C.Vfci.f.sw5264sZlAcS01IzdaQ69jj7GNQ9GYcbnDMkN
 Mjdg2CNXKjWmwjbJSBPbrMT4ihxClmVB60yukLovVT4Id5IW.UEw_bOOHAWaCfNeml3yEiqvcalp
 vw3Ysf0GA1NEu1T7fwGi_QE.NKwv9NqMxNeh7BoocdfWtbKmIel1BI0p0_oaDVdC_ZfqcbMg3rXv
 ZGX8.Nxw7m3CmBlzAyQv4xJVNzImN_y.ccurQfWctEZ0niqp9zPrhhOhdNe_c05JDueX9E3ZPBFN
 ehtgYyKeYc5.DEtca5AvkUEeKv1zqYlTty4y18CO_pRxruiD3qpkaYQRZFxDoZbMIqw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ir2.yahoo.com with HTTP; Wed, 3 Jun 2020 08:47:18 +0000
Date:   Wed, 3 Jun 2020 08:47:15 +0000 (UTC)
From:   Mr Manu <kalammm9000@gmail.com>
Reply-To: mrmanukala02@gmail.com
Message-ID: <151738227.3246878.1591174035452@mail.yahoo.com>
Subject: VERY URGENT ATTENTION.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <151738227.3246878.1591174035452.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16037 YMailNodin Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

I am Mr. Manu Kala writing you from Burkina Faso West Africa. I feel quite safe dealing with you in this important business, however, this correspondence is private, and it should be treated in strict confidence.

Firstly I will like to assure you that this transaction is 100% risk and trouble free to both  parties, In order to transfer out Twenty Million five  Hundred Thousand Dollars, (US$20.500 000 ) from our bank here, secondly the fund for transfers of clean origin. 

The owner of the fund is late Mr. Paul Louis Halley who died Along with his entire family in a plane crash. 

http://newswww.bbc.net.uk/2/hi/uk_news/england/oxfordshire/4537663.stm 

I have the opportunity of transferring the left over Funds ($20.5million) of one of my bank clients Mr. Paul Louis Halley who died Along with his entire family in a plane crash.

I contact you believing that you will not let me down once the fund goes into your account. 

Please delete this message if are not interested.

Looking forwards to hear from you soon.

Regards
Mr. Manu Kala.
