Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C940A639B72
	for <lists+linux-serial@lfdr.de>; Sun, 27 Nov 2022 15:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbiK0Osn (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sun, 27 Nov 2022 09:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiK0Osi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 27 Nov 2022 09:48:38 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3FFF593
        for <linux-serial@vger.kernel.org>; Sun, 27 Nov 2022 06:48:37 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id y5so1660876lji.0
        for <linux-serial@vger.kernel.org>; Sun, 27 Nov 2022 06:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BT171Unjb6EFvUBvn33Ts5USHKYTfqzQFkQsCflakoA=;
        b=ksaDiADiHYUwyECmaFvDzycpKpe9Xd5WJW+hjLSdxUt7x1AgLVaQ2LAvbvADQy26xA
         yPSzlXO7l2F+c3nwbjKuRsai9iHNZSCJedxrampb59vvfhiV3Hv32UBiQhzq1s9IuVer
         ZFNnzJp7A79KSzjIpqwf5ad/GgyewraNFFFEXpV+HDz7x13Fo2xhG0QZIrRWyWcbARJA
         1XR//uhlyS0x3bLxFwP97usLpXBbuwOVv0HtkpJMxLL0+eTs26gJWHdhh9RczSpB/31B
         b4BzzDE/EwCGbMbo9Eb5vTdjz/p0kO7EP9WNJI+gZf6n8y/t590iliEMKJkV6pVxHLLE
         RoLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BT171Unjb6EFvUBvn33Ts5USHKYTfqzQFkQsCflakoA=;
        b=ebYiW5AKvYKQpU9nmjYUVkUOS741ZZsb3JZmazBWqQYMwCR3121F1Td68aFRQHzD5x
         XiIZOTWdlcA2qcF/b8lOlgOkfkjbxiDsIbR/X+mzJ3Meqz+eGXMLxVUtrl5flpJqw8WV
         W+Ls9R4n4g1+ATpACGBlpFqiz+QlUZQG9j1xO9VhL9E418nPq8vR+DowwwecLLfW9cos
         qfe5l0PW/ZhXfm0GBCgcBuNQ1o/dRK3tJ1HPYbq1M8hDLsg7U+UJf8yqcQy8OdoeZce5
         rU4LjAp3GbxwuFtc/fvX7cmGpBsVqVM/NOJNdqap34RAKykyWzZ+b5sCMo1rSzKrn/QN
         oc4w==
X-Gm-Message-State: ANoB5plPCEIItqkD5RVRmVa9FUfGqvXaNKeT7y6CLch5YlIzDrb8DpkK
        rPhizFZI+wI3tRoLVuKztxkNBX7byR5yaTT/jPM=
X-Google-Smtp-Source: AA0mqf7LWtnvfWBknIx0eTYFZ2ojCNrosyqsqQznes507f9XwC/ZsbL1Hl+LFJFeoSvbyKDx3Pq5eMvGl4Fr0Y8hOw0=
X-Received: by 2002:a2e:9194:0:b0:279:7ffa:15aa with SMTP id
 f20-20020a2e9194000000b002797ffa15aamr5827142ljg.307.1669560515762; Sun, 27
 Nov 2022 06:48:35 -0800 (PST)
MIME-Version: 1.0
Sender: mohammedaahil30@gmail.com
Received: by 2002:a05:6504:28e:0:0:0:0 with HTTP; Sun, 27 Nov 2022 06:48:35
 -0800 (PST)
From:   H mimi m <mimih6474@gmail.com>
Date:   Sun, 27 Nov 2022 14:48:35 +0000
X-Google-Sender-Auth: gYWnCTEBcNrhxjy2J-gWsCV371g
Message-ID: <CALoWANjJkmQS0dc8=kvMCJfLRWf5QcHbLgAZGm54nFopNnabDQ@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

If you are interested to use the sum US$9,500,000.00 to help the
orphans around the world and invest it in your country, kindly get
back to me for more information
Warm
Regards,
Mrs.MIMI HASSAN  ABDUL MOHAMMAD
