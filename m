Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D41D3CB62
	for <lists+linux-serial@lfdr.de>; Tue, 11 Jun 2019 14:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390026AbfFKM0L (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 11 Jun 2019 08:26:11 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:13030 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389806AbfFKM0H (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 11 Jun 2019 08:26:07 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5BCN2JA024846;
        Tue, 11 Jun 2019 14:25:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=q+8EPvTaJkovohssWYYhUuM4RMRQjz08eTtbGZ/5swc=;
 b=Ys4wns7kv2MLHTcSdOYO6J36CL38mo3MAhvTgLgFlX8KqIsOR4hhzIPdER+H2iw0M8jU
 QUzxpvZfgPah0FO2XD8mDB8bdSOBB1NZAQ86Pdz9jfZ6Ve0zTMVyY9hPA3MICPwWi1kI
 WJll6Lda1t55etzTSab87mtsx6MDdUh/FgLRMJjr4fQ3eIEDqggJc8+RYZ5uwZqH1yme
 of6PD/CpVsnWI+orcq4uBQXDnkMep8GQHR9hSzz/HdA9THZPU3jpQxNX4nJ6QXJzD+cy
 lKKt1sEMw5B0FwjLFTyFKyykhLzfQ3Je6hOy8CSCxeCrgln2Tgk9Fv4AFiTnzLBsRnZu bA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2t26rjsvaq-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 11 Jun 2019 14:25:51 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6162A31;
        Tue, 11 Jun 2019 12:25:51 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 45F772A29;
        Tue, 11 Jun 2019 12:25:51 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 11 Jun
 2019 14:25:51 +0200
Received: from localhost (10.201.23.31) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 11 Jun 2019 14:25:49
 +0200
From:   Erwan Le Ray <erwan.leray@st.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Alexandre Torgue" <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>
CC:     <linux-serial@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Erwan Le Ray <erwan.leray@st.com>,
        "Fabrice Gasnier" <fabrice.gasnier@st.com>
Subject: [PATCH v2 05/10] serial: stm32: Use __maybe_unused instead of #if CONFIG_PM_SLEEP
Date:   Tue, 11 Jun 2019 14:25:25 +0200
Message-ID: <1560255930-22554-6-git-send-email-erwan.leray@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1560255930-22554-1-git-send-email-erwan.leray@st.com>
References: <1560255930-22554-1-git-send-email-erwan.leray@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.31]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-11_06:,,
 signatures=0
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Use __maybe_unused for power management related functionsinstead of

fixes: 270e5a74fe4c ("serial: stm32: add wakeup mechanism")
Signed-off-by: Erwan Le Ray <erwan.leray@st.com>

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 60f3faf..0d43711 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -1275,8 +1275,8 @@ static int stm32_console_setup(struct console *co, char *options)
 	.cons		= STM32_SERIAL_CONSOLE,
 };
 
-#ifdef CONFIG_PM_SLEEP
-static void stm32_serial_enable_wakeup(struct uart_port *port, bool enable)
+static void __maybe_unused stm32_serial_enable_wakeup(struct uart_port *port,
+						      bool enable)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
@@ -1300,7 +1300,7 @@ static void stm32_serial_enable_wakeup(struct uart_port *port, bool enable)
 	}
 }
 
-static int stm32_serial_suspend(struct device *dev)
+static int __maybe_unused stm32_serial_suspend(struct device *dev)
 {
 	struct uart_port *port = dev_get_drvdata(dev);
 
@@ -1316,7 +1316,7 @@ static int stm32_serial_suspend(struct device *dev)
 	return 0;
 }
 
-static int stm32_serial_resume(struct device *dev)
+static int __maybe_unused stm32_serial_resume(struct device *dev)
 {
 	struct uart_port *port = dev_get_drvdata(dev);
 
@@ -1327,7 +1327,6 @@ static int stm32_serial_resume(struct device *dev)
 
 	return uart_resume_port(&stm32_usart_driver, port);
 }
-#endif /* CONFIG_PM_SLEEP */
 
 static int __maybe_unused stm32_serial_runtime_suspend(struct device *dev)
 {
-- 
1.9.1

