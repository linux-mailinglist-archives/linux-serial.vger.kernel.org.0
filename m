Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44CB4713E5
	for <lists+linux-serial@lfdr.de>; Tue, 23 Jul 2019 10:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731411AbfGWIYL (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 23 Jul 2019 04:24:11 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37970 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733196AbfGWIYK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Jul 2019 04:24:10 -0400
Received: by mail-lf1-f68.google.com with SMTP id h28so28680372lfj.5
        for <linux-serial@vger.kernel.org>; Tue, 23 Jul 2019 01:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z4oiDNheB7tcp4OlfdwdNJixiwjQ7CN/OqrZSF2BQl4=;
        b=ia1JfK+7eINBofKtKO04fnLG2c/ORhlen9wzZsM3f9jtvacXw9wzVipd/IKpZyIvt1
         lHiZytrgcytx8wNSN/KWkpGTYd2Pc+5F6WztnIV747hg4bWIFwcLpBrgxDIQPi9bxm9k
         yaKEWcLo7Avc1KZD51rYRu3VdD8EC4p5AMW4LA4gJyumXz3WtvcQJO/qcDAmSCxTsQvb
         NJ00x/3dUoIP8iWdxEHFbjRzvM1VietYOAkDZd/S2iPkneOyqH6ZyCMENQyxWanGeVlv
         gmGyqfEwS9tNOy4P5+KQlY4JIBwPnHXOAayXHOoVjd0w5Ea5vTo5b5AamT0F0Q+RTEeK
         Kuhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z4oiDNheB7tcp4OlfdwdNJixiwjQ7CN/OqrZSF2BQl4=;
        b=sZidtYfhP0pzbI0WvHMzH5qaRtDy8xSpDvcummwXrMn0+uEHgUtv2Uo3Ey1BWU8nLU
         8xemgc7eQtua5JxobX+tLOJdGhyzBTb7E6Bt2C+SIfTV5GIWsE5gQPwfIngtnVl+IsA6
         sJsYcrt8zAm9OdDJS1/lbxvEVDjwc2i+CESTOevtlTXMA0BE1sy/Vp42mSikUai8uw6D
         RdKy8RV/T8rlsHGxvMGfLltCCGpgtT59nOgdYZA+o4VIEnK+LzwA3B6++CLIKlMJohN0
         kmoyV/Y0BfFL6IkAjcIb5qn0eiTYMHpMAHaZScyKe36ohR3LMCrpjvOuH+wta9oVbrVF
         Tnsg==
X-Gm-Message-State: APjAAAUhbMZV6fIwv8z9DJ2zNNxkFRfa8aa92x59gotzto4jhMw1CMCe
        zLW6lKkpAYM3C7hPnTmtXJ1BdlRW3oH+O2qq4iUEaWVA
X-Google-Smtp-Source: APXvYqxRHlls9XsJdn6N1L6aNp6XRxRHchgvWi1x+4y2L86sh1FPQdZY43ccO4gdutnunaw+n+p1U04JRza21fs1hSg=
X-Received: by 2002:a19:6a01:: with SMTP id u1mr34253339lfu.141.1563870248944;
 Tue, 23 Jul 2019 01:24:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190722191304.164929-1-arnd@arndb.de>
In-Reply-To: <20190722191304.164929-1-arnd@arndb.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 23 Jul 2019 10:23:57 +0200
Message-ID: <CACRpkdZMRmF_CEhXJYyeNEThwHc-ihEReLgU2pvJWjWiBnNFWw@mail.gmail.com>
Subject: Re: [PATCH 1/3] [net-next] net: remove netx ethernet driver
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>, linux-serial@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Jul 22, 2019 at 9:13 PM Arnd Bergmann <arnd@arndb.de> wrote:

> The ARM netx platform got removed in 5.3, so this driver
> is now useless.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I thought I sent a patch like this yesterday but it apparently
never left the mailserver as I can't find it in the archives.

Linus Walleij
