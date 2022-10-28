Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E3961158F
	for <lists+linux-serial@lfdr.de>; Fri, 28 Oct 2022 17:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiJ1PLS (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 28 Oct 2022 11:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiJ1PLR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 28 Oct 2022 11:11:17 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1341DC0A7
        for <linux-serial@vger.kernel.org>; Fri, 28 Oct 2022 08:11:16 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id d3so1908093uan.4
        for <linux-serial@vger.kernel.org>; Fri, 28 Oct 2022 08:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=huYKu3zCGUAjNe1V+fwzWUibgp5qt9T7Bp033OSK+pw=;
        b=H06sIArNmMbKUshTpaxUcEaZryiYkJjUrXdxKAF2CpbnnKxYQHni62AXv8Hshe0VKV
         gYHTWIxBsBBTwVYtgWR/W085mX00UCsb6UmZvvwYmKHsxIOVY4b3ncwsUKxdXW76GJy1
         X53iYuq6SPSoHbCzWUsYqpcXgVt6beWRiH6O183+cKkpKucRHW9XeJzKMuNif+Ki1mQX
         a45lzBVNKSkB5MeGIJv74I4J3w4DVbCP6/AhNHJ1pvktefqa2YZxXf9fW2oBX/EgATqe
         i4uTUTDuMh8WUPzehTK7wnPMzgmtf2TuSC6bGp3EZoECdivUeYTsOYOKDZ28gHuTQTGv
         tUaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=huYKu3zCGUAjNe1V+fwzWUibgp5qt9T7Bp033OSK+pw=;
        b=jJv047vZh61dsRG1wqgyvZA5aHcSk8TaiswlAZoBwZn06Dy9u60IkiFzcNMkZou5I2
         ZzwBPD4llOtPP09m6OUFXOYkbqBwalN+2ARL8NG+m3B/vaT+AWPfiGJdgnp7UwKN1JCf
         tR4HumzSsDInRPxJi25hxlYqSy2COapNkRaG7uA32Ky/jMqLaBWmu0OMVAiFX1Xn6OUu
         XX9c0c9+F6AG3WLOnmbQoEjDBfdKAYZue45BLk5rSDT1sV5JA9qW+adei/VuWGm0YIDP
         4tKVZk2DxGryNeP4evX2yJYNsFUOva2eBraKGtKkIzveag2LHtm6PeSPBc89Zl775bmv
         +OVg==
X-Gm-Message-State: ACrzQf1v7b4nYf10c4uOci/PMOZRGsuuGzBOwa0AtU1nP74qGfEutpCt
        J8VLbWBJlnKEOMCDedh0CPpb+VermSLmAB2//iU=
X-Google-Smtp-Source: AMsMyM5MlpT3ZMmRUoEMQOemKXqIecSZm1GpGTzRfdAZg8FBAko8pw5Rn7uSXGHwsOxEOADHZjPyN6x+cYAxOh0JQBs=
X-Received: by 2002:ab0:2546:0:b0:411:2adf:98ad with SMTP id
 l6-20020ab02546000000b004112adf98admr43557uan.72.1666969875120; Fri, 28 Oct
 2022 08:11:15 -0700 (PDT)
MIME-Version: 1.0
Sender: hamp56690@gmail.com
Received: by 2002:ab0:274f:0:0:0:0:0 with HTTP; Fri, 28 Oct 2022 08:11:14
 -0700 (PDT)
From:   Pavillion Tchi <tchipavillion7@gmail.com>
Date:   Fri, 28 Oct 2022 15:11:14 +0000
X-Google-Sender-Auth: t5DzOAD-YJBXcwEVmZnnZFkNJQE
Message-ID: <CAGPqaA5zQ0nWJddcZp04sUZxDR8sjA7n5edPBJCXXnCEcbtrfA@mail.gmail.com>
Subject: Hallo
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

-- 
Hallo
Erhalten Sie meine vorherige E-Mail?
