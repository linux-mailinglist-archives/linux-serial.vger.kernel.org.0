Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA5A482AB4
	for <lists+linux-serial@lfdr.de>; Sun,  2 Jan 2022 11:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbiABKMm (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sun, 2 Jan 2022 05:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiABKMm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 2 Jan 2022 05:12:42 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64BCC061574
        for <linux-serial@vger.kernel.org>; Sun,  2 Jan 2022 02:12:41 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id q16so64361929wrg.7
        for <linux-serial@vger.kernel.org>; Sun, 02 Jan 2022 02:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=g8Z10qgIS0EarfPNyU/0T6kl3UEk/EndXdl7judHSI4=;
        b=phTexj/pvY35khgBHH4ufmYYoQHDrQg3EUJ8JjXVbCR5gGl8LopxyTLCRB2Xja/3nz
         GBFaf9jrAGClorNeAOoiIuV9MbIcTo7UDCx64o1CxszGzWQaX4EyWx/eZUOVp8ql7WMj
         enFp1z/vKc2rUR5Yo3cpyrS0GRIZrNArVvUDIRuVtYFzbJ0xG/WjnasrKEablscMvTFO
         4lQlV594i0rvs3rRgtqewgApGJqUxp9nwRKbeTetFU3fSOeYwp5jvjsU2JuG0EjA0oTk
         VaN4+qmo+lX2DhazW6EyuBv4AitL1Pln79Bs9Ra6/Fr2wQpWBw4gAFU+SjoVv7Lt8npc
         t3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=g8Z10qgIS0EarfPNyU/0T6kl3UEk/EndXdl7judHSI4=;
        b=AgCbDY2vtkDsDcTExM+tJ3gTAMcQvv8aOYXHdOm1Zs0hsCviwS2eBNLa+xY/B3Mv0h
         84PLmi3NRmjZLINpgqzFOc16u/bADPaH7a8BO1MS/1gdMUpuZm3KOs1qgHIjFlYRIxCf
         pIxYyrSLPxSgwf5Jnv3O9VlE891YXoXGx7TToKxxE3ZHF4w2UUlIrRJSRlaFn2lHcxQj
         WejG6kKJDgIhNlrQCKjfGLpEoNi2PASn0Ewx+tMd3t7PDDD+lHL53s4SmZJ1jUisgV28
         BWplnrdLuuXf/+0R2U1FL1Zvos5TjwhDq8GCpTukx3RgNw4EmOlj5UBjJ+pxGuu1dx2y
         b8vQ==
X-Gm-Message-State: AOAM530fyLUIjFC2wskQ1mxvtxV1UEuVXtKUkY6ql96FWga+CpIxeTIu
        dBwQitz0oCGexL77rM6APOMsl+1bFkE/DA==
X-Google-Smtp-Source: ABdhPJzk00Zd6NUcZZ29gP+vtlXj6hSgr4OSPnR8m5a3R9aTw4Qj1WIeCJXaT0ksZ7y0CvHR6EJMFQ==
X-Received: by 2002:adf:e403:: with SMTP id g3mr21119679wrm.272.1641118360257;
        Sun, 02 Jan 2022 02:12:40 -0800 (PST)
Received: from [192.168.9.102] ([197.211.59.105])
        by smtp.gmail.com with ESMTPSA id d5sm9501411wrs.61.2022.01.02.02.12.35
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 02 Jan 2022 02:12:39 -0800 (PST)
Message-ID: <61d17a97.1c69fb81.82a4d.4044@mx.google.com>
From:   Margaret Leung KO May-yee <abubakaradamishaq631@gmail.com>
X-Google-Original-From: Margaret Leung KO May-yee
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: =?utf-8?q?Gesch=C3=A4ftsvorschlag?=
To:     Recipients <Margaret@vger.kernel.org>
Date:   Sun, 02 Jan 2022 11:12:31 +0100
Reply-To: la67737777@gmail.com
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Am Mrs. Margaret Leung I have a business proposal for you reach at: la67737=
777@gmail.com

Margaret Leung
Managing Director of Chong Hing Bank
