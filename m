Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78C4E170B72
	for <lists+linux-serial@lfdr.de>; Wed, 26 Feb 2020 23:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbgBZWXf (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 26 Feb 2020 17:23:35 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37470 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727757AbgBZWXe (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 26 Feb 2020 17:23:34 -0500
Received: by mail-ot1-f65.google.com with SMTP id b3so1038634otp.4
        for <linux-serial@vger.kernel.org>; Wed, 26 Feb 2020 14:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kopismobile-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pfUf4spEhkDBmKxyxMorooyDLjAKRPJLyckzruXNUbg=;
        b=wZYkr7JBtdoc5YuzjF3ohzPAVDJ1gnRZjKmKJAFSt/LvVdTzc/ObarwxW+Bfdg0qsO
         GL/MnvZ3yJNOS9OYbhuim58B12tHPBcZ5hMil2MR9CQlrzjgrVX0oTW5g0cuuvr/TYUD
         A9wRyDpW6BvopIGKAfqgmPhJCQ8+DdSWS71A2JthVnFXEfX3H/uw7zrK96geumE2yg87
         O+abf6qnRXqoff+ABDXk0afpLrELFb3v6f0+PvdILW5xN41xRP1RVZTITIbBJwfZgFME
         xPFOCujPruB9hRVoqFBJSv2/wTfedfZR7L4GLC7Gj+UEFKqI5wuq+/M6Vo7zt8/pyHXC
         q/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pfUf4spEhkDBmKxyxMorooyDLjAKRPJLyckzruXNUbg=;
        b=nYN9uTNQ8F/D+PdoagkTRxColtbw89+aB0nBlxCWA5QOlwKx2DhDfFXtAY+VMKJKwj
         /EDELCmHEy3yp7edZZ2SlRxoSf2qyiGGh8Y+G0BDFfPkl8qbalBZUWne9ytGaSdvc3A8
         6WtRTszI4ArJ78wkqpouLqKiIxs18WY2e5DapbCNZhB7sxcoz9NyGJRSrntF9ppjk6bl
         lJUZARa0mh8WR2KKzi6JhQBhj9zedD5neltxQyZFpgfi4fjRfXXm3aFcUiC/pPokHvVR
         bVLddJLVRZ/VFMPj3jQehWi0kmq7RFdgS0JHoFPLCnChc2n788XopXbJ+Sm6XZaKNxvG
         Ha6A==
X-Gm-Message-State: APjAAAXjZNZ8wlNe518/pHFryhxRLos0n1ASalUCa9tSFyAcBiPufgAT
        YkZUjjR9FTmeP578C7eq2PRTew==
X-Google-Smtp-Source: APXvYqzH14hksfq8W/t4RGgz57wk9GHGGZP32bA2kV+roi7VwOltmEnTMtsVyCnxC1QyoQwXk/+3Yw==
X-Received: by 2002:a05:6830:145:: with SMTP id j5mr812538otp.242.1582755812741;
        Wed, 26 Feb 2020 14:23:32 -0800 (PST)
Received: from farregard-ubuntu.kopismobile.org (c-73-177-17-21.hsd1.ms.comcast.net. [73.177.17.21])
        by smtp.gmail.com with ESMTPSA id z21sm1237614oto.52.2020.02.26.14.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 14:23:32 -0800 (PST)
From:   George Hilliard <ghilliard@kopismobile.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     George Hilliard <ghilliard@kopismobile.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>, kernel@pengutronix.de
Subject: [PATCH v4 0/2] Implement support for inverted serial TX/RX on i.MX
Date:   Wed, 26 Feb 2020 16:23:17 -0600
Message-Id: <20200226222319.18383-1-ghilliard@kopismobile.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This peripheral has dedicated control bits that flip input/output
signals before handing them off to the OS.  This is useful on my
hardware because the UART is connected to an RS-422 transceiver with the
+/- pins hooked up backward.  Instead of a hack flipping all the bits
before sending them, the hardware can do it for free.

v4 cleans up the bit manipulation in v3; see previous series at
https://lore.kernel.org/linux-serial/20200212163538.3006-1-ghilliard@kopismobile.com/

George Hilliard (2):
  dt-bindings: serial: document fsl,inverted-tx and -rx options
  tty: imx serial: Implement support for reversing TX and RX polarity

 .../bindings/serial/fsl-imx-uart.txt          |  4 ++
 drivers/tty/serial/imx.c                      | 44 ++++++++++++-------
 2 files changed, 32 insertions(+), 16 deletions(-)

-- 
2.25.0

