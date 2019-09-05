Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEA49AA61B
	for <lists+linux-serial@lfdr.de>; Thu,  5 Sep 2019 16:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389540AbfIEOlo (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 5 Sep 2019 10:41:44 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:38675 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730867AbfIEOlo (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 5 Sep 2019 10:41:44 -0400
Received: by mail-qk1-f201.google.com with SMTP id l64so2662700qkb.5
        for <linux-serial@vger.kernel.org>; Thu, 05 Sep 2019 07:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DBIgduCaugj8tqfaD9C0q1cOrYEMjHp+EVVP9xE+eQU=;
        b=kFQCO+ILTxycGD0xPpwoQ2n/kJ3/gIMamkdeAtF5gZONEcygdv6B8viIrHbUn7pAn1
         jsPrQfi+A5AUgpFzxVSBgYJY+wfn8U1b00aSKG/0puFKN9MDOdDuM3TRK06qBA8pViHf
         S3SVzRuVjVk+odURthKdo7VMqFnql4/SSn7EuZJhMyOedA76sMhZuNiTvFoQ5UOBXjTT
         dciBZ4RasmNWXIUULCEW+v9XFRolhBz3ew/8kAyesPCTnhxFhST6joqcANAAr6gi7w25
         aWy9TL/ETCspFPHhrreos5OCONl4Om8cu9vActrASMUIPHSt/+I4NnxIm7a/CUywGlAI
         Mf0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DBIgduCaugj8tqfaD9C0q1cOrYEMjHp+EVVP9xE+eQU=;
        b=U9NQaXpdN4CG/qpj9BIaQBGCqOt4Jo8qErHsqoZQf+I7RHEndHkp8juA7SNoARLz5L
         Qpu9H7jGbKaBYLUgshOg8W/nX2HTI0Sa/I4CXTzCWR38pwmWGRW+ZdIq1pa63Ajz5Me4
         L4IMqdWkhcDgVbcIPs8NcYnpIQoVnF5tX9O9TuDrny7jAyZeKUdZDKRtnL3I+5nbtTjz
         JZQ0cxURF2SNdhJlXzRQKtFf6YYC5zOmdP3vDsUbEIBuoxBXA14f4srxx9Gwzl768ILk
         qG8M6jbdzY2nXAM/IQBerm/5NWgKtZb5jTlKPOcZ9cPVqqqGSsTIhj6z+zc5Q9symxkn
         fG3w==
X-Gm-Message-State: APjAAAXpSQyweEs9Y3Ge6z7C/jQWUP82f2Tm1pBVmU9blQn1QNdTsKxv
        HnWcvkXykDYz3ZatT4w3K90fNNo=
X-Google-Smtp-Source: APXvYqyNSVOy6oyG9DD0QBvBuTaufZmFloO9JVWmWZHMU1JZn5mMUAwUE7z3OJooXuAyecAHfFp7wjQ=
X-Received: by 2002:ac8:130d:: with SMTP id e13mr2670110qtj.287.1567694502968;
 Thu, 05 Sep 2019 07:41:42 -0700 (PDT)
Date:   Thu,  5 Sep 2019 10:41:30 -0400
In-Reply-To: <20190905144130.220713-1-osk@google.com>
Message-Id: <20190905144130.220713-3-osk@google.com>
Mime-Version: 1.0
References: <20190905144130.220713-1-osk@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v3 3/3] arm: dts: aspeed: Add vuart aspeed,sirq-polarity-sense
 to aspeed-g5.dtsi
From:   Oskar Senft <osk@google.com>
To:     joel@jms.id.au, andrew@aj.id.au, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, jk@ozlabs.org
Cc:     openbmc@lists.ozlabs.org, linux-aspeed@lists.ozlabs.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        Oskar Senft <osk@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Enable auto-configuration of VUART SIRQ polarity on AST2500.

Signed-off-by: Oskar Senft <osk@google.com>
---
 arch/arm/boot/dts/aspeed-g5.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 5b1ca265c2ce..06e489c1d0cb 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -351,6 +351,7 @@
 				interrupts = <8>;
 				clocks = <&syscon ASPEED_CLK_APB>;
 				no-loopback-test;
+				aspeed,sirq-polarity-sense = <&syscon 0x70 25>;
 				status = "disabled";
 			};
 
-- 
2.23.0.187.g17f5b7556c-goog

