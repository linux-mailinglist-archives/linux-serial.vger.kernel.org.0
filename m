Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9655756315F
	for <lists+linux-serial@lfdr.de>; Fri,  1 Jul 2022 12:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236296AbiGAK3b (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 1 Jul 2022 06:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236308AbiGAK3a (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 1 Jul 2022 06:29:30 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33347435F
        for <linux-serial@vger.kernel.org>; Fri,  1 Jul 2022 03:29:28 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id o18so2001922plg.2
        for <linux-serial@vger.kernel.org>; Fri, 01 Jul 2022 03:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VdNa/95C+Rq3ZQV57wHlrLqjNCNUqyjRCenQXq1FaAg=;
        b=cy1kEUQixm6Y3cXrhbEG6G6G49ltkDnz3uOcRvbpf0diLCBi2ak+q3dCBCWQ917zz/
         VZEdxHXiV8F6LXr9LeEFjI0NQXT4372zLzvnSH8wejd6f6KZRCgxXRGveF+PA+AWTD5m
         0nAkxFLfPFrCYD/vvDbHNHjHmkIlEneAHemmibvgW/4W2ODvKTyjaGaEYmgm/nUlJza2
         tp2JQo9+Uwthm+fCpktFC+WWJNC/FI4u8gaJ7jkxnTwaxlM6MjNBaCY4GJ75oEe2loqM
         ZToj4ocsM8VJ+OxWCyoNR8+gNhkrMkQhILGNpn3RrCIsjYnH0NFVxE54WyLgKGi3d7lp
         I7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VdNa/95C+Rq3ZQV57wHlrLqjNCNUqyjRCenQXq1FaAg=;
        b=PMaOaYLbYpeyIC0LvDoec6nXqocNv9OT6QVKO+iPJWkTmdg7mfTne9Lvfbic1XWSHf
         MD5lG7tapKNarwv9rtLYQHlWliQoNfW/07DwYBabTp/Ij4BCU7NJf4BznNWE6T79m3Uq
         exMehTc7WWuBTHGeFeCjUqAH+XO9wGzkgfJCT5+GrsfObClI1I72wI0npzXNzt0Skry2
         WZo4+zM/mjhjW1Zr2BMuwpMfg1WsSyq2+OpVJm1eWc+k+OsfUSd2knU44boSMCnfseRE
         g2pqE6Cfq1+bBmzKjEP1/uEUTTAaIk4D+Zc47Nu6aeVQw/fBs2ub8R3Oj+xCnWQZXTBU
         D1/Q==
X-Gm-Message-State: AJIora/Y2YBJVJw4ELmtnZZtbs4e5eAVSQv9uJYWduzSGtepZ4Pkop4L
        xyxK8hgIcVocbU1hQiTrgBV/0g==
X-Google-Smtp-Source: AGRyM1t98ZHNClSSTvU8mPt7KxgDKs8MLh+PmLSjlMqDYqC8nplHzkfK/QaYm4OOEsoOG88Rlpdk4A==
X-Received: by 2002:a17:902:a9c9:b0:161:5b73:5ac9 with SMTP id b9-20020a170902a9c900b001615b735ac9mr20278437plr.14.1656671368482;
        Fri, 01 Jul 2022 03:29:28 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id mr12-20020a17090b238c00b001ecc616c9f3sm3668647pjb.21.2022.07.01.03.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 03:29:28 -0700 (PDT)
Date:   Fri, 1 Jul 2022 15:59:26 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 24/30] serial: qcom: Migrate to dev_pm_opp_set_config()
Message-ID: <20220701102926.uwvn7rurbxdybzeu@vireshk-i7>
References: <cover.1656660185.git.viresh.kumar@linaro.org>
 <1f3328dafaf9e2944fba8ec9e55e3072a63a4192.1656660185.git.viresh.kumar@linaro.org>
 <Yr6z5ixRTsIbZvsq@kroah.com>
 <20220701092458.tzqv7yul476kh2o7@vireshk-i7>
 <Yr7AwAZeSPeQKDPU@kroah.com>
 <20220701100100.bxv4t4t7iqphalpv@vireshk-i7>
 <Yr7J6f6+EQfXFjYN@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yr7J6f6+EQfXFjYN@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 01-07-22, 12:18, Greg Kroah-Hartman wrote:
> On Fri, Jul 01, 2022 at 03:31:00PM +0530, Viresh Kumar wrote:
> Still crazy, but a bit better.

:)

> Why do you need the clk_count?  A null terminated list is better,

Because I am not a big fan of the null terminated lists :)

I had to chase a bug once where someone removed that NULL at the end
and it was a nightmare to understand what's going on.

> as the
> compiler can do it for you and you do not have to keep things in sync
> like you are expecting people to be forced to do now.

I am not sure I understand what the compiler can do for us here.

The users will be required to do this here, isn't it ?

        const char *clks[] = { "core", NULL };
        struct dev_pm_opp_config opp_config = {
               .clk_names = clks,
        };


> The above is much more complex than a simple function call to make.
> Remember to make it very simple for driver authors, and more
> importantly, reviewers.

Hmm.

> Thanks, and drop the count field please.

There is one case at least [1] where we actually have to pass NULL in
the clk name. This is basically to allow the same code to run on
different devices, one where an OPP table is present and one where it
isn't. We don't want to do clk_set_rate() for the second case but just
use dev_pm_opp_set_rate() (which does a lot of stuff apart from just
clk).

-- 
viresh

[1] https://lore.kernel.org/lkml/b19a02422cae2408f953b92ae3c46a37fba688a3.1656660185.git.viresh.kumar@linaro.org/
