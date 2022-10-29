Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F636123EC
	for <lists+linux-serial@lfdr.de>; Sat, 29 Oct 2022 16:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiJ2Ojl (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sat, 29 Oct 2022 10:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiJ2Ojj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 29 Oct 2022 10:39:39 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8306B10B4
        for <linux-serial@vger.kernel.org>; Sat, 29 Oct 2022 07:39:37 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id y69so11716715ede.5
        for <linux-serial@vger.kernel.org>; Sat, 29 Oct 2022 07:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQx//nIMTXIuGES5wdU306SDyqo/9GYHWGhMmpKB5Ag=;
        b=pvW7n1iTMRWqwkMW5J1XJMZkms2ly2F5eyf4gkQhb3g4oalaqvGgTRtL94q5LF/KcC
         tyRO8Zly3pCRVRiM9COdaTbpTmgTwY86JI1N6vT3sKIC3S9h/Ftdz3peJP2shpy1R8is
         H1bRs8mD795pCfjXRF9L2uS2jddmBoWpLXCleSqaLf8s2a5qU7J8TWpn8dKYwmUDGEXm
         hFJRgXBJoGBMJ6TwdicRGrym+pAwD0R2vcgYUcu+9yKSzH/+2injSL0dl+sc7B3ipRAY
         tQ36JOZ51fOaVDImqVc0ZhgkXrc50q7FHQTJIi4q8xibTcQooNv9EA/oDexcDFyr6+sJ
         QEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OQx//nIMTXIuGES5wdU306SDyqo/9GYHWGhMmpKB5Ag=;
        b=KS+PGyJ9/pzDxaaxSDBreuduN7WE1HJNsTS6k2G/5NiYQAA6BEhS5TlguJoaEGwUN5
         C4VdEaxjg3PE0BoYceuQh2WRkuBQfdj2banOzFgKHgO5NMoCE/Ukif6nOWLqWC1GIh4n
         BSW6quYUixktjsjA8xNvEZOsEGRG414KwwWzcAoZ5+HJMkLBAMy90BcGY1OVPmJMdk+1
         RUPyseAhKeTbMzAwQFwFnnU1yfKbt4gILold/E9Jw/O03fnS+UjZ5OEwztxutQSAj+fy
         CEE4QjuIgPsvintpevbY7uC3ASSMPdzC/cqSUaACP538dZhsU0PlyHBEiwGkOMLGjKLQ
         8pgQ==
X-Gm-Message-State: ACrzQf3Wiqx6zTXJBIfdOzTlJQUxoy3gFnrYrtDNeAxmXsn8E72S/eU1
        ikz2sA2UdgL1rfJvmSLkBDYQXwqYkYca1fi3uw0=
X-Google-Smtp-Source: AMsMyM6vpnlzIHxMTS3GzjQwGghE55ZhyDEFY0gDanOqZixBobLxw1n2nGmkLcnXYQEfyEGX5QQ6F8zfq7H1+fecKQg=
X-Received: by 2002:a05:6402:11ce:b0:45c:a364:2c3d with SMTP id
 j14-20020a05640211ce00b0045ca3642c3dmr4670519edw.204.1667054375728; Sat, 29
 Oct 2022 07:39:35 -0700 (PDT)
MIME-Version: 1.0
Sender: lolorachida@gmail.com
Received: by 2002:a17:907:ea3:0:0:0:0 with HTTP; Sat, 29 Oct 2022 07:39:35
 -0700 (PDT)
From:   H mimi m <mimih6474@gmail.com>
Date:   Sat, 29 Oct 2022 15:39:35 +0100
X-Google-Sender-Auth: qCXzwILSlnXyuyDwBpw63G4aQw4
Message-ID: <CAPDHN6rcFtKvE3xKsL93PV+0qi9mo8vedY0XnCqb7Gz6Q8Gsdg@mail.gmail.com>
Subject: GOOD TO HEAR FROM YOU
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

i am Mrs Mimi Hassan Abdul Muhammad, and i was diagnosed with  cancer
about 2 years ago,before i go for my surgery i  have to do this by helping the
Less-privileged, with this fund so If you are interested to use the
sum of US17.3Million that is in  a Finance house) in  OUAGADOUGOU
BURKINA FASO to help them, kindly get back to me for more information.
Warm Regards,
Mrs Mimi Hassan Abdul Muhammad
