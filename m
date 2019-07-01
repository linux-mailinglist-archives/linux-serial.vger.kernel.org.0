Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFA2143927
	for <lists+linux-serial@lfdr.de>; Thu, 13 Jun 2019 17:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732292AbfFMPMA (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 13 Jun 2019 11:12:00 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:48710 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732290AbfFMNu0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 13 Jun 2019 09:50:26 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5DDkxMY019851;
        Thu, 13 Jun 2019 15:50:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=9gSGjqYoy+Fbf2xPESzbOyGUbO7HOvEvjLu/ZOx6/bE=;
 b=pXcj6LtCHYL6EtxnPfIvZzHvGM5Llo4PJOqzFMBrLfpeFoOlmtSRwHQZY2mJkqt62gc2
 mITKuIsEXlJ0GF4T3JEY2pjBip8FCJT71ajPI2O1+hdhPYU7UWWijvlZqpuYPb3NxU7l
 Y+eQDFs0QLffXLADWmLWMdO72CegM772nR1Vc9zsSN2H43O6MICZsZk8PYryOVdG56bK
 xblLjTth6FKZ3Us9TJUrlG4hD5ErT+PKyLNOyP5h7EkOVNXf7Fbr0Tq2TgDv3Rq6WUoH
 5a6RcMto0xKudSbPp4UGhxnaW7+TXrL2eIC2l8cRAGkNpOKSnlQs8WDWbqrjPCsgeWeg 9w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2t2gxec010-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 13 Jun 2019 15:50:13 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2228631;
        Thu, 13 Jun 2019 13:50:13 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EA9782BC2;
        Thu, 13 Jun 2019 13:50:12 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 13 Jun
 2019 15:50:12 +0200
Received: from localhost (10.201.23.31) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 13 Jun 2019 15:50:12
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
        "Fabrice Gasnier" <fabrice.gasnier@st.com>,
        Bich Hemon <bich.hemon@st.com>
Subject: [PATCH v3 01/10] dt-bindings: serial: stm32: add wakeup option
Date:   Thu, 13 Jun 2019 15:49:51 +0200
Message-ID: <1560433800-12255-2-git-send-email-erwan.leray@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1560433800-12255-1-git-send-email-erwan.leray@st.com>
References: <1560433800-12255-1-git-send-email-erwan.leray@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.31]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-13_08:,,
 signatures=0
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add a note for enabling wakeup capabilities of usart

Signed-off-by: Bich Hemon <bich.hemon@st.com>
Signed-off-by: Erwan Le Ray <erwan.leray@st.com>

diff --git a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
index 9d3efed..5ec80c1 100644
--- a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
+++ b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
@@ -19,6 +19,11 @@ Optional properties:
   linux,rs485-enabled-at-boot-time: see rs485.txt.
 - dmas: phandle(s) to DMA controller node(s). Refer to stm32-dma.txt
 - dma-names: "rx" and/or "tx"
+- wakeup-source: bool flag to indicate this device has wakeup capabilities
+- interrupt-names, if optional wake-up interrupt is used, should be:
+  - "event": the name for the interrupt line of the USART instance
+  - "wakeup" the name for the optional wake-up interrupt
+
 
 Examples:
 usart4: serial@40004c00 {
-- 
1.9.1

