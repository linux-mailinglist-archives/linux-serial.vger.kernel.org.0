Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75EEC5EFF15
	for <lists+linux-serial@lfdr.de>; Thu, 29 Sep 2022 23:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiI2VJd (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 29 Sep 2022 17:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiI2VJM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 29 Sep 2022 17:09:12 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DD61BBEFF
        for <linux-serial@vger.kernel.org>; Thu, 29 Sep 2022 14:08:45 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id a129so2936801vsc.0
        for <linux-serial@vger.kernel.org>; Thu, 29 Sep 2022 14:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date;
        bh=a/4gJxYFUflekDqu/7BIxC8IwRhmkcL7ufJZYwUJhJs=;
        b=R5TZJFfzjDdVHlS0JDkykfowudaEFNUaOSkvUrPiadaq5uIQrwotLFns4vaXKXZhWZ
         tuvBXDxk/95/oDVdCw5PpVv3nHfyYk2gyaWXlKGNI+ixhnYy2az8VEDhFi5bNLZ+8JZR
         Fq9MUsYQWi/pVVho9vXHp9BmZmlvrTx+wItMNg7UPb5B2ho7WG+eHKGAee9PmAPBBPC/
         mlSYi6t/s+Vz3f19rUMJIwJobx6RKdSwvNn1V8VFcctxbsMlzWvouDbQWNeGKShNMHke
         15urtxmDKvgLFi3vrIh2oZbNaRhk9LrMCy5hgTRUiALxZKLF/PsT53VIbTrq6sCJz5uT
         IAcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=a/4gJxYFUflekDqu/7BIxC8IwRhmkcL7ufJZYwUJhJs=;
        b=vkWze5EuqIKNMD+bOZ2Z6C5NowztVa46L6+8JFqsoDa1nZejc9AZ93IhO3iDz4GsDM
         r8NHbbdJ7oHyEQxc0wa6KHqH9dKWoZgqpatUipEYSS8y263S9BeW7zW5rx40qwdW1Ywb
         4Yg5s2LvCL+/dIcSBDYWkMKhDasQcUfF7zhFZFOZkY+yGBWAC5Y2HeH/1+zG0eHHyh1H
         itHlC0e/AA6p8ztPBCEEmWDDJX66wqOs0UnbSa8jTuxDsQsf+hh4l0YH1W7jc5QcCsRY
         DRQ662q/ylb9DNYic6ThhR9RstsOcqGg9+bJkWQ8WLQOobDju7xnVoJvmLBkOELv1tUq
         Vaow==
X-Gm-Message-State: ACrzQf3RSwbDc2zYf/WM3oljNfSja6d7pQPYsI5Q6MqsCgBlDVZL4gXz
        v0EBu5+Leow/xaITkF7+OqSkqKGoahF5bSj0PsA=
X-Google-Smtp-Source: AMsMyM5zN7PhIhSRNChl8O0iIlB4qusgl34Jz0tchmp036TH7mk0W6ZZTBHe6SLQvN5owwIbDTDXdCBQOOf5CuaruZQ=
X-Received: by 2002:a67:d704:0:b0:3a5:de42:fe2e with SMTP id
 p4-20020a67d704000000b003a5de42fe2emr2969954vsj.9.1664485723963; Thu, 29 Sep
 2022 14:08:43 -0700 (PDT)
MIME-Version: 1.0
Sender: christiangnansa05@gmail.com
Received: by 2002:a05:6122:c9b:0:0:0:0 with HTTP; Thu, 29 Sep 2022 14:08:43
 -0700 (PDT)
From:   Tomani David <davidtomani24@gmail.com>
Date:   Thu, 29 Sep 2022 21:08:43 +0000
X-Google-Sender-Auth: 0gSuSLFVGi3fyOLEa4LCA7UE3OM
Message-ID: <CACuprae0A1b7mEQuVqAh6jM=z5rc_UjLAHurRDHVUWNZVRme5A@mail.gmail.com>
Subject: Opportunity
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

Good evening,

I want to discuss a business with you if you are interested


Regards,
Mr. David
