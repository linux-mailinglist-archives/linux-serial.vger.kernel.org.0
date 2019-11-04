Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7AEBED9F8
	for <lists+linux-serial@lfdr.de>; Mon,  4 Nov 2019 08:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbfKDHir (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 4 Nov 2019 02:38:47 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37975 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfKDHiq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 4 Nov 2019 02:38:46 -0500
Received: by mail-lj1-f193.google.com with SMTP id v8so758105ljh.5
        for <linux-serial@vger.kernel.org>; Sun, 03 Nov 2019 23:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Skx+IlvEjbz4Ey3Z8Es5BpI/gDpf4xIU9seBvakWE2o=;
        b=fKyAoSLbBB7K6Hwz7WQ1hkLB8UolD91873nvpgYDwu3vHgk9FskSurtOXN9GkL1c/5
         O1QO4r/LPsSNuj4aQkwxPg2auKprW4F4lCLH/I6JsLtqOEwdNwfRS8W2sWECsVQqK6CO
         JdWAYkhmIGvDXKDiJ6rIDpzfpG3P7N4TPq36U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Skx+IlvEjbz4Ey3Z8Es5BpI/gDpf4xIU9seBvakWE2o=;
        b=guRX0yPyDwU2LNpfn58lNGb2UAvxggNU615VwN5RPgEDqNoXONUCva2ze7vVZGnMQx
         2b9k/cyhQj82JbuHvCamudWXfZqcc5V+mqtCbEz9h0KCd5/kwi2EOU3YW1bKkb9jtPte
         3a8Sn6kGxljwh7pLEyUiilvYtsLRiltp3RKZG04zgLsg0HDtp+L3WkTojey+rWvOB13G
         5LZKwTDLgQQ9NHIrJapJckKW/CgAvXrpIEo7wH8bIVJETkzyBCvGSrxyOC8T2QcIylwQ
         /mvH/+IZEmR17tPF8sdW9fKAMS8cgO5poEjRaWaoV0XtoOCcngr6ZDiGKJgp2ZaWj3Ma
         vE4w==
X-Gm-Message-State: APjAAAUVDJ/JEnGeFZUhcdf3IaJ3ePERGb/60Xne34iUsDO+1IVzbskr
        0zI0lcQGnQ0T4hnD4rjdCzCViUS35BwzXg==
X-Google-Smtp-Source: APXvYqy0dojhXdV/Wyv7nl7DnnJ1xyl+IlR4kyBZvriN/BA2WM6WGs9kvJj6pwDEOoKIklqLOYQZtg==
X-Received: by 2002:a2e:5d1:: with SMTP id 200mr18228489ljf.50.1572853123654;
        Sun, 03 Nov 2019 23:38:43 -0800 (PST)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id c5sm6344575ljd.57.2019.11.03.23.38.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Nov 2019 23:38:42 -0800 (PST)
Subject: Re: [PATCH v3 28/36] serial: ucc_uart: explicitly include
 soc/fsl/cpm.h
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, linux-serial@vger.kernel.org
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <20191101124210.14510-1-linux@rasmusvillemoes.dk>
 <20191101124210.14510-29-linux@rasmusvillemoes.dk>
 <a921b57b-04d5-4874-89e2-df29dfe99bfc@c-s.fr>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <0acb2e96-3485-5e49-bed1-8deb2051cb91@rasmusvillemoes.dk>
Date:   Mon, 4 Nov 2019 08:38:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <a921b57b-04d5-4874-89e2-df29dfe99bfc@c-s.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 01/11/2019 17.19, Christophe Leroy wrote:
> Le 01/11/2019 à 13:42, Rasmus Villemoes a écrit :
>> This driver uses #defines from soc/fsl/cpm.h, so instead of relying on
>> some other header pulling that in, do that explicitly. This is
>> preparation for allowing this driver to build on ARM.
>>
> 
> UCC are only on QE.
> CPM has SCCs. instead.
> So this driver shouldn't need cpm.h

But it does. At the very least for the BD_SC_* defines, possibly others
things. It's possible one could split off the common part to a separate
header, but that sort of cleanup/refactoring is beyond what I'd be
comfortable including in this series.

Rasmus
