Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14C3D3C35F
	for <lists+linux-serial@lfdr.de>; Tue, 11 Jun 2019 07:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390539AbfFKFRr (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 11 Jun 2019 01:17:47 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35812 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390492AbfFKFRq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 11 Jun 2019 01:17:46 -0400
Received: by mail-lj1-f193.google.com with SMTP id x25so5592850ljh.2
        for <linux-serial@vger.kernel.org>; Mon, 10 Jun 2019 22:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=A4JluKr10LiYnrxlrWxqDJOqk9oyU7ZZ0uG+Jx4KPc8=;
        b=Dw793RTwR2AetiG6Pit/74IkXRK3JSR/6nzDDjMmc9Gz/aHSXtbQfyvhGZWLKusSd3
         fCGwdbDu0ZnkVVIxvIRMsL9OQf95JaAGFglw8N9rvLC3A50Y8qjaNtcltPAJuRsPieji
         TPPtenTt2kfhH7KVgSmPwnQO8YAyIbyNH6CYerjGidwBs8R31FmV2NHlGlyUBuVgQJY8
         1uKeyQpWJxSKbj9RkKcnTwrCFW2gInxCDGzldvz+zOWh2eHsRLBnMmgluZlxAti2o8bL
         RZ2JbtqF3sImJPzxQsjLd7tBYNqf2pgOa2+f89gAEeWzj6EWEOMXIIeaXfQQoYQav/gn
         bf4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=A4JluKr10LiYnrxlrWxqDJOqk9oyU7ZZ0uG+Jx4KPc8=;
        b=WBNXgZwV11nzaNlehmwaC2XSR1Wksi36GwzLxBD+n+6aD+Tk757DQxRN8CAGP7GkH8
         KLNeEumksVxOUJxrRgspGbB04skRjGt4yvcepPwWaOG/tHVLfZ6nhOqo/7CVfb19vKzU
         gTQFi30b/VceyFv+3DyDjTSOipde3lrNFalf1LxIagjeZMQNbeQqxvHOwrkk04vsVL9w
         zpNLnGwAHG9PwDQG2TBo1d6GvPtJZGoItAHKlrEHte3YW3v5U4c80kuOpFdcvlKEzbgC
         IPH9iYLrjXt0CbHjdn9bbR3/kibWi18GNP4E0B7DPvb85DHXo1vp8rDtihR4X2Xu31QG
         WoZQ==
X-Gm-Message-State: APjAAAXdc+mlPaJ2XlBrT4QwdIhfD06GaWLQg/nld9E9MnET8cWQxqeF
        YOp/0BFnGvCTKw/glZAH6CrDJxOt
X-Google-Smtp-Source: APXvYqz/hq8+dcJGgdd1MPMORvCrec8Q9SDDvyS8sk0l3c8jA11rfcxWUf7JDzjjAH+gEZR33QBF0A==
X-Received: by 2002:a2e:5d1:: with SMTP id 200mr20110894ljf.10.1560230264521;
        Mon, 10 Jun 2019 22:17:44 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id x15sm896126lfn.78.2019.06.10.22.17.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 22:17:43 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH RFC] serial: imx: fix locking in set_termios()
References: <1559807977-4598-1-git-send-email-sorganov@gmail.com>
        <20190610165239.GC32085@kroah.com>
Date:   Tue, 11 Jun 2019 08:17:42 +0300
In-Reply-To: <20190610165239.GC32085@kroah.com> (Greg Kroah-Hartman's message
        of "Mon, 10 Jun 2019 18:52:39 +0200")
Message-ID: <87tvcwu2dl.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Thu, Jun 06, 2019 at 10:59:37AM +0300, Sergey Organov wrote:
>> imx_uart_set_termios() called imx_uart_rts_active(), or
>> imx_uart_rts_inactive() before taking port->port.lock.
>> 
>> As a consequence, sport->port.mctrl that these functions modify
>> could have been changed without holding port->port.lock.
>> 
>> Moved locking of port->port.lock above the calls to fix the issue.
>> 
>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> ---
>>  drivers/tty/serial/imx.c | 24 ++++++++++++++----------
>>  1 file changed, 14 insertions(+), 10 deletions(-)
>
> I do not review "RFC" patches as obviously the submitter doesn't think
> they are actually correct :)

Oops! Noticed. As an excuse, there is no: "Don't put "RFC" in if you'd
like Greg to review the patch" in the submitting-patches :)

Lock-correctness is delicate matter that is hard to test, reviewing by
the experts in the filed being probably the best testing strategy
available, and thus your review, Greg, is in fact one of those I'd
especially like to achieve.

I'll re-post the patch without "RFC" anyway if I don't get any
objections, after a while.

Thanks!

-- Sergey
