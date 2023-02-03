Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64DA7689C49
	for <lists+linux-serial@lfdr.de>; Fri,  3 Feb 2023 15:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbjBCO4D (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 3 Feb 2023 09:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbjBCO4C (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 3 Feb 2023 09:56:02 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B7F3B664
        for <linux-serial@vger.kernel.org>; Fri,  3 Feb 2023 06:56:01 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id q10-20020a1cf30a000000b003db0edfdb74so5710584wmq.1
        for <linux-serial@vger.kernel.org>; Fri, 03 Feb 2023 06:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GE8LRefBbCr+vfDK+OAPRXSUgs+NOR142JeKY5u24zc=;
        b=gVLHbXSFArNyVySbKLYtIAbS7wOVw2/uF/7sFj1V2kQyD+OBs0IMZz6moOQLkH8p0r
         zuwe9faHu/8YamWSB5HU9WLJQ9uoTOqd96AjLwUffqwKAr0EKRNfb/Mq6XIkpMqEpa5C
         kUJGoC+v/lRH4cZv6btzkNVIvI2zcq8xl/PBLMSSXxk8dk7+VczpQNIZtQGSezjkcnwo
         PQ0zfatYfyrm5cdMBns4US5evzsSW+cFbSnW9jEFuXdJ4XNHz69G4XtIvQQttOfELFuX
         EVuWH65V1X9CMGuQEpKMM2T4+BgH6heHlnLQ34e1KBngPH8LyWNVvhfTMA3nv4FpsV4m
         8qjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GE8LRefBbCr+vfDK+OAPRXSUgs+NOR142JeKY5u24zc=;
        b=qBrqvAIieP6jVSB6wdBysXvTEM5N9e433EIPHoRBGuBgPWnedteacL1kyuq8G+7GvV
         jryu/HZzPu3rblyFSXfYFQRKypLbJ8AgdGRVF3EgMFFHns2og4vuRUuyymQOdo+u/unZ
         NtEEtt89oUDo6zRMH/gsa/U5ybO0wwnuWlTM1WFR89Gk8icMJECMxu/BnjBS0IO7Ho/F
         hVPZgAyDHzzUF10HdtKSnDiKcO3aK1Hesoid/p6DZ4crAxJdI0qAS1tDYscyijTbIIJv
         Z56136MmqV7z9NRVEw4jkVlw8txx3NuI0jeJfRHYpNLD8a12y7QGIjNJh4P6BMzEqkYw
         0rxw==
X-Gm-Message-State: AO0yUKUghEDB5WlRJaqD/JC1BqDI85BAEfsOJOorv5YDfdJhfZpe4Niv
        OQWthjOGgpW8pczIVt6CzJdKn2FNYNaOpQOucFw=
X-Google-Smtp-Source: AK7set8eM/FKZMeOZp5dEOwzN74dSpKypZJhDF906hgMPRd8mfG+Hg3Sg2xPhWjL9YFq34trlg5irNBxFCwrH/5B/cg=
X-Received: by 2002:a05:600c:5569:b0:3df:e1d9:8914 with SMTP id
 ja9-20020a05600c556900b003dfe1d98914mr341691wmb.189.1675436159398; Fri, 03
 Feb 2023 06:55:59 -0800 (PST)
MIME-Version: 1.0
Sender: dareadja5@gmail.com
Received: by 2002:a05:6020:4710:b0:259:ad88:21bb with HTTP; Fri, 3 Feb 2023
 06:55:58 -0800 (PST)
From:   Kayla Manthey <sergeantkayllamanthey@gmail.com>
Date:   Fri, 3 Feb 2023 14:55:58 +0000
X-Google-Sender-Auth: YeauNz1P6sTBHUxFP3WntVqGFL0
Message-ID: <CAE9bZtNgCnc6DJ4cN88CyUew6oLNNkiCuqHnaLRvYJfpCgsmjA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Dia duit a st=C3=B3r, an bhfuair t=C3=BA mo theachtaireacht roimhe seo?, Go
raibh maith agat.
