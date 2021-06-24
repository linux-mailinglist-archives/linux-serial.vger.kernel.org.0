Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B655A3B3463
	for <lists+linux-serial@lfdr.de>; Thu, 24 Jun 2021 19:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbhFXRLx (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 24 Jun 2021 13:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbhFXRLw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 24 Jun 2021 13:11:52 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66556C061574
        for <linux-serial@vger.kernel.org>; Thu, 24 Jun 2021 10:09:31 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id r12so9164021ioa.7
        for <linux-serial@vger.kernel.org>; Thu, 24 Jun 2021 10:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=ANhbTggsY3NFhRZExKMwUmb3VzJqye8XLvWVXSvNBkQ=;
        b=p95plxgcKdT8+TUJCmcKdAyJL6L8C+j3muAeTI6tbvEOMwKUFZvBH22Z3GEGxdnUZH
         d9XkDasjcz/bUj2n1PkWxPPQL/Sxtf1a7ckN43IkWwU4a9v6DYeOi9Tg8DPYHl700hH/
         xlmv54Ir2NUVB8zwaX1UsxTzP5GUW3mdywmszCeflzWKbXzDgkMNhx+qVsi3FklHnD5x
         fSDWvxz3POXOJ/0yZM+F2G99rPMTFJK+bPA5TWYu0VJpvpEjmQwRSgXLB6dx+kXpC0Uz
         JX+JhI0lSB7VkwJTdkbApCrUx6TGzp99N5mAm/d0lil4hmexz93RFAPSpMzmwkjNchKB
         rXTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to;
        bh=ANhbTggsY3NFhRZExKMwUmb3VzJqye8XLvWVXSvNBkQ=;
        b=ibW1dpR2eBusIH2BP7/7Vpu8wsfpwdOVkRFPftELsG66GZOYpEpxtsQwQDIl/nR+Rp
         QtfsC6r45LpFEsLOxDCA1VfbWgC6gW5WMsg2gCZyuEu71yn+TFeTOA1BzfCbLt4j0CsC
         0FwLuDAOOtRGMPHij8VjekC6QaZENehikI70WO3vRF7JWBexy/25w0FAoRbFCl64SWgY
         wRVLQhCEc9hosqYuqnUp3a/Q2Lzar93sZQIWuDPZ6vNIqIuXVKzggEI3+xC/bgtzGtn5
         +ce3fOzbHhzF5g3gUx178zjBStuof7z9j2kFC7YGI2JeNQWnuLgmGI+G6wIW0W+kWgvc
         zF1g==
X-Gm-Message-State: AOAM533iEAtGaE3d0yNsoxVmDJWvdgjpAs3nskspepjQGEsexT27MHyT
        fT/PUYFZeEDvtgLGUm76VY3lx6YjbKlotJSppA3qMUnZXWaY7w==
X-Google-Smtp-Source: ABdhPJzkYUuO368jts0QgMQyJe9SHzg0U698qd8KdfojEfYsXnHtwMfPGxVHmw7fwQ64+IhHRhAEJH5nusdeW4BWzcA=
X-Received: by 2002:a05:6e02:524:: with SMTP id h4mr4098121ils.255.1624554560853;
 Thu, 24 Jun 2021 10:09:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6638:3aa:0:0:0:0 with HTTP; Thu, 24 Jun 2021 10:09:20
 -0700 (PDT)
Reply-To: tutywoolgar021@gmail.com
In-Reply-To: <CADB47+4Wa3T59Vq_==GTXEfHrX5x-2vQFxaTBO0dTdyAweCVpw@mail.gmail.com>
References: <CADB47+4Wa3T59Vq_==GTXEfHrX5x-2vQFxaTBO0dTdyAweCVpw@mail.gmail.com>
From:   tuty woolgar <faridaamadoubas@gmail.com>
Date:   Thu, 24 Jun 2021 17:09:20 +0000
Message-ID: <CADB47+607zNBfYFb4bj0nUhuuYgAdwT=G_wJ9-EeV0ESHe56Jg@mail.gmail.com>
Subject: greetings,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

My greetings to you my friend i hope you are fine and good please respond
back to me thanks,
