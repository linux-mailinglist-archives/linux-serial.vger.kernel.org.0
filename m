Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0218C4E2B0A
	for <lists+linux-serial@lfdr.de>; Mon, 21 Mar 2022 15:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349515AbiCUOn1 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 21 Mar 2022 10:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349664AbiCUOnM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 21 Mar 2022 10:43:12 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E0318BCCF
        for <linux-serial@vger.kernel.org>; Mon, 21 Mar 2022 07:41:47 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id c2so10446157pga.10
        for <linux-serial@vger.kernel.org>; Mon, 21 Mar 2022 07:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=sDjPtktIyw1XYQTehtGtcrk9f/L/zhz+Abu/xqbrSZA=;
        b=g85WNlPDLm1rLsYpwFPAeq1IQOXdJ/0ImLONY9RpD0rmhWDyo6h2DbqPo7/vBO7xAg
         X8wu1J0z5WpiFUf629VbHqLXYet5HwpnIbuMlo7dBzFwtvbKj6LIv9wfyF1YYEMdVsRp
         w9nvYsdrDJkSxSZtqum6SZBQkKSz3vNpz2nX1IBYm6rj+lmQboLfXCyoITqVfpu581vy
         j/0UjSyBwWBsYK78/gE49tsW9nKwz+FfD+12zUlyZOwoXIOL7gPQIAsBDK5FMyem08fz
         tVnRibpRmZcGLUHyYu//JgXn5G4FgOu7Km9ud44dnlEiR5UDV5rAkKHHUtzq2nUzrw+r
         pBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=sDjPtktIyw1XYQTehtGtcrk9f/L/zhz+Abu/xqbrSZA=;
        b=eG6TYtRVR4SPZiK5/WG93G0T+x0m0j34ICHmhXpSqEZBHQ3VjHjKFBby1KL6BkobYz
         0tF/woN5JDRArk8bEda1Zk0qTNJ5FnEIF+9ZJfl0BCRi6WJvvlkEI6qJD6tNl9AIil5+
         hktenaUjXhqwg06OIYyDxNm51+eYW6rv/md7gZ5XJAqpWNbaGbXXBTi6FCs0DUUI6iWi
         QwfnRzRd9cxiAA3i7Jk0IsyZMBENqlO+jriIYX9LSVmhHVGFd6fTbV//BICczZhEI5TE
         6YkSWlvY4MCQReQHWWNvhgQ6JkVea45p/anrG4cdV+AEFT6fDllAirXiB/y4G8AWOH8g
         pYhg==
X-Gm-Message-State: AOAM532kLzFgNGKtQb2lFe12Se5p1F1Enw0Dr+ohbzuluKaPfKh8Uizz
        KgULIB+a8Iixqa3+93IJ0GXTqK3QfA7Q388UDew=
X-Google-Smtp-Source: ABdhPJxEnWavAtUJoZ0Zmc8zgQjPd9dTuNiwzus/2ik9pdq9tqbrHDIghsoDmvH0lS5y3onGHJoixE1a/SlQViJw78o=
X-Received: by 2002:a05:6a00:2444:b0:4f7:71bd:892 with SMTP id
 d4-20020a056a00244400b004f771bd0892mr24377985pfj.81.1647873706835; Mon, 21
 Mar 2022 07:41:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7300:7885:b0:58:1461:ae43 with HTTP; Mon, 21 Mar 2022
 07:41:45 -0700 (PDT)
Reply-To: peacemaurice96@gmail.com
From:   OKENWA2019 <aichairo75@gmail.com>
Date:   Mon, 21 Mar 2022 14:41:45 +0000
Message-ID: <CAL0BvUSn69j7di50genO1=_OEC+_T+pm=Ga1QYY4NUZ8CZw+4A@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.6 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

I also wrote you a previous message two days ago but no response from you,
