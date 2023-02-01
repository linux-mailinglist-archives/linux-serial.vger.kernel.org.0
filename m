Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF2E68605A
	for <lists+linux-serial@lfdr.de>; Wed,  1 Feb 2023 08:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjBAHMu (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 1 Feb 2023 02:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjBAHMt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 1 Feb 2023 02:12:49 -0500
X-Greylist: delayed 1831 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 31 Jan 2023 23:12:47 PST
Received: from walmailout01.yourhostingaccount.com (walmailout01.yourhostingaccount.com [65.254.253.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48E22ED64
        for <linux-serial@vger.kernel.org>; Tue, 31 Jan 2023 23:12:47 -0800 (PST)
Received: from mailscan01.yourhostingaccount.com ([10.1.15.1] helo=walmailscan01.yourhostingaccount.com)
        by walmailout01.yourhostingaccount.com with esmtp (Exim)
        id 1pN6ow-00014S-WE
        for linux-serial@vger.kernel.org; Wed, 01 Feb 2023 01:42:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=grabaclue.com; s=dkim; h=Content-Type:MIME-Version:Message-ID:Reply-To:From
        :Date:To:Subject:Sender:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BNWIenDKDE/rJsWT3z/BcBFEn9zY8Sn1XbkLDij0qSU=; b=MlAidqyIbjsdCMfhPMJK675bGH
        MDaQzepYL2ST9O+vcJK+vvHB9wls4C+mkNqzOcKsuWW+Fd8+EDYRY1aBTQsUlDdZcxrWKC+2lO8MI
        eoMjOxODiuytkwLQMSq3lSH1NCsqVz3GuNn6x5pf43Wj9RBWsQQQGcpi1PtJsgSZf39tVCT63ZEgc
        ygTyDwFNOiEu7/2izZJ7rycDh/IMkBdqBtNH0PcDJ7VIEJ7GS9oiDI+JA1LSCXui25ZcmGHQONm0Y
        RBywkFMoXt0cPfnn0XbT+HNE/ZkJxxTLJN4p3EOSvsTD4lVb4XDAPwCn0nsggrHGpS316YHGJjfoW
        Lm4aWU1Q==;
Received: from [10.114.3.23] (helo=walimpout03)
        by walmailscan01.yourhostingaccount.com with esmtp (Exim)
        id 1pN6ow-0002Ne-OU
        for linux-serial@vger.kernel.org; Wed, 01 Feb 2023 01:42:14 -0500
Received: from IIS85S.nt.com ([10.15.51.85])
        by walimpout03 with 
        id FiiB2900x1qHeCS01iiEMB; Wed, 01 Feb 2023 01:42:14 -0500
X-EN-SP-DIR: OUT
X-EN-SP-SQ: 1
Received: from IIS85S.nt.com ([127.0.0.1]) by IIS85S.nt.com with Microsoft SMTPSVC(10.0.20348.1);
         Wed, 1 Feb 2023 01:42:11 -0500
Subject: linux-serial,  please confirm
To:     linux-serial@vger.kernel.org
X-PHP-Originating-Script: 0:d3dccas.php
Date:   Wed, 1 Feb 2023 01:42:11 -0500
From:   Sello Juaquin Dabeer <support@grabaclue.com>
Reply-To: sellojuaquindabeer@gmail.com
Message-ID: <9edcd91b02d9eecc6a81e5e6b3250271@grabaclue.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-OriginalArrivalTime: 01 Feb 2023 06:42:11.0705 (UTC) FILETIME=[502F3690:01D93608]
X-Spam-Status: Yes, score=6.4 required=5.0 tests=BAYES_95,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_REPLYTO,
        HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  3.0 BAYES_95 BODY: Bayes spam probability is 95 to 99%
        *      [score: 0.9514]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  1.1 LOCALPART_IN_SUBJECT Local part of To: address appears in
        *      Subject
        *  0.2 HEADER_FROM_DIFFERENT_DOMAINS From and EnvelopeFrom 2nd level
        *      mail domains are different
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

02/01/2023 01:42:11 am

Good day ,

Did you receive my previous email to you, or do I repeat ?

Best Regard,

Juaquin Dabeer

