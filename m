Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C5B6889C4
	for <lists+linux-serial@lfdr.de>; Thu,  2 Feb 2023 23:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbjBBW2r (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 2 Feb 2023 17:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbjBBW21 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 2 Feb 2023 17:28:27 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0B837F33
        for <linux-serial@vger.kernel.org>; Thu,  2 Feb 2023 14:28:23 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 312M0Hkm013919;
        Thu, 2 Feb 2023 22:28:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=vuoLPSHhS7Z7dJ4H2wqwi9wDT+zAXQJtQtlZ/tbiFqY=;
 b=j0IcR4crzBsiOlPYRzM82hH2wTBh/K8WtvOQshvNzbBpwbPiWdCrYlDt4d9D1XzbBN6X
 Pjdv88MKTdHJB6AikGAGG26REsstVlUW7h6jxSCr0MfTy/eg0r0nrLFLtIJ3RKWcQJCm
 9rc8tQo1Rrb45v8KAGMOkC9+GsBqv3JohGwzoDTINzJdTrCPHKF+vuPWeXjsQiRHGM6t
 I/fuKrf18XgKc1qUwnSPoEavmiO/7XHmKTL0BgYuWk/YtEqm4G0fLOX5b+GHP7Xtj6UB
 HayPWS54M1I0WKlp7L0C8dJawIGR85gWoLCx0YYY/d0Ya5Eb9CsKkHcpATVQ4XuQ2Xjy +w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ngkm0bgdn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 22:28:20 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 312M2HLj017219;
        Thu, 2 Feb 2023 22:28:19 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ngkm0bgd2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 22:28:19 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 312IewGt028518;
        Thu, 2 Feb 2023 22:28:18 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([9.208.129.116])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3ncvuywrt1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 22:28:18 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 312MSH7x7078438
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Feb 2023 22:28:17 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 426E258065;
        Thu,  2 Feb 2023 22:28:17 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8908758055;
        Thu,  2 Feb 2023 22:28:16 +0000 (GMT)
Received: from li-6bf4d4cc-31f5-11b2-a85c-838e9310af65.ibm.com.com (unknown [9.211.158.218])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  2 Feb 2023 22:28:16 +0000 (GMT)
From:   Brian King <brking@linux.vnet.ibm.com>
To:     gregkh@linuxfoundation.org
Cc:     linuxppc-dev@lists.ozlabs.org, brking@pobox.com,
        mmc@linux.vnet.ibm.com, linux-serial@vger.kernel.org,
        Brian King <brking@linux.vnet.ibm.com>
Subject: [PATCH v2 3/6] hvcs: Use driver groups to manage driver attributes
Date:   Thu,  2 Feb 2023 16:28:01 -0600
Message-Id: <20230202222804.383229-4-brking@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230202222804.383229-1-brking@linux.vnet.ibm.com>
References: <20230202222804.383229-1-brking@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cRucB6oEl7GlOYdxPrFRMR30JAN5nxCq
X-Proofpoint-GUID: 3W7Gb8FZaFcubAQk9LYYCcf2bxD_pGoh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_14,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302020196
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Rather than manually creating attributes for the hvcs driver,
let the driver core do this for us. This also fixes some hotplug
remove issues and ensures that cleanup of these attributes
is done in the right order.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---
 drivers/tty/hvc/hvcs.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
index 7f79444b4d89..5de7ad555540 100644
--- a/drivers/tty/hvc/hvcs.c
+++ b/drivers/tty/hvc/hvcs.c
@@ -473,6 +473,20 @@ static ssize_t rescan_store(struct device_driver *ddp, const char * buf,
 
 static DRIVER_ATTR_RW(rescan);
 
+static struct attribute *hvcs_attrs[] = {
+	&driver_attr_rescan.attr,
+	NULL,
+};
+
+static struct attribute_group hvcs_attr_group = {
+	.attrs = hvcs_attrs,
+};
+
+const static struct attribute_group *hvcs_attr_groups[] = {
+	&hvcs_attr_group,
+	NULL,
+};
+
 static void hvcs_kick(void)
 {
 	hvcs_kicked = 1;
@@ -827,6 +841,7 @@ static struct vio_driver hvcs_vio_driver = {
 	.remove		= hvcs_remove,
 	.name		= hvcs_driver_name,
 	.driver = {
+		.groups = hvcs_attr_groups,
 		.dev_groups = hvcs_attr_dev_groups,
 	},
 };
@@ -1505,13 +1520,6 @@ static int __init hvcs_module_init(void)
 
 	pr_info("HVCS: Driver registered.\n");
 
-	/* This needs to be done AFTER the vio_register_driver() call or else
-	 * the kobjects won't be initialized properly.
-	 */
-	rc = driver_create_file(&(hvcs_vio_driver.driver), &driver_attr_rescan);
-	if (rc)
-		pr_warn("HVCS: Failed to create rescan file (err %d)\n", rc);
-
 	return 0;
 }
 
@@ -1536,8 +1544,6 @@ static void __exit hvcs_module_exit(void)
 	hvcs_pi_buff = NULL;
 	spin_unlock(&hvcs_pi_lock);
 
-	driver_remove_file(&hvcs_vio_driver.driver, &driver_attr_rescan);
-
 	tty_unregister_driver(hvcs_tty_driver);
 
 	hvcs_free_index_list();
-- 
2.31.1

