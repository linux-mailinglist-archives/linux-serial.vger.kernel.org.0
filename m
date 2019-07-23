Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05B17713F2
	for <lists+linux-serial@lfdr.de>; Tue, 23 Jul 2019 10:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733282AbfGWI03 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 23 Jul 2019 04:26:29 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43339 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733275AbfGWI02 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Jul 2019 04:26:28 -0400
Received: by mail-lf1-f65.google.com with SMTP id c19so28700639lfm.10
        for <linux-serial@vger.kernel.org>; Tue, 23 Jul 2019 01:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zsiWTINlQxQR1BEMzpafRnmPuOo+39W0PN0QoI1ovkc=;
        b=UtDTFi9ccOoAkHVESnLfXEbFLemHF9B8RDfypnAA5oaC3NIEZTwutKq3jYEOcljXI4
         w9N9q2yKTlZz1mIelhgYCLyGAqi+Zxbss8IrFSWt75qNmhHMWrgITO6nF18BRt/A7dYZ
         GZ5yBg/87s4VJUvy3E6uKBjToaEpBrF/kho8q49+dXMfX+4H2byW1KLcISCNUz++aMIO
         vPbrArL37nfwhMs2CG9gkRvOI/1+3xfxJCbWfyG1Z9HDEsTg302Ft+LQY5cVK0uojTcf
         2Lzu0E6a2JAuZoa+xqPfucFLvEMbfxuQQFhH/LBTbEu8vA96/6nqDz1eflFUBbDFBNvT
         RIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zsiWTINlQxQR1BEMzpafRnmPuOo+39W0PN0QoI1ovkc=;
        b=T0gim2g7YyxzwBou+Qp/KudMqUKPIONJCojYk+71OXgz0sVDAv+jeOKE3LdV4wUZIU
         LReXbVUAh8ZE+VqdY8yfdLznx1YJye71m33FXLGc9f4kTmgtZ1YN1b4fsMUpKM8zl0lu
         06ROrsZJDVaPBKDL7ykr7uJdXUspwOyeElS0ozUBoOtDAX0u/0vtMfPjzmquh8vUtPJr
         LM9t3oDDNF76g4IyZ3yt80uV6RogcrJad6PscOXgWB3aGHL7uZluiwg0+2Fah+hl58u1
         LIAbTVWoFD0oIMxilnq/AFQ/EnNW7PIW6IEbXiUnzZz0ilXRWsx7qs4Loa7qE22ruvTw
         SGOQ==
X-Gm-Message-State: APjAAAWW2+H2Ameuw6gDgH0vYNoJ2L9uutbNZkf+xWB0CaKB0g5JEmSM
        UqwW0/Dtn2h6Xn47k6q+j3yG0uweyNIVLJJUes2y/g==
X-Google-Smtp-Source: APXvYqwaAW9VPdzw6w7+LXOEsz/GsbIL85m1zVTzHrf8+5wPBVj8Khzr0ti5BsipSFSvkPpe98hNW3JqnQLoLK+l45c=
X-Received: by 2002:ac2:5c42:: with SMTP id s2mr23717207lfp.61.1563870386861;
 Tue, 23 Jul 2019 01:26:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190722191552.252805-1-arnd@arndb.de> <20190722191552.252805-2-arnd@arndb.de>
In-Reply-To: <20190722191552.252805-2-arnd@arndb.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 23 Jul 2019 10:26:15 +0200
Message-ID: <CACRpkdbm5MpcNdm8EGTR=U8MpK2VPzEg=Us0-AxZzOZ=vVJSmQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] serial: remove netx serial driver
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        netdev <netdev@vger.kernel.org>, linux-serial@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Michael Trensch <MTrensch@hilscher.com>,
        Robert Schwebel <r.schwebel@pengutronix.de>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Jul 22, 2019 at 9:16 PM Arnd Bergmann <arnd@arndb.de> wrote:

> The netx platform got removed, so this driver is now
> useless.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

We seem so overlap :)
https://marc.info/?l=linux-serial&m=156377843325488&w=2

Anyways, the patches are identical except here:

> -/* Hilscher netx */
> +/* Hilscher netx (removed) */
>  #define PORT_NETX      71

Is there some reason for keeping the magical number around?
When I looked over the file there seemed to be more "holes"
in the list.

Yours,
Linus Walleij
