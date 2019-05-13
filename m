Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D30321B298
	for <lists+linux-serial@lfdr.de>; Mon, 13 May 2019 11:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbfEMJOz (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 13 May 2019 05:14:55 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:39781 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728837AbfEMJOy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 13 May 2019 05:14:54 -0400
Received: by mail-wr1-f44.google.com with SMTP id w8so11900638wrl.6
        for <linux-serial@vger.kernel.org>; Mon, 13 May 2019 02:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=devtank-co-uk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=JdbYErrB5tDySb548PLG6zFwTxebqIfiNZjcuJAQKd8=;
        b=rLHgUuV8+owfUjxhIlvXXHPxio7XMJo4mytPfMVfUQdBuK8a/EbR5Y+DWJob5keOk0
         t4wuI5y7X+b0E0OGROYFbkC1wmEisXv7lW1bcRtFTgqkPVA86HfyPXTBImFq+PrytrHv
         BHFJgfYzbe3wkeh7HbmjnPuD5S4czjd8Y+J66llq718A+R4cjsHnSGWkrhr3sD7kvgE8
         MNowvAq0nk3vSNImIec2nGiJmWL4y9AKqQDioTCX54dtckVP3+hZ8wq/uQa1mlDDH6NA
         busmvdJfqUB/q1mnCfOY8+r29FgoNEkwuPxTzJigNWyQsxUucHDYEs0hZ/hQ/ik1zqde
         DYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=JdbYErrB5tDySb548PLG6zFwTxebqIfiNZjcuJAQKd8=;
        b=GKONDdWC4VvPr0SRoy89irJ5uNfRtQY5rutdw2zypDo35mr6kbI//0IBHkVUBI5tp3
         RmeWZZmP0ri2N5PC9q8OOu2QDbgeSjLjjh7t9ADepUAxW9Vq4iwrUxxBRJq/ah5eiFEz
         P0mGkAh+XlrR4RAITTC1aFUMgc1z54A/8CwcPs5j5ukM41rL+nHZf5Botds7j++PteK9
         vbFMUdVWoXNtmamysvgsDDtadKCaqDW1f/J+UQuW8nVk7564IyXhvpdOCTBeKN2/tVDh
         b0v61SJ/b8/LNW4mWmbnT3VrH3Wn8uefCUQYsyw466AMh3of1EyanXWvBo3zx9y2yYtO
         Q3OQ==
X-Gm-Message-State: APjAAAW+DLaZu1nTYRKNZLIZpK4URM/3jLdmf8G8svPBMWxYSnPB3zNB
        uBPiDzMLek3c0Epp842KfC+7HVjDoYE=
X-Google-Smtp-Source: APXvYqx2RNPWFimD9AgfjCYaKYZtttEDtrOMP5dMyE77FnYXydUCdkN4DFPL4dtrhWoA/sRpS6DxEQ==
X-Received: by 2002:adf:cd09:: with SMTP id w9mr1473125wrm.242.1557738892352;
        Mon, 13 May 2019 02:14:52 -0700 (PDT)
Received: from [192.168.200.229] ([141.105.200.141])
        by smtp.gmail.com with ESMTPSA id p24sm10973400wma.18.2019.05.13.02.14.51
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 02:14:51 -0700 (PDT)
To:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
From:   Joe Burmeister <joe.burmeister@devtank.co.uk>
Subject: max310x driver bugfix
Message-ID: <4d4a2230-f237-0196-76da-262d66fe8e02@devtank.co.uk>
Date:   Mon, 13 May 2019 10:14:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------A39185189785CA9CF4B65A23"
Content-Language: en-GB
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This is a multi-part message in MIME format.
--------------A39185189785CA9CF4B65A23
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

We have a MAX3107 we are using for RS485 and we have an external crystal.

The relevant parts of our drive tree overlay is:


...
...

             uart_clk: xtal_max14830 {
                 compatible = "fixed-clock";
                 #clock-cells = <0>;
                 clock-frequency = <3686400>;
             };

...
...
             uart2: max3107@0 {
                 compatible = "maxim,max3107";
                 reg = <0>;
                 clocks = <&uart_clk>;
                 clock-names = "xtal";
...
...
             };
             uart3: max3107@1 {
                 compatible = "maxim,max3107";
                 reg = <1>;
                 clocks = <&uart_clk>;
                 clock-names = "xtal";
...
...


When we use the driver as it comes, it appears and we can do what we 
like with it's GPIOs, but it doesn't send or receive.

The only thing we see wrong in dmesg is "clock is not stable yet". So we 
figured our problem was related to the clock.

Looking on a scope, nothing is transmitted when we try sending something 
from Linux.


At line 579, in max310x_set_ref_clk, there is the line.


clksrc = xtal ? MAX310X_CLKSRC_CRYST_BIT : MAX310X_CLKSRC_EXTCLK_BIT;


The chip's datasheet (p43) states:


Bit 4: ClockEnSet the ClockEn bit high to enable an external clocking 
(crystal or clock generator at XIN). Set the ClockEn bit to 0 to disable 
clocking
Bit 1: CrystalEnSet the CrystalEn bit high to enable the crystal 
oscillator. When using an external clock source at XIN, CrystalEn must 
be set low.



So it sounds like with an external crystal, you also need bit 4, 
MAX310X_CLKSRC_EXTCLK_BIT.


So shouldn't that line read:

clksrc = MAX310X_CLKSRC_EXTCLK_BIT | (xtal ? MAX310X_CLKSRC_CRYST_BIT : 0);


When we do that, we don't see "clock is not stable yet" in dmesg and our 
data transmits.


Patch attached.


Regards,


Joe

--------------A39185189785CA9CF4B65A23
Content-Type: text/x-patch;
 name="max310x_cryst_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="max310x_cryst_fix.patch"

commit 028b9a3692f27da5e5524489e834ba3bb477ff63
Author: Joe Burmeister <joe.burmeister@devtank.co.uk>
Date:   Mon Apr 1 12:03:51 2019 +0100

    Fix external crystal register setup.

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 3db48fcd6068..73a144be3e2c 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -576,7 +576,7 @@ static int max310x_set_ref_clk(struct device *dev, struct max310x_port *s,
 	}
 
 	/* Configure clock source */
-	clksrc = xtal ? MAX310X_CLKSRC_CRYST_BIT : MAX310X_CLKSRC_EXTCLK_BIT;
+	clksrc = MAX310X_CLKSRC_EXTCLK_BIT | (xtal ? MAX310X_CLKSRC_CRYST_BIT : 0);
 
 	/* Configure PLL */
 	if (pllcfg) {


--------------A39185189785CA9CF4B65A23--
