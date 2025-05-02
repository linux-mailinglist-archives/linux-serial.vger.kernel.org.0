Return-Path: <linux-serial+bounces-9208-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 696EDAA6A4C
	for <lists+linux-serial@lfdr.de>; Fri,  2 May 2025 07:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F9A61BC251A
	for <lists+linux-serial@lfdr.de>; Fri,  2 May 2025 05:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69EB1DB125;
	Fri,  2 May 2025 05:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kH6QIXCx"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDC9158DA3
	for <linux-serial@vger.kernel.org>; Fri,  2 May 2025 05:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746164284; cv=none; b=VWZwksA7JWjcEONCNirIlWyIxHVZSdjqtcpTd5ngwT5v0PLgMtzwJj/eXSSap1aTIKLnd8c+8//VjjoUocloD1eLzdCAubEki5uzaA0ViLl2XwrsJzp5nGPsS0JIvX7A5fIL0B0grPp83gl0P5yZ2ZxxK+T22W8cE6zaXOMOpDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746164284; c=relaxed/simple;
	bh=N/Fwk495kD9mepOgV0IPLwaThwSJRDLJnhumIXeiRno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a3EtsVXLCo3uAQ9IUmvVEC3inrXwegKmqTgvQrC6J3TE7XWTGkoAgNy+NWEHaGWBjA94GV1Qd22XPpzW9kD9ADfg78gUvr+My4WVV+3oNEtH33ibl4/xUjhYihY9s2sksK1nlTNZMPQvn+dyhYcqABUu8nUxqlbF3N8SPKc2v1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kH6QIXCx; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-309fac646adso2653700a91.1
        for <linux-serial@vger.kernel.org>; Thu, 01 May 2025 22:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746164281; x=1746769081; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YaX+qGxsFULZ7aFPA9lXuC3vgye3yN1BRqF93u06YOM=;
        b=kH6QIXCxDGDbgypMyPjky0LYSk1QUTu0nprBfhSuqcgoy4ZHqMOIe66zMNqVGBSrpO
         D0w6k5Jflw40imWBOas27XH0LKJI8dXWN5fVShJ5unpfVGMqAPYCLmF1d2p/YhXQyx+N
         iL+C7jSY/KbI60dOwiXWP8QGTj43Sx5zZqJCMcfP4dMP+sggypKexSVMQ3v+Jkd4E8qW
         72JdoBxWY7h74zqS6Ihu2hnHeWoKwfEH4BGlZ55rtFEF5ncGqpTI6H2Q4mGjxFeAQ2/N
         aqpeP6J7XZm9y1Cy0StSJUZZZ5vLY2go6ZiVipRzBBf3bLC9Enw6QlbTSpv/GT/Zr8Wi
         4oRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746164281; x=1746769081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YaX+qGxsFULZ7aFPA9lXuC3vgye3yN1BRqF93u06YOM=;
        b=rcwi/b5LR7qUNncqRIWD+R+HkLBwHlMHxsQh2Yn3w3cect0ynMt8rjY6kHYB27MuUY
         92vR4ODaim/Agu8HQFrQ+VXkhOSv/4fx9kcCp0LiwOVEc2aLGCVGXxQAQV4tTGtWVvkl
         CUJrgnVDsrXV5lBMvEoJEKT8dcsLuaeEQxDtz1TH4bngdUKr0/gvIcMx27hhV9DNt5e2
         u5nJ/DVPPoKU+N1k9rEVsw1YWgy5KAmd9xc3wc5WoXShFgdj+DE8VcjHqr0rvArm8pa+
         7Z50ZN8Dop2Fji4WZ7so1d4pkLq/uiqf4ZoCU9XOK0amzTA/aItLUIuLF6MRYr+JTjOr
         MbNQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/viaEJrzVMafNkxIJ16EcArWRSKzXDQ6dRlkC6PCnz+BQ4r7MNB5p+2hTwyTVVHup/+JwLcH+4g8mSzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ8Jz8D8tWZENCvQesudW8QP3J3bXBZ+EVyjCUtujhQ97qZwVg
	QzWi+4Ct2tLBcsr+viL3/GHygAL/giIj92NSi390FnO5RoXa2MLjYPV7FRPj5Pg=
X-Gm-Gg: ASbGncsaOAmxg07z4iYCLMLKdCTz1g3SbxFoFx2ZAVmVQm7mGlQEiIbCpFvS7yrcr14
	FZdQwl8kIG55CZgr3jH5faxXhkeM/ICTk8de9h5+MkM3vain13RWWmZD1xiPX2/u49PR9QxVueR
	R9FmrCtyaRLT0KymNOfyK+567w1CmrV3xcu0Kg+lyl13INGy6K62J2TZ082PQmdByKnp34WFOFo
	JAKcZ/PF5TMwRUnUpH1/sG1lfb8vk/FyqubhpX2yWbcNNwhXs+RQyjpdVgimFPnw1if9+HQpSW+
	sYL3RaY10oyPyfafWzQ/Thf945f0wZ/FOV7ySOWZPQ==
