Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8702D511250
	for <lists+linux-serial@lfdr.de>; Wed, 27 Apr 2022 09:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353996AbiD0H1V (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 27 Apr 2022 03:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236000AbiD0H1V (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 27 Apr 2022 03:27:21 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9299469290
        for <linux-serial@vger.kernel.org>; Wed, 27 Apr 2022 00:24:11 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id v65so1064543oig.10
        for <linux-serial@vger.kernel.org>; Wed, 27 Apr 2022 00:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=4vfQyttDdobHbBrio36ZO852PxT9+1cO/BhU8vf48uk=;
        b=p4SAxTuh8CdBMPFvXnVOofzMuWnq5TfijM4SIX9sUqJoOPp6uAEONTOgirMQu32iTe
         YHn+obR6gGMqD2mZo0h0J338c6KV+4htwrOMaiF3WIBjqByW1O8JUehLP6AoHejXYe2t
         ExvfW0/hTdERkGmqBo+zJH9Vjcj8ybw98bAoNNyw+whszg9KKRS7hHIo3gwP+qPMi3nJ
         PSacFTezi2Dhwu1PsR58HH2ox18Y0R/OjhGe3EPBRwS7yLSt7Rpz04hBPTb0Ou4wOPZn
         cZ0tt+mobSiOqKXUNjVi/m+dR+599pRyGhkQZxEgWCzzvqp/PY5Q/K3/oEIRFbHZ0Bae
         SVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=4vfQyttDdobHbBrio36ZO852PxT9+1cO/BhU8vf48uk=;
        b=pwY1lV57oTs0FO7qMl1Fw7hBwVBCysTjxPeQ0Zszt9aXIcVCa94dt8sq6v9cAx6aHj
         amUkVgCVacZ3X6GgCchZf/JYO4EJj2YWsLDCPJcHFQpLx/FWq7Z3JgmCGvDvHRTQ5y6v
         k2cLz56uVFrW7rYhSMgUL9QMdht+w0rHAtdc+vNr/cHvTHIrXwiedC/gmlYDi4LJNulS
         cOd+7N3yUjOMBNQhOkhjv5F9K2i5xaEOKHd0Krk5E+Y08zoQuBxb4KkMM51gL2X96bTY
         w3AXLcQo5J/iHPpzfsQR5UznLjxFOOIJcqPyR4ilYJR5BETHQXboazp6UZw2dVO44S/B
         QStA==
X-Gm-Message-State: AOAM531TQehIGRwesxC9ZCPTbkRJVY8HFKHCKaJROPVcdMy2pPjjkc5O
        i3xa1TUutViwzalnBMTuN/dR+9Ft2B/V+0LtsSM=
X-Google-Smtp-Source: ABdhPJx4fKzn+pkiLhyllQS26dgsYYWonCfiv7h/+RuUqPTRjKW8hGxwX5QwqR7cp+bjBt2tZlwcTj86+TtCQgOM1hU=
X-Received: by 2002:a05:6808:1ab4:b0:323:e309:facc with SMTP id
 bm52-20020a0568081ab400b00323e309faccmr11709131oib.205.1651044251013; Wed, 27
 Apr 2022 00:24:11 -0700 (PDT)
MIME-Version: 1.0
Sender: ogbundubuisi2@gmail.com
Received: by 2002:a05:6850:d38b:b0:2ec:1f4:f345 with HTTP; Wed, 27 Apr 2022
 00:24:10 -0700 (PDT)
From:   Hannah Johnson <hannahjohnson8856@gmail.com>
Date:   Wed, 27 Apr 2022 07:24:10 +0000
X-Google-Sender-Auth: PdQLBw-zt2HmOx-RUjkteSEkMf4
Message-ID: <CAGPSnpi90G2=bM0MHUV2Bf01+cdZGye6km5ZeJ1PQM36hQDRoQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

-- 
Hello
Nice to meet you
my name is Hannah Johnson i will be glad if we get to know each other
more better and share pictures i am  expecting your reply
thank you
