Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5947AA618
	for <lists+linux-serial@lfdr.de>; Thu,  5 Sep 2019 16:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389503AbfIEOln (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 5 Sep 2019 10:41:43 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:38673 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730671AbfIEOlm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 5 Sep 2019 10:41:42 -0400
Received: by mail-qk1-f202.google.com with SMTP id l64so2662637qkb.5
        for <linux-serial@vger.kernel.org>; Thu, 05 Sep 2019 07:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RaOdMEdHWabRyA48tWifREdKC/PQMtkOlsK8xXnOLlg=;
        b=BtnXfkFFib9LY2N7CLMrbVvS73v4Eq6wm+VbGidSpNhFCD42EtMTDvVL8+G02UX2lJ
         6hfjWa8pXNEsKJfxRxDoiJ6Js2le/D2knnMzOom9h3YZXu6WCmWpYxSPqhxIf8XvjDqK
         4mY6MhLeCLz8/uWepBTNX4NevsjTbdtjpmk3VvfemuGiEPKEMVJGs1z5NKuM2TNKIIoy
         rU9+aiGOOrDooEWyk2m/Kjd8XrbaMEzSWl/SESdIm9GPtZki1ifsqtx7xqM3Ww2w7UL0
         9GgqgjK2Efr4Fibow4GjVnEev3fd78/76t9xWzithNMZm/vJerJGWBfYf/js6NCc21jt
         WkqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RaOdMEdHWabRyA48tWifREdKC/PQMtkOlsK8xXnOLlg=;
        b=NlIulWjTx3iROuU6tDcnqUqlZCh2fVAFSck+cscL762YzBHhHlrqmfl3s1o2hIJy/Y
         q1GUFLocl2B9yMJdb/LxHaD4v/GXm3ip9zrXhmLPBVXKFski59wx67LWDDTaB5tVHdFz
         Q1Q4T8waBROqnUqKwxYxu9Hrdym/gmQiLzhY9opj3MzZDetTFf09k3NVPa8xQg5ikRAF
         cl8WRUAmFMpnviIcgL1IuH3N87WVENitflc3g5KDNb4Ett2GqCobUj2kwi80irsav3Ax
         isYeoD7TREppsef7LJ/uX/am1TGomnLMdRbA1Nyn/EvDHSeM58kQsEKn0do1lBIZxvxo
         RGSQ==
X-Gm-Message-State: APjAAAWW75b1Z31AFsklubegeVqdhU3UXjbcTgknfEQ3DdJHsE2PmByi
        WyhAKv5vEG2Bl0dZzA8IXwcvCrw=
X-Google-Smtp-Source: APXvYqzkDOBp79PXpEAipYZadtwGS7ZnIH63SZDea9FHuBgDn4feswfOL5kDKxXMwh4xwbR5YKHd0wE=
X-Received: by 2002:a37:9d3:: with SMTP id 202mr3162654qkj.391.1567694501708;
 Thu, 05 Sep 2019 07:41:41 -0700 (PDT)
Date:   Thu,  5 Sep 2019 10:41:29 -0400
In-Reply-To: <20190905144130.220713-1-osk@google.com>
Message-Id: <20190905144130.220713-2-osk@google.com>
Mime-Version: 1.0
References: <20190905144130.220713-1-osk@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v3 2/3] dt-bindings: serial: 8250: Add aspeed,sirq-polarity-sense.
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

Add documentation for 8250_aspeed_vuart's aspeed,sirq-polarity-sense
property that enables to auto-configure the VUART's SIRQ polarity.

Signed-off-by: Oskar Senft <osk@google.com>
---
 Documentation/devicetree/bindings/serial/8250.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/8250.txt b/Documentation/devicetree/bindings/serial/8250.txt
index 20d351f268ef..55700f20f6ee 100644
--- a/Documentation/devicetree/bindings/serial/8250.txt
+++ b/Documentation/devicetree/bindings/serial/8250.txt
@@ -56,6 +56,11 @@ Optional properties:
 - {rts,cts,dtr,dsr,rng,dcd}-gpios: specify a GPIO for RTS/CTS/DTR/DSR/RI/DCD
   line respectively. It will use specified GPIO instead of the peripheral
   function pin for the UART feature. If unsure, don't specify this property.
+- aspeed,sirq-polarity-sense: Only applicable to aspeed,ast2500-vuart.
+  phandle to aspeed,ast2500-scu compatible syscon alongside register offset
+  and bit number to identify how the SIRQ polarity should be configured.
+  One possible data source is the LPC/eSPI mode bit.
+  Example: aspeed,sirq-polarity-sense = <&syscon 0x70 25>
 
 Note:
 * fsl,ns16550:
-- 
2.23.0.187.g17f5b7556c-goog

