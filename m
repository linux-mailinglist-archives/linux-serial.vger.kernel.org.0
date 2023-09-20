Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942AC7A7478
	for <lists+linux-serial@lfdr.de>; Wed, 20 Sep 2023 09:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbjITHmu (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 20 Sep 2023 03:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233793AbjITHmu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 20 Sep 2023 03:42:50 -0400
X-Greylist: delayed 377 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 20 Sep 2023 00:42:43 PDT
Received: from mail.venturelinkage.com (mail.venturelinkage.com [80.211.143.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC06DCA
        for <linux-serial@vger.kernel.org>; Wed, 20 Sep 2023 00:42:43 -0700 (PDT)
Received: by mail.venturelinkage.com (Postfix, from userid 1002)
        id 395E5826D0; Wed, 20 Sep 2023 09:36:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=venturelinkage.com;
        s=mail; t=1695195385;
        bh=7iowqdzve/IIiUUjcEwx8j3uMrVqqiE7R9zbOCKRV9Q=;
        h=Date:From:To:Subject:From;
        b=egE3XCkbgYh0fWVabaSeI9B019KYqs5th2oVZ/pxhmKhSz7c9K1orQvTts/DTuXk7
         joR/JmEik0S8akV7/Vd4WxHDVZbFd5rogiq1WRLEIu0WTmRm0iTLLDzluFrJb7Vmol
         X0O06O5U5xu4wRezO2ewQ0NLi8OlbksIea2mo6bLCo62k1MTTfkiShbzovVzMajDXN
         fd7RAu4q3vNrDx4xQ/RVb4GQCmtMQE+y/eMKNDuOO/32pU6TnpVflrGCxY10yJpV/3
         KfQ5ghrUmHaZ/SiWrdhlL/qLkWAnqTDs/bvSHBdpCQqGEx+NvzTQc7jG7oJh4VxZBK
         qnNKghb9ht2Xg==
Received: by mail.venturelinkage.com for <linux-serial@vger.kernel.org>; Wed, 20 Sep 2023 07:36:09 GMT
Message-ID: <20230920084500-0.1.l.11ia.0.8by7dn1qg2@venturelinkage.com>
Date:   Wed, 20 Sep 2023 07:36:09 GMT
From:   "Lukas Varga" <lukas.varga@venturelinkage.com>
To:     <linux-serial@vger.kernel.org>
Subject: =?UTF-8?Q?Popt=C3=A1vka?=
X-Mailer: mail.venturelinkage.com
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.0 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_FMBLA_NEWDOM28,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        URIBL_CSS_A,URIBL_DBL_SPAM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: *  2.5 URIBL_DBL_SPAM Contains a spam URL listed in the Spamhaus DBL
        *      blocklist
        *      [URIs: venturelinkage.com]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [80.211.143.151 listed in zen.spamhaus.org]
        *  0.1 URIBL_CSS_A Contains URL's A record listed in the Spamhaus CSS
        *      blocklist
        *      [URIs: venturelinkage.com]
        *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [80.211.143.151 listed in list.dnswl.org]
        * -0.5 BAYES_05 BODY: Bayes spam probability is 1 to 5%
        *      [score: 0.0423]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.8 FROM_FMBLA_NEWDOM28 From domain was registered in last 14-28
        *      days
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Dobr=C3=A9 r=C3=A1no,

Dovolil jsem si V=C3=A1s kontaktovat, proto=C5=BEe m=C3=A1m z=C3=A1jem ov=
=C4=9B=C5=99it mo=C5=BEnost nav=C3=A1z=C3=A1n=C3=AD spolupr=C3=A1ce.

Podporujeme firmy p=C5=99i z=C3=ADsk=C3=A1v=C3=A1n=C3=AD nov=C3=BDch obch=
odn=C3=ADch z=C3=A1kazn=C3=ADk=C5=AF.

M=C5=AF=C5=BEeme si promluvit a poskytnout podrobnosti?

V p=C5=99=C3=ADpad=C4=9B z=C3=A1jmu V=C3=A1s bude kontaktovat n=C3=A1=C5=A1=
 anglicky mluv=C3=ADc=C3=AD z=C3=A1stupce.


Pozdravy
Lukas Varga
