Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 673D524D08
	for <lists+linux-serial@lfdr.de>; Tue, 21 May 2019 12:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbfEUKmV (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 21 May 2019 06:42:21 -0400
Received: from mail-eopbgr680040.outbound.protection.outlook.com ([40.107.68.40]:41422
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726995AbfEUKmV (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 21 May 2019 06:42:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVfBPSfUF2u9OBY51iiya6z7lwQAFQDcPPTmkPHtVkw=;
 b=NqU/w8AixeF81RG+uGvT1ft5DXe59i5LKaeBY00s0h0oMmpup4x+ZZLDgkI1kJBb8fcnftCJi3pzxVWW+cQdu67z2KRBahBD/E2ZaO4nm7BHTGIbIkXS361dNNK8cNqkeTskis25kOgg+10JEmfj8mkMjnthaqZsseyxpdx4lwg=
Received: from BN6PR02CA0100.namprd02.prod.outlook.com (2603:10b6:405:60::41)
 by BL0PR02MB4930.namprd02.prod.outlook.com (2603:10b6:208:53::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1900.18; Tue, 21 May
 2019 10:42:18 +0000
Received: from CY1NAM02FT058.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by BN6PR02CA0100.outlook.office365.com
 (2603:10b6:405:60::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1900.18 via Frontend
 Transport; Tue, 21 May 2019 10:42:18 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT058.mail.protection.outlook.com (10.152.74.149) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1900.16
 via Frontend Transport; Tue, 21 May 2019 10:42:17 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1hT2Dp-0006gR-An; Tue, 21 May 2019 03:42:17 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1hT2Dk-0000QZ-7Y; Tue, 21 May 2019 03:42:12 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x4LAg1ud002949;
        Tue, 21 May 2019 03:42:01 -0700
Received: from [172.23.37.106] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1hT2DX-0000GS-1Y; Tue, 21 May 2019 03:42:01 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     linux-serial@vger.kernel.org
Cc:     michal.simek@xilinx.com, gregkh@linuxfoundation.org,
        shubhrajyoti.datta@gmail.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH 1/2] serial: uartps: Move the spinlock after the read of the tx empty
Date:   Tue, 21 May 2019 16:11:54 +0530
Message-Id: <1558435314-25587-1-git-send-email-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(136003)(39860400002)(2980300002)(189003)(199004)(50466002)(48376002)(336012)(426003)(77096007)(2361001)(2906002)(186003)(2351001)(26005)(107886003)(8936002)(486006)(8746002)(50226002)(305945005)(8676002)(81156014)(81166006)(2616005)(476003)(126002)(4326008)(63266004)(44832011)(478600001)(36386004)(9786002)(6666004)(36756003)(356004)(51416003)(7696005)(106002)(14444005)(47776003)(6916009)(5660300002)(316002)(5024004)(70206006)(70586007);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4930;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2480446a-89c9-45fb-0d25-08d6ddd8fef8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328);SRVR:BL0PR02MB4930;
X-MS-TrafficTypeDiagnostic: BL0PR02MB4930:
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB493088677AA49693A3C6EE4BAA070@BL0PR02MB4930.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0044C17179
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 98oG2j125IlyHCxuMFZyCezmOhsVVRKrAawSZUcY9ICFlmuOfx5WjHuOR3RjkXl/fOHUfxafK2aYX803p3ciuUromoVqy9McgcfQf8cvfiK2Bra9ZgllFoCTcLQP/hhGNTTYuiDxrnPysfdtDRV7ztinzn9zG1yTlWt02+FrNMIAObUzPFaboKdZAwQcFuASfKYPeU6NTpIwDg5tXRLJHUIjkzpcJHg/KeEugzk30oDZMjZMtXJvVzNYuIbOGsXJ2981B7pW6hugtzmURg+f4Od2IAHFK63NITFI7rQCecWL69uBamZiLuhC8IbXezANOstdE+04Eo4dEU55TMrBDCp1Rn8NLrppN7bGXxbOSpPVSOdTLVjW8psIL9WZ68M1HI3d3FqNQcWB2pjCu6SMyekOmo7jZP9mCr+G/JQ60NA=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2019 10:42:17.7725
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2480446a-89c9-45fb-0d25-08d6ddd8fef8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4930
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Currently we are doing a read of the status register.
Move the spinlock after that as the reads need not be spinlock
protected.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/tty/serial/xilinx_uartps.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx=
_uartps.c
index 75e1027..8850790 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -690,8 +690,6 @@ static void cdns_uart_set_termios(struct uart_port *por=
t,
        unsigned long flags;
        unsigned int ctrl_reg, mode_reg;

-       spin_lock_irqsave(&port->lock, flags);
-
        /* Wait for the transmit FIFO to empty before making changes */
        if (!(readl(port->membase + CDNS_UART_CR) &
                                CDNS_UART_CR_TX_DIS)) {
@@ -700,6 +698,7 @@ static void cdns_uart_set_termios(struct uart_port *por=
t,
                        cpu_relax();
                }
        }
+       spin_lock_irqsave(&port->lock, flags);

        /* Disable the TX and RX to set baud rate */
        ctrl_reg =3D readl(port->membase + CDNS_UART_CR);
--
2.1.1

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