X-Google-Smtp-Source: AGHT+IHL3pc4Gg50CajefQDLcK4ACzy8Pdk2nQi1FceIxJmjgGkFLMkDvveyaUAdVzjKAu9GfP26qw==
X-Received: by 2002:a17:90b:544c:b0:2fa:3174:e344 with SMTP id 98e67ed59e1d1-30a42fd0638mr7349801a91.14.1746164281091;
        Thu, 01 May 2025 22:38:01 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a34778329sm4692345a91.28.2025.05.01.22.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 22:38:00 -0700 (PDT)
Date: Fri, 2 May 2025 11:07:58 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Praveen Talari <quic_ptalari@quicinc.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org, psodagud@quicinc.com, djaggi@quicinc.com,
	quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com,
	quic_arandive@quicinc.com, quic_mnaresh@quicinc.com,
	quic_shazhuss@quicinc.com
Subject: Re: [PATCH v3 1/9] opp: add new helper API dev_pm_opp_set_level()
Message-ID: <20250502053758.utawzhq6famwenc2@vireshk-i7>
References: <20250502031018.1292-1-quic_ptalari@quicinc.com>
 <20250502031018.1292-2-quic_ptalari@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502031018.1292-2-quic_ptalari@quicinc.com>

On 02-05-25, 08:40, Praveen Talari wrote:
> To configure a device to a specific performance level, consumer drivers
> currently need to determine the OPP based on the exact level and then
> set it, resulting in code duplication across drivers.
> 
> The new helper API, dev_pm_opp_set_level(), addresses this issue by
> providing a streamlined method for consumer drivers to find and set the
> OPP based on the desired performance level, thereby eliminating
> redundancy.
> 
> Signed-off-by: Praveen Talari <quic_ptalari@quicinc.com>
> 
> v2 -> v3
> - moved function defination to pm_opp.h from core.c with inline
> - updated return value with IS_ERR(opp)
> 
> v1 -> v2
> - reorder sequence of tags in commit text

As Trilok mentioned, this is not the right place for this.

> ---
>  include/linux/pm_opp.h | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index e7b5c602c92f..31ed8a7b554e 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -197,6 +197,28 @@ int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
>  void dev_pm_opp_remove_table(struct device *dev);
>  void dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask);
>  int dev_pm_opp_sync_regulators(struct device *dev);
> +
> +/*
> + * dev_pm_opp_set_level() - Configure device for a level
> + * @dev: device for which we do this operation
> + * @level: level to set to
> + *
> + * Return: 0 on success, a non-zero value if there is an error otherwise.
> + */

No need of these for simple wrappers.

> +static inline int dev_pm_opp_set_level(struct device *dev, unsigned int level)
> +{
> +	struct dev_pm_opp *opp = dev_pm_opp_find_level_exact(dev, level);
> +	int ret;
> +
> +	if (IS_ERR(opp))
> +		return IS_ERR(opp);

IS_ERR is wrong here, should be PTR_ERR.

> +
> +	ret = dev_pm_opp_set_opp(dev, opp);
> +	dev_pm_opp_put(opp);
> +
> +	return ret;
> +}
> +
>  #else
>  static inline struct opp_table *dev_pm_opp_get_opp_table(struct device *dev)
>  {
> @@ -461,6 +483,11 @@ static inline int dev_pm_opp_sync_regulators(struct device *dev)
>  	return -EOPNOTSUPP;
>  }
>  
> +static inline int dev_pm_opp_set_level(struct device *dev, unsigned int level)
> +{
> +	return -EOPNOTSUPP;
> +}
> +

No need of these too for such wrappers. And then this isn't rebased
over latest changes in the OPP core.

I modified it and applied the below version to my tree now.

-- 
viresh

Author: Praveen Talari <quic_ptalari@quicinc.com>
Date:   Fri May 2 10:58:22 2025 +0530

    OPP: Add dev_pm_opp_set_level()

    To configure a device to a specific performance level, consumer drivers
    currently need to determine the OPP based on the exact level and then
    set it, resulting in code duplication across drivers.

    The new helper API, dev_pm_opp_set_level(), addresses this issue by
    providing a streamlined method for consumer drivers to find and set the
    OPP based on the desired performance level, thereby eliminating
    redundancy.

    Signed-off-by: Praveen Talari <quic_ptalari@quicinc.com>
    [ Viresh: Lot of fixes in the code, and rebased over latest changes.
               Fixed commit log too. ]
    Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/linux/pm_opp.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 8313ed981535..cf477beae4bb 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -197,6 +197,7 @@ int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
 void dev_pm_opp_remove_table(struct device *dev);
 void dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask);
 int dev_pm_opp_sync_regulators(struct device *dev);
+
 #else
 static inline struct opp_table *dev_pm_opp_get_opp_table(struct device *dev)
 {
@@ -717,4 +718,14 @@ static inline unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
        return dev_pm_opp_get_freq_indexed(opp, 0);
 }

+static inline int dev_pm_opp_set_level(struct device *dev, unsigned int level)
+{
+       struct dev_pm_opp *opp __free(put_opp) = dev_pm_opp_find_level_exact(dev, level);
+
+       if (IS_ERR(opp))
+               return PTR_ERR(opp);
+
+       return dev_pm_opp_set_opp(dev, opp);
+}
+
 #endif         /* __LINUX_OPP_H__ */

