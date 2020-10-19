Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79EE7292D40
	for <lists+linux-serial@lfdr.de>; Mon, 19 Oct 2020 19:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730428AbgJSR7Z (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 19 Oct 2020 13:59:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26064 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730334AbgJSR7Z (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 19 Oct 2020 13:59:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603130364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type;
        bh=4H/4VlvZn6NucRVpFY4pzGUiWYTHTFz3lrsu4Py62T4=;
        b=NzI9SJ4mImmk9bLdeBV6x3yDV4TOyonm/XQ1mnioCyUOQceFHaZqyKUCxykYgnbYxdnK9U
        Z/nIQaONBrEI+R3U1VgTpmTEkmwKDIc/N9q+Fks1iuS37qaa/0VVabzquoWeOROXQfCE6S
        yrOrThl0Y99ePK3V2Bc5zGoAjMgyfm8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-1ZhlwVSkNaiyFcXS2VWong-1; Mon, 19 Oct 2020 13:59:21 -0400
X-MC-Unique: 1ZhlwVSkNaiyFcXS2VWong-1
Received: by mail-qk1-f198.google.com with SMTP id d5so201988qkg.16
        for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2020 10:59:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4H/4VlvZn6NucRVpFY4pzGUiWYTHTFz3lrsu4Py62T4=;
        b=oUVjr51Noz9aPgUHfSWdSUtZ6++wHKzwjLVWfVAZOoYYymr7uDtOXn3iDocfxGVnxG
         CYdIKk2A37mYXFiU8afqUkw53o/94xAFz3YuXqSJRHY0B2VcH7I8gDU6828A+oHMRCCt
         m85GO68FgU/vSfke+JppQB5NrbkLS0MwXyvpFa2ivfX8r8zgErxzSdBQ+9R0266tY5y8
         +UiB2kEcUkZXZCbtC+1ed36AB25RHzIJu44aCbSt0f239r95m+04WeFRXNK7GWdkBhf9
         t7wtEmlMWhN24guiZEvZPh9HGBd5wyHo3OpSDSKW6HL4fF3aiOmYVsOpS1sPzpXI8+PM
         pPLA==
X-Gm-Message-State: AOAM533Ob2yVZmtxkGeuSVycrMLZGX6Hgux7PM2y6X/D+FQ88IGKXFn3
        egZmseU2fbsRJpNcnFvun1GvQD+igPWZBnSuMRgYYgInUqcFEg57elF5GLoxwCClPsVCKnXTFII
        N8krme/irl/ItLI5RcWaGq7pU
X-Received: by 2002:ac8:5816:: with SMTP id g22mr601299qtg.316.1603130360722;
        Mon, 19 Oct 2020 10:59:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxaBqNmSBrMPJHuYqKierKOg1cy0Yax1D0cPaSGeCTCBhmZz3EoB/iutfA2SPaR+VRasCSlRQ==
X-Received: by 2002:ac8:5816:: with SMTP id g22mr601273qtg.316.1603130360444;
        Mon, 19 Oct 2020 10:59:20 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 9sm322063qkv.110.2020.10.19.10.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 10:59:19 -0700 (PDT)
From:   trix@redhat.com
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] tty: remove unneeded break
Date:   Mon, 19 Oct 2020 10:59:15 -0700
Message-Id: <20201019175915.3718-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="US-ASCII"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A break is not needed if it is preceded by a return

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/tty/serial/imx.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 1731d9728865..09703079db7b 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -320,7 +320,6 @@ static u32 imx_uart_readl(struct imx_port *sport, u32 offset)
 	switch (offset) {
 	case UCR1:
 		return sport->ucr1;
-		break;
 	case UCR2:
 		/*
 		 * UCR2_SRST is the only bit in the cached registers that might
@@ -331,16 +330,12 @@ static u32 imx_uart_readl(struct imx_port *sport, u32 offset)
 		if (!(sport->ucr2 & UCR2_SRST))
 			sport->ucr2 = readl(sport->port.membase + offset);
 		return sport->ucr2;
-		break;
 	case UCR3:
 		return sport->ucr3;
-		break;
 	case UCR4:
 		return sport->ucr4;
-		break;
 	case UFCR:
 		return sport->ufcr;
-		break;
 	default:
 		return readl(sport->port.membase + offset);
 	}
-- 
2.18.1

