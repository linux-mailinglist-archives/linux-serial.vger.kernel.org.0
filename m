Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDB33311E2C
	for <lists+linux-serial@lfdr.de>; Sat,  6 Feb 2021 15:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhBFO5e (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sat, 6 Feb 2021 09:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbhBFO5A (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 6 Feb 2021 09:57:00 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48FAC061223
        for <linux-serial@vger.kernel.org>; Sat,  6 Feb 2021 06:56:03 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id s11so12916355edd.5
        for <linux-serial@vger.kernel.org>; Sat, 06 Feb 2021 06:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=sY4fgq/DSyThalwU7QX+pWYKs/8sGH7ZznMUn5qQ1EY=;
        b=LKTydslwkBHjRBD/0U/iTEH4rnbV3bQM+PEGCYVnKRWqCpBuxiyyJWlH+XxoDVh2b/
         HFZWTfmHMpqHsMdZMtB/2gIQb6SrU7HNNg4Pbg6aDUnwTTYa4ErmhrI4rReQ/aAXsVVq
         wwdcwN/6PaD+QIBMSCrJ3tjlNWUWWctCNR4ZtJFT9jJA61Cvt48scMGk7sXyE5r6ccDR
         P3Y4T1+1qudMtHcSBxbPHr6TwKJ2cZ6qwDAUiEhK7eJUvy9B8fetIBZUma+T+Fz/B+MD
         X/a9+Uu3zKZgMCYnPeP2cVIikCY3zOffZKfAVZgicLkOAYPws+uBFNEJqRYUVgffaWvv
         FXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=sY4fgq/DSyThalwU7QX+pWYKs/8sGH7ZznMUn5qQ1EY=;
        b=dpIDwMR7zISRGAnePWvB6/Q07jXlJqyoYybXOvK1M1C68W9Zrgh2RaJzb4qH4v7U7u
         SElaa74KLshQ7tw8tHvzKlAZKrHqWj+wj05zJ0gJrjsptb0kAuYxNn8x4uSMIS4D6EuO
         r+C1c7WO4KJGS3foaTtjSxDGhJf4DtwiCE4iKJmuxJ1JGA6mp2oZx8A6t/ygORDk9Oh9
         xeLii0Iv1XT95FZ67956SG+Xj7L5iOL9PkCcfkqc07iHvVjUpX8Wsm1ad+ViEQIwlPW2
         PS7DPstGidKQcNVyCfCYDjmOQyKFZ4aPSNY+27hBwb6UIpQ2d1KVk4OikxpLET+QiJIZ
         dYjw==
X-Gm-Message-State: AOAM530jkmqu3mDDccGAq48I7HDI0pZKwaE0Dsin7yNWM3LQ5aZPHl+j
        6T+PISCf/czEbAo1991Jvj4LuNgm2oijqYzjbqE=
X-Google-Smtp-Source: ABdhPJzHuK3LvHqbpz7y7FkmfdCO+mLpCyAcQI6UI8feOQjxzQakBQkfzu17R8y2ODfxQ2tLrHWIUKNuNGqsXo7YnO0=
X-Received: by 2002:a05:6402:3508:: with SMTP id b8mr8823036edd.341.1612623362722;
 Sat, 06 Feb 2021 06:56:02 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:906:25d0:0:0:0:0 with HTTP; Sat, 6 Feb 2021 06:56:02
 -0800 (PST)
Reply-To: lawyer.nba@gmail.com
From:   Barrister Daven Bango <stephennbada9@gmail.com>
Date:   Sat, 6 Feb 2021 15:56:02 +0100
Message-ID: <CAGSHw-BTtjFX0_eZQxh6ESq0ccY53ZvhP0ukJTUOzzjPJEQARQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

--=20
Korisnik fonda =C4=8Destitanja, Va=C5=A1a sredstva za naknadu od 850.000,00
ameri=C4=8Dkih dolara odobrila je Me=C4=91unarodna monetarna organizacija (=
MMF)
u suradnji s (FBI) nakon mnogo istraga. =C4=8Cekamo da se obratimo za
dodatne informacije

Advokat: Daven Bango
Telefon: +22891667276
(URED MMF-a LOME TOGO)
