Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 405EB5676E
	for <lists+linux-serial@lfdr.de>; Wed, 26 Jun 2019 13:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfFZLTJ (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 26 Jun 2019 07:19:09 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37271 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfFZLTJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 26 Jun 2019 07:19:09 -0400
Received: by mail-lj1-f194.google.com with SMTP id 131so1780506ljf.4
        for <linux-serial@vger.kernel.org>; Wed, 26 Jun 2019 04:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=AVMpKxe2p8Y00koF5Afa/fEzfYbR4vv73nY4wLLyVp8=;
        b=hLmM57z4wc92EsRmENpSDF005m/k+Y/cZr8gblqkxT5XYod6lXNHMqO6mucLJoLvTc
         n5T4EU+2IHvr9UXQ8XUK9iHozwoGhovxjGNAqagjkdKNveVrVdeGhhAz4g9PorOZd8Oc
         dfLEEkQYxn0jzQ0cHSMxuYfGWqL6Vp4F4hvL9Byn6cmNCyaqbRGoHXXJTh4yQAY2F0/1
         3zJqv5exxGQiqq9eWK83kvZ4atnK9E2c/LD0Kuh4F6+NQn9Py2Fk2NAPn3zerCDS/dyB
         LV3+G3EsK1a5hZ4qaGGqHs9S182oUZOdQ0I8xKOqmGGuEMLtZVONVw3kFWhcoLjXp2t1
         nlpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=AVMpKxe2p8Y00koF5Afa/fEzfYbR4vv73nY4wLLyVp8=;
        b=bYvul+jkh5925ycgm9ba9FChHDvlANFqyvw4r8UC6RsMhi6Fpt+KrRZ/gQQjCSX+DL
         z9MG8TXuoRLn8rqpSKa9E2dg8ypYZlSOqP3YCLQ6UZjNg6E4IhyWhzwKyzE06QXrNOpq
         RrX+gdOUCWzUXWJL+Pth9hsyiNq9kSkt11FC7mqEL4OyI72VnpQSaYytDjNvpuG7tZag
         6fztRlLodMY9hWkzILpXJf2lXZM/Pu8MtV4rRCJ7qLh5cvvRVj3vT2PUoxH5r1yB3UE8
         9r664Yl129mE4MNk//AUJKLHQg38HWu6ii+qcc/8887Pb/W3lbS3c6myGErDUPLzQs6E
         kjRQ==
X-Gm-Message-State: APjAAAUWeyb+9NkuouClaoUaHfHZwUo7GAW+Hia3wycsQDsAjIcuaeFl
        Y7YbJjWZyPkc7jGNktgln1A=
X-Google-Smtp-Source: APXvYqwjrve8BS31UumnoHZ93usQMoZGKW5BnXbF2qDHDoa+QW9cf0GsOFz/PPlz/4i/5bneKATAYg==
X-Received: by 2002:a2e:9f57:: with SMTP id v23mr2715325ljk.138.1561547947083;
        Wed, 26 Jun 2019 04:19:07 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id f1sm2752352ljk.86.2019.06.26.04.19.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 04:19:06 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH RFC v1 0/7] serial: imx: fix RTS and RTS/CTS handling
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
        <1561042073-617-1-git-send-email-sorganov@gmail.com>
        <20190626100041.a7hyyhubun6y2r2z@pengutronix.de>
Date:   Wed, 26 Jun 2019 14:19:05 +0300
In-Reply-To: <20190626100041.a7hyyhubun6y2r2z@pengutronix.de> (Sascha Hauer's
        message of "Wed, 26 Jun 2019 12:00:41 +0200")
Message-ID: <87ef3gr3va.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Sasha,

Sascha Hauer <s.hauer@pengutronix.de> writes:
> Hi Sergey,
>
> On Thu, Jun 20, 2019 at 05:47:46PM +0300, Sergey Organov wrote:
>> The patches are not tested yet, so the RFC in the header. I'll re-roll
>> without RFC once Sasha Hauer tests them.
>> 
>> Sasha, in addition to already discussed fixes, I've also reordered 2
>> patches so that the sequence makes sense.
>> 
>
> I reviewed and tested this series, so when resending you can add my:
>
> Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
> Tested-by: Sascha Hauer <s.hauer@pengutronix.de>

Thank you so much!

Have a nice day,

-- Sergey
