Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22F8824D82
	for <lists+linux-serial@lfdr.de>; Tue, 21 May 2019 13:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfEULDz (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 21 May 2019 07:03:55 -0400
Received: from mail-eopbgr770089.outbound.protection.outlook.com ([40.107.77.89]:12323
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726242AbfEULDz (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 21 May 2019 07:03:55 -0400
Received: from BN6PR02CA0095.namprd02.prod.outlook.com (2603:10b6:405:60::36)
 by BYAPR02MB5862.namprd02.prod.outlook.com (2603:10b6:a03:120::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1900.17; Tue, 21 May
 2019 11:03:53 +0000
Received: from CY1NAM02FT043.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::201) by BN6PR02CA0095.outlook.office365.com
 (2603:10b6:405:60::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1900.16 via Frontend
 Transport; Tue, 21 May 2019 11:03:52 +0000
Authentication-Results: spf=softfail (sender IP is 149.199.60.100)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 149.199.60.100 as permitted sender)
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT043.mail.protection.outlook.com (10.152.74.182) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1900.16
 via Frontend Transport; Tue, 21 May 2019 11:03:52 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:44522 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1hT2Yh-0008JY-Ti; Tue, 21 May 2019 04:03:51 -0700
Received: from localhost ([127.0.0.1] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1hT2Yc-00020j-Pt; Tue, 21 May 2019 04:03:46 -0700
Received: from [172.23.37.106] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1hT2Yb-00020G-Vq; Tue, 21 May 2019 04:03:46 -0700
From:   shubhrajyoti.datta@gmail.com
To:     linux-serial@vger.kernel.org
Cc:     michal.simek@xilinx.com, gregkh@linuxfoundation.org,
        shubhrajyoti.datta@gmail.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCHv2 2/2] serial: uartps: Add a timeout to the tx empty wait
Date:   Tue, 21 May 2019 16:33:38 +0530
Message-Id: <1558436618-26194-1-git-send-email-shubhrajyoti.datta@gmail.com>
X-Mailer: git-send-email 2.1.1
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--6.465-7.0-31-1
X-imss-scan-details: No--6.465-7.0-31-1;No--6.465-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 132029102325432317;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(346002)(136003)(2980300002)(199004)(189003)(47776003)(48376002)(2361001)(4326008)(2351001)(76482006)(61266001)(83322999)(6916009)(86362001)(36756003)(81166006)(2616005)(8676002)(476003)(126002)(81156014)(55446002)(16586007)(51416003)(486006)(82202003)(85782001)(336012)(426003)(73392003)(6666004)(356004)(9786002)(498600001)(5660300002)(305945005)(14444005)(77096007)(87572001)(70586007)(9686003)(73972006)(50466002)(2906002)(70206006)(8936002)(26005)(63266004)(50226002)(107886003)(316002)(85772001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5862;H:xsj-pvapsmtpgw02;FPR:;SPF:SoftFail;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a335a69-8533-4e16-8832-08d6dddc028c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(5600141)(711020)(4605104)(2017052603328);SRVR:BYAPR02MB5862;
X-MS-TrafficTypeDiagnostic: BYAPR02MB5862:
X-Microsoft-Antispam-PRVS: <BYAPR02MB586249D9FEB087CE93FF825687070@BYAPR02MB5862.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0044C17179
X-Microsoft-Antispam-Message-Info: KjugPUZx6TJomQbSG/m1Jkeh81C8TwgdzZGpz848EOn2tlaeRvaMsFeYDNkJ0jinh8oiN6noiO2rhtDmYZnUcbSNH3PDTT2gAKsTVvcmGtvrs4vsNMEuji30H6g/6uNDi9zHXEgIBqxsxLpoafqHYM2xYPhOEH/xBgblK0xX/KLaf9uJq3hoP/RYF7uyR5uSyvQlDmQtMAqU1JFWTH/pOcNVq1SJ7Hsys4sUz2wqHfyRkMNrrUpfI6/cwHeunO2xLQFMaB4HnOaDeePe/6bIpFgGk/S+0+aJVCMu6nmNGdoofTWn7yF9A17pkv1FZ4ZJxMmhhfg9+4vILrXvhuYGl2d46KlDkeKCQsMo51N2IdA93Zhte3vEQIPNfH3WTrzOBcLcydksDRhXwd8ByyRJt/aILOEI8JuPKaEo2muJ378=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2019 11:03:52.3540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a335a69-8533-4e16-8832-08d6dddc028c
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5862
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

In case the cable is not connected then the target gets into
a infinite wait for tx empty.
Add a timeout to the tx empty wait.

Reported-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/tty/serial/xilinx_uartps.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 8850790..dc86511 100644
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
+			dev_info(port->dev, "timed out waiting for tx empty");
+			return;
 		}
 	}
 	spin_lock_irqsave(&port->lock, flags);
-- 
2.1.1

