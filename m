Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3287212237
	for <lists+linux-serial@lfdr.de>; Thu,  2 May 2019 20:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfEBS5V (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 2 May 2019 14:57:21 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37281 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbfEBS5V (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 2 May 2019 14:57:21 -0400
Received: by mail-pg1-f196.google.com with SMTP id e6so1475813pgc.4
        for <linux-serial@vger.kernel.org>; Thu, 02 May 2019 11:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=lM2c+tlo6jGaS6GcPDKA87rxkv7bKTgFNvNaS30BO0w=;
        b=TI91P15erL2OywYjQHKmIyJKBc6sPfbma4Qr9Fh0sTkr/TzyaepILFifwYW4g3wWaw
         JuJPUAw4UCajVjqYmP0wxQ4QClyaC1XNagHXWS8h3ToDYO6hg5yh/bnRCdy2zSZpUXIF
         +ZrwD3wVO9CmImJ6Cr65rI0qa09e2fyN1HhuaRJcY8jarKy4cgoU5rDr7ewq9l9WpxVM
         UnfLfaw/exsvG2xp7cpGC3033uhM41JUT8rpyrK/C29Hn+61Jm4tlyynwE0NkdVriH1A
         Pvav5x2WyCk2Er31bwKzupa2n2HetnuU0Cf+9naP7mL/8eBllYDQq7WXm98G685XPEDf
         cTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=lM2c+tlo6jGaS6GcPDKA87rxkv7bKTgFNvNaS30BO0w=;
        b=F9v+87P1Sst1iGYsQ1MBEREL6SWhB+mLiGP8wnISmD4uigCYWZwcc5ielM9gKjJ8/1
         BL18HIJdQN+YbVc/S322sG/Hq/iSwesLRN6vGxrAD59n6ZPXbcxSFkhNfTUt4A2jOGws
         8fuWdG7RKuHI7W99PhzJBtly83Og5IrJEm3UWgbSEG1qNtCnl2+zOI1rIijVMyeDP72+
         578RuHRr6JQmOYNw5QL60sYyuyVpkEJZ9pvljZxW6G80ygwThfci7VRDVv3CTv+h71eX
         oM3XrOaR8M+UfRR4S1DXLzG2jctSItIhhQ556gJGKm79hyoI6b5IT+K0z5DYWs5sBwLv
         fn2w==
X-Gm-Message-State: APjAAAUVaxCVCQhLQ0IpsB4DHpU1GeOxmuFN1wj9Iij/7rZedIZGwDXp
        s2bPlOIetk4Gx+N/4belz96QOQ==
X-Google-Smtp-Source: APXvYqymPePW8yUoH5ZJ85MmB2vDe8cjepG/rf5Xz4mWP/mQIgzpZMZjapJeyzFwZOJiaQm+QroUbA==
X-Received: by 2002:a65:608a:: with SMTP id t10mr5631142pgu.125.1556823440489;
        Thu, 02 May 2019 11:57:20 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:e50d:c7fa:92aa:c53d])
        by smtp.googlemail.com with ESMTPSA id j22sm30688288pfi.139.2019.05.02.11.57.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 11:57:19 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial\@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-riscv\@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "gregkh\@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 0/2] tty: serial: add DT bindings and serial driver for the SiFive FU540 UART
In-Reply-To: <alpine.DEB.2.21.9999.1904191407310.5118@viisi.sifive.com>
References: <20190413020111.23400-1-paul.walmsley@sifive.com> <7hmukmew5j.fsf@baylibre.com> <883f3d5f-9b04-1435-30d3-2b48ab7eb76d@wdc.com> <7h5zr9dcsi.fsf@baylibre.com> <f2bb876c-2b44-663b-ea06-d849f721fb6c@wdc.com> <7htvetbupi.fsf@baylibre.com> <alpine.DEB.2.21.9999.1904191407310.5118@viisi.sifive.com>
Date:   Thu, 02 May 2019 11:57:18 -0700
Message-ID: <7hsgtwlm5t.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Paul Walmsley <paul.walmsley@sifive.com> writes:

> On Fri, 19 Apr 2019, Kevin Hilman wrote:
>
>> Looks like Paul has so far only tested this with BBL + FSBL, so I think
>> I'll wait to hear from him how that setup might be different from using
>> OpenSBI + u-boot.
>
> I'd recommend testing the DT patches with BBL and the open-source FSBL.  
> That's the traditional way of booting RISC-V Linux systems.

OK, but as you know, not the tradiaional way of booting most other linux
systems.  ;)

I'm working on getting RISC-V supported in kernelCI in a fully-automated
way, and I don't currently have the time to add add support for BBL+FSBL
to kernelCI automation tooling, so having u-boot support is the best way
to get support in kernelCI, IMO.

Kevin
