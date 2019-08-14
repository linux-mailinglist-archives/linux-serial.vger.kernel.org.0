Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 623CE8D64D
	for <lists+linux-serial@lfdr.de>; Wed, 14 Aug 2019 16:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfHNOg1 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 14 Aug 2019 10:36:27 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36704 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfHNOg1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Aug 2019 10:36:27 -0400
Received: by mail-oi1-f195.google.com with SMTP id c15so17764667oic.3
        for <linux-serial@vger.kernel.org>; Wed, 14 Aug 2019 07:36:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pvsHSvpg41jxNDti1Hf84M9pS4PxdF1lWKU6RcYkCmQ=;
        b=INDxlPWqSlxIiBrv0nokBFhZicUsli/TGH6NEN5UU0aaBqPvw0gTeEIio3LeA+yU43
         nZ3f8HcpgkprqirsTFxDf3QIG1ITppE/GwN72ZDM383hqsqFp1gBhd1IT5Xjd4FitTjA
         rtjRCpULeT+tKwUbgvYld+keec9lyTDQr6+vqk6T+0ANR3eQDkRn6mkoWwBSHkrdyuxi
         521nX/MxK0h1Tvh5Lze730kT7eszJ7vtnN6bxpIYx7kYd5d6U8fvozGbE2DMg2BX3sJg
         M6aNMfXfB+uWrffaU+JnkN0AFSrun8GWhVoOlSr2OAaiCl1lG2zduGGYIb42fByGFWM4
         5GqQ==
X-Gm-Message-State: APjAAAV72OihG6YaZEJMX6pG7R9NfsDhcbxkaM6jE4Ke3AY9icidNzBy
        7J7lpI0athBN16ySg0U+7oYOvdzVbU600kXFUJw=
X-Google-Smtp-Source: APXvYqxjcFfnr+bLIjqVJ7/o3ryb1+YW2y+bRYjywsUz/1Ud5zAfQGQXj9hlIGUbmRf5d7zpXXYAJYEgztRXV0bFwKA=
X-Received: by 2002:a54:478d:: with SMTP id o13mr189487oic.54.1565793386309;
 Wed, 14 Aug 2019 07:36:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190814140759.17486-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20190814140759.17486-1-andriy.shevchenko@linux.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 14 Aug 2019 16:36:15 +0200
Message-ID: <CAMuHMdWEZg9Q+NcVuB1CNsq0gBHKAx49GOB5JiRJsRnuN_6zJw@mail.gmail.com>
Subject: Re: [PATCH v1] serial: mctrl_gpio: Use gpiod flags directly
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Stefan Roese <sr@denx.de>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Aug 14, 2019 at 4:08 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> Description of the modem line control GPIOs contain a boolean type to set
> direction of the line. Since GPIO library provides an enumerator type of flags,
> we may utilize it and allow a bit more flexibility on the choice of the type of
> the line parameters. It also removes an additional layer of value conversion.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
