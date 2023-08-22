Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327C2784E97
	for <lists+linux-serial@lfdr.de>; Wed, 23 Aug 2023 04:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbjHWCQx (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 22 Aug 2023 22:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjHWCQv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 22 Aug 2023 22:16:51 -0400
X-Greylist: delayed 902 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Aug 2023 19:16:43 PDT
Received: from symantec4.comsats.net.pk (symantec4.comsats.net.pk [203.124.41.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB71E4A
        for <linux-serial@vger.kernel.org>; Tue, 22 Aug 2023 19:16:43 -0700 (PDT)
X-AuditID: cb7c291e-055ff70000002aeb-06-64e5539c7d98
Received: from iesco.comsatshosting.com (iesco.comsatshosting.com [210.56.28.11])
        (using TLS with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by symantec4.comsats.net.pk (Symantec Messaging Gateway) with SMTP id 03.12.10987.C9355E46; Wed, 23 Aug 2023 05:32:28 +0500 (PKT)
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns;
        d=iesco.com.pk; s=default;
        h=received:content-type:mime-version:content-transfer-encoding
          :content-description:subject:to:from:date:reply-to;
        b=I919c5iou+2apJpSue2Vy7KzlAWMIrOa8DqKlT+Y6Kasgncc6KmsDT6EoEukqQmxE
          wT7xQqGfzULr30LhLhOwc57hryGQ6a2hDDSlgbZvHtrxMq3pPQJykznwQ/2PUC6Dj
          tmWGelgG7NlpRqWyInmZh5SSfP51Y1iIbKzdl56M0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iesco.com.pk; s=default;
        h=reply-to:date:from:to:subject:content-description
          :content-transfer-encoding:mime-version:content-type;
        bh=GMzYzcyTxDsE6wX/XHG6MHqAdAiHrhqbmmLQ/TZ1QnQ=;
        b=bVUJPjkPIfQMoUnhMpvf5lWPU1oKpGZSjREMvZlQpBKuB7fux4I8KTaFWAXNte3LH
          Tbd8mj2gcPjF7BYWsxU0nJB1LLZg2NTuIrfthNG0EnWPVj9c5TkxGV4uod77zA9/2
          uXzeT07Pp6mqWQnu6OUYhWD3pgZXpJB6w4KDjAMUo=
Received: from [94.156.6.90] (UnknownHost [94.156.6.90]) by iesco.comsatshosting.com with SMTP;
   Wed, 23 Aug 2023 04:31:07 +0500
Message-ID: <03.12.10987.C9355E46@symantec4.comsats.net.pk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Re; Interest,
To:     linux-serial@vger.kernel.org
From:   "Chen Yun" <pso.chairmanbod@iesco.com.pk>
Date:   Tue, 22 Aug 2023 16:31:21 -0700
Reply-To: chnyne@gmail.com
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsVyyUKGW3dO8NMUgw2HDS3OLO5ld2D0+LxJ
        LoAxissmJTUnsyy1SN8ugStjyboLLAW7mSva+hexNDA+Zupi5OSQEDCRmDl/HmsXIxeHkMAe
        JonlV1YzgzgsAquZJbbumMQK4Txklmi4fpgFpEVIoJlR4tARzS5GDg5eAWuJ/hOpIGFmAT2J
        G1OnsIHYvAKCEidnPmGBiGtLLFv4mhmknFlATeJrVwlIWFhATOLTtGXsILaIgILEm5aXzCA2
        m4C+xIqvzYwgNouAqsSMpZPYIbZKSWy8sp5tAiP/LCTbZiHZNgvJtlkI2xYwsqxilCiuzE0E
        BlqyiV5yfm5xYkmxXl5qiV5B9iZGYBCertGU28G49FLiIUYBDkYlHt6f656kCLEmlgF1HWKU
        4GBWEuGV/v4wRYg3JbGyKrUoP76oNCe1+BCjNAeLkjivrdCzZCGB9MSS1OzU1ILUIpgsEwen
        VAMjb9FDzUx+pw8reJVCAudYPdJZEXyP0XLr3T+Br2Y/ZDupJ3c61maxzOrklxbFfi//Zz//
        o9Z3LOlbzZe4p/71gncXHedsrFz3vrlcX2Dy052Tp0o2yEo/EMnWTdI4/PDh9srTDILhkV/i
        JblUuZ+5X4u+EbznWseNQ4+UTHpYHPUs9ySrxDEpsRRnJBpqMRcVJwIAe81Blj4CAAA=
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        RCVD_IN_DNSWL_LOW,RCVD_IN_SBL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: iesco.com.pk]
        * -0.7 RCVD_IN_DNSWL_LOW RBL: Sender listed at https://www.dnswl.org/,
        *       low trust
        *      [203.124.41.30 listed in list.dnswl.org]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [94.156.6.90 listed in zen.spamhaus.org]
        *  0.1 RCVD_IN_SBL RBL: Received via a relay in Spamhaus SBL
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Re; Interest,

I am interested in discussing the Investment proposal as I explained
in my previous mail. May you let me know your interest and the
possibility of a cooperation aimed for mutual interest.

Looking forward to your mail for further discussion.

Regards

------
Chen Yun - Chairman of CREC
China Railway Engineering Corporation - CRECG
China Railway Plaza, No.69 Fuxing Road, Haidian District, Beijing, P.R.
China

