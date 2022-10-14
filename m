Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCEF5FEB2B
	for <lists+linux-serial@lfdr.de>; Fri, 14 Oct 2022 10:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiJNIwF (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 14 Oct 2022 04:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiJNIvh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Oct 2022 04:51:37 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D5C1C492B
        for <linux-serial@vger.kernel.org>; Fri, 14 Oct 2022 01:50:40 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id h12so4389499pjk.0
        for <linux-serial@vger.kernel.org>; Fri, 14 Oct 2022 01:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ng7mcmr4QJ6ZL7X9dSXkz6scbTE1whqwn58ZUV1v7fU=;
        b=fl2DDYb6sXIUk+qaBL13rlS9GoxSjIN7An/O2MV8JX9SMYz9XToI3mTg8mdjaXEwF4
         b+UHSSSnwNCpi7/LHm6oo/GiN9j/9V1IAZIotyj/JIIDm4uFGgPylrfUNLfXTn31mlp4
         jBMUdqParK4xBjG1b8z//l9kseFfYIwWlsTKduZdNr81Fp91zNCMZR+gFWUHAuX4mmtc
         rGO+bEzplHd2QQDcbiDac1iPuEXe+oUFnkQwKEVaEowCE5VwxseDcs8zB1BVGOKexX0T
         HCb0P6e4hLZjjtmc2d07r6//iA/NfCNyVTUbtzy+K2/neclaOKfPZXFqDvXrT1p/qpsw
         7O3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ng7mcmr4QJ6ZL7X9dSXkz6scbTE1whqwn58ZUV1v7fU=;
        b=0qLZ7hm68a6C00Y4eV58O/Ae2vGIGdM0JSNvihs/gjra3E3ZI05yAv0cWCs1I4Fp09
         GJFi/NpwCi8uUR0CnGEOZytlEPSyj7LFeR3ehkqeCclsZVauZWXqbO+/6Xg475ueRYZ8
         bID+F2Eh31rrpPQtL6jPvLdkbrpuN4iD6WVppKutt2BseFq4udTSdYyKqt70rOTfwf25
         IhH8kjz7wmLiTJTfvxnFEOa0quNkq6OsmsOGucNyFC3GecAxAl4uOVjYOrgg2V2NQceN
         thU5+D5EkxO+SSpjZ09N9BkJAeeUC7D+oAhbcHznOX9fnEY0XabfjSA99q92wIjhjtAF
         w+dg==
X-Gm-Message-State: ACrzQf2owMwip8aARrxILcSZtrzkgbvf+hTrkjvNPnZe8jNLuv/pVc/f
        xEa+imlrdSJyfQapUdDj7/4/+ERF6KfYuWUuK5U=
X-Google-Smtp-Source: AMsMyM6Gki/zibqvO4IUgq6AOHNg4UurZbkRSjnNzOHtUw9ZXTifNl1yRiqLhPXHcg0Trce5ObeLDauGmNB586RL02s=
X-Received: by 2002:a17:902:c241:b0:182:a32f:4db7 with SMTP id
 1-20020a170902c24100b00182a32f4db7mr4093749plg.131.1665737439596; Fri, 14 Oct
 2022 01:50:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a11:48e:b0:2f5:1f00:a707 with HTTP; Fri, 14 Oct 2022
 01:50:39 -0700 (PDT)
Reply-To: stephenbord61@yahoo.com
From:   Stephen Bordeaux <baslealio.58@gmail.com>
Date:   Fri, 14 Oct 2022 09:50:39 +0100
Message-ID: <CADG+sOauq0k+wqigL2_kC79B-9gjhV5=WvFGZBMgDTq4R1Oaiw@mail.gmail.com>
Subject: =?UTF-8?B?TcWvxb5lIG8gdG8gcG/FvsOhZGF0?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1043 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4202]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [baslealio.58[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [stephenbord61[at]yahoo.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [baslealio.58[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Dobr=C3=BD den

Jsem Stephen Bordeaux, pr=C3=A1vn=C3=AD z=C3=A1stupce z advok=C3=A1tn=C3=AD=
 kancel=C3=A1=C5=99e Bordeaux.
Kontaktoval jsem v=C3=A1s ohledn=C4=9B poz=C5=AFstalosti fondu zesnul=C3=A9=
ho Dr. Edwin ve
v=C3=BD=C5=A1i 8,5 milionu dolar=C5=AF, kter=C3=A9 maj=C3=AD b=C3=BDt repat=
riov=C3=A1ny na v=C3=A1=C5=A1 =C3=BA=C4=8Det.
Nav=C3=ADc v t=C3=A9to transakci chci, abyste odpov=C4=9Bd=C4=9Bli d=C5=AFv=
=C4=9Brn=C4=9B.

Stephen Bordeaux
