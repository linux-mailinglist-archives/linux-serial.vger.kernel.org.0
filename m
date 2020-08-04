Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 974BE23C1F6
	for <lists+linux-serial@lfdr.de>; Wed,  5 Aug 2020 00:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgHDWqk (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 4 Aug 2020 18:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgHDWqj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 4 Aug 2020 18:46:39 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20033C06174A
        for <linux-serial@vger.kernel.org>; Tue,  4 Aug 2020 15:46:39 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id p8so7207799pgn.13
        for <linux-serial@vger.kernel.org>; Tue, 04 Aug 2020 15:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=gAGQPSeE7HOwYwavskE5e9li4T5ni5I6TXg1XHHwgN0=;
        b=S8KEZAlbl6pvkO7ScFienlfz7/lOjSs5NJ8AjO2nNQwSAA9jf7FyFqoVI2MTfy3hfd
         xNglYenipTnZmPNNbFjxBMb17c4IP83io74otsfCIAwhK+OjHwSWczqI6vCxU9aH9gPk
         aephWYw+G8XJnsPkcLYd5bIcKOypn3p/HEP5b5PQz5sWw3jSbCtzFKiqCGU0wfVMoO2N
         wsdTBJnpGRkhiA8w6yYoqDR8om5hPnw23/b9msjjnxEuVFYYuJmq1XWgIg6DF5ock4B6
         Zzv9nTRzLsuSL4rg8868rmjfK7OAQ5gotIxYuy2Q0l8TB0/OaR4c0Do9UQ1ux4Dc+uVX
         FtvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to;
        bh=gAGQPSeE7HOwYwavskE5e9li4T5ni5I6TXg1XHHwgN0=;
        b=FYxQhlPNN6W5zhgxnHORQUJgDpoUsVdbqQVQ1Ukbbr6/irT19xOFGGSXJG4bLIMCwU
         vqD02bsQelLNODx/3Of9IaU24N3KZ4AXiKQBkhc890upwd6eB8mnxIUDyhJVViT3q5Fx
         jRGM8qeSWGNCnHNB86jPKKobgMEnTU+haIxXg+5auSufy7f7Yj7soXHkFthjD6Cu9Wc1
         4Z2gNvCXdby2CqUlabf7iQOZ5ikYBuwi1tR9P5Eod3qWm9nt4m9OKKD6u6mEQxibAx25
         K6TkMnYOoRwrepOl5+wdcncjWQ3W/NElY3qv/Gbl12x/zaOjlkbkCSBTqsiNCKMQmf4R
         bGPA==
X-Gm-Message-State: AOAM530OEc1tnHEcDm7Fe5McJ5TrjPApS9FdCkHdS04Qc/JHX5g6vV60
        dNhCMIkRF9Z1jQsvtbFLREZ/0tdCixgxYA26bXM=
X-Google-Smtp-Source: ABdhPJxnxokx0yglyXAcmSR2WTppK7a6iBRSkM39vkPcUfJdw8mGt/vNafuAEiXto3IZAelY/0hytGZuqfKrjwi4/d0=
X-Received: by 2002:aa7:82d5:: with SMTP id f21mr566716pfn.222.1596581198593;
 Tue, 04 Aug 2020 15:46:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:95a4:0:0:0:0 with HTTP; Tue, 4 Aug 2020 15:46:37
 -0700 (PDT)
Reply-To: sararrobrt@gmail.com
In-Reply-To: <CAHiqPVdXrXDo2EELn8qKaQk+YABbOUxLj_c3ymENGS0AOwr3-A@mail.gmail.com>
References: <CAHiqPVf3G_DekFSQm3j+4pxZnYdgcRuK+epsfah9kzUqOEXYWA@mail.gmail.com>
 <CAHiqPVf7Rf5DAm6-T7r9Ai0thktFugvpKGY98T-tSW+wum2sbg@mail.gmail.com>
 <CAHiqPVehmZEzFod6csrvXQ8Y+dDmpXmtmyHOGogYX3iO+8ruTw@mail.gmail.com>
 <CAHiqPVfYwayR-cQ_07s7bDfQxi_FgefLTLu6RpaOkO3_PZ_cqw@mail.gmail.com>
 <CAHiqPVeM5PkXV2+CCxP06cPfhrvX3cpV6n3aE44si0_Tm6rm8Q@mail.gmail.com>
 <CAHiqPVeav29gUaW9QDXFAcp3TYfpd-uX-skTazcOENdxeyZh4w@mail.gmail.com>
 <CAHiqPVevkWmD3X+Ne=GnQDBrPanM8uSDwdRPbGuU_c3vsmnDkg@mail.gmail.com>
 <CAHiqPVeJ+Rz=kHO9V_eTpAeOtWf=Ce92DGFGnQnLoUZeReYYQQ@mail.gmail.com>
 <CAHiqPVef_Za46DwN_+F=YaCXP45brF8OGyw2rKm4OURGg1+wRw@mail.gmail.com>
 <CAHiqPVfFE=PR0c4zx0JZd2XurRrdCv+tQ4F-+LurjK-nwBXgfw@mail.gmail.com>
 <CAHiqPVdtsvEcTfGCxSGVn4d3kwQVW7_GHvwiDwSrfHupfCdLQw@mail.gmail.com>
 <CAHiqPVdL6j0VyrSSP8JAxHbqNJi3XUYSfZBkyU2rOHtR9ckHrw@mail.gmail.com>
 <CAHiqPVda4TQRzqn3hshv1QgAo4yK8pHFQaxGu3-RdmJ2h5nAyw@mail.gmail.com>
 <CAHiqPVdXSvDo51DeK1i1UFKJXyeuMvsnjX4+qhEedgA97MFUKg@mail.gmail.com>
 <CAHiqPVe_vtxaevYnmS8ooVbrH=_Y7HBJ3Vcdesqfj0tGHNNu5w@mail.gmail.com>
 <CAHiqPVdFzL2cvyFuKVxhyk+QWU1nFOR+PVHLMB+xjUOkKCqWPw@mail.gmail.com>
 <CAHiqPVfeozuRr9CN_e6BZ-Af+ap=B5wvF2QvD4MevW8HuXHwYA@mail.gmail.com>
 <CAHiqPVeT7f2-hyuSMy5EP-ai+suGt4q7pP+MjM9n-R1gzow9mA@mail.gmail.com>
 <CAHiqPVf_hAL3BP72spVgnu_mkfFif+By1HiovN=T7uHxxeu0-Q@mail.gmail.com>
 <CAHiqPVcqk6RHCYEFiMe-PadbisaaCiBeGdqYSirBz7S7kLdDZA@mail.gmail.com>
 <CAHiqPVfdjGdY7=nRVnANxOOhskWoSSED25yo8e3Vx=jvBAjXng@mail.gmail.com>
 <CAHiqPVfgyxaPbqYQgLMkzQa5errLSChnV_t0rg9mFk3ZQ-DfdQ@mail.gmail.com>
 <CAHiqPVcrL+XC1g1NpX2cAquhgbDRrnU-BL-5hzqP4W5=U-hpMw@mail.gmail.com>
 <CAHiqPVcNGgm8nXKwnbZ7=LhY+BHj+8Eg88ONYFscDRsbAyKJ3A@mail.gmail.com> <CAHiqPVdXrXDo2EELn8qKaQk+YABbOUxLj_c3ymENGS0AOwr3-A@mail.gmail.com>
From:   "Mrs. Sara Robert" <goodwllalex@gmail.com>
Date:   Tue, 4 Aug 2020 23:46:37 +0100
Message-ID: <CAHiqPVeirVoyoNc7Y6ROHRKPHCVXjXfJoHV=MtjSRj=JB0FwYg@mail.gmail.com>
Subject: Greeting?
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

My Dear,
I'm Mrs. Sarah H. Robert, 77 years old dying widow from Australia;
that was diagnosed of cancer about 4 years ago. I got your details
after an extensive online search Via (Network Power Charitable Trust)
for a reliable person,  I have decided to donate my late husband WILL
valued of ($5,500,000,00) (Five Million Five Hundred Thousand United
States Dollars) to you for charitable goals. Get back to me if you
will be interesting in carrying out this humanitarian project, so that
i can arrange for the release of the funds to you for the work of
charity before entering the surgery theater. Contact me via
E-mail at :  sararrobrt@gmail.com
Sincerely,
Mrs. Sarah H. Robert.
