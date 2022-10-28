Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44AD161159E
	for <lists+linux-serial@lfdr.de>; Fri, 28 Oct 2022 17:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiJ1PQS (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 28 Oct 2022 11:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiJ1PQO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 28 Oct 2022 11:16:14 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96523196EDB
        for <linux-serial@vger.kernel.org>; Fri, 28 Oct 2022 08:15:24 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id y14so13643485ejd.9
        for <linux-serial@vger.kernel.org>; Fri, 28 Oct 2022 08:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=huYKu3zCGUAjNe1V+fwzWUibgp5qt9T7Bp033OSK+pw=;
        b=DRBR8Gt5rK3lvlnfUunfI45nnZxBmRZOIBi+s12jFupA7imnvF7Q/vpHeJ3je5J7tT
         4+RycvkhuJW9XLWwZh5j4UMICuYyf3rhxNwmExFnMrwu7M3S/U5DohJtniR4WeSRiAah
         WpkNfhsGBRLgOfdrBB9rOTCG8meHOs5b35Yl5aYGZw/YRfJ2RTN0oaXjox9yBq+ErItL
         tAhj35ppZkga+kVDDSjYSoJ6kvjwL0XHcDdeVEwVNYzzKys3/kEMJfYc+CAQcn3WPXMZ
         /lFGJjxIZBJI5Ex5tTFOLQQMj0xsOCXKNHFm+9KAtmez2xQIUIvwyevZSzAG5Cp+Q/Rb
         MmpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=huYKu3zCGUAjNe1V+fwzWUibgp5qt9T7Bp033OSK+pw=;
        b=36wg8i4w/Owo5xKgrdPfB48jPJ5loqJLhYpthPbqCQKgGtYuyeztsdoymRJpFM3DsB
         6SbJPL+qaGZrIjUFgbp1mOxrCBX74ccVLW3DBdZFU/Cp+orNwEdDvcP7FN2oE5GhOKob
         IXYx+ySCiSFl312BI/u/aOkapxX3duD0AWKHsDbn2wXShFyUJIMQ6qBFMIAQSdIj+xus
         RUcUyj4wpR7FQgQDAtE8/Ccd9y7zKiNCp5H+N+7OqLTt0IDQERSHq4SIav//15R8JV65
         bdwQP8RwcYoebVVBumxNgF646Mzc+80DTJq0E7FZzohs4kZbXdrYyAq43ZRsYqremrDA
         AjdA==
X-Gm-Message-State: ACrzQf00gjFo4xNexYTfuAvADbcfxXLXILOcUeOU2jYh3aOEjmqJ3RC2
        MpsU8ItPOuAehrSTKNvK4Xv1SmUPGkiU53iSkbU=
X-Google-Smtp-Source: AMsMyM73T7sQinBCzLekjAyDwAmNbnozGWE+kGcpD0tocJ9mTYKW9DGs1JYdQO+Swp/Gs9Qswqxcnlr6878Xglf7kKg=
X-Received: by 2002:a17:907:2bd2:b0:7ad:9ada:a6ca with SMTP id
 gv18-20020a1709072bd200b007ad9adaa6camr4401791ejc.637.1666970120209; Fri, 28
 Oct 2022 08:15:20 -0700 (PDT)
MIME-Version: 1.0
Sender: paanhamzi178@gmail.com
Received: by 2002:a50:200c:0:b0:1da:a9eb:12c9 with HTTP; Fri, 28 Oct 2022
 08:15:19 -0700 (PDT)
From:   Pavillion Tchi <tchipavillion7@gmail.com>
Date:   Fri, 28 Oct 2022 15:15:19 +0000
X-Google-Sender-Auth: to3QvOH-BD2_u2jdNI1g9gMEaB8
Message-ID: <CA+gcyoUsT6dUmTVj4c6XtUwbGvM+8DErPa7wRN79coBBmkk2sg@mail.gmail.com>
Subject: Hallo
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

-- 
Hallo
Erhalten Sie meine vorherige E-Mail?
