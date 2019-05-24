Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB6329440
	for <lists+linux-serial@lfdr.de>; Fri, 24 May 2019 11:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389569AbfEXJLm (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 24 May 2019 05:11:42 -0400
Received: from mail-eopbgr820070.outbound.protection.outlook.com ([40.107.82.70]:19456
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389564AbfEXJLm (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 24 May 2019 05:11:42 -0400
Received: from MWHPR02CA0004.namprd02.prod.outlook.com (2603:10b6:300:4b::14)
 by SN6PR02MB5166.namprd02.prod.outlook.com (2603:10b6:805:68::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1922.15; Fri, 24 May
 2019 09:11:40 +0000
Received: from BL2NAM02FT046.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by MWHPR02CA0004.outlook.office365.com
 (2603:10b6:300:4b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1922.17 via Frontend
 Transport; Fri, 24 May 2019 09:11:39 +0000
Authentication-Results: spf=softfail (sender IP is 149.199.60.100)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 149.199.60.100 as permitted sender)
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT046.mail.protection.outlook.com (10.152.76.118) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1922.16
 via Frontend Transport; Fri, 24 May 2019 09:11:39 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:35526 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1hU6Ek-0002Cl-Ho; Fri, 24 May 2019 02:11:38 -0700
Received: from localhost ([127.0.0.1] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1hU6Ef-00028y-DZ; Fri, 24 May 2019 02:11:33 -0700
Received: from [172.23.37.106] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1hU6Ee-00028j-Eo; Fri, 24 May 2019 02:11:32 -0700
From:   shubhrajyoti.datta@gmail.com
To:     linux-serial@vger.kernel.org
Cc:     michal.simek@xilinx.com, gregkh@linuxfoundation.org,
        shubhrajyoti.datta@gmail.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCHv3 1/2] serial: uartps: Move the spinlock after the read of the tx empty
Date:   Fri, 24 May 2019 14:41:28 +0530
Message-Id: <1558689089-8107-1-git-send-email-shubhrajyoti.datta@gmail.com>
X-Mailer: git-send-email 2.1.1
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--1.235-7.0-31-1
X-imss-scan-details: No--1.235-7.0-31-1;No--1.235-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 132031626995410150;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(396003)(136003)(2980300002)(199004)(189003)(76482006)(73972006)(9686003)(4326008)(82202003)(63266004)(126002)(476003)(2616005)(336012)(9786002)(51416003)(486006)(426003)(2351001)(8676002)(81166006)(81156014)(50226002)(2361001)(6916009)(107886003)(305945005)(26005)(77096007)(73392003)(8936002)(48376002)(356004)(6666004)(50466002)(5660300002)(86362001)(2906002)(16586007)(36756003)(498600001)(55446002)(70586007)(316002)(61266001)(85782001)(83322999)(47776003)(87572001)(14444005)(70206006)(5001870100001)(85772001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB5166;H:xsj-pvapsmtpgw02;FPR:;SPF:SoftFail;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b13dce4-0425-48a6-ab27-08d6e027d48c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(5600141)(711020)(4605104)(2017052603328);SRVR:SN6PR02MB5166;
X-MS-TrafficTypeDiagnostic: SN6PR02MB5166:
X-Microsoft-Antispam-PRVS: <SN6PR02MB5166B5C48CED80705772003C87020@SN6PR02MB5166.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0047BC5ADE
X-Microsoft-Antispam-Message-Info: V6g/vM0pFZ3sAzYxSHNyjA98t15cV9rVOktaSsXNbEbq0Z34oSXANnA+V/Vvax/ULz44uSt57siQYEqUIBAFmrmNQ0v0qBFyAj/Lka2IXILxX9k5GFAi05B4la0vE1gSLNmg/NqwJxiHWr/BUD/UN9b9hjtW9ynO66X7PQ6C9KhIX/0ff1T9MdRT1N/RlY69zfEWzn3fBSfDCX9iS3isr+gkynJzxuuu8mYahRFUUj8eA9/lkWykBldCdmelu+QoBLAF2lixBAVRVRUhHg2eHyueycxWvwUmxceRbKXDVzzmgJR69BeHeYY9Nz6Y4EblQrOhhD7fXO3heIk4eEq/a93d41J6xSrYZXqR8kYEFyPj5y0BbtpRFDRkPQQs8NpBYscZcbKtiRXmQCunL3VCJeSZREh0/PIJmCgqWwGHNZI=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2019 09:11:39.1967
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b13dce4-0425-48a6-ab27-08d6e027d48c
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5166
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Currently we are doing a read of the status register.
Move the spinlock after that as the reads need not be spinlock
protected. This patch prevents relaxing the cpu with spinlock held.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
v3:
Update the description

 drivers/tty/serial/xilinx_uartps.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 75e1027..8850790 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -690,8 +690,6 @@ static void cdns_uart_set_termios(struct uart_port *port,
 	unsigned long flags;
 	unsigned int ctrl_reg, mode_reg;
 
-	spin_lock_irqsave(&port->lock, flags);
-
 	/* Wait for the transmit FIFO to empty before making changes */
 	if (!(readl(port->membase + CDNS_UART_CR) &
 				CDNS_UART_CR_TX_DIS)) {
@@ -700,6 +698,7 @@ static void cdns_uart_set_termios(struct uart_port *port,
 			cpu_relax();
 		}
 	}
+	spin_lock_irqsave(&port->lock, flags);
 
 	/* Disable the TX and RX to set baud rate */
 	ctrl_reg = readl(port->membase + CDNS_UART_CR);
-- 
2.1.1

