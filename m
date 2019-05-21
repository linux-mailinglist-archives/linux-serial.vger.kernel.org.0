Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADB2124D0C
	for <lists+linux-serial@lfdr.de>; Tue, 21 May 2019 12:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbfEUKoJ (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 21 May 2019 06:44:09 -0400
Received: from mail-eopbgr690052.outbound.protection.outlook.com ([40.107.69.52]:12942
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726296AbfEUKoJ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 21 May 2019 06:44:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8lb9xLGvm2NJGhbpoJkww7r07bxSBREFHuT0GoG7Hok=;
 b=QLxgmUxn2J/kh5mntlH0m4uThOduet4VXcw9U7iiTIUrb9TWnnLybVP4TGxjqSRSCUcPl9Iem7UaL2l+mZrz21Nd5zsTH6EiuMA6BAK7I8FRJKa1eVPHZtGSX8H+JcnzlI93OQ2MeMXN0g/WmO0efhfZdNDBMhf4GH95Eo3xb50=
Received: from MWHPR02CA0007.namprd02.prod.outlook.com (2603:10b6:300:4b::17)
 by BY5PR02MB6226.namprd02.prod.outlook.com (2603:10b6:a03:1ff::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1922.15; Tue, 21 May
 2019 10:43:19 +0000
Received: from BL2NAM02FT012.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by MWHPR02CA0007.outlook.office365.com
 (2603:10b6:300:4b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1900.18 via Frontend
 Transport; Tue, 21 May 2019 10:43:18 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT012.mail.protection.outlook.com (10.152.77.27) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1900.16
 via Frontend Transport; Tue, 21 May 2019 10:43:18 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:52631 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1hT2En-0007bb-Kf; Tue, 21 May 2019 03:43:17 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1hT2Ei-0000gp-HS; Tue, 21 May 2019 03:43:12 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x4LAhAgw003954;
        Tue, 21 May 2019 03:43:10 -0700
Received: from [172.23.37.106] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1hT2Ef-0000gN-HO; Tue, 21 May 2019 03:43:09 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     linux-serial@vger.kernel.org
Cc:     michal.simek@xilinx.com, gregkh@linuxfoundation.org,
        shubhrajyoti.datta@gmail.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH 2/2] serial: uartps: Add a timeout to the tx empty wait
Date:   Tue, 21 May 2019 16:13:06 +0530
Message-Id: <1558435386-27124-1-git-send-email-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(136003)(376002)(2980300002)(199004)(189003)(47776003)(48376002)(63266004)(4326008)(50466002)(2361001)(36756003)(2351001)(9786002)(14444005)(5660300002)(5024004)(36386004)(70586007)(70206006)(305945005)(6666004)(478600001)(186003)(336012)(106002)(2906002)(6916009)(356004)(81156014)(126002)(81166006)(2616005)(476003)(426003)(7696005)(51416003)(486006)(44832011)(8936002)(26005)(8746002)(50226002)(77096007)(316002)(107886003)(8676002)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR02MB6226;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3d0db0e-3c7c-48a0-a079-08d6ddd922f1
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328);SRVR:BY5PR02MB6226;
X-MS-TrafficTypeDiagnostic: BY5PR02MB6226:
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BY5PR02MB62261DEB75207D0B72D4875DAA070@BY5PR02MB6226.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0044C17179
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: vDkxs7aIH2uAigJzPFCOXDUcfg3uO7s3S0xQsto/oHdMVjNArRY5adqy70Omyil9NHtLTaoDFQxdOlALfiMDjWjRhFH6ItTv2iKWUf9r16r9nNP9XFoQae9pRyswLj63LRZWtRjY3OgRrW0PE1G2nH3guYOmN61lMQ61yOep5R9hk3Q2BVJAlVZfyLv/+fQeefRti9RG9O4cHKQYC4dvdXohDWamQhyBHam6zbv+ETpci/fByX8fDbQxD42AUeAOlfxiLIYjc16XDpUh2RbbGjS8sIBf/uzYJbH4MTyIajgxkUZnscXm96skkTNEzxIlnghFje3EZz5YiCxkiJbKOfXx8q87LHZOE6Q9EM4IZW88ZkHFsWLB88qY4Ac6iEMe43NXZBjPuJS3smSQ7X7Xs7rbNyqmfP0Ng3O1EQoDf1k=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2019 10:43:18.1664
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d0db0e-3c7c-48a0-a079-08d6ddd922f1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6226
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add a timeout to the tx empty wait.

Reported-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/tty/serial/xilinx_uartps.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx=
_uartps.c
index 8850790..dc86511 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -26,12 +26,14 @@
 #include <linux/of.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
+#include <linux/iopoll.h>

 #define CDNS_UART_TTY_NAME     "ttyPS"
 #define CDNS_UART_NAME         "xuartps"
 #define CDNS_UART_MAJOR                0       /* use dynamic node allocat=
ion */
 #define CDNS_UART_FIFO_SIZE    64      /* FIFO size */
 #define CDNS_UART_REGISTER_SPACE       0x1000
+#define TX_TIMEOUT             500000

 /* Rx Trigger level */
 static int rx_trigger_level =3D 56;
@@ -688,14 +690,18 @@ static void cdns_uart_set_termios(struct uart_port *p=
ort,
        unsigned int cval =3D 0;
        unsigned int baud, minbaud, maxbaud;
        unsigned long flags;
-       unsigned int ctrl_reg, mode_reg;
+       unsigned int ctrl_reg, mode_reg, val;
+       int err;

        /* Wait for the transmit FIFO to empty before making changes */
        if (!(readl(port->membase + CDNS_UART_CR) &
                                CDNS_UART_CR_TX_DIS)) {
-               while (!(readl(port->membase + CDNS_UART_SR) &
-                               CDNS_UART_SR_TXEMPTY)) {
-                       cpu_relax();
+               err =3D readl_poll_timeout(port->membase + CDNS_UART_SR,
+                                        val, (val & CDNS_UART_SR_TXEMPTY),
+                                        1000, TX_TIMEOUT);
+               if (err) {
+                       dev_info(port->dev, "timed out waiting for tx empty=
");
+                       return;
                }
        }
        spin_lock_irqsave(&port->lock, flags);
--
2.1.1

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
