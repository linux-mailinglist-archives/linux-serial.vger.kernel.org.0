Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC894D275E
	for <lists+linux-serial@lfdr.de>; Wed,  9 Mar 2022 05:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiCIEFl (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 8 Mar 2022 23:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiCIEFk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 8 Mar 2022 23:05:40 -0500
X-Greylist: delayed 3589 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Mar 2022 20:04:40 PST
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02hn2226.outbound.protection.partner.outlook.cn [139.219.146.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FDB106613
        for <linux-serial@vger.kernel.org>; Tue,  8 Mar 2022 20:04:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLxy3cpwGQXHtBgFfPaF1ONUmXMKHUZIyp9iDAdCW97oI20jfCNzhtAviqv4CCTOKvcZqp++8QFqNrETAkD+pjVQYZMVDf5TKFR0P92zCcg6+C2CyacgQK8oVARCur1J5YPva5Yx7i2O1gsGNMfto8dqxkAYDOvzDX1vJ639p2Oh9lQ2xlw+b3jAlyZcX1X54jAT3gouxJ+BrGBrs+oK8iGrhYueu8lfgAclLEXQL6jfg5+xlIhSlaxPXHIWSH0aKWjOM6UBSLQ21OkbCNBC8sXMQXW1megcyS7wSXmV+5WfaTgDO6OaU8JGPL78ei4+x93B1yYinNNq82kYqdYdfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OjRIttYofng/XgTbQ8L2Ek8lt2yZEluQ3PEyc+4P7Gw=;
 b=inU+7dm/Cpk5lTYw+5wgsU1SZkEeDsmvSGUGNvgiosi2vI9ttCEx/tKJtE3gBVNx4i8yAM6fzDckkvTZsqGSfveGtswO2nVuEM59D24YyRje9Ls+LTWcuOSXnW9JVKXDA0Uhp9u9Waep+yYHTU7KTcKNURpal9sAnK27iidY61PXWGLaILhXdLAtvK9DRN9trtbaXpErKdpRoPKVB8q24590yjxr0IkZs12LVFdWSMMEJ+w0VS4lq75cpBNAnvhThKjGRUQRkQF1yFOpAnYP4MajVnanSRGpCD3GRXxGoMUrR+6bJSAhHoFBs36asgnHTtpsgZc7qfSsAxSHvuNLug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pactera.com; dmarc=pass action=none header.from=pactera.com;
 dkim=pass header.d=pactera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pactera.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OjRIttYofng/XgTbQ8L2Ek8lt2yZEluQ3PEyc+4P7Gw=;
 b=eCMwSEG04r2dOcebK0H21Mksn8hQFqgXw1Ii6bEJjmov1eJ3MWtJCDFVkqjSQmKppjQr6pmYoQDUGU+jz2crFlguurJzRYEKl+kml7rAzGwuGtdzsSgKX3cSJ3LHQmB4MWgO0ExRI0Y86l+X94AS7htp1+reI5hEVoc9CBPlvj1sWhl3TcgIwkwZwEF0vT8Z+lNroCXrNWGnZ+uGOMrIwzZeaPd+7s10sLfZT9ppksRKEbgVUgFNvJ3BivV7QioInZQamy3x1TkkEK9eZPwXryif4z0AsEp98K2Yxm/rnUhnYZH7AOWTfJdr7uXZU832vaAsNsiqd212CdjEFQHcpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pactera.com;
Received: from BJSPR01MB0786.CHNPR01.prod.partner.outlook.cn (10.43.37.206) by
 BJSPR01MB0689.CHNPR01.prod.partner.outlook.cn (10.43.37.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.15; Wed, 9 Mar 2022 01:30:28 +0000
Received: from BJSPR01MB0786.CHNPR01.prod.partner.outlook.cn ([10.43.37.206])
 by BJSPR01MB0786.CHNPR01.prod.partner.outlook.cn ([10.43.37.206]) with mapi
 id 15.20.5038.026; Wed, 9 Mar 2022 01:30:28 +0000
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: You Won
To:     Recipients <sathiavathy.veeriah@pactera.com>
From:   "Mr. Manuel Franco" <sathiavathy.veeriah@pactera.com>
Date:   Wed, 09 Mar 2022 02:07:09 +0100
Reply-To: maunelfranco19@gmail.com
X-ClientProxiedBy: BJXPR01CA0046.CHNPR01.prod.partner.outlook.cn (10.43.33.13)
 To BJSPR01MB0786.CHNPR01.prod.partner.outlook.cn (10.43.37.206)
Message-ID: <BJSPR01MB078627E85A344106D52829C4FB0A9@BJSPR01MB0786.CHNPR01.prod.partner.outlook.cn>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abbc1a5a-07d6-47cd-9bf2-08da01692ac3
X-MS-TrafficTypeDiagnostic: BJSPR01MB0689:EE_
X-Microsoft-Antispam-PRVS: <BJSPR01MB06896D7F445F911D0D5FF17BFB0A9@BJSPR01MB0689.CHNPR01.prod.partner.outlook.cn>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?tq541Hq6HNBMdzp8x/CLBAl+nPWAvMFd38eAmOdsRrUtiyr85Kz5XEH9ZN?=
 =?iso-8859-1?Q?tAJuJb7Z7RtOsDi3VpwbOrLbKzKpRTYTpvkFHC1pGxlyjbjlc4wlAC79S/?=
 =?iso-8859-1?Q?op1JJhBHTnNXYZa60+HbmIKEbKpPb4ermYniV9XalmYtFNPGlQKcvlZfks?=
 =?iso-8859-1?Q?mSjHEfVakJsU3wAa6iq4UdFqXRdKzrxd5snQYQUCBkhwziK9Oonq6kzaX/?=
 =?iso-8859-1?Q?TD+83t/rSZ/RaKyGoe1Y/cuk34ivfPQDsll+K3ZpfjQC2opE9WNo0JWl3S?=
 =?iso-8859-1?Q?QmsoE3RccNfZeYaMUL28iYcew4ldVJGJaI8/OfEPK2UDRQZa81ICWnqunz?=
 =?iso-8859-1?Q?ltb0Ee6HN5mWPuOisbRdwJV9cb+6hRi/PihBr34sks6kMusnRlHMd530wC?=
 =?iso-8859-1?Q?K4pyJr3txjFDnK8VIKcEyUxgOLtGgO1jZqeaolsEK/EZ8w0zJsC4G47Uzy?=
 =?iso-8859-1?Q?imbjlxdDv+b+g6JxP931AjCKF4dAq04l8hwoUZmuA1FXGrKiTmB9ZJtWUu?=
 =?iso-8859-1?Q?d1yW/zGNzkd5vtgJAA03Y+phMD88Z/8enNRXpd9s+viKrxucEDSYP3jZH1?=
 =?iso-8859-1?Q?l/fGZ0AGzki1dY9NrlsIhwfO6VmBRoUL5BP4uHu4doVX63JsHG6Jvl8Cq8?=
 =?iso-8859-1?Q?y+HFnxvrca/YnOenvhHeJ7byDoyt6T8oY4I81fzh2worIc/5v1TbTU025o?=
 =?iso-8859-1?Q?xdQ5BZKxmaJDVm5YtwSPT+lVYMGJUGsGpNR0EEBMr0F5xsqHWz4qFYBB3u?=
 =?iso-8859-1?Q?uPxXH1pVF47V3m36j16jhEbFYH65L2PNM0eRVNoatzjr0k1aEwpzmQVmgp?=
 =?iso-8859-1?Q?8h5QSIiVYZV9TSQL1blsQU48rLcdLhzomt4XNAeEfKUX0f8SUM9nyI3Jon?=
 =?iso-8859-1?Q?MlzMTqFJJXAMrXP6nngePyBQOyUJIN7UixQzNNWEwt9bhUqWo2wZC6TJpS?=
 =?iso-8859-1?Q?Azbl38kycEury8d2/nqXULelWODzmfJxTn0nQZKBzyQgYNhRA6YkFkC/90?=
 =?iso-8859-1?Q?uS+SK8V8ZAhceEc1lSCvv+eCKv34TTrn1uHYlIz9voDcLCVUsV6qsZpFnl?=
 =?iso-8859-1?Q?dw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:BJSPR01MB0786.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:OSPM;SFS:(13230001)(366004)(4744005)(55016003)(7416002)(33656002)(83380400001)(6666004)(9686003)(7696005)(40160700002)(52116002)(40180700001)(66574015)(38100700002)(38350700002)(508600001)(186003)(26005)(2860700004)(86362001)(8936002)(8676002)(7116003)(66556008)(66946007)(66476007)(966005)(6200100001)(6862004)(3480700007)(296002)(2906002)(5660300002)(62346012);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?8Ov77sn8Vp0NELQgVl6LsrWrV24PJM8Wh5fDwTh57q3Rfsc69z2NNo3vjV?=
 =?iso-8859-1?Q?3L33hsFnkd/Lq+i5Nijag0ed3zHKY3r3PeKMuCkNYjPrHV+kkZeHGkbYn2?=
 =?iso-8859-1?Q?WUSf5pNzQh0GTJ7qAgBBdf3fV0rvqeU8qw8uy5/ZKaoP7TmfhVztZhnQV7?=
 =?iso-8859-1?Q?ISB4quuFbA5zo4wfv1ZaGWz8jXBzXoCpwYTpUJ7VYfndDk3cd6eF6DLQyF?=
 =?iso-8859-1?Q?eGTVwPAS6rF6BSrZ99UhYH0LYDcAJ1vdm86O225mSY6RMQtJcJxORGsMVX?=
 =?iso-8859-1?Q?gPS8JphBWsQq7FbLXmSQIKSWRF8Z7bTBLPSLYpZqGEzRKnZhmVTcd/lJC9?=
 =?iso-8859-1?Q?XVlcs53cgLM9tIRtoH7XihJkFhoCtJ31ZgYAaWM5EDkaMzmh2k7C4IN64+?=
 =?iso-8859-1?Q?bo/lqKDvqi0CifB+pqIOtHSJdVBUVgny3+JoS07jTf7lRrIKyZhej8sFd8?=
 =?iso-8859-1?Q?oIm4/LesJU/1BqBATC5rkTZUeje0I7vK44oopte9fp0wqg/Ztl7O0BrLwr?=
 =?iso-8859-1?Q?YdZGEjtKlG+vOnm+fVzdXTCIdtbv7f+w835SvPTj8Pnui4sSrT32gH7nmz?=
 =?iso-8859-1?Q?MSIW7jgU+CeyqcbK/bkwPOdbSGgPuycIBkBj0H32lEOT2hlYWcv7zR490q?=
 =?iso-8859-1?Q?+nlS6fw7V138RUQCMy7St/iX3Hs2w/annscYy+eNJNi+mN9f0xePCV/7U+?=
 =?iso-8859-1?Q?+DUFmTa7KhwwxjinW1ca7iE9Yc/Sv8Uj1Ce89aoeyZpCFqa+JjBJXj1/+X?=
 =?iso-8859-1?Q?G0K51ODa/152m4RHLhV7nb5tXmFtcR9yq38fn/F/17tlmc7uJ96Yr8lVvR?=
 =?iso-8859-1?Q?Z/DinKAbuZmKkgHm0iHJ84xy6fCHsUvdrtP9IMnDG5/uNE3RENyAJU4bvp?=
 =?iso-8859-1?Q?lbzHQ3sIFxzCMZcpF8aiDzH61c0XsHQMr/KHiZU+eStn/RkZ4L/Vi2e+0n?=
 =?iso-8859-1?Q?NX3QqQPIErcMqpCJQEIYWfhaoQ/mUXWSl0r1bS8aoiV54J9l0quvGVFEtD?=
 =?iso-8859-1?Q?RMpPKmGzZCNjNfVsA0HgiViVcLAph1F5oWxx+l+L10Y7zoF3iFAd4cL579?=
 =?iso-8859-1?Q?d+ehhhvea3U0mCtjUnknDCCxz0peTt/yIlLeUtS+/X+PYczcfrlBqnIbnU?=
 =?iso-8859-1?Q?oaHXvZL6qyp2n3+0YRQimV56KQJpRax9aN1cWlYdxm/9NcBDJ+tNNcLUAV?=
 =?iso-8859-1?Q?JnYTdf8IYPl8bnjn0NuOx4fKb/QJ9wqDuOQPJYUFmVyEtOWhsJNAAxrXqV?=
 =?iso-8859-1?Q?BLqjFqv3Dm8OXHNJEeN+mcD8DLIC58idooA/zILN+VYjBM5i+JN8jDMfKk?=
 =?iso-8859-1?Q?bjT0U+kPH1Y7uwMgnWx/dd+gqRpatta0i2GQf1y5KZdvcsQBTHaVhKxLOL?=
 =?iso-8859-1?Q?TWsKWVHTzDhy+5k/Rt9xCzwf8IP5cnrxiZq1CaOOPgPtHcXT0jWuOgBTOK?=
 =?iso-8859-1?Q?k1PJycB/PWybD9JM2oatvz01O6R1jzrg98Hh3/JMewUFXb9wmXu9Z6xgSX?=
 =?iso-8859-1?Q?HUk34URpx3wJ4mLMskRfYPCfbZFu69xBvSZddIiJAh7dt0u6lLS0IPdtH0?=
 =?iso-8859-1?Q?UhhAX0jmd+cm/tFDVEAdUgsJjCkCGutNa1gFx4pHMOKW1yzU38H6RB9xWe?=
 =?iso-8859-1?Q?y9iBq5nrlOet4jts6sIIPQb7cPP/61w7cbjjsx35yF3Wf6pV6fIk3kjA?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: pactera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abbc1a5a-07d6-47cd-9bf2-08da01692ac3
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0786.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 01:07:22.7784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 89592e53-6f9d-4b93-82b1-9f8da689f1b4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t1xwxy8SMj4q45htaH2NeGmn8rwGRkJAMruhtRGLyU+uPhTRF/VwDqmzu7wCPapUpI/35kMmHONrL+5zPgor/Fja+HMAjtSdfgIOIp6h//U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0689
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_INVALID,
        DKIM_SIGNED,FORGED_SPF_HELO,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,HK_NAME_MR_MRS,KHOP_HELO_FCRDNS,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello,



I am Manuel Franco, you have a donation of $3,100,000.00 .
I won the $768 million Powerball lottery on April 23 2019, I am donating pa=
rt of it to five lucky people and Ten Charity organisations.
Your email came out victorious. Contact me urgently for claims. To help the=
 world because of the corona virus. Here is the youtube Video https://www.y=
outube.com/watch?v=3DR_pDrt1np1U
