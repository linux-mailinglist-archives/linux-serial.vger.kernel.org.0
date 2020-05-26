Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC9B1ADF27
	for <lists+linux-serial@lfdr.de>; Fri, 17 Apr 2020 16:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730788AbgDQOFT (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 17 Apr 2020 10:05:19 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:23788 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730865AbgDQOFS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 17 Apr 2020 10:05:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587132317; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=0yvYjguOx84bHKDg7ORP2jVfhZBtiUmKbBffrVbFt34=; b=vEuMkWxwPkvOOAJEH4an+waqUmOA+7CCCc3qkmMIszcteOO0LSvz/GwQl4ckbgmpd++1xtTg
 8aPeyztYvVvhDOJ39NxfJnfKi8B7FizRDt6DFcWyt2oa4gGnX8ZySaTZr5XBXFgWLQJ06k8d
 CEzv3gzWSzxWzZ6zAUUR5p/T7tk=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyIzZmY0MiIsICJsaW51eC1zZXJpYWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e99b79d.7f76c3c28a78-smtp-out-n05;
 Fri, 17 Apr 2020 14:05:17 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 80E0FC44795; Fri, 17 Apr 2020 14:05:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A62C1C4478F;
        Fri, 17 Apr 2020 14:05:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A62C1C4478F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     viresh.kumar@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, agross@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Akash Asthana <akashast@codeaurora.org>,
        linux-serial@vger.kernel.org
Subject: [PATCH v2 01/17] tty: serial: qcom_geni_serial: Use OPP API to set clk/perf state
Date:   Fri, 17 Apr 2020 19:34:23 +0530
Message-Id: <1587132279-27659-2-git-send-email-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587132279-27659-1-git-send-email-rnayak@codeaurora.org>
References: <1587132279-27659-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

geni serial needs to express a perforamnce state requirement on CX
powerdomain depending on the frequency of the clock rates.
Use OPP table from DT to register with OPP framework and use
dev_pm_opp_set_rate() to set the clk/perf state.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Akash Asthana <akashast@codeaurora.org>
Cc: linux-serial@vger.kernel.org
---
 drivers/tty/serial/qcom_geni_serial.c | 30 +++++++++++++++++++++++++-----
 include/linux/qcom-geni-se.h          |  2 ++
 2 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 6119090..151012c 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/pm_opp.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm_wakeirq.h>
@@ -128,6 +129,7 @@ struct qcom_geni_serial_port {
 	int wakeup_irq;
 	bool rx_tx_swap;
 	bool cts_rts_swap;
+	bool opp_table;
 };
 
 static const struct uart_ops qcom_geni_console_pops;
@@ -961,7 +963,7 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 		goto out_restart_rx;
 
 	uport->uartclk = clk_rate;
-	clk_set_rate(port->se.clk, clk_rate);
+	dev_pm_opp_set_rate(uport->dev, clk_rate);
 	ser_clk_cfg = SER_CLK_EN;
 	ser_clk_cfg |= clk_div << CLK_DIV_SHFT;
 
@@ -1198,8 +1200,11 @@ static void qcom_geni_serial_pm(struct uart_port *uport,
 	if (new_state == UART_PM_STATE_ON && old_state == UART_PM_STATE_OFF)
 		geni_se_resources_on(&port->se);
 	else if (new_state == UART_PM_STATE_OFF &&
-			old_state == UART_PM_STATE_ON)
+			old_state == UART_PM_STATE_ON) {
+		/* Drop the performance state vote */
+		dev_pm_opp_set_rate(uport->dev, 0);
 		geni_se_resources_off(&port->se);
+	}
 }
 
 static const struct uart_ops qcom_geni_console_pops = {
@@ -1318,13 +1323,20 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 	if (of_property_read_bool(pdev->dev.of_node, "cts-rts-swap"))
 		port->cts_rts_swap = true;
 
+	port->se.opp = dev_pm_opp_set_clkname(&pdev->dev, "se");
+	if (IS_ERR(port->se.opp))
+		return PTR_ERR(port->se.opp);
+	/* OPP table is optional */
+	if (!dev_pm_opp_of_add_table(&pdev->dev))
+		port->opp_table = true;
+
 	uport->private_data = drv;
 	platform_set_drvdata(pdev, port);
 	port->handle_rx = console ? handle_rx_console : handle_rx_uart;
 
 	ret = uart_add_one_port(drv, uport);
 	if (ret)
-		return ret;
+		goto err;
 
 	irq_set_status_flags(uport->irq, IRQ_NOAUTOEN);
 	ret = devm_request_irq(uport->dev, uport->irq, qcom_geni_serial_isr,
@@ -1332,7 +1344,7 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(uport->dev, "Failed to get IRQ ret %d\n", ret);
 		uart_remove_one_port(drv, uport);
-		return ret;
+		goto err;
 	}
 
 	/*
@@ -1349,11 +1361,16 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 		if (ret) {
 			device_init_wakeup(&pdev->dev, false);
 			uart_remove_one_port(drv, uport);
-			return ret;
+			goto err;
 		}
 	}
 
 	return 0;
+err:
+	if (port->opp_table)
+		dev_pm_opp_of_remove_table(&pdev->dev);
+	dev_pm_opp_put_clkname(port->se.opp);
+	return ret;
 }
 
 static int qcom_geni_serial_remove(struct platform_device *pdev)
@@ -1361,6 +1378,9 @@ static int qcom_geni_serial_remove(struct platform_device *pdev)
 	struct qcom_geni_serial_port *port = platform_get_drvdata(pdev);
 	struct uart_driver *drv = port->uport.private_data;
 
+	if (port->opp_table)
+		dev_pm_opp_of_remove_table(&pdev->dev);
+	dev_pm_opp_put_clkname(port->se.opp);
 	dev_pm_clear_wake_irq(&pdev->dev);
 	device_init_wakeup(&pdev->dev, false);
 	uart_remove_one_port(drv, &port->uport);
diff --git a/include/linux/qcom-geni-se.h b/include/linux/qcom-geni-se.h
index dd46494..737e713 100644
--- a/include/linux/qcom-geni-se.h
+++ b/include/linux/qcom-geni-se.h
@@ -24,6 +24,7 @@ enum geni_se_protocol_type {
 
 struct geni_wrapper;
 struct clk;
+struct opp_table;
 
 /**
  * struct geni_se - GENI Serial Engine
@@ -39,6 +40,7 @@ struct geni_se {
 	struct device *dev;
 	struct geni_wrapper *wrapper;
 	struct clk *clk;
+	struct opp_table *opp;
 	unsigned int num_clk_levels;
 	unsigned long *clk_perf_tbl;
 };
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
