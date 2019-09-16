Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 850B4B37F9
	for <lists+linux-serial@lfdr.de>; Mon, 16 Sep 2019 12:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730059AbfIPKVK (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 16 Sep 2019 06:21:10 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34216 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfIPKVK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 16 Sep 2019 06:21:10 -0400
Received: by mail-wm1-f68.google.com with SMTP id y135so6983898wmc.1
        for <linux-serial@vger.kernel.org>; Mon, 16 Sep 2019 03:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=s8jNMO99LalgIB0MNN5n8ucLI6Yy712UQYizzmnW3WM=;
        b=lU3fehKz5Rq4X9MmWZdW0i8qsX0bulnAdihulOyBBydleMItW3OD2SAcjI594gFSyn
         mlkqBfaGmUHStfoK/330byFtNFjOBKYek4XrcO7r7O2rHY9ayeFhesnGctcLaa0jj0Yy
         PQWoHRAcxSWd+qu1T/odVdmLosyOzTPOQQ6CS0Pe2zJDSTHBp2oIhdv+us1lQIyC3h8n
         tpWXIioy84lYoFWX/kfil+rO6lq3d1Hc8dbM+BSEN3y6vd4yEAb3Hx/sKS4GL8WxqrUU
         Kdvt9vfjfAE0eO1nsh8eHNO6zqQOzK/9CuG0kmqDMpJoY5TihNO2jSPhc5DlDsCRNWhi
         hxmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=s8jNMO99LalgIB0MNN5n8ucLI6Yy712UQYizzmnW3WM=;
        b=K20YEhDLzxCxOBFgpv2EJVazIxSgsJM9KFh6eVEmSYzQp7TDevEik3uCDBV7KZVFG0
         kt2i3+NBJOGtXR1jw/8hZdZA/vtdXJuMW2jF4we1gBXJIAO+p17Nztdpi7pvsrPWokMo
         mi0idGPaaBjHLmsOyU3lk4t9yHRCLX8En02aj9HT5QTH/XVhZu85uEn4QvH4UrzKD6rV
         9T8GejF2aFc0MnVRfL51+bwbob9gKzCoIUsGJvcBHJdrytd9RWdVLEJheeNbsPxVrhGb
         e6GnkcKNq1OoNkxmBq7XzAa4s9bwEWyAUwFPwPfb9ZAfyUj1nP8t8nuZJIVXQb820Dcz
         415Q==
X-Gm-Message-State: APjAAAVOtHAJXGvIOg+0C3c5ng/1Vfsco4VEzk2HlaPinhFgazzbUbuD
        1Xgqd3s9HERBDFWMfaRafUur+MjXBm2hkQ==
X-Google-Smtp-Source: APXvYqzsTu55mbfMPQKaK1c0o/x2N47IuQtcU2zQuc6VY5VF1h0PhASxZpXnGQ9FqoBFF5/LJP04VQ==
X-Received: by 2002:a7b:c8c3:: with SMTP id f3mr13024512wml.157.1568629267100;
        Mon, 16 Sep 2019 03:21:07 -0700 (PDT)
Received: from localhost ([195.200.173.126])
        by smtp.gmail.com with ESMTPSA id a7sm43545756wra.43.2019.09.16.03.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 03:21:06 -0700 (PDT)
Date:   Mon, 16 Sep 2019 03:21:05 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Christoph Hellwig <hch@lst.de>
cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial/sifive: select SERIAL_EARLYCON
In-Reply-To: <20190910055923.28384-1-hch@lst.de>
Message-ID: <alpine.DEB.2.21.9999.1909160320540.9917@viisi.sifive.com>
References: <20190910055923.28384-1-hch@lst.de>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, 10 Sep 2019, Christoph Hellwig wrote:

> The sifive serial driver implements earlycon support, but unless
> another driver is built in that supports earlycon support it won't
> be usable.  Explicitly select SERIAL_EARLYCON instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Paul Walmsley <paul.walmsley@sifive.com>

- Paul
