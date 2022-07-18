Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680E8578A32
	for <lists+linux-serial@lfdr.de>; Mon, 18 Jul 2022 21:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbiGRTBs (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 18 Jul 2022 15:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234234AbiGRTB1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 Jul 2022 15:01:27 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D728D2F679
        for <linux-serial@vger.kernel.org>; Mon, 18 Jul 2022 12:01:17 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id a14-20020a0568300b8e00b0061c4e3eb52aso9969082otv.3
        for <linux-serial@vger.kernel.org>; Mon, 18 Jul 2022 12:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=h0ZslgqQ94UM3iGDYCZGEx8ZwvbYHY5ZrQARiO/Kpbc=;
        b=IQXHlBQ3jHSYUTt89EYBBYMpS/rXYtHBaNUJ6e2ZzB07/ETpvOJM0/ZijryokIEfDh
         oJG0jiachEiIldTcksV5XzU+dy3csOVeMrzVRYAIpdf4PUrGYfI/KNNvcLIWjvmc8oHa
         yWKlPWKnOFkuEw2Mq2CzZYpqcRK9kJ+LygeUXE0izxh4s3I+nauj1w40rP+480vJCi+X
         rAPSoEvo8wXV23cydMjOZnuzBivYToT/OwjRuq1iqX/8Isb8Rqougy46FnOdoQuh9Z/u
         z7xKihQATs9EIIDqpmGAQl/2n//vpMk3ZDpLHQioaLk/1hVBrL4som/CgeyT77yPFwbn
         VU6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=h0ZslgqQ94UM3iGDYCZGEx8ZwvbYHY5ZrQARiO/Kpbc=;
        b=JGv87dQ7UEOMs+N86EUCnx4Pg7FegneTrt7MLaDDYPse9RmfOdZWa0wBao5ptiB2Rj
         CqY6XmvxDv/woIQ1vAxEXjfce/cJSC4kbgxhfWGmrRhmkwDuZA8Y+5kRIzJBsnq2+hWn
         10FrIjkYXyUKDlSVdLuZmqreqeTTy61RPHEsZ51iNoo6gBJMgPd3hIXyk6dcSjYUttDY
         yq4EdSt7JZd4+aaBc+2wWWN/o7TpudA4KdGk1u/HF9UjpSymK0zRoMzpobYjYGOaPIOC
         qzf3Lb4zUM9xjp134pqLsE60DcJ5TDY8f5ILWbibNK+n9bUeXmKSXhE4ptfHzasCrjzR
         unAQ==
X-Gm-Message-State: AJIora+ezn7761+hBFHVzHAXtYyrzyrcs2d8FFAcndJtuiU+TgkLdCcl
        ewvIRHNrKTbf9GHppdtxYnBSBwQmRSIxCoLnQWS+aTpBS8ALjA==
X-Google-Smtp-Source: AGRyM1sOF4caZ/Mzb7i1HwUB8dyXYAmjf9y+Pd1nVHRKiUHeMR6opOrMc10oZNu5DLkN2HS0cpkKNGEh0T+MU99Jmes=
X-Received: by 2002:a81:5747:0:b0:31d:1bb8:65b7 with SMTP id
 l68-20020a815747000000b0031d1bb865b7mr30830046ywb.168.1658170865217; Mon, 18
 Jul 2022 12:01:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6919:4004:b0:cc:50ff:b3d8 with HTTP; Mon, 18 Jul 2022
 12:01:04 -0700 (PDT)
Reply-To: lilywilliam989@gmail.com
From:   Lily William <sgtalberts@gmail.com>
Date:   Mon, 18 Jul 2022 11:01:04 -0800
Message-ID: <CALPTejMFgL0Bg7jCKa7j+5KxVv_jnSM4ZPq-QhHCiUpG_ZswsQ@mail.gmail.com>
Subject: Hi Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Dear,

My name is Dr Lily William from the United States.I am a French and
American nationality (dual) living in the U.S and sometimes in France
for Work Purpose.

I hope you consider my friend request. I will share some of my pics
and more details about myself when I get your response.

Thanks

With love
Lily
