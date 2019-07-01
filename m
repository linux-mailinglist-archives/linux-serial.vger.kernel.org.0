Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA388454C3
	for <lists+linux-serial@lfdr.de>; Fri, 14 Jun 2019 08:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbfFNGcO (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 14 Jun 2019 02:32:14 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43890 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfFNGcO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Jun 2019 02:32:14 -0400
Received: by mail-pl1-f196.google.com with SMTP id cl9so575166plb.10
        for <linux-serial@vger.kernel.org>; Thu, 13 Jun 2019 23:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+B7qKXGJFcpQLr7qp/Npmcr+UB+pLON9p4u3OT4sydE=;
        b=IteYjWMcdrUIqBhhG5AEnX6ufnl4qdQ94/AhbuAqyXzyusOiHbjueExr31Z/7k3vK1
         8qxjudR4xriHfmMP9c6US25vQWx1jXjkH8k/Mu3slZvFI70Hc9fpA4PC3oQ3cfq1GnBz
         DfiY/Ib8YY5gn+P1ODVqEgVHY/OCOLDh+1M7OSwV8m1AeZ5bgYJrZvSrMPc7hH111ZRA
         oE5TmKKmdmW3InOVhB9xPk5eSBVIU7YqJ2GCgHUCJMKB/rJVw1WSQxmqP9gSfpKZ/htO
         va49FUHCzSBqKq6qVHw9WUMQZMZWYPylyZmguBUq1jqSAbUvDs/rqipmfDendsqMUjtu
         zJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+B7qKXGJFcpQLr7qp/Npmcr+UB+pLON9p4u3OT4sydE=;
        b=cMlzAQ2WUAKjl6tfv8gOpLzSWdk5Ij8jYTpVEQQ3zoRSVDfFf6QWmrBj3H+qPYCjDz
         ZjTyNb7clmtQzGBFTuPzwi4TTSHgioPuuSNqJ5SxDfBPZR/mLjEBocxBF8gvS8AbWGRc
         lSatLk1C7KQ+zmXr5gKz999JRaknuhfOMOdVss9GJSMLoOLtHGbAPsbqsrgMQ2x2BTVQ
         lIntI3IITvYxtaM+ATNdhEQlaXRRHveF6kHYRQ2mk4aMHMlST3PYfhLc8wXAYS+ad6Id
         r7LoyVGgfjTolF+ExmrJHB4k0eHvttA7e+UjtI4w1c/GGoiYdHP/LfqQrYIW+Wcl88qE
         TvUQ==
X-Gm-Message-State: APjAAAX8Qoe3SOPtcdFX3a6tdG6vwj0FkrIgDfKD4rIj9MFwaPlpIpZj
        d6+Y/gQRkqBO9RbI1uNUiAK6Sw==
X-Google-Smtp-Source: APXvYqwaUgWQWH6DKaYdF1Cdc9oLYapZi22Rqa6xAUqkllNSLwfCxqoVWtlD/qftHOdi36hhnvLW8A==
X-Received: by 2002:a17:902:2ba9:: with SMTP id l38mr85574068plb.300.1560493933681;
        Thu, 13 Jun 2019 23:32:13 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id x25sm1719091pfm.48.2019.06.13.23.32.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 23:32:12 -0700 (PDT)
Date:   Fri, 14 Jun 2019 12:02:10 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-scsi@vger.kernel.org, swboyd@chromium.org,
        ulf.hansson@linaro.org, dianders@chromium.org, rafael@kernel.org
Subject: Re: [RFC v2 02/11] OPP: Make dev_pm_opp_set_rate() with freq=0 as
 valid
Message-ID: <20190614063210.lfsquoycronah3fe@vireshk-i7>
References: <20190320094918.20234-1-rnayak@codeaurora.org>
 <20190320094918.20234-3-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320094918.20234-3-rnayak@codeaurora.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 20-03-19, 15:19, Rajendra Nayak wrote:
> For devices with performance state, we use dev_pm_opp_set_rate()
> to set the appropriate clk rate and the performance state.
> We do need a way to *remove* the performance state vote when
> we idle the device and turn the clocks off. Use dev_pm_opp_set_rate()
> with freq=0 to achieve this.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/opp/core.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)

What about this instead ?

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 2fe96c2363a3..9accf8bb6afc 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -711,7 +711,7 @@ static int _set_required_opps(struct device *dev,
 
        /* Single genpd case */
        if (!genpd_virt_devs) {
-               pstate = opp->required_opps[0]->pstate;
+               pstate = likely(opp) ? opp->required_opps[0]->pstate : 0;
                ret = dev_pm_genpd_set_performance_state(dev, pstate);
                if (ret) {
                        dev_err(dev, "Failed to set performance state of %s: %d (%d)\n",
@@ -729,7 +729,7 @@ static int _set_required_opps(struct device *dev,
        mutex_lock(&opp_table->genpd_virt_dev_lock);
 
        for (i = 0; i < opp_table->required_opp_count; i++) {
-               pstate = opp->required_opps[i]->pstate;
+               pstate = likely(opp) ? opp->required_opps[i]->pstate : 0;
 
                if (!genpd_virt_devs[i])
                        continue;
@@ -770,14 +770,13 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 
        if (unlikely(!target_freq)) {
                if (opp_table->required_opp_tables) {
-                       /* drop the performance state vote */
-                       dev_pm_genpd_set_performance_state(dev, 0);
-                       return 0;
+                       ret = _set_required_opps(dev, opp_table, NULL);
                } else {
-                       dev_err(dev, "%s: Invalid target frequency %lu\n", __func__,
-                               target_freq);
-                       return -EINVAL;
+                       dev_err(dev, "target frequency can't be 0\n");
+                       ret = -EINVAL;
                }
+
+               goto put_opp_table;
        }
 
        clk = opp_table->clk;
