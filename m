Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1BA95A7EA8
	for <lists+linux-serial@lfdr.de>; Wed, 31 Aug 2022 15:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbiHaNXw (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 31 Aug 2022 09:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiHaNXs (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 31 Aug 2022 09:23:48 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED2BC8742
        for <linux-serial@vger.kernel.org>; Wed, 31 Aug 2022 06:23:47 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id 193so4120329ybc.10
        for <linux-serial@vger.kernel.org>; Wed, 31 Aug 2022 06:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date;
        bh=DnjnZSajfNgAzpK5ym8unXyyAyM+qS8cquz4gOGGtuU=;
        b=oIowiPM1/UbQb6FgwwkGzMKffOMoCYtqtmXPDiW94Xxv+cHuo0b/RW5nuXq1u0G21R
         B/fFtI5pEaDzRqYbzPeb2KbN041o1htjjIBQEylaQ6ZNM92zvFQ43ltpc6tVTbLRBAi3
         a5fz1kax2j3XDDTRzYxmq+AVJPJXCDeVtZJnlRV2KS65Z2x8XacYPiN4TB17A3TVBF2O
         pZcpu4ii4i82Y0QrNvshOkXjToVQS61ZneLXCdN+gIdTwL++3E76TLve5TZO0+lgNQ+X
         /FQ55Bv2pCxtUg40rG4SyKoQRwfPDEx/dO4zun7Ko3aISFw90oNkrVSwi4naUEkHw2NM
         kHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=DnjnZSajfNgAzpK5ym8unXyyAyM+qS8cquz4gOGGtuU=;
        b=bi+h23YfQFQ7Ko8b1GC3EyLzWGx765K4BdS6Bb29L2qFcqEfbtzHMJU1sOgAod3dzg
         R9uzhY9D+nrEGTxPmrYcdA7VODM9IQlhqdtnxbikS59lg2E7gRK6IS2YW7qlP6T+Bv+a
         YIX1mvnCOPk69vLwchrieUy8td1hk9rhM35xYgEB5NhXaaps44k7LwkhUs7Yn+PLNpEq
         jFf37o0x7HtSp/3xInEhVRsPcOjjn+Rwi9sE74v2ooPjH1k7h8uS95Pb9zlV6XxWEDCt
         NF+RzGd5TOi5EMfceYlN623/7KkCDkE+gHOcuSP50DWTuCn5Zle1N9ZtFUkWdUXivd8V
         vmtQ==
X-Gm-Message-State: ACgBeo09JygdnhL68XcfgT9BWNE00iRom/pTOL2PnfJcxQQ+6ax5YMD+
        Jgs0CpbeVv22pjmqJdIzLOdZIvQztoFCZwOL1Ls=
X-Google-Smtp-Source: AA6agR44YotKhdmzsNa8y7Zsy+eexQ66Q7DWEaCyMqmHMRoQfJvt1jPn2517KBpPOyIghvZJR7ddE32ihJwDZ1EjJEg=
X-Received: by 2002:a05:6902:12cc:b0:695:6549:a86a with SMTP id
 j12-20020a05690212cc00b006956549a86amr15558853ybu.65.1661952226741; Wed, 31
 Aug 2022 06:23:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7108:74d3:0:0:0:0 with HTTP; Wed, 31 Aug 2022 06:23:46
 -0700 (PDT)
Reply-To: golsonfinancial@gmail.com
From:   OLSON FINANCIAL <khadijayusuf6876@gmail.com>
Date:   Wed, 31 Aug 2022 06:23:46 -0700
Message-ID: <CAEUDHmh0RYoFMBXnLWkv3KCc6bMve+z+Cs5CO5uPAap9cotcXg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b44 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [khadijayusuf6876[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [khadijayusuf6876[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

--=20
Hallo Gr=C3=BC=C3=9Fe,
Ben=C3=B6tigen Sie dringend einen Kredit, um ein Haus oder ein Auto zu
kaufen? oder ben=C3=B6tigen Sie ein Gesch=C3=A4fts- oder Privatdarlehen, um=
 zu
investieren? ein neues Gesch=C3=A4ft er=C3=B6ffnen, Rechnungen bezahlen? Un=
d
zahlen Sie uns Installationen zur=C3=BCck? Wir sind ein zertifiziertes
Finanzunternehmen. Wir bieten Privatpersonen und Unternehmen Kredite
an. Wir bieten zuverl=C3=A4ssige Kredite zu einem sehr niedrigen Zinssatz
von 2 %. F=C3=BCr weitere Informationen
mailen Sie uns an: golsonfinancial@gmail.com..
