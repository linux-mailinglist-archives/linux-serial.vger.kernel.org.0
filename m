Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2933824DA1
	for <lists+linux-serial@lfdr.de>; Tue, 21 May 2019 13:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfEULKG (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 21 May 2019 07:10:06 -0400
Received: from mail-eopbgr710048.outbound.protection.outlook.com ([40.107.71.48]:40179
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726389AbfEULKG (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 21 May 2019 07:10:06 -0400
Received: from DM6PR02CA0106.namprd02.prod.outlook.com (10.141.168.175) by
 SN6PR02MB4734.namprd02.prod.outlook.com (52.135.113.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Tue, 21 May 2019 11:10:04 +0000
Received: from SN1NAM02FT038.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::200) by DM6PR02CA0106.outlook.office365.com
 (2603:10b6:5:1f4::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1922.15 via Frontend
 Transport; Tue, 21 May 2019 11:10:04 +0000
Authentication-Results: spf=softfail (sender IP is 149.199.60.83)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 149.199.60.83 as permitted sender)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT038.mail.protection.outlook.com (10.152.72.69) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1900.16
 via Frontend Transport; Tue, 21 May 2019 11:10:04 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1hT2aN-0007Od-UX; Tue, 21 May 2019 04:05:35 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1hT2aI-0002ig-QQ; Tue, 21 May 2019 04:05:30 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x4LB5Tj1012497;
        Tue, 21 May 2019 04:05:30 -0700
Received: from [172.23.37.106] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1hT2aH-0002iZ-Fk; Tue, 21 May 2019 04:05:29 -0700
From:   shubhrajyoti.datta@gmail.com
To:     linux-serial@vger.kernel.org
Cc:     michal.simek@xilinx.com, gregkh@linuxfoundation.org,
        shubhrajyoti.datta@gmail.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCHv2 1/2] serial: uartps: Move the spinlock after the read of the tx empty
Date:   Tue, 21 May 2019 16:35:26 +0530
Message-Id: <1558436726-32097-1-git-send-email-shubhrajyoti.datta@gmail.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--0.493-7.0-31-1
X-imss-scan-details: No--0.493-7.0-31-1;No--0.493-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 132029106045373063;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(376002)(346002)(2980300002)(199004)(189003)(82202003)(8936002)(498600001)(47776003)(61266001)(81166006)(486006)(336012)(305945005)(5660300002)(86362001)(73392003)(76482006)(50226002)(2906002)(70586007)(9786002)(83322999)(26005)(63266004)(14444005)(70206006)(81156014)(16586007)(85782001)(316002)(77096007)(73972006)(50466002)(55446002)(6916009)(8676002)(48376002)(2351001)(476003)(126002)(2361001)(36756003)(4326008)(6666004)(426003)(356004)(87572001)(51416003)(107886003)(9686003)(2616005)(85772001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4734;H:xsj-pvapsmtpgw01;FPR:;SPF:SoftFail;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5da21001-f245-4953-0488-08d6dddce046
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(5600141)(711020)(4605104)(2017052603328);SRVR:SN6PR02MB4734;
X-MS-TrafficTypeDiagnostic: SN6PR02MB4734:
X-Microsoft-Antispam-PRVS: <SN6PR02MB47346F1282D2A5C65196FE1387070@SN6PR02MB4734.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0044C17179
X-Microsoft-Antispam-Message-Info: MRSWKYOcLbrgcQKOE1J+Dj+29Kkqc4qlcDoOjPwS5AtP7XPdejdjbqI1p12vUf6hFn5vAqO77VpaeJ9TajdwCXBUAWM6BzdK/LQG5yuDSI2SVjYpwTWCxVyHfgRi/IB//DR6T7cbPxJ04+Nkt3tWlY1TQVLgAWP+BCyKtMwsEhqD0+ZzKIN1SaizMwmOCRlf5Lm2l8zpwLbpBIrd72XecPy77Nq002+JeSdenK2J+jvMwGEs1RGKJ++dchvOZHvY5/h6C2/AE3IraMTnsob4jPCTeU4xZQ00P3uoV3csugSO3iYj590B2nCRynob7PhiJgXoTgZUtdC7rgTpY/TfaW6xaKVqdUP+BEkhz7c+PeXmOrQvAWJtMc9PnXq5ncsxn9olE6kgRFRZhA8V2dWu8pX6om36aVRSl0ZsRw8uIAc=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2019 11:10:04.3551
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5da21001-f245-4953-0488-08d6dddce046
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4734
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Currently we are doing a read of the status register.
Move the spinlock after that as the reads need not be spinlock
protected.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---

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

