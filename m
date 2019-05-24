Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFC629443
	for <lists+linux-serial@lfdr.de>; Fri, 24 May 2019 11:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389425AbfEXJLp (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 24 May 2019 05:11:45 -0400
Received: from mail-eopbgr720040.outbound.protection.outlook.com ([40.107.72.40]:51888
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389564AbfEXJLo (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 24 May 2019 05:11:44 -0400
Received: from DM6PR02CA0075.namprd02.prod.outlook.com (2603:10b6:5:1f4::16)
 by SN6PR02MB4733.namprd02.prod.outlook.com (2603:10b6:805:8f::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1922.15; Fri, 24 May
 2019 09:11:41 +0000
Received: from CY1NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::205) by DM6PR02CA0075.outlook.office365.com
 (2603:10b6:5:1f4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1922.16 via Frontend
 Transport; Fri, 24 May 2019 09:11:41 +0000
Authentication-Results: spf=softfail (sender IP is 149.199.60.83)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 149.199.60.83 as permitted sender)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT040.mail.protection.outlook.com (10.152.75.135) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1922.16
 via Frontend Transport; Fri, 24 May 2019 09:11:41 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1hU6Em-0001Wy-Vj; Fri, 24 May 2019 02:11:40 -0700
Received: from localhost ([127.0.0.1] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1hU6Eh-00029L-SF; Fri, 24 May 2019 02:11:35 -0700
Received: from [172.23.37.106] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1hU6Eh-00028j-73; Fri, 24 May 2019 02:11:35 -0700
From:   shubhrajyoti.datta@gmail.com
To:     linux-serial@vger.kernel.org
Cc:     michal.simek@xilinx.com, gregkh@linuxfoundation.org,
        shubhrajyoti.datta@gmail.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCHv3 2/2] serial: uartps: Add a timeout to the tx empty wait
Date:   Fri, 24 May 2019 14:41:29 +0530
Message-Id: <1558689089-8107-2-git-send-email-shubhrajyoti.datta@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1558689089-8107-1-git-send-email-shubhrajyoti.datta@gmail.com>
References: <1558689089-8107-1-git-send-email-shubhrajyoti.datta@gmail.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--7.000-7.0-31-1
X-imss-scan-details: No--7.000-7.0-31-1;No--7.000-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 132031627016249280;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(376002)(346002)(2980300002)(199004)(189003)(14444005)(86362001)(87572001)(50466002)(55446002)(9786002)(51416003)(76176011)(85782001)(82202003)(4326008)(8676002)(81156014)(2361001)(2906002)(81166006)(63266004)(2351001)(16586007)(8936002)(316002)(6916009)(498600001)(83322999)(50226002)(486006)(356004)(6666004)(5660300002)(70206006)(73972006)(26005)(107886003)(36756003)(73392003)(77096007)(336012)(126002)(61266001)(48376002)(446003)(70586007)(9686003)(76482006)(426003)(47776003)(305945005)(11346002)(2616005)(476003)(85772001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4733;H:xsj-pvapsmtpgw01;FPR:;SPF:SoftFail;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4fb852d-3f5c-4f28-2428-08d6e027d5db
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(5600141)(711020)(4605104)(2017052603328);SRVR:SN6PR02MB4733;
X-MS-TrafficTypeDiagnostic: SN6PR02MB4733:
X-Microsoft-Antispam-PRVS: <SN6PR02MB4733E3D5BB023AD94585C7BC87020@SN6PR02MB4733.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0047BC5ADE
X-Microsoft-Antispam-Message-Info: 8wmmr571KM5hXf68Xd0cIqLvd6Z/+/Zh0vy0rib5dfKdkk0/vkqvSSw9R506Oak8tROO7RNZn8rLJm2eUN7v6xjBjikmT2gv2CR7mbPyfSr+Amr1BPgqlRP7sxywbxVFf5U1Z7HmEQ4qSibiDgbbMw/qomgm2H6RzvN1+gK2fna1jCxaqLHp8ZqXxEgh3yDYySgcELCk//zsqcKoyfSltVZYuonCdYddBEmhGqQenIYnLx1Ey65UZ9mdDX9RYgFUBCipYqtDqSQRyd70Dg0LYbl6eQ4eZ1GQAVMJD2xqc5vSOHHhGe/l+fVQjCk55sA84SqC5rlMxx4brxX9dg1KJDvpNkRm16uISzpf9HLXqoTJW1icuquuT/EUEcg4CFVuY8BLelNmEXvRIollSWeCOZ15X61DYOSwHoFC4Ulny8M=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2019 09:11:41.4497
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4fb852d-3f5c-4f28-2428-08d6e027d5db
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4733
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

In case the cable is not connected then the target gets into
an infinite wait for tx empty.
Add a timeout to the tx empty wait.

Reported-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
v3:
update the print to dev_err

 drivers/tty/serial/xilinx_uartps.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 8850790..d872b25 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -26,12 +26,14 @@
 #include <linux/of.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
+#include <linux/iopoll.h>
 
 #define CDNS_UART_TTY_NAME	"ttyPS"
 #define CDNS_UART_NAME		"xuartps"
 #define CDNS_UART_MAJOR		0	/* use dynamic node allocation */
 #define CDNS_UART_FIFO_SIZE	64	/* FIFO size */
 #define CDNS_UART_REGISTER_SPACE	0x1000
+#define TX_TIMEOUT		500000
 
 /* Rx Trigger level */
 static int rx_trigger_level = 56;
@@ -688,14 +690,18 @@ static void cdns_uart_set_termios(struct uart_port *port,
 	unsigned int cval = 0;
 	unsigned int baud, minbaud, maxbaud;
 	unsigned long flags;
-	unsigned int ctrl_reg, mode_reg;
+	unsigned int ctrl_reg, mode_reg, val;
+	int err;
 
 	/* Wait for the transmit FIFO to empty before making changes */
 	if (!(readl(port->membase + CDNS_UART_CR) &
 				CDNS_UART_CR_TX_DIS)) {
-		while (!(readl(port->membase + CDNS_UART_SR) &
-				CDNS_UART_SR_TXEMPTY)) {
-			cpu_relax();
+		err = readl_poll_timeout(port->membase + CDNS_UART_SR,
+					 val, (val & CDNS_UART_SR_TXEMPTY),
+					 1000, TX_TIMEOUT);
+		if (err) {
+			dev_err(port->dev, "timed out waiting for tx empty");
+			return;
 		}
 	}
 	spin_lock_irqsave(&port->lock, flags);
-- 
2.1.1

