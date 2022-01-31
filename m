Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 462F94A5017
	for <lists+linux-serial@lfdr.de>; Mon, 31 Jan 2022 21:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbiAaU1Q (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 31 Jan 2022 15:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiAaU1N (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 31 Jan 2022 15:27:13 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11930C061714
        for <linux-serial@vger.kernel.org>; Mon, 31 Jan 2022 12:27:13 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id s9so27693082wrb.6
        for <linux-serial@vger.kernel.org>; Mon, 31 Jan 2022 12:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=2ZvfYnWghHGJhp04LzFyo784NkSrBCEluCep501zyw8=;
        b=hBcsO1jkh7niAe658f5HGQGQGyoPyEeOaknNZcn7sGbUptrpIfLXlxQt0FzhedDjwX
         Lu1Rqc9GhX7b+IP07JeD/QuCDbmRNA2DmTLkJVvUF5umzsnjKhfrT2hjKXJuGq0nM/Lc
         IAmlEFNFd1eg0VTi4WuYK/YPJziV/Vif8E8znR7hxNkW/4zXjFKexSv8fe4PzBpoTu23
         0eTcuc0Lghq+EPHd/XQKcfJFWOYbJ6gluSNAkigpOErNjFO0KV5u8FfMMv8xggnGUEd0
         VZzFG4fmsCl0LT5gNLsljkgo4/bko+zrTGOkD5+J+1dPsBTeci5RLcRouUHJkMHle+DT
         NdwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=2ZvfYnWghHGJhp04LzFyo784NkSrBCEluCep501zyw8=;
        b=dAymwYD4UXcBcBLdOROZRPPxwy3zI5PHLAnCXvTro3EXsqXMMVhgzHAPGQJ3s3b657
         tJEdZG4iEKKIOlob1aGD9J4SDnJJB+q/ximpWsq8amjtAkxPh/LBpWbM1DZTm2ZtqG1S
         tNaGSJhiYMn5tkRvqi3G86Zwy8hfiRALyFQV0CUh5DGtzoawVTYYLKTh86rXRAPst1+w
         IsThdl3zRpIqltSfVfzU4FEiXAhLyGvZ01fv7sTXmMt+c+xFrff5mIOrX9OogIopIlRQ
         GldvSatjX5UcpHkgAtLaMTbLxxkVk09ibuqL8pFNMtJQTh2j2N2B6rLc4kzZn0lJPLPv
         sVWw==
X-Gm-Message-State: AOAM530K1BW7WCtMJOBD1ICHa0Q2BMzmqiP4pzXzZDMpNlDSr/kI/G0C
        0WG5+q3GJ8dRcUpCr17s6gwmjipq09DXGRC1HEyBSm/PP1PBqQ==
X-Google-Smtp-Source: ABdhPJxfcKzEdhlhzkUTkKaXj57szPPj2NIBTUL5Sm5HTdbwawps9lsbTS824sVWH6WyZL6J2W5SsbxHwBAJZnVVyAE=
X-Received: by 2002:adf:c448:: with SMTP id a8mr19348804wrg.697.1643660831503;
 Mon, 31 Jan 2022 12:27:11 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6000:2c7:0:0:0:0 with HTTP; Mon, 31 Jan 2022 12:27:11
 -0800 (PST)
Reply-To: info@maria-elisabethschaeffler.org
From:   Maria Elisabeth Schaeffler <rahabadamusaren@gmail.com>
Date:   Mon, 31 Jan 2022 21:27:11 +0100
Message-ID: <CAJkCv97HN3=suaUEgVt6prvipGXRvd_GQdwwnfb6mQbjXNbcRg@mail.gmail.com>
Subject: Re;
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

--=20
Witaj,

Nazywam si=C4=99 Maria Elisabeth Schaeffler, kobieta biznesu z Niemiec,
inwestorka. Po tym, jak straci=C5=82am m=C4=99=C5=BCa w szpitalnym =C5=82=
=C3=B3=C5=BCku, kaza=C5=82 mi
przekaza=C4=87 darowizn=C4=99 w wysoko=C5=9Bci 3,500.000 euro dobrej osobie=
 takiej
jak ty. Odda=C5=82em 25 procent mojego osobistego maj=C4=85tku na cele
charytatywne. Zobowi=C4=85za=C5=82em si=C4=99 r=C3=B3wnie=C5=BC przekaza=C4=
=87 pozosta=C5=82e 25% w tym
roku 2022 osobom prywatnym. Zdecydowa=C5=82em si=C4=99 przekaza=C4=87 Ci 3,=
500,000.00
euro. Je=C5=9Bli jeste=C5=9B zainteresowany moj=C4=85 darowizn=C4=85, skont=
aktuj si=C4=99 ze
mn=C4=85, aby uzyska=C4=87 wi=C4=99cej informacji pod adresem:
info@maria-elisabethschaeffler.org

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Ciep=C5=82e pozdrowienie,
Maria Elisabeth Schaeffler
CEO
Grupa Schaefflera.
