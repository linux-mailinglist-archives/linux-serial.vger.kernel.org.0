Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30D1E117335
	for <lists+linux-serial@lfdr.de>; Mon,  9 Dec 2019 18:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfLIR4T (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 9 Dec 2019 12:56:19 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33534 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfLIR4T (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 9 Dec 2019 12:56:19 -0500
Received: by mail-ed1-f68.google.com with SMTP id r21so2830936edq.0;
        Mon, 09 Dec 2019 09:56:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Gi+hOHgs4FbeACcCTQiZTWxm/wZf1RY5AFjxL2lbXlA=;
        b=I7Sr86xNmtbM+dqzQa+PH2PuH9d41cOeVRCu2s1Ew1c1ryrlMOnCq85/ewgS8jh/h4
         Dh9lxPZ1iPIMsruUyzNmsh6F2Auda/pxrSpjDEbswKTNF+DHWY9Q4G4HIAAyf12QTpbF
         66zEghfQ+1YbIUbZppmgUtacW/NqLCGFh7YWMhxayW5vL8CVASgdGMBR8KlZPpSKPLX4
         CAbUy+oDVcwbH5d90QM5abl/7Ku6tdQ/CXhQ4t8XH7QD4TSYNJF7FL8QHGRBsaq/Rged
         VSiaaJbSXon/08if3wZ8FM1ksQ2RQA/CEv9KDYvaNo5oiXfH5R8vAuEfFO2caSqXXKZ3
         Pm8w==
X-Gm-Message-State: APjAAAWZROnMoYsmtWPYp3CmxbEoTOqbf09TF+w9Q920VwxPG6sCTxXz
        yOP8MCabT/TYRmsDt9f80U8=
X-Google-Smtp-Source: APXvYqxibjuMKqfHUp5/cyShtSVtcPbXPbo0Lhkzsi+XqDkOd1hJozuvx/jD2HgO6rz0P1LDl87cRQ==
X-Received: by 2002:a17:906:ccd0:: with SMTP id ot16mr2638134ejb.121.1575914177112;
        Mon, 09 Dec 2019 09:56:17 -0800 (PST)
Received: from kozik-lap ([194.230.155.234])
        by smtp.googlemail.com with ESMTPSA id g26sm14541ejc.33.2019.12.09.09.56.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Dec 2019 09:56:16 -0800 (PST)
Date:   Mon, 9 Dec 2019 18:56:11 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH] MAINTAINERS: Include Samsung SoC serial driver in
 Samsung entry
Message-ID: <20191209175611.GB26324@kozik-lap>
References: <20191205200422.5781-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191205200422.5781-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Dec 05, 2019 at 09:04:22PM +0100, Krzysztof Kozlowski wrote:
> Samsung SoC (S3C, S5P and Exynos) serial driver does not have dedicated
> reviewing person so some patches might be missed be Samsung-related
> folks (e.g. not even reaching Samsung SoC mailing list).  Include them
> in generic Samsung SoC maintainer entry to provide some level of
> reviewing and care.  This will not change handling of patches (via
> serial tree).
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> I am not the author of the code and I do not feel confident in its
> internals so if anyone else would also like to join in taking care
> serial driver, feel free to let me know.
> ---
>  MAINTAINERS | 1 +

Applied to samsung-soc.

Best regards,
Krzysztof

