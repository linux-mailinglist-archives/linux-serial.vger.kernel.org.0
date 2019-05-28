Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5E82BE04
	for <lists+linux-serial@lfdr.de>; Tue, 28 May 2019 05:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfE1D7y (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 27 May 2019 23:59:54 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:46158 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbfE1D7x (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 May 2019 23:59:53 -0400
Received: by mail-pg1-f170.google.com with SMTP id v9so3712378pgr.13
        for <linux-serial@vger.kernel.org>; Mon, 27 May 2019 20:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=accesio-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=3Cl89/tyholnwx8+FcDKA+kcoSLNN4fn7uuWTfTZgOc=;
        b=dmd2tuEgBNYXipPzKXagUCEI8JcRnI1qoZLfhz87Q1Jd3tbH+ZdAxAcbQZk+LxDbpV
         9XhyPQyrWX4/tXRSj7/ao7pwCLf5L0/VXHFMaqV/GLQJ2SJ44Obtryz76AFh3m9OKRyW
         nlkRZCul6VTy5ewpZQILzPZJxYOerjN8BAEkbPnxh3YXv1KHHz2nu0njePeoYdLx1E/A
         q3gPHnN2tq9CZWwbLFFb14PaNfTrRqoCJs3objdC0NgAbtwv92AUF67HYoXPX9LOCfxi
         SPK/btmVvXebD0L/nhnZ0QwDwU1qE8d220nLdfs02ZnVNSh+I6fzuWKgsUH7LiRaJ1vh
         cHRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3Cl89/tyholnwx8+FcDKA+kcoSLNN4fn7uuWTfTZgOc=;
        b=VQVDMoYz6IoDUoQIECiHklERraDYZEpA6TparMtezz0yePqFTwRipY9D/ZuVwAy9yi
         I4Dasp8ZVg9jc/rVhLd1F2Qc4vz5PEByqN4zg4xvaBtnLMM/eF1iQ9SUzVMojhmnBplO
         sg6fH6TT1Vsa1vVfxMCYE67ZPMdnD1ZnO63SrMdd04tWL7v5Cmt/dmBIRZfLSrr5Tjot
         IZstwD5J9mEwbnpmLVKeXExzytWJJyez+mcUQX1nENrdytPizsDlJAcjsl+zrOFYkHr2
         O6YWqHtTGJGVYs70piW9bjJj5H2zHeC/iw+mme2yeDZjCw+r4H8yyXH7M9Fp9WgBrSEx
         VSTQ==
X-Gm-Message-State: APjAAAUm9YCxTf/J2gxq2rcAq20wSRbzG/Ymy3tBFybtQ3Q1pdiiZnLx
        yCSZYb1eTrm/jIXjrXV+tHz2+pWakSkftFqLj4DeLqHEgM7uhle3NkM+DfXtbpMRkwQ5dIbNB/p
        ZpoOigN+hxqJfKNzBD76BGAS0YOGkaBMiodeOn8vk8otjz/nwvCwHZL9VsYlaQDf0eGNIQKm/EO
        rc
X-Google-Smtp-Source: APXvYqxC6Y0WtOa/bbUpXc2xgkcg1Bu/n3EI0630R7xfpMTNGEUgFgXlHqDTQlHVgMSzQC/ZHHEdTw==
X-Received: by 2002:a17:90a:5d09:: with SMTP id s9mr2820449pji.120.1559015993054;
        Mon, 27 May 2019 20:59:53 -0700 (PDT)
Received: from acces-pc.dolannet.net (cpe-70-95-148-49.san.res.rr.com. [70.95.148.49])
        by smtp.gmail.com with ESMTPSA id j64sm23438052pfb.126.2019.05.27.20.59.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 20:59:52 -0700 (PDT)
From:   jay.dolan@accesio.com
To:     linux-serial@vger.kernel.org
Cc:     Jay Dolan <jay.dolan@accesio.com>
Subject: [PATCH v3 0/1] Add support for higher baud rates to Pericom
Date:   Mon, 27 May 2019 20:59:42 -0700
Message-Id: <20190528035943.6274-1-jay.dolan@accesio.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Jay Dolan <jay.dolan@accesio.com>

Change in v3:
1. Moved pericom_do_set_divisor to 8250_pci.c
2. No longer touch any other file

Change in v2:
1. Fixed whitespace
2. Don't export pericom_do_set_divisor()

Jay Dolan (1):
  serial: 8250: Add support for higher baud rates to Pericom chips

 drivers/tty/serial/8250/8250_pci.c | 97 ++++++++++++++++++++++++------
 1 file changed, 79 insertions(+), 18 deletions(-)

-- 
2.17.1

