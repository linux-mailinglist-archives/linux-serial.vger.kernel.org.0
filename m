Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEDB03475BD
	for <lists+linux-serial@lfdr.de>; Wed, 24 Mar 2021 11:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbhCXKTl (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 24 Mar 2021 06:19:41 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:18694 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbhCXKTN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 24 Mar 2021 06:19:13 -0400
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 24 Mar 2021 03:19:13 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 24 Mar 2021 03:19:11 -0700
X-QCInternal: smtphost
Received: from c-rojay-linux.qualcomm.com ([10.206.21.80])
  by ironmsg01-blr.qualcomm.com with ESMTP; 24 Mar 2021 15:48:41 +0530
Received: by c-rojay-linux.qualcomm.com (Postfix, from userid 88981)
        id 0F0D1315E; Wed, 24 Mar 2021 15:48:40 +0530 (IST)
From:   Roja Rani Yarubandi <rojay@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        gregkh@linuxfoundation.org, mka@chromium.org, robh+dt@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        akashast@codeaurora.org, msavaliy@qti.qualcomm.com,
        Roja Rani Yarubandi <rojay@codeaurora.org>
Subject: [RESEND PATCH V3 2/2] arm64: dts: qcom: sc7180: Remove QUP-CORE ICC path
Date:   Wed, 24 Mar 2021 15:48:36 +0530
Message-Id: <20210324101836.25272-3-rojay@codeaurora.org>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210324101836.25272-1-rojay@codeaurora.org>
References: <20210324101836.25272-1-rojay@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

We had introduced the QUP-CORE ICC path to put proxy votes from
QUP wrapper on behalf of earlycon, if other users of QUP-CORE turn
off this clock before the real console is probed, unclocked access
to HW was seen from earlycon.

With ICC sync state support proxy votes are no longer need as ICC
will ensure that the default bootloader votes are not removed until
all it's consumer are probed.

We can safely remove ICC path for QUP-CORE clock from QUP wrapper
device.

Signed-off-by: Roja Rani Yarubandi <rojay@codeaurora.org>
Signed-off-by: Akash Asthana <akashast@codeaurora.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in V3:
 - No change

Changes in V2:
 - No change

 arch/arm64/boot/dts/qcom/sc7180.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 83fbb481cae5..2709051740d1 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -768,8 +768,6 @@ qupv3_id_0: geniqup@8c0000 {
 			#size-cells = <2>;
 			ranges;
 			iommus = <&apps_smmu 0x43 0x0>;
-			interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>;
-			interconnect-names = "qup-core";
 			status = "disabled";
 
 			i2c0: i2c@880000 {
@@ -1059,8 +1057,6 @@ qupv3_id_1: geniqup@ac0000 {
 			#size-cells = <2>;
 			ranges;
 			iommus = <&apps_smmu 0x4c3 0x0>;
-			interconnects = <&qup_virt MASTER_QUP_CORE_1 0 &qup_virt SLAVE_QUP_CORE_1 0>;
-			interconnect-names = "qup-core";
 			status = "disabled";
 
 			i2c6: i2c@a80000 {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

