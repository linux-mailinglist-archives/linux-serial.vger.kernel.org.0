Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDD441230CA
	for <lists+linux-serial@lfdr.de>; Tue, 17 Dec 2019 16:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfLQPrn (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 17 Dec 2019 10:47:43 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43466 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfLQPrn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 17 Dec 2019 10:47:43 -0500
Received: by mail-wr1-f67.google.com with SMTP id d16so11842458wre.10
        for <linux-serial@vger.kernel.org>; Tue, 17 Dec 2019 07:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BH/GNjEuKwaSuSLw1wxU/rm9ywlcEyhGqhViGDKQ4n8=;
        b=jdlk6KB1CQWgSVBxrjkbO6Q1OsOiue3Cc/wgX96MQkUYTuLzX2w7+HbSI+nRie5Hxk
         DG9NML7SiMN6vJegdzuGh6e+MAYSG3B+SOz+jxM6SoOdUBJ7Ak7PveWFZ+y1TpG36DCq
         nW2/SQIy1ll4xvPGTmsqZDoobeu25hgFrGHRaMSwIq7GbdTqem9GTFRILHLl6pUBBeLF
         a25wSxYfSh97FiIFAqDPFtZOAYeAcCiiUk4u6lY9lVJmqbnDyLSisY5IieKTPCDza7rQ
         sNF54PXRt4GCWD7estr0m3j80SCByhlIfD5dEU6XpavUIT7ncxibg3PKJ+V0ce51XMRq
         bNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BH/GNjEuKwaSuSLw1wxU/rm9ywlcEyhGqhViGDKQ4n8=;
        b=ZKIQSzSOXI0f6ABPam1l11CWKNvE+uI3jVXZsQAuvki9M636AWGPgyLjuecuzpTWbO
         HLwvg5/8kTKuPTycfPLwDqB7bwg8WcJIA01KgEorMSncMybpyGUrJGwm028NGeGylIGh
         63zAXq8TsYuh3TMBftsaO7RlXOgO8GJ4nGRiNUwxkOLh/caFOttKb59uJhTFbL73tXM/
         /B6m1u2xnh/LxDZXwUwVUGgzIEC+FxQUBM1IE/zpwIeS8leSI+FT5Yyk+HSA7qxACo+c
         MwT2uPu2ntgbqpx7sw6cjdRfowqFJDsivEqFA1kXfSOb/IDCImaM2QqRrr7FpyOipmw/
         7Eog==
X-Gm-Message-State: APjAAAWidYURYPUtGtRVyRuQGjNXpVqnNMkuJ798mfTjwHFYKgVO0fy8
        5iBZqyGVQsJ5grfhWc0np18t1g==
X-Google-Smtp-Source: APXvYqwnEA0SeuV8gW6pD1T907mTdAFjzJEgCw4Kn6mp7NMydfnWBMc4mxcEFNljrORO3+RH5Oh13g==
X-Received: by 2002:adf:d4ca:: with SMTP id w10mr14624687wrk.53.1576597661609;
        Tue, 17 Dec 2019 07:47:41 -0800 (PST)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id k13sm25710075wrx.59.2019.12.17.07.47.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 07:47:40 -0800 (PST)
Subject: Re: [PATCH] tty: serial: samsung_tty: do not abuse the struct
 uart_port unused fields
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kukjin Kim <kgene@kernel.org>, Hyunki Koo <kkoos00@naver.com>,
        HYUN-KI KOO <hyunki00.koo@samsung.com>,
        Shinbeom Choi <sbeom.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191217140232.GA3489190@kroah.com>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <e0fbb679-54fb-25c6-0e88-012d0490e291@arista.com>
Date:   Tue, 17 Dec 2019 15:47:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191217140232.GA3489190@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 12/17/19 2:02 PM, Greg Kroah-Hartman wrote:
> The samsung_tty driver was trying to abuse the struct uart_port by using
> two "empty" bytes for its own use.  That's not ok, and was found by
> removing those fields from the structure.
> 
> Move the variables into the port-specific structure, which is where
> everything else for this port already is.  There is no space wasted here
> as there was an empty "hole" in the structure already for these bytes.

Thanks!
Sorry for not noticing this myself.

> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Hyunki Koo <kkoos00@naver.com>
> Cc: HYUN-KI KOO <hyunki00.koo@samsung.com>
> Cc: Shinbeom Choi <sbeom.choi@samsung.com>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Dmitry Safonov <dima@arista.com>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: linux-serial@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

I see you already applied it to your tree, but in case it helps anything:
Reviewed-by: Dmitry Safonov <dima@arista.com>

Thanks,
          Dmitry
