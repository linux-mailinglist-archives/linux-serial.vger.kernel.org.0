Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2693863D5C1
	for <lists+linux-serial@lfdr.de>; Wed, 30 Nov 2022 13:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbiK3Mk5 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 30 Nov 2022 07:40:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234906AbiK3Mky (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 30 Nov 2022 07:40:54 -0500
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374A23054A
        for <linux-serial@vger.kernel.org>; Wed, 30 Nov 2022 04:40:54 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-142306beb9aso20757617fac.11
        for <linux-serial@vger.kernel.org>; Wed, 30 Nov 2022 04:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oNTsrxZo5cKEX2PMxLfebJegeMEfNuHBu9jUamsGw8Y=;
        b=dvbSHjGmNX+38vKi4wKyzTCkKEZpnsAJWUH/+NMj04ufVkMkGRCLFmR7DXY2qBl1L3
         9X0lHhLgQfgH4kHtYY+Qv+febcZwWxgsqh5M2PYp7kr3Kvjl5QvgNTcumszl3udjw/52
         5zfhPYVx1zUrjk0HSQf16lKGVos7Isk0JGk6/fVGYWvpPcYVrAOIE4movXcehP2VuBjj
         CexMIVrD2oImJNmKZsWsqRtRWib+PauuitnIy6AQzIrMsiMGxjPGBtn+0WfUwurPOybd
         CQPFzODTTn/vcyzQalLin1ra85W0V98h20G+tmArko1HCsaZ2t1K36sUuF3q5Edg481j
         UQtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oNTsrxZo5cKEX2PMxLfebJegeMEfNuHBu9jUamsGw8Y=;
        b=ZEDuDrbXs9NDQWrdNviwkaUSsmzh+MpWn5IVvBLzIWBMiVbvhXgfLtqfToHRDEKlee
         3gH6jZD5pAMlWtjlLyq2M58FPj/M+L7YDdW2Ug3ztEB5qFF9WYvNHmq7x/0J1fjYft5f
         VD3ocBvJXk4jOtNelLT6RKX6cEfexcK8ComVzV2griEpAHJv0sSMhtP5kMv70HSGjw5A
         2C9QzD4AOC010t4iOnXyx7PNHVO8rQt1g0Vxy4bFKz9B4i0pyNljlt9qgTksn+2yE18C
         5yDeGQAWEZLxNtLwba/e6kSBetnhEVVtlF2911+aKFvggODSD5JN/zC7MCLlvH+rOqAT
         uu5Q==
X-Gm-Message-State: ANoB5pmhvCjrX5V2PAQYEmUWGb4eGiJceDXM+Cks1kMn855ioHTgWtDn
        8FuP40JMBhKMm+7gMSwId+FKrs1BwzupneCNUEQ=
X-Google-Smtp-Source: AA0mqf7upfu4IcJGvrOgQWGDYt/58bN1ER9b6avsKNicTWXgY2VuAUuo8QmTB5uL5g8p+yFmaKjmmJhyRO41lzGaiwc=
X-Received: by 2002:a05:6870:7d1c:b0:13a:eee0:199a with SMTP id
 os28-20020a0568707d1c00b0013aeee0199amr23793672oab.61.1669812053462; Wed, 30
 Nov 2022 04:40:53 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6358:1998:b0:c7:ff4f:34a5 with HTTP; Wed, 30 Nov 2022
 04:40:52 -0800 (PST)
Reply-To: illuminatiinitiationcenter56@gmail.com
From:   Garry Lee <kinatexgm@gmail.com>
Date:   Wed, 30 Nov 2022 15:40:52 +0300
Message-ID: <CAFBm7QO3TXYNfQ5zr3j8XLTqLCs1YXCOZgcxDDAWKH6qAWhLQg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_FILL_THIS_FORM_SHORT,UNDISC_FREEM,UPPERCASE_75_100 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

-- 
DO YOU WANT TO BE RICH AND FAMOUS? JOIN THE GREAT ILLUMINATI ORDER OF
RICHES, POWER/FAME  NOW AND ACHIEVE ALL YOUR DREAMS? IF YES EMAIL US :
MAIL: illuminatiinitiationcenter56@gmail.com

YOUR FULL NAME:
PHONE NUMBER :
COUNTRY :
GENDER:
