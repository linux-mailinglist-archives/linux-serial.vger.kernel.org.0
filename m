Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDF7127A7FE
	for <lists+linux-serial@lfdr.de>; Mon, 28 Sep 2020 08:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgI1G76 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 28 Sep 2020 02:59:58 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:19494 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgI1G75 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 28 Sep 2020 02:59:57 -0400
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 27 Sep 2020 23:59:57 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 27 Sep 2020 23:59:55 -0700
X-QCInternal: smtphost
Received: from parashar-linux.qualcomm.com ([10.206.13.63])
  by ironmsg01-blr.qualcomm.com with ESMTP; 28 Sep 2020 12:29:42 +0530
Received: by parashar-linux.qualcomm.com (Postfix, from userid 2363307)
        id 5CC332162F; Mon, 28 Sep 2020 12:29:41 +0530 (IST)
From:   Paras Sharma <parashar@codeaurora.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        akashast@codeaurora.org, Paras Sharma <parashar@codeaurora.org>
Subject: [PATCH V5] serial: qcom_geni_serial: To correct QUP Version detection logic
Date:   Mon, 28 Sep 2020 12:29:38 +0530
Message-Id: <1601276378-4325-1-git-send-email-parashar@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

For QUP IP versions 2.5 and above the oversampling rate is
halved from 32 to 16.
Commit ce734600545f ("tty: serial: qcom_geni_serial: Update
the oversampling rate") is pushed to handle this scenario.But
the existing logic is failing to classify QUP Version 3.0 into
the correct group ( 2.5 and above).

As result Serial Engine clocks are not configured properly for
baud rate and garbage data is sampled to FIFOs from the line.

So, fix the logic to detect QUP with versions 2.5 and above.

Fixes: ce734600545f ("tty: serial: qcom_geni_serial: Update the oversampling rate")
Signed-off-by: Paras Sharma <parashar@codeaurora.org>
---
Changes in V5:
Moved QUP_SE_VERSION_2_5 to common header file qcom-geni-se.h

Changes in V4:
Created a new #define QUP_SE_VERSION_2_5 for Qup serial engine having version 2.5

Changes in V3:
Replaced the condition for detecting Qup version(2.5 or greater) with value 0x20050000

Changes in V2:
Changed subject line and logic for checking Qup version

 drivers/tty/serial/qcom_geni_serial.c | 3 ++-
 include/linux/qcom-geni-se.h          | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index f0b1b47..198ecdd7 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -106,6 +106,7 @@
 /* We always configure 4 bytes per FIFO word */
 #define BYTES_PER_FIFO_WORD		4
 
+
 struct qcom_geni_private_data {
 	/* NOTE: earlycon port will have NULL here */
 	struct uart_driver *drv;
@@ -1000,7 +1001,7 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 	sampling_rate = UART_OVERSAMPLING;
 	/* Sampling rate is halved for IP versions >= 2.5 */
 	ver = geni_se_get_qup_hw_version(&port->se);
-	if (GENI_SE_VERSION_MAJOR(ver) >= 2 && GENI_SE_VERSION_MINOR(ver) >= 5)
+	if (ver >= QUP_SE_VERSION_2_5)
 		sampling_rate /= 2;
 
 	clk_rate = get_clk_div_rate(baud, sampling_rate, &clk_div);
diff --git a/include/linux/qcom-geni-se.h b/include/linux/qcom-geni-se.h
index 8f385fb..1c31f26 100644
--- a/include/linux/qcom-geni-se.h
+++ b/include/linux/qcom-geni-se.h
@@ -248,6 +248,9 @@ struct geni_se {
 #define GENI_SE_VERSION_MINOR(ver) ((ver & HW_VER_MINOR_MASK) >> HW_VER_MINOR_SHFT)
 #define GENI_SE_VERSION_STEP(ver) (ver & HW_VER_STEP_MASK)
 
+/* QUP SE VERSION value for major number 2 and minor number 5 */
+#define QUP_SE_VERSION_2_5                  0x20050000
+
 /*
  * Define bandwidth thresholds that cause the underlying Core 2X interconnect
  * clock to run at the named frequency. These baseline values are recommended
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

