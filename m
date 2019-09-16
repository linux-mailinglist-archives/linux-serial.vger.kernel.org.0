Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C65BB3E7A
	for <lists+linux-serial@lfdr.de>; Mon, 16 Sep 2019 18:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731251AbfIPQMM (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 16 Sep 2019 12:12:12 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36985 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729934AbfIPQMM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 16 Sep 2019 12:12:12 -0400
Received: by mail-pf1-f196.google.com with SMTP id y5so186018pfo.4
        for <linux-serial@vger.kernel.org>; Mon, 16 Sep 2019 09:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=ukGKzeQPiPEN2lY4FZKKhDC0scsYCbLIRezpYkGEnF0=;
        b=FcKOD68QvYkg/1znS/5QrPPjZXv1QqH3fSK02oc1bQKW0SYkWoBRFY6PxGg06yy0vy
         Gs0ZPsn6syFlKJbmV+0D1OEPzqwRYjqxq3XjpoyLe4EPDEEtGybpzwPAwZDL2X6nRUWR
         0hBr73Y+Xcmun0vUwyv07NC2OeEq2h0MOqqNJpYIN//5tFEjfAErHegVySR5pdKk48AL
         c/DeGoJrrbR6tViGA+Mk9waaSgMA6qNWt5vgKlcsXnPmq33h2mXRdKFHUBMnRHy/vmIA
         qK++wUW/pwm4QDry1/6EKTSbOdK16U7MX4dqjP3bqR5eEsd6DYZcohc4P3QfAr94S1c4
         qlhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=ukGKzeQPiPEN2lY4FZKKhDC0scsYCbLIRezpYkGEnF0=;
        b=hGE3mrsGWAu0QJOU2eq8ISlbW3Rgf/KtWfRhu70LzVYd5qX786azL/vAehWH5/Weo9
         ifgWBCXiaXPOnENdpPJGwRpiPfVYmYad2gLX9LILdoUPB5RbtkyARLCysMGruzLSAa1E
         OWsrroApWSY+JwiLabZ32nc8F2H6T2bQP7CmhxREoK2foolCiwyNk2Lt8DqGX+UZiaoX
         1dxEeUGNX963DWZr8mjDhVDX3bjmU9jdoEk1HyUY2PKyffkjKL7MwqHTg/l5JcBzyEMn
         o4eMWvcJ8p/kydD6lFzJVG7ZozBVGhY3vyQrqdk3aJOu+xlXT+72Y5RLQo40huWfOl9R
         yJuw==
X-Gm-Message-State: APjAAAX2inXo/rWA+G7J1BcYFJsRT/xkQKlQA4Thx64R/QoSIFZdb0Rj
        5udfXwk/xj044FgZCV1BlQU+Jw==
X-Google-Smtp-Source: APXvYqxGwHBnWhE1JX8v2f0UHWjla9dhYdqMsX29OJQAB0Zsm8tHG2v71dQ/iUvU9YoelteZGOUV1w==
X-Received: by 2002:a63:f84b:: with SMTP id v11mr1321632pgj.187.1568650331586;
        Mon, 16 Sep 2019 09:12:11 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id 31sm8888334pgr.55.2019.09.16.09.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 09:12:09 -0700 (PDT)
Date:   Mon, 16 Sep 2019 09:12:09 -0700 (PDT)
X-Google-Original-Date: Mon, 16 Sep 2019 08:32:58 PDT (-0700)
Subject:     Re: [PATCH] serial/sifive: select SERIAL_EARLYCON
In-Reply-To: <20190916064253.GA24654@lst.de>
CC:     schwab@suse.de, Christoph Hellwig <hch@lst.de>,
        Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Christoph Hellwig <hch@lst.de>
Message-ID: <mhng-671404fb-c86e-444a-86fb-b1ba027b1c36@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, 15 Sep 2019 23:42:53 PDT (-0700), Christoph Hellwig wrote:
> On Fri, Sep 13, 2019 at 01:40:27PM -0700, Palmer Dabbelt wrote:
>> OpenEmbedded passes "earlycon=sbi", which I can find in the doumentation.
>> I can't find anything about just "earlycon".  I've sent a patch adding sbi
>> to the list of earlycon arguments.
>
> earlycon without arguments is documented, although just for ARM64.
> I can send a patch to update it to properly cover all DT platforms
> in addition.

Thanks.  I've kind of lost track of the thread, but assuming that does the 
"automatically pick an earlycon" stuff then that's probably what we should be 
using in the distros.
