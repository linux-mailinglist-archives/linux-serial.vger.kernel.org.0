Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 730661230EF
	for <lists+linux-serial@lfdr.de>; Tue, 17 Dec 2019 16:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfLQP4p (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 17 Dec 2019 10:56:45 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:47008 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbfLQP4p (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 17 Dec 2019 10:56:45 -0500
Received: by mail-wr1-f68.google.com with SMTP id z7so11827241wrl.13
        for <linux-serial@vger.kernel.org>; Tue, 17 Dec 2019 07:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Kru/p1qE5H/BCcW43apBsFqD+qqTgGNhKSFSdhalhZw=;
        b=mne8nhxlUm5JUVJvci8lY6PyqcJV58bkC/8MDX3fLFmKigBiUT2/qYAVumFGxcCQKH
         Lj2xkBkFvl4p3SnIPI1/tosatcIg9yz7/xCw01e/oYKvCYJTGjYLkiRt7lZXEkzTMDDi
         koiy7XLiHNLTtPsPdvJn0F4aRm0UoxyPXhCqjPgTanpJCHs1G08oXGcl9VrZE3+2FnBH
         VUxQHqYUdNGqdIfRAT1LOa1iiVP2JU7kEE5qzDFfdB66qbMWKkf7SdLY36Z+gFcATrCZ
         rqUX0MU6tbLJkV6Gp+ZZVn06QNbK0OBpr48hKvsnsHJejoFCmclwuyq0Vb1/l+pSWMxh
         XNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Kru/p1qE5H/BCcW43apBsFqD+qqTgGNhKSFSdhalhZw=;
        b=dWK/H3TfP297Q0s8Z6twASGzcN8VTHJHLkg/Ufr/TBDr1q/rAKuHFMxRnKsrt++mwH
         cDMFysebXf9FEVX1YTtVv/ajJtb8GrFJq2CIwmLx2SiUFBNni9TqBHKcDI8rT9EJStz0
         TzMRIALTqfLQU2zfikrN3dvYUdOOwzGHG8JHCE2ikJotDRIYq84+jeDZer2VjkdlxPqn
         ZWRzarqBsE1BTc4rqMgdBhliwcIf75SQtUmMaM4RCRSE0jBFRNZTywDRosoMABNQZ+hy
         vxECYTkYy37AIyu8dE/gnWW9e10iziGX5S+9RsLeEQWp9wdNdUG/y+6u5XoWEkQKrscB
         YBIw==
X-Gm-Message-State: APjAAAV6UpY/kkSI/9kmYm4RifpfgobTkb9N/i5m32DX8lFspmXiDvT5
        lPbbls9cmeNZJHJu21LjwVJEBw==
X-Google-Smtp-Source: APXvYqyNMAVe3i3HHStXWaTydu4DNl69XCzW5OGGXtdFookbpapo5jksY/g3ZK42dfA5bT/chPKB5Q==
X-Received: by 2002:a5d:56ca:: with SMTP id m10mr36759405wrw.313.1576598202967;
        Tue, 17 Dec 2019 07:56:42 -0800 (PST)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x16sm3455140wmk.35.2019.12.17.07.56.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 07:56:42 -0800 (PST)
Subject: Re: [PATCH] tty: serial: samsung_tty: do not abuse the struct
 uart_port unused fields
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kukjin Kim <kgene@kernel.org>, Hyunki Koo <kkoos00@naver.com>,
        HYUN-KI KOO <hyunki00.koo@samsung.com>,
        Shinbeom Choi <sbeom.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191217140232.GA3489190@kroah.com>
 <e0fbb679-54fb-25c6-0e88-012d0490e291@arista.com>
 <20191217155219.GA3754999@kroah.com>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <c0b28ccc-7a0e-f6e7-ac6f-f310094acc03@arista.com>
Date:   Tue, 17 Dec 2019 15:56:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191217155219.GA3754999@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 12/17/19 3:52 PM, Greg Kroah-Hartman wrote:
> On Tue, Dec 17, 2019 at 03:47:34PM +0000, Dmitry Safonov wrote:
>> On 12/17/19 2:02 PM, Greg Kroah-Hartman wrote:
>>> The samsung_tty driver was trying to abuse the struct uart_port by using
>>> two "empty" bytes for its own use.  That's not ok, and was found by
>>> removing those fields from the structure.
>>>
>>> Move the variables into the port-specific structure, which is where
>>> everything else for this port already is.  There is no space wasted here
>>> as there was an empty "hole" in the structure already for these bytes.
>>
>> Thanks!
>> Sorry for not noticing this myself.
> 
> You wouldn't have noticed this unless you build for that platform. I
> just recently made it buildable for other ones.

Ah, I was running CONFIG_COMPILE_TEST and thought that it should trigger
anything (and fixed an issue before sending). Probably, managed not to
enable samsung driver's option.

Thanks,
          Dmitry
